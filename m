Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSGGQoo>; Sun, 7 Jul 2002 12:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSGGQon>; Sun, 7 Jul 2002 12:44:43 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:25768 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316113AbSGGQon>; Sun, 7 Jul 2002 12:44:43 -0400
Date: Sun, 7 Jul 2002 18:47:07 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Thunder from the hill <thunder@ngforever.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE 96 and __ata_end_request()
In-Reply-To: <Pine.LNX.4.44.0207061734500.10105-100000@hawkeye.luckynet.adm>
Message-ID: <Pine.SOL.4.30.0207071843430.1945-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 6 Jul 2002, Thunder from the hill wrote:

> Hi,
>
> Just a small question about IDE 96: in __ata_end_request(), we do
>
> 	spin_lock_irqsave(ch->lock, flags);
>
> 	BUG_ON(!(rq->flags & REQ_STARTED));
>
> Shouldn't we rather flip these two, or much rather move
> spin_lock_irqsave() even more down, below
>
> 	if (!nr_secs)
> 		nr_secs = rq->hard_cur_sectors;
>
> since it hasn't got any use to hold a spin lock until the udma_enable &
> co.? However, I'd at least move it below the BUG_ON().
>
> 							Regards,
> 							Thunder

We can move spin_lock_irqsave() down, below if (!nr_secs), thanks.

Regards
--
Bartlomiej

