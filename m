Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315879AbSEGPoW>; Tue, 7 May 2002 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315878AbSEGPoV>; Tue, 7 May 2002 11:44:21 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:30731 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S315879AbSEGPoU>; Tue, 7 May 2002 11:44:20 -0400
Date: Tue, 7 May 2002 10:44:13 -0500
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gzip vs. bzip2 (mainly de-)compression "benchmark"
Message-ID: <20020507154413.GW4049@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Mark Mielke]
> For floppy disks, it is doubtful that the image could be read off the
> floppy faster than even older computers could un-bzip2 the images,
> meaning that execution time is irrelevant in this context.

Well, first, the disk reads are performed by the boot loader, so to run
the two steps concurrently you'd have to do the decompression stage in
the boot loader as well.  In which case what you really want is an
uncompressed image format, bzip2'd after the fact.  A hypothetical
bImage.bz2, if you will.

The other problem with your statement is that bzip2 (unlike gzip) is
block-oriented: you can't start until you have a pretty big chunk of
the input data.  (I could be wrong, but I believe you need the same
block size you compressed with - whatever 900k compresses to, in the
case of maximum compression.)  So that would limit the amount of
parallelisation you could get within LILO anyway.
