Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTK3SFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 13:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbTK3SFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 13:05:33 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35794 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262792AbTK3SFa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 13:05:30 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sun, 30 Nov 2003 19:07:01 +0100
User-Agent: KMail/1.5.4
Cc: Jeff Garzik <jgarzik@pobox.com>, marcush@onlinehome.de, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <3FC36057.40108@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <3FCA26AA.90302@gmx.de>
In-Reply-To: <3FCA26AA.90302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301907.01152.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 of November 2003 18:19, Prakash K. Cheemplavam wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > In 2.6.x there is no max_kb_per_request setting in
> > /proc/ide/hdx/settings. Therefore
> > 	echo "max_kb_per_request:128" > /proc/ide/hde/settings
> > does not work.
> >
> > Hmm. actually I was under influence that we have generic ioctls in 2.6.x,
> > but I can find only BLKSECTGET, BLKSECTSET was somehow lost.  Jens?
> >
> > Prakash, please try patch and maybe you will have 2 working drivers now
> > :-).
>
> OK, this driver fixes the transfer rate problem. Nice, so I wanted to do
> the right thing, but it didn't work, as you explained... Thanks.

Cool.

> Nevertheless there is still the issue left:
>
> hdparm -d1 /dev/hde makes the drive get major havoc (something like:
> ide: dma_intr: status=0x58 { DriveReady, SeekCOmplete, DataRequest}
>
> ide status timeout=0xd8{Busy}; messages taken from swsups kernal panic
> ). Have to do a hard reset. I guess it is the same reason why swsusp
> gets a kernel panic when it sends PM commands to siimage.c. (Mybe the
> same error is in libata causing the same kernel panic on swsusp.)
>
> Any clues?

Strange.  While doing 'hdparm -d1 /dev/hde' the same code path is executed
which is executed during boot so probably device is in different state or you
hit some weird driver bug :/.

And you are right, thats the reason why swsusp panics.

--bart

