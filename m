Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUGQSrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUGQSrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 14:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbUGQSrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 14:47:21 -0400
Received: from ozlabs.org ([203.10.76.45]:11177 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261232AbUGQSrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 14:47:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16633.20767.128875.570852@cargo.ozlabs.ibm.com>
Date: Sun, 18 Jul 2004 02:17:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jhf@rivenstone.net (Joseph Fannin), linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-mm7
In-Reply-To: <20040709141103.592c4655.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	<20040709203852.GA1997@samarkand.rivenstone.net>
	<20040709141103.592c4655.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> hm, OK.  It could be that the debug patch is a bit too aggressive, or that
> ppc got lucky and happens to always be in state TASK_RUNNING when these
> calls to schedule() occur.
> 
> Maybe this task incorrectly has _TIF_NEED_RESCHED set?

Is CONFIG_PREEMPT enabled?

> Anyway, ppc guys: please take a look at the results from
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken-out/detect-too-early-schedule-attempts.patch
> and check that the kernel really should be calling schedule() at this time
> and place, let us know?
> 
> Thanks.
> 
> >  The first one looks like:
> >
> > Calibrating delay loop... 1064.96 BogoMIPS
> > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > Badness in schedule at kernel/sched.c:2153
> > Call trace:
> >  [c00099e4] dump_stack+0x18/0x28
> >  [c0006bac] check_bug_trap+0x84/0xac
> >  [c0006d38] ProgramCheckException+0x164/0x1a4
> >  [c0006240] ret_from_except_full+0x0/0x4c
> >  [c02021bc] schedule+0x24/0x684
> >  [c0005e80] syscall_exit_work+0x108/0x10c
> >  [c02e0ad0] proc_root_init+0x14c/0x158
> >  [00000000] 0x0
> >  [c02ce5a0] start_kernel+0x158/0x184
> >  [000035fc] 0x35fc

This looks like CONFIG_PREEMPT is enabled and _TIF_NEED_RESCHED is set
at the end of handling a system call.  AFAICS i386 will also call
schedule in these circumstances.  Does this mean we shouldn't do
system calls until the scheduler is running?

Paul.
