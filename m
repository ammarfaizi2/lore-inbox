Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133117AbRDRNFq>; Wed, 18 Apr 2001 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133118AbRDRNFg>; Wed, 18 Apr 2001 09:05:36 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:13642 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S133117AbRDRNF0>; Wed, 18 Apr 2001 09:05:26 -0400
Date: Wed, 18 Apr 2001 13:49:24 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: Laurent Chavet <lchavet@av.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a way to turn file caching off ?
In-Reply-To: <3ADC7144.36E715C5@av.com>
Message-ID: <Pine.LNX.3.96.1010418134153.20558A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A similar phenomenon happens when you simply copy a file - file A is read
into the cache and file B is written to the cache, until the memory runs
out. Then both start to flush at the same time, creating a horrible
performance hit (especially if A and B are on the same disk :) 

I don't know a way to fix this except having the kernel correctly identify
the access pattern and optimize for it (i.e. if it recognizes that cache
pages are flushed in order to make room for more pages from the same
inode, then it's probably a suboptimal caching pattern and instead it
should probably increase the readahead and flush bigger chunks of pages at
the same time). I don't think anything can be done to the writing queue
(except maybe make the kernel understand that seek-time is more expensive
than transfer-time, so it does not schedule the read/writeing each odd
page..)

I'm still using 2.4.0 though so maybe this behaviour has been fixed to the
better in later kernels.. 

As a sidenote, try the same thing on an WinNT box and watch it die :) Like
unpacking a 1 GB file on a machine with 128 MB ram.. after it has unpacked
the first 100 MB's or so, performance drops to 1% or something..

-BW

On Tue, 17 Apr 2001, Laurent Chavet wrote:
>     First cache grows to the size of RAM (2GB) with transfer rate
> slowing down as the cache grows.
>     Then the transfer rates drops a lot (2 to 3 time slower than the
> drive capacity) and there is a very high CPU usage of system time (more
> than a CPU) used by bdflush and kswapd (and some others like kupdated).

