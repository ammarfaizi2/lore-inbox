Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTAQRIE>; Fri, 17 Jan 2003 12:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267617AbTAQRIE>; Fri, 17 Jan 2003 12:08:04 -0500
Received: from [213.171.53.133] ([213.171.53.133]:6404 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267616AbTAQRID>;
	Fri, 17 Jan 2003 12:08:03 -0500
Date: Fri, 17 Jan 2003 20:16:54 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Adam Belay <ambx1@neo.rr.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.58][PnP] Some small points.
In-Reply-To: <20030117111838.GB26108@neo.rr.com>
Message-ID: <Pine.BSF.4.05.10301172005520.71917-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Adam Belay wrote:
> Hi Ruslan,
> > 3) Queston: Why we do free in this way?
> > static int snd_opl3sa2_free(opl3sa2_t *chip)
> > {
> > #ifdef CONFIG_PNP
> >         chip->dev = NULL;   -> Here. Why NULL? Who realy free resources and how?
> 
> The structure that chip->dev points to is freed by the pnp layer on the release call.
> Is this what you were asking or are you talking about something else?

I've got understood it already. Thanks.
At the begining I think that It's an driver job to free it, I've forgot
that this pnp_devs registered in several lists of PnP layer. 

> 
> > #endif
> > #ifdef CONFIG_PM
> >         if (chip->pm_dev)
> >                 pm_unregister(chip->pm_dev);
> > #endif
> >         if (chip->irq >= 0)
> >                 free_irq(chip->irq, (void *)chip);
> >         if (chip->res_port) {
> >                 release_resource(chip->res_port);
> >                 kfree_nocheck(chip->res_port);
> >         }
> >         snd_magic_kfree(chip);
> >         return 0;
> > }

