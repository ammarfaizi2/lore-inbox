Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135826AbRD2Q16>; Sun, 29 Apr 2001 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135827AbRD2Q1s>; Sun, 29 Apr 2001 12:27:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4482 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135826AbRD2Q1c>;
	Sun, 29 Apr 2001 12:27:32 -0400
Date: Sun, 29 Apr 2001 12:27:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Frank de Lange <frank@unternet.org>
cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
In-Reply-To: <20010429181809.A10479@unternet.org>
Message-ID: <Pine.GSO.4.21.0104291225130.2210-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Apr 2001, Frank de Lange wrote:

> Running 'nget v0.7' (a command line nntp 'grabber') on 2.4.4 leads to massive
> amounts of memory disappearing in thin air. I'm currently running a single
> instance of this app, and I'm seeing the memory drain away. The system has 256
> MB of physycal memory, and access to 500 MB of swap. Swap is not really being
> used now, but it soon will be. Have a look at the current /proc/meminfo:
> 
> [frank@behemoth mozilla]$ cat /proc/meminfo 
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  262049792 259854336  2195456        0  1773568 31211520
> Swap: 511926272     4096 511922176
> MemTotal:       255908 kB
> MemFree:          2144 kB
> MemShared:           0 kB
> Buffers:          1732 kB
> Cached:          30480 kB
> Active:          26944 kB
> Inact_dirty:      2384 kB
> Inact_clean:      2884 kB
> Inact_target:      984 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       255908 kB
> LowFree:          2144 kB
> SwapTotal:      499928 kB
> SwapFree:       499924 kB

What about /proc/slabinfo? Notice that 2.4.4 (and couple of the 2.4.4-pre)
has a bug in prune_icache() that makes it underestimate the amount of
freeable inodes.

