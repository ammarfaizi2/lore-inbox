Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTK3Q5e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbTK3Q5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:57:34 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7368 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264938AbTK3Q5b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:57:31 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sun, 30 Nov 2003 17:58:53 +0100
User-Agent: KMail/1.5.4
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
References: <3FC36057.40108@gmx.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de>
In-Reply-To: <20031130165146.GY10679@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301758.53885.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 of November 2003 17:51, Jens Axboe wrote:
> On Sun, Nov 30 2003, Jeff Garzik wrote:
> > Jens Axboe wrote:
> > >On Sun, Nov 30 2003, Bartlomiej Zolnierkiewicz wrote:
> > >>Hmm. actually I was under influence that we have generic ioctls in
> > >> 2.6.x, but I can find only BLKSECTGET, BLKSECTSET was somehow lost. 
> > >> Jens?
> > >
> > >Probably because it's very dangerous to expose, echo something too big
> > >and watch your data disappear.
> >
> > IMO, agreed.
> >
> > Max KB per request really should be set by the driver, as it's a
> > hardware-specific thing that (as we see :)) is often errata-dependent.

Yep.

> Yes, it would be better to have a per-drive (or hwif) extra limiting
> factor if it is needed. For this case it really isn't, so probably not
> the best idea :)
>
> > Tangent:  My non-pessimistic fix will involve submitting a single sector
> > DMA r/w taskfile manually, then proceeding with the remaining sectors in
> > another r/w taskfile.  This doubles the interrupts on the affected
> > chipset/drive combos, but still allows large requests.  I'm not terribly
>
> Or split the request 50/50.

We can't - hardware will lock up.

--bart

