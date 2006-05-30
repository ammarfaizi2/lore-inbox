Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWE3MOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWE3MOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWE3MOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:14:45 -0400
Received: from mail.gmx.de ([213.165.64.20]:34697 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751427AbWE3MOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:14:45 -0400
X-Authenticated: #14349625
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060530120641.GA8263@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <20060530111138.GA5078@elte.hu> <1148990326.7599.4.camel@homer>
	 <1148990725.8610.1.camel@homer>  <20060530120641.GA8263@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:17:02 +0200
Message-Id: <1148991422.8610.8.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:06 +0200, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > On Tue, 2006-05-30 at 13:58 +0200, Mike Galbraith wrote:
> > 
> > > =====================================================
> > > [ BUG: possible circular locking deadlock detected! ]
> > > -----------------------------------------------------
> > > mount/2545 is trying to acquire lock:
> > >  (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa
> > > 
> > > ...and deadlocks.
> > > 
> > > I'll try to find out what it hates.
> > 
> > It hates NTFS.
> 
> i'd still love to figure out what's going on here.
> 
> hmm ... do you have the NMI watchdog enabled? Could you try with 
> nmi_watchdog=0?

I have nmi_watchdog=1.  I'll reboot with 0 and see if it'll trigger.

I found a warning.

ip6_tables: (C) 2000-2006 Netfilter Core Team
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8191 buckets, 65528 max) - 228 bytes per conntrack
BUG: warning at kernel/lockdep.c:2398/check_flags()
 <b1003dd2> show_trace+0xd/0xf  <b10044c0> dump_stack+0x17/0x19
 <b103ae46> check_flags+0x26e/0x273  <b103da2c> lockdep_release+0x1e/0x3e6
 <b13d2d10> _spin_unlock_irq+0x16/0x3b  <b13d21aa> rwsem_down_read_failed+0x64/0x1d0
 <b10a76fa> .text.lock.task_mmu+0x3d/0x63  <b10a8b6b> proc_pid_follow_link+0x2b/0x3a
 <b1081a9b> __link_path_walk+0xc1d/0xe98  <b1081d5c> link_path_walk+0x46/0xc6
 <b1082057> do_path_lookup+0x10f/0x281  <b108298a> __user_walk_fd+0x32/0x45
 <b107b81a> vfs_stat_fd+0x1b/0x41  <b107b8cd> vfs_stat+0x11/0x13
 <b107b8e3> sys_stat64+0x14/0x28  <b13d3043> syscall_call+0x7/0xb
irq event stamp: 3101
hardirqs last  enabled at (3101): [<b13d3081>] restore_nocheck+0x8/0xb
hardirqs last disabled at (3100): [<b13d27b5>] _spin_lock_irq+0xf/0x48
softirqs last  enabled at (3094): [<b1028ae7>] __do_softirq+0xe4/0xf5
softirqs last disabled at (3085): [<b10056f4>] do_softirq+0x5a/0xca
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:02:02.1[A] -> GSI 18 (level, low) -> IRQ 17
bt878_probe: card id=[0x1c11bd],[ Pinnacle PCTV Sat ] has DVB functions.
bt878(0): Bt878 (rev 17) at 02:02.1, <6>input: i2c IR (Hauppauge) as /class/input/input2
ir-kbd-i2c: i2c IR (Hauppauge) detected at i2c-0/0-001a/ir0 [bt878 #0 [hw]]
irq: 17, latency: 32, memory: 0xea101000
saa7130/34: v4l2 driver version 0.2.14 loaded


