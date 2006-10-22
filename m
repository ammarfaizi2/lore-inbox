Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWJVSPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWJVSPc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWJVSPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:15:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48870 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWJVSPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:15:30 -0400
Date: Sun, 22 Oct 2006 11:13:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@muc.de>
Subject: Re: [Nasty crash on boot] was Re: 2.6.19-rc2-mm2
Message-Id: <20061022111352.6b58ef58.akpm@osdl.org>
In-Reply-To: <453B7308.70307@reub.net>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<453B7308.70307@reub.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 23:32:56 +1000
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> Hi,
> 
> On 20/10/2006 6:56 PM, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> > 
> > - Added the IOAT tree as git-ioat.patch (Chris Leech)
> > 
> > - I worked out the git magic to make the wireless tree work
> >   (git-wireless.patch).  Hopefully it will be in -mm more often now.
> 
> I've just moved country so haven't had anything to test with recently, but built 
> up a 2.6.19-rc2-mm2 and it reliably fails to boot.  I'm not sure quite what part 
> of the code has gone wrong here, although it blew up not long after ACPI stuff:
> 
> ...
>
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
> Unable to handle kernel paging request at ffffffff82800000 RIP:
>   [<ffffffff80267849>] dump_trace+0x3a9/0x422
> PGD 203027 PUD 205027 PMD 0
> Oops: 0000 [1] SMP
> last sysfs file:
> CPU 1
> Modules linked in:
> Pid: 5, comm: ksoftirqd/1 Not tainted 2.6.19-rc2-mm2 #1
> RIP: 0010:[<ffffffff80267849>]  [<ffffffff80267849>] dump_trace+0x3a9/0x422
> RSP: 0000:ffff81003f61bbd8  EFLAGS: 00010006
> RAX: 0000000000000000 RBX: e203a5a4e203a4a4 RCX: ffffffff805831a0
> RDX: ffff810037eb6140 RSI: 0000000000000002 RDI: 0000000000000001
> RBP: ffff81003f61bd18 R08: 0000000000000002 R09: 0000000000000002
> R10: ffffffff8029d801 R11: ffffffff80269149 R12: ffffffff827ffff9
> R13: ffff81003f61bfc0 R14: ffffffff8057bb80 R15: ffffffff80727418
> FS:  0000000000000000(0000) GS:ffff81003f6eb398(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: ffffffff82800000 CR3: 0000000000201000 CR4: 00000000000006e0
> Process ksoftirqd/1 (pid: 5, threadinfo ffff81003f610000, task ffff810037eb6140)
> Stack:  ffff810037eb4040 0000000000000001 ffff81003f61bfc0 000000003f61bd40
>   ffffffff80267553 ffffffff80689180 ffffffff804a5074 ffffffff80285ed2
>   0000000000000001 ffff81003f601c40 00001025048b4865 0000000000000246
> Call Trace:
>   [<ffffffff8026c7f7>] save_stack_trace+0x22/0x3e
>   [<ffffffff80296de0>] save_trace+0x50/0xf3
>   [<ffffffff802980c2>] mark_lock+0x82/0x5ba
>   [<ffffffff80298fef>] __lock_acquire+0x43f/0xbd1
>   [<ffffffff802997d0>] lock_acquire+0x4f/0x6f
>   [<ffffffff80262f82>] _spin_lock+0x25/0x34
>   [<ffffffff802bfb18>] cache_flusharray+0x47/0x115
>   [<ffffffff8020b381>] kfree+0xe1/0x120
>   [<ffffffff80344320>] selinux_task_free_security+0x1e/0x20
>   [<ffffffff802470ac>] __put_task_struct+0xb5/0x109
>   [<ffffffff802842fe>] delayed_put_task_struct+0x21/0x23
>   [<ffffffff80290898>] __rcu_process_callbacks+0x162/0x1ed
>   [<ffffffff80290946>] rcu_process_callbacks+0x23/0x44
>   [<ffffffff8028601f>] tasklet_action+0x6b/0xc0
>   [<ffffffff8021173a>] __do_softirq+0x6f/0xf5
>   [<ffffffff8025deec>] call_softirq+0x1c/0x30
>   [<ffffffff80285ed2>] ksoftirqd+0x0/0xb9
>   [<ffffe04480f76600>]
> DWARF2 unwinder stuck at 0xffffe04480f76600
> Leftover inexact backtrace:
> Unable to handle kernel paging request at ffffffff82800000 RIP:
>   [<ffffffff80267849>] dump_trace+0x3a9/0x422
>

lockdep was trying to record the call trace but the unwinder oopsed.

Try disabling CONFIG_LOCKDEP and/or CONFIG_STACK_UNWIND.

>
> Box is a 3.0GHZ x86_64 with 1GB DRAM built with Fedora Core rawhide.
> 
> 2.6.19-rc1-mm1 is the last release that works OK and is stable for me, but I 
> haven't tested any releases between that and this one.  If it's useful I can 
> spend some time on this trying it out this week.
> 
> Reuben
