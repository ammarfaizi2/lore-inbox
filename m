Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274873AbTHMNeY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273288AbTHMNeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:34:24 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:18948 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S273027AbTHMNeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:34:21 -0400
Subject: Re: OPL3SA2: spin_is_locked on uninitialized spinlock
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, zwane@commfireservices.com,
       linux-sound@vger.kernel.org
In-Reply-To: <20030813050448.221aaa49.akpm@osdl.org>
References: <1060774796.3518.4.camel@teapot.felipe-alfaro.com>
	 <20030813050448.221aaa49.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1060781658.987.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 13 Aug 2003 15:34:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-13 at 14:04, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > I've found a lot of errors like this when loading the OPL3SA2 sound
> >  driver on my old Intel AL440LX computer, running 2.6.0-test3-mm1:
> > 
> >  sound/isa/opl3sa2.c:204: spin_is_locked on uninitialized spinlock
> >  d6200034.
> 
> Does this help?
> 
> diff -puN sound/isa/opl3sa2.c~opl3sa2-lock-init-fix sound/isa/opl3sa2.c
> --- 25/sound/isa/opl3sa2.c~opl3sa2-lock-init-fix	2003-08-13 05:03:32.000000000 -0700
> +++ 25-akpm/sound/isa/opl3sa2.c	2003-08-13 05:04:06.000000000 -0700
> @@ -752,6 +752,7 @@ static int __devinit snd_opl3sa2_probe(i
>  		err = -ENOMEM;
>  		goto __error;
>  	}
> +	spin_lock_init(&chip->reg_lock);
>  	chip->irq = -1;
>  	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
>  		goto __error;
> 
> _
> 

Yes, it does...
Thanks!

