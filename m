Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288731AbSBIIqu>; Sat, 9 Feb 2002 03:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288733AbSBIIqk>; Sat, 9 Feb 2002 03:46:40 -0500
Received: from mtiwmhc26.worldnet.att.net ([204.127.131.51]:58782 "EHLO
	mtiwmhc26.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S288731AbSBIIqa>; Sat, 9 Feb 2002 03:46:30 -0500
Date: Sat, 9 Feb 2002 00:45:03 -0800
From: "Luis A. Montes" <lmontes@worldnet.att.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 filesystem corruption
Message-ID: <20020209004503.C662@penguin.montes2.org>
In-Reply-To: <200202030538.g135chu00602@penguin.montes2.org> <E16XMwN-0004UB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16XMwN-0004UB-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 03, 2002 at 05:44:19 -0800
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002.02.03 05:44 Alan Cox wrote:
> > this list to handle my SiS 735 chipset. It did seem more stable for a
> > while, until I decided to try and enable ultra dma 66 on my primary
> > drive. The two partitions that I had mounted got completely corrupted
> 
> How did you switch on UDMA66 ?
Well, when you mentioned this I remember a couple of things that I probably
shouldn't have done, that's why it took me so long to answer, I went back 
and
systematically tested different kernels on a test partition and taking 
note of
the hdparm's I used. I've still got a couple of kernels I want to test, so 
I
will post more complete results tomorrow. Still the answer seems to be that
2.4.5 is stable while 2.4.17 is not.
But to answer your question, I downloaded a utility from WD that switches 
the
drive from udma 33 to udma 66, and I then boot linux and type
hdparm -c 1 -d 1 -m 8
Last time before I wrote I also used -X66, but I'm not sure that's a good
idea ...

> 
> > hda: Western Digital Caviar WDC AC313000R (it is *not* in the udma
> > black list, should it be?)
> 
> There is certainly no evidence it should be

> 
> > hdb: Western Digital Caviar WDC AC23200L (this one is in the black
> > list, but is not being mounted, so it shouldn't matter, right?)
> 
> Unknown. But you can test that
> 
> > - Was there some change between 2.4.5 and 2.4.17 that could have
> >   introduced problems in the IDE layer? I really tried to test 2.4.5
> 
> For the SiS possibly.
> 
There is something in vanilla 2.4.17. Using the exact same .config and
filesystem as the one for 2.4.5 it crashes while 2.4.5 remains stable.
OTOH, I've finally managed to have an stable system for a week (I'm
actually using it right now) with 2.4.17. The difference is that
it's got the sis5513.c patch from Lionel Bouton that I found in
the lkml. I'm not using dma yet, though! The driver, as the previous
driver for this chipset, disables everything by default (but even
that didn't help for plain 2.4.17) That's what I'm going to test next,
using the above mentioned hdparm line.
