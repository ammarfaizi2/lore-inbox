Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262163AbSI3QMu>; Mon, 30 Sep 2002 12:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262268AbSI3QMu>; Mon, 30 Sep 2002 12:12:50 -0400
Received: from gate.perex.cz ([194.212.165.105]:39698 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262163AbSI3QMt>;
	Mon, 30 Sep 2002 12:12:49 -0400
Date: Mon, 30 Sep 2002 18:17:54 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "David S. Miller" <davem@redhat.com>,
       "jgarzik@pobox.com" <jgarzik@pobox.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "alan@redhat.com" <alan@redhat.com>
Subject: Re: [PATCH] ALSA update [6/10] - 2002/07/20
In-Reply-To: <1033390451.16337.33.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0209301812550.503-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Sep 2002, Alan Cox wrote:

> On Mon, 2002-09-30 at 01:53, David S. Miller wrote:
> >    From: Jaroslav Kysela <perex@suse.cz>
> >    Date: Sun, 29 Sep 2002 22:34:51 +0200 (CEST)
> >     
> >    -	if (hwdev == NULL || ((u32)hwdev->dma_mask != 0xffffffff))
> >    +	if (hwdev == NULL || (u32)hwdev->dma_mask <= 0x00ffffff)
> >     		gfp |= GFP_DMA;
> > 
> > So alan, why is this really broken?
> > 
> > EISA/ISA DMA is defined as using a hwdev of NULL or requiring
> > <16MB address, he is preserving GFP_DMA in those cases.
> 
> Firstly the DMA mask on x86 can't be below 24bits, we don't support
> allocation from a smaller zone. Secondly what about PCI for 25-31bits -
> there we do need to force gfp_dma to have any chance of getting the
> right pages

Not really. The test in original code - if the page is in right area - was 
bellow first allocation. Sure, it's dirty hack.

> Giving the page allocator a mask argument does sound a lot nicer

Right, my aim was to point to a bug. Let's go to create proper DMA 
allocation for broken hardware. I still wonder why hardware vendors are 
lazy to support full bus addressing. Perhaps, saving few coins per 
chip make them happy.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

