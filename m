Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbTAJSje>; Fri, 10 Jan 2003 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbTAJSaN>; Fri, 10 Jan 2003 13:30:13 -0500
Received: from [193.158.237.250] ([193.158.237.250]:19337 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265777AbTAJS33>; Fri, 10 Jan 2003 13:29:29 -0500
Date: Fri, 10 Jan 2003 19:38:11 +0100
Message-Id: <200301101838.h0AIcBP05694@mail.intergenia.de>
To: <3E1E50FB.4000301@emageon.com>
From: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440) [rescued]
CC: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pentium 4 Xeon MP processors
> 
> 2 processor system has 4GB RAM
> 4 processor system has 8GB RAM
> 
> 1 IBM ServeRAID controller
> 2 Intel PRO/1000MT NICs
> 2 QLogic 2340 Fibre Channel HBAs
> 
>> Or perhaps the kernel version is not up-to-date. Please also provide
>> the precise kernel version (and included patches). And workload too.
>> 
> The kernel version is stock 2.4.20 with Chris Mason's data logging and journal relocation patches for ReiserFS (neither of which are actually in use for any mounted filesystems). It is compiled for 64GB highmem support. And just to refresh, I have seen this exact behavior on stock 2.4.19 and stock 2.4.17 (no patches on either of these) also compiled with 64GB highmem support.
> 
> Workload:
> When the live-lock occurs, the system is performing intensive network I/O and intensive disk reads from the fibre channel storage (i.e., the backup program is reading files from disk and transferring them to the backup server). I posted a snapshot of sar data collection earlier today showing selected stats leading up to and just after the live-lock occurs (which is noted by a ~2 minute gap in sar logging). After the live-lock is released, the only thing that stands out is an unusual increase in runtime for kswapd (as reported by ps).
> 
> The various Java programs mentioned in prior postings are *mostly* idle at this point in time as it is after hours for our clients.


If you don't have any individual processes that need to be particularly
large (eg > 1Gb of data), I suggest you just cheat^Wfinesse the problem
and move PAGE_OFFSET from C0000000 to 80000000 - will give you more than
twice as much lowmem to play with. I think this might even be a config
option in RedHat kernels.

Martin.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

