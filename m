Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUHBKBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUHBKBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 06:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266425AbUHBKBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 06:01:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:2804 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264717AbUHBKBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 06:01:01 -0400
Date: Mon, 2 Aug 2004 15:27:41 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: V Srivatsa <vatsa@in.ibm.com>, Nathan Lynch <nathanl@austin.ibm.com>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: CPU hotplug broken in 2.6.8-rc2 ?
Message-ID: <20040802095741.GA4599@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040802094907.GA3945@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802094907.GA3945@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copied to the right email ids to avoid bouncing emails on replies.

Thanks
Dipankar

On Mon, Aug 02, 2004 at 03:19:07PM +0530, Dipankar Sarma wrote:
> Could it be that recent sched domain stuff broke CPU hotplug ?
> While testing cpu hotplug with some RCU changes, I got the following
> panic (while onlining).
> 
> Thanks
> Dipankar
> 
> cpu 0x2: Vector: 380 (Data SLB Access) at [c00000000152f4a0]
>     pc: c00000000004b1b0: .find_busiest_group+0x274/0x464
>     lr: c00000000004b0e4: .find_busiest_group+0x1a8/0x464
>     sp: c00000000152f720
>    msr: 8000000000001032
>    dar: 10
>   current = 0xc000000001520040
>   paca    = 0xc000000000535200
>     pid   = 0, comm = swapper
> enter ? for help
> 2:mon>
> 
> 2:mon> t
> [c00000000152f720] c000000000654f30 (unreliable)
> [c00000000152f830] c00000000004b4cc .rebalance_tick+0x12c/0x2d4
> [c00000000152f920] c00000000005b954 .update_process_times+0xc4/0x154
> [c00000000152f9c0] c0000000000385e8 .smp_local_timer_interrupt+0x3c/0x58
> [c00000000152fa30] c000000000015088 .timer_interrupt+0x11c/0x3fc
> [c00000000152fb10] c00000000000a2b4 Decrementer_common+0xb4/0x100
> --- Exception: 901 (Decrementer) at c000000000013bc0 .default_idle+0x70/0x110
> [c00000000152fe90] c0000000000139e4 .cpu_idle+0x38/0x50
> [c00000000152ff00] c000000000038e18 .start_secondary+0xfc/0x150
> [c00000000152ff90] c00000000000bf20 .enable_64b_mode+0x0/0x28
>                                                                                 
> 2:mon> r
> R00 = 000000000000002b   R16 = 0000000000000040
> R01 = c00000000152f720   R17 = 0000000000000180
> R02 = c0000000006d6d40   R18 = 0000000000000040
> R03 = 0000000000000020   R19 = c000000000828e08
> R04 = 0000000000000020   R20 = 0000000000000002
> R05 = 0000000000000002   R21 = 0000000000000000
> R06 = c00000000073f9b0   R22 = 0000000000000000
> R07 = 000000000000000b   R23 = c00000000152f790
> R08 = c0000000006fc728   R24 = c0000000006d5008
> R09 = 0000000000000015   R25 = c000000000529c38
> R10 = 0000000000000000   R26 = c000000000529c38
> R11 = 0000000000000080   R27 = c00000000073f9b0
> R12 = 0000000028282482   R28 = 0000000000000001
> R13 = c000000000535200   R29 = 0000000000000015
> R14 = c00000000073f980   R30 = c0000000005bbe00
> R15 = 0000000000000000   R31 = c00000000152f720
> pc  = c00000000004b1b0 .find_busiest_group+0x274/0x464
> lr  = c00000000004b0e4 .find_busiest_group+0x1a8/0x464
> msr = 8000000000001032   cr  = 28282488
> ctr = c000000000013b50   xer = 0000000000000000   trap =      380
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
