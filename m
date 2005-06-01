Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVFAGRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVFAGRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 02:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVFAGRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 02:17:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:56227 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261289AbVFAGQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 02:16:57 -0400
Date: Tue, 31 May 2005 23:15:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: mingo@elte.hu, piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] improve SMP reschedule and idle routines
Message-Id: <20050531231553.786a2994.akpm@osdl.org>
In-Reply-To: <4296EA77.2030605@yahoo.com.au>
References: <4296CA7A.4050806@cyberone.com.au>
	<20050527085726.GA20512@elte.hu>
	<4296EA77.2030605@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>  Make some changes to the NEED_RESCHED and POLLING_NRFLAG to reduce
>  confusion, and make their semantics rigid. Also have preempt explicitly
>  disabled in idle routines. Improves efficiency of resched_task and some
>  cpu_idle routines.

This patch, with or without sched-resched-optimisation-fix.patch causes my
x86_64 box to soil its pants.  

I'll try to get -mm2 out the door - maybe there was some interaction with
something else.



CPU: Trace cache: 12K uops, L1 D cache: 16K                                     
CPU: L2 cache: 1024K                       
CPU: Physical Processor ID: 3
CPU1: Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
CPU 1: Syncing TSC to CPU 0.                               
Bo6tCng 2r sencor 2iz diTS6000 hspPf ff81a07ffiff 8
cyclesrsi mng Cr 923                               
       tinofdelck p ing ad 2 ssaetediupr
/7PUipL6 cachs: 1ff4K100CPU: Ph8-11[1)ease U:teraee ca -e-------o
                                icIn tracizing CPU 0
.4PU:zTsaep iach04uoiigg enabled ciM1) rou   e.. 680 . 1  oIntIP(R)lpjo1360) 29) 
tC U:U hyLr Dn ache: 16K40)CPUCPU 2c cyn: n024KC
sCarte Thermal monitoring enabled (TM1)
                  Intel(R) Xeon(TM) CPU 3.40GHz stepping 04
APIC error on CPU3: 00(40)                                 
CPU 3: Syncing TSC to CPU 0.
Kernel BUG at "kernel/sched.c":2805
invalid operand: 0000 [1] PREEMPT SMP 
CPU 2                                 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.12-rc5-mm2
RIP: 0010:[<ffffffff8012a97a>] <ffffffff8012a97a>{sub_preempt_count+22}
RSP: 0018:ffff81007ff7fef0  EFLAGS: 00010297                           
RAX: ffff81007ff7ffd8 RBX: ffffffff805d8180 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000001
RBP: ffff81007ff7fef0 R08: 00000000fffffff9 R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000000 R12: 00000000000011d1
R13: ffff81007ff7ff18 R14: ffff81007ff7ff20 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffffff805a3400(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b                           
CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81007ff7e000, task ffff81007ff740d0)
Stack: 0000000000000040 ffffffff8010beed ffffffffffffff67 ffffffff805b77c9  
       0000000000000246 0000000000000270 00000000000003af 0000000000000000 
       0000000000000000 0000000000000000                                   
Call Trace:<ffffffff8010beed>{cpu_idle+94} <ffffffff805b77c9>{start_secondary+531}
                                                                                  
       
Code: 0f 0b c4 7e 3d 80 ff ff ff ff f5 0a 81 ff fe 00 00 00 3e 77 
RIP <ffffffff8012a97a>{sub_preempt_count+22} RSP <ffff81007ff7fef0>
 <0>>ePnel payic -onoted nSC gi htCempte( tst iil  46 cyclesa ka   
                                                                errPU 1: synlhs)
                                                                                izeo tSo kuththrea0 ( ssartif  -1
                                                                                                                 63)
Brought up 4 CPUs                                                                                                  
