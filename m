Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264412AbSIVRIm>; Sun, 22 Sep 2002 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264417AbSIVRIm>; Sun, 22 Sep 2002 13:08:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42173 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264412AbSIVRIl>; Sun, 22 Sep 2002 13:08:41 -0400
Date: Sun, 22 Sep 2002 10:11:57 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <78206124.1032689516@[10.10.2.3]>
In-Reply-To: <200209221030.32323.efocht@ess.nec.de>
References: <200209221030.32323.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> would you please check the boot messages for the NUMA scheduler before
> doing the run. Martin sent me an example where he has:
> 
> CPU pools : 1
> pool 0 :0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
> node level 0 : 10
> pool_delay matrix:
>  129 
> 
> which is clearly wrong. In that case we need to fix the cpu-pools setup
> first.

OK, well I hacked this for now:

sched.c somewhere:
- lnode_number[i] = pnode_to_lnode[SAPICID_TO_PNODE(cpu_physical_id(i))];
+ lnode_number[i] = i/4;

Which makes the pools work properly. I think you should just use
the cpu_to_node macro here, but the hack will allow us to do some
testing.

Results, averaged over 5 kernel compiles:

Before:
Elapsed: 20.82s User: 191.262s System: 59.782s CPU: 1206.4%
After:
Elapsed: 21.918s User: 190.224s System: 59.166s CPU: 1137.4%

So you actually take a little less horsepower to do the work, but 
don't utilize the CPUs quite as well, so elapsed time is higher.
I seem to recall getting better results from Mike's quick hack
though ... that was a long time back. What were the balancing 
issues you mentioned?

M.

