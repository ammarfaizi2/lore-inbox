Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316364AbSGAT4I>; Mon, 1 Jul 2002 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSGAT4H>; Mon, 1 Jul 2002 15:56:07 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:38219 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S316364AbSGAT4H>;
	Mon, 1 Jul 2002 15:56:07 -0400
Date: Mon, 1 Jul 2002 21:58:32 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hd_geometry question.
Message-ID: <20020701195832.GA21495@win.tue.nl>
References: <200207011802.07212.schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207011802.07212.schwidefsky@de.ibm.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 06:02:07PM +0200, Martin Schwidefsky wrote:

> I have a question about the start field in the hd_geometry structure. We used
> 
> 	geo->start = device->major_info->gendisk.part[MINOR(kdev)].start_sect
> 		>> device->sizes.s2b_shift;
> 
> in the old dasd driver but now we use
> 
> 	geo.start = get_start_sect(kdev);
> 
> to set the start field. One variant is wrong because the start sector differ if
> the block size is not 512 byte. The first variant calculates the start sector
> based on physical blocks (e.g. with 4096 bytes instead of 512 bytes). The
> second variant calulcates a "soft" start sector based on logical 512 byte
> blocks. Whats correct, first or second variant ?? I tend to favor the first
> variant because struct hd_geometry describes the physical geometry
> (number of heads, sectors, cylinders and start sector) but I am not 100%
> sure about it.

About a partition one wants to know start and length.
About a full disk one wants to know size, and perhaps a (fake) geometry.

The vital partition data cannot depend on obscure hardware info.
So, the units used must be well-known. Earlier, everything was in
512-byte sectors, but there are a few places where that is inconvenient
or unnatural, and now that one has more than 2^32 sectors and 64 bits
are needed anyway, things are measured in bytes.

That the start field comes with the HDIO_GETGEO ioctl and the size with
the BLKGETSIZE ioctl is due to history. Both are given in 512-byte sectors.
BLKGETSIZE64 gives bytes.

Andries

