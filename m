Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262015AbSJISDr>; Wed, 9 Oct 2002 14:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262037AbSJISDr>; Wed, 9 Oct 2002 14:03:47 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:40875 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262015AbSJISDh> convert rfc822-to-8bit; Wed, 9 Oct 2002 14:03:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Erich Focht <efocht@ess.nec.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Wed, 9 Oct 2002 12:58:08 -0500
X-Mailer: KMail [version 1.4]
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210091826.20759.efocht@ess.nec.de> <1548227964.1034159598@[10.10.2.3]>
In-Reply-To: <1548227964.1034159598@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091258.08379.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm testing on 2.5.41-mm1 ... your patches still apply clean. That
> has a whole bunch of nice NUMA mods, you might want to try that
> instead? All the changes in there will end up in mainline real soon
> anyway ;-)
>
> One minor warning:
>
> arch/i386/kernel/smpboot.c: In function `smp_cpus_done':
> arch/i386/kernel/smpboot.c:1199: warning: implicit declaration of function
> `bld_pools'
>
> And the same panic:
>
> Starting migration thread for cpu 3
> Bringing up 4
> CPU>dividNOWrro!

I got the same thing on 2.5.40-mm1.  It looks like it may be a a divide by 
zero in calc_pool_load.  I am attempting to boot a band-aid version right 
now.  OK, got a little further:

PCI: Cannot allocate resource region 1 of device 03:0a.0
PCI: Cannot allocate resource region 4 of device 03:0e.1
PCI: Cannot allocate resource region 2 of device 05:0a.0
PCI: Cannot allocate resource region 0 of device 05:0b.0
PCI: Cannot allocate resource region 4 of device 05:0e.1
PCI: Cannot allocate resource region 1 of device 07:0a.0
PCI: Cannot allocate resource region 0 of device 07:0b.0
PCI: Cannot allocate resource region 4 of device 07:0e.1
Starting kswapd
d<4>highmem bounce poo
sCPU:    3
eEIP:    0060:[<c011a3d3>]    Not tainted
EFLAGS: 00010046
eax: 00000001   ebx: 00000000   ecx: 00000003   edx: 00000000
esi: c02c98c4   edi: c39c5880   ebp: f0199ee8   esp: f0199ec0
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=f0198000 task=f01c1740)
Stack: c39c58a0 c02c94c8 c02c993c 00000000 c02c94c4 00000000 0000007d c02c94a0 
       00000001 00000003 f0199f1c c0117bec c02c94a0 00000003 00000003 00000001 
       00000000 c01135d1 f01a3f10 00000000 00000003 f01c1740 c02cb4e0 f0199f44 
Call Trace: [<c0117bec>] [<c01135d1>] [<c0117eed>] [<c0122587>] [<c0105420>] 
[<c0125e60>] [<c0113ca7>] [<c0105420>] [<c010818e>] [<c0105420>] [<c0105420>] 
[<c010544a>] [<c01054ea>] [<c011cf50>]
Code: f7 f3 3b 45 e4 7e 06 89 45 e4 89 7d ec 8b 45 d8 8b 00 39 f0 
 
-Andrew Theurer


