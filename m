Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262806AbTAJFIc>; Fri, 10 Jan 2003 00:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262808AbTAJFIc>; Fri, 10 Jan 2003 00:08:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:6613 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262806AbTAJFIb>; Fri, 10 Jan 2003 00:08:31 -0500
Date: Thu, 09 Jan 2003 21:17:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brian Tinsley <btinsley@emageon.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
Message-ID: <887390000.1042175828@titus>
In-Reply-To: <3E1E50FB.4000301@emageon.com>
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com> <3E1E410E.5050905@emageon.com> <20030110035412.GJ23814@holomorphy.com> <3E1E4757.3060206@emageon.com> <20030110041918.GK23814@holomorphy.com> <3E1E50FB.4000301@emageon.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IBM x360
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

