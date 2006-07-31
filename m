Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWGaE55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWGaE55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbWGaE55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:57:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1177 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750917AbWGaE54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:57:56 -0400
Date: Sun, 30 Jul 2006 21:57:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com, ak@muc.de
Subject: Re: 2.6.18-rc2-mm1
Message-Id: <20060730215739.f8a31429.akpm@osdl.org>
In-Reply-To: <44CD8A34.5030305@reub.net>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<44CD8A34.5030305@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 16:42:28 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> 
> 
> On 27/07/2006 8:56 p.m., Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/
> > 
> > - git-klibc has been dropped due to very bad parallel-make problems.
> > 
> > - Added a new line to the boilerplate, below!
> > 
> > - Added Sam's lxdialog tree, as git-lxdialog.patch.  You no longer need
> >   x-ray spectacles to read the menuconfig screens.
> > 
> > - Lots of random patches.  Many of them are bugfixes and I shall, as usual,
> >   go through them all identifying 2.6.18 material.  But I can miss things, so
> >   please don't be afraid to point 2.6.18 candidates out to me.
> > 
> >   I also have, as usual, a number of bugfixes agains the git trees.  I'll
> >   send these to the maintainers until they stick and then I lose track of
> >   them.  So don't be afraid to send reminders to the subsystem maintainers
> >   either.
> 
> Just had this come out on the console:
> 
> (x86_64 - maybe unwinder related?)
> 
> Jul 31 16:35:01 tornado kernel: kjournald starting.  Commit interval 5 seconds
> Jul 31 16:35:01 tornado kernel: EXT3 FS on sdb1, internal journal
> Jul 31 16:35:01 tornado kernel: EXT3-fs: mounted filesystem with ordered data mode.
> Jul 31 16:35:01 tornado kernel: php[28644]: segfault at 00007fff064edfe8 rip 
> 0000003852a718a8 rsp 00007fff064edfd0 error 6

Please watch the wrodwrapping - it makes things harder to read.

> Jul 31 16:35:01 tornado kernel: general protection fault: 0000 [1] SMP
> Jul 31 16:35:01 tornado kernel: last sysfs file: /block/fd0/dev
> Jul 31 16:35:01 tornado kernel: CPU 1
> Jul 31 16:35:01 tornado kernel: Modules linked in: hidp rfcomm l2cap bluetooth 
> ipv6 ip_gre iptable_filter iptable_nat ip_nat i
> p_conntrack nfnetlink iptable_mangle ip_tables binfmt_misc i2c_i801 serio_raw 
> iTCO_wdt
> Jul 31 16:35:01 tornado kernel: Pid: 15189, comm: nagios Not tainted 
> 2.6.18-rc2-mm1 #2
> Jul 31 16:35:01 tornado kernel: RIP: 0010:[<ffffffff8028f1d1>] 
> [<ffffffff8028f1d1>] notifier_call_chain+0x1e/0x45
> Jul 31 16:35:01 tornado kernel: RSP: 0018:ffff810020d35d58  EFLAGS: 00010202
> Jul 31 16:35:01 tornado kernel: RAX: 6b6b6b6b6b6b6b6b RBX: ffff81003913f100 RCX: 
> 6b6b6b6b6b6b6b6b
> Jul 31 16:35:01 tornado kernel: RDX: ffff81003913f100 RSI: 0000000000000001 RDI: 
> ffff81001fd8cec0
> Jul 31 16:35:01 tornado kernel: RBP: ffff810020d35d78 R08: 0000000000000000 R09: 
> 0000000000000001
> Jul 31 16:35:01 tornado kernel: R10: 0000000000000001 R11: 0000000000000001 R12: 
> ffff81003913f100
> Jul 31 16:35:01 tornado kernel: R13: 0000000000000001 R14: ffff81003913f100 R15: 
> ffff81003913f100
> Jul 31 16:35:01 tornado kernel: FS:  00002b1be57ae450(0000) 
> GS:ffff81003f6eb430(0000) knlGS:0000000000000000
> Jul 31 16:35:01 tornado kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> Jul 31 16:35:01 tornado kernel: CR2: 0000000000884ab0 CR3: 0000000034634000 CR4: 
> 00000000000006e0
> Jul 31 16:35:01 tornado kernel: Process nagios (pid: 15189, threadinfo 
> ffff810020d34000, task ffff81002ff8c0c0)
> Jul 31 16:35:01 tornado kernel: Stack:  ffff810020d35d88 ffff81003913f100 
> 0000000000000001 0000000001200011
> Jul 31 16:35:01 tornado kernel:  ffff810020d35d88 ffffffff8028f226 
> ffff810020d35da8 ffffffff8028f61f
> Jul 31 16:35:01 tornado kernel:  ffff810020d36000 ffff81002ff8c0c0 
> ffff810020d35e78 ffffffff8021eafc
> Jul 31 16:35:01 tornado kernel: Call Trace:
> Jul 31 16:35:01 tornado kernel:  [<ffffffff8028f226>] 
> raw_notifier_call_chain+0x9/0xb
> Jul 31 16:35:01 tornado kernel:  [<ffffffff8028f61f>] notify_watchers+0x64/0x69
> Jul 31 16:35:01 tornado kernel:  [<ffffffff8021eafc>] copy_process+0x4dc/0x15c0
> Jul 31 16:35:01 tornado kernel:  [<ffffffff80231867>] do_fork+0xf7/0x210
> Jul 31 16:35:01 tornado kernel:  [<ffffffff802692f7>] sys_clone+0x23/0x25
> Jul 31 16:35:01 tornado kernel:  [<ffffffff8025f7af>] ptregscall_common+0x67/0xac
> Jul 31 16:35:01 tornado kernel: DWARF2 unwinder stuck at ptregscall_common+0x67/0xac

That looks like the task-watchers versus delay-accounting bug.  The word on
the street is "change WATCH_TASK_CLONE to WATCH_TASK_INIT in the
delayacct_watch_task function", but nobody has done a patch.

I'm angling to drop the task-watchers patches from next -mm.

> Jul 31 16:35:01 tornado kernel: Leftover inexact backtrace:
> Jul 31 16:35:01 tornado kernel:
> Jul 31 16:35:01 tornado kernel:
> Jul 31 16:35:02 tornado kernel: Code: 48 8b 59 08 4c 89 e2 4c 89 ee 48 89 cf ff 
> 11 66 85 c0 78 08

I think Jan has a fix for that in the works.

> Jul 31 16:35:02 tornado kernel: RIP  [<ffffffff8028f1d1>] 
> notifier_call_chain+0x1e/0x45
> Jul 31 16:35:02 tornado kernel:  RSP <ffff810020d35d58>
> 
> I've applied only one patch to the generic -rc2-mm1 that is in the newer -mm - 
> the x86_64-unwinder-fix.patch.  That fixed the problem I had with the backtraces 
> repeating over and over until the kernel panicked.
> 

OK, thanks.  But the "DWARF2 unwinder stuck" problem remains.

