Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSJIRaV>; Wed, 9 Oct 2002 13:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261923AbSJIRaV>; Wed, 9 Oct 2002 13:30:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50130 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261921AbSJIRaT>; Wed, 9 Oct 2002 13:30:19 -0400
Date: Wed, 09 Oct 2002 10:33:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Message-ID: <1548227964.1034159598@[10.10.2.3]>
In-Reply-To: <200210091826.20759.efocht@ess.nec.de>
References: <200210091826.20759.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is strange. It works for me really reliably. I added a check
> for non-online CPUs in calc_pool_load and changed the pool_lock to
> be a spinlock. The patches are attached again.

I'm testing on 2.5.41-mm1 ... your patches still apply clean. That
has a whole bunch of nice NUMA mods, you might want to try that 
instead? All the changes in there will end up in mainline real soon
anyway ;-)

One minor warning:

arch/i386/kernel/smpboot.c: In function `smp_cpus_done':
arch/i386/kernel/smpboot.c:1199: warning: implicit declaration of function `bld_pools'

And the same panic:

Starting migration thread for cpu 3
Bringing up 4
CPU>dividNOWrro!
                 0St0
igrU:    4
ead :or  0060:[<c011422d>]    Not tainted
EFLAGS: 00010046
EIP is at calc_pool_load+0x115/0x12c
eax: 00000000   ebx: 00000001   ecx: c028f948   edx: 00000000
esi: c034f380   edi: 00000020   ebp: c3a37efc   esp: c3a37ed4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c3a36000 task=f01bf060)
Stack: c028f948 c028efa0 f01bf060 00002928 00002944 00002944 ffffffff ffffffff 
       c028efa0 ffffffff c3a37f78 c01142d1 c028f948 00000004 00000001 00000001 
       c3a36000 c028efa0 f01bf060 00000010 00000008 00000000 00000001 00002a13 
Call Trace:
 [<c01142d1>] load_balance+0x8d/0x5c8
 [<c0118a9d>] call_console_drivers+0xdd/0xe4
 [<c0118cd2>] release_console_sem+0x42/0xa4
 [<c0114c21>] schedule+0xd5/0x3ac
 [<c0105300>] default_idle+0x0/0x34
 [<c01053bf>] cpu_idle+0x43/0x48
 [<c0118cd2>] release_console_sem+0x42/0xa4
 [<c0118c2d>] printk+0x125/0x140

Code: f7 3c 9e 89 84 99 80 00 00 00 8b 45 f4 5b 5e 5f 89 ec 5d c3 

