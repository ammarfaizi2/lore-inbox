Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270549AbUJTWhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270549AbUJTWhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270562AbUJTWgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:36:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:4851 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S270547AbUJTWfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:35:55 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <4176A50C.9050303@ru.mvista.com>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
	 <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
	 <20041020094508.GA29080@elte.hu>  <4176A50C.9050303@ru.mvista.com>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1098311753.26596.89.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Oct 2004 15:35:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 10:49, Alexander Batyrshin wrote:
> Ingo Molnar wrote:
> > i have released the -U8 Real-Time Preemption patch:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
> > 
> 
> used i386/defconfig
> 
> 1. at boot
> [...skip...]
> hda: 78242976 sectors (40060 MB) w/2048KiB Cache, CHS=16383/255/63, 
> UDMA(100)
>   hda: hda1 hda2 hda3 hda4 < hda5 >
> BUG: semaphore recursion deadlock detected!
> .. current task khpsbpkt/723 is already holding c04610c0.
> 00001f23 00001f2f c04e8de9 00000086 00000009 00000000 c011b552 00000020
>         00000400 c03b3efa dfdc9f70 dfdc9f50 0000000c dfdc78f0 c011b430 
> c03b3efa
>         dfdc9f70 c01052a5 c03b3efa c03b3efa 00000000 dfdc78f0 dfdc78f0 
> c01fd364
> Call Trace:
>   [<c012caa4>] __kernel_text_address+0x2e/0x37 (24)
>   [<c01051c9>] show_trace+0x4e/0xcc (12)
>   [<c01052c9>] show_stack+0x82/0x97 (36)
>   [<c01fd364>] __rwsem_deadlock+0xd9/0x135 (24)
>   [<c039e2a0>] down_write_interruptible+0xe6/0x202 (48)
>   [<c029dd80>] hpsbpkt_thread+0x2b/0x86 (48)
>   [<c029dd55>] hpsbpkt_thread+0x0/0x86 (12)
>   [<c01024d1>] kernel_thread_helper+0x5/0xb (4)
> preempt count: 00000003
> . 3-level deep critical section nesting:
> .. entry 1: _spin_lock_irqsave+0x19/0x74 / (0x0)
> .. entry 2: _spin_lock+0x19/0x6d / (0x0)
> .. entry 3: print_traces+0x17/0x50 / (0x0)
> [...skip...]


This looks related to IEEE1394 . It has a deadlock in it. Try turning it
off..



Daniel

