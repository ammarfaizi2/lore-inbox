Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282944AbRLCIvd>; Mon, 3 Dec 2001 03:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282082AbRLCIuq>; Mon, 3 Dec 2001 03:50:46 -0500
Received: from yuha.menta.net ([212.78.128.42]:27040 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S284329AbRLBWhi>;
	Sun, 2 Dec 2001 17:37:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>, Erik Elmore <lk@bigsexymo.com>
Subject: Re: EXT3 - freeze ups during disk writes
Date: Sun, 2 Dec 2001 23:37:17 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112021310480.29688-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10112021310480.29688-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Message-Id: <01120223371700.01168@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Diumenge 02 Desembre 2001 19:15, Mark Hahn va escriure:
> in other mail I asked Erik about the disk's mode: it is PIO,
> so the pathetic speed and crippling VM/Ext2 performance is
> entirely expected.  I'm guessing he's missing CONFIGs of either
> the chipset-specific driver or one of:
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_BLK_DEV_ADMA=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_AUTO=y
>
> > > I've seen a couple of reports where ext3 appears to exacerbate
> > > the effects of poor hdparm settings.  What is your raw disk
> > > throughput, from `hdparm -t /dev/hda'?
> >
> > `hdparm -t /dev/hda` reports:
> >
> > # hdparm -t /dev/hda
> >
> > /dev/hda:
> >  Timing buffered disk reads:  64 MB in 16.76 seconds =  3.82 MB/sec

maybe the only thing he is missing is the *AUTO configs

you could try:
# /sbin/hdparm -c 1 -d 1 /dev/hda
which tries to do this:
/dev/hda:
 setting 32-bit I/O support flag to 1
 setting using_dma to 1 (on)

and then test again with -t to see if it gets better...
