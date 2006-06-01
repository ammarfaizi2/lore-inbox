Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWFABix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWFABix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWFABix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 21:38:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751500AbWFABiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 21:38:52 -0400
Date: Wed, 31 May 2006 18:43:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531184302.9e79f518.akpm@osdl.org>
In-Reply-To: <20060531182507.aaf1f9fd.rdunlap@xenotime.net>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<20060531182507.aaf1f9fd.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 18:25:07 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Tue, 30 May 2006 02:29:25 -0700 Andrew Morton wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> 
> 
> Some odd panic, reproducible.  .config attached.
> Machine is Pentium-D with 2 GB RAM and SATA drives.
> 

There's nothing odd about a panic in that kernel.

> [   33.232729] netconsole: device eth0 not up yet, forcing it
> [   36.489028] Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> [   36.500245]  [<0000000000000000>] stext+0x7feff0e8/0xe8
> [   36.549518] PGD 0 
> [   36.570488] Oops: 0010 [1] SMP 
> [   36.593713] last sysfs file: 
> [   36.616496] CPU 0 
> [   36.637392] Modules linked in:
> [   36.660367] Pid: 0, comm: idle Not tainted 2.6.17-rc5-mm1 #1
> [   36.688549] RIP: 0010:[<0000000000000000>]  [<0000000000000000>] stext+0x7feff0e8/0xe8
> [   36.704388] RSP: 0000:ffffffff804f4f98  EFLAGS: 00010006
> [   36.749115] RAX: 0000000000001d00 RBX: ffffffff8054fec8 RCX: 0000000000000000
> [   36.780475] RDX: ffffffff8054fec8 RSI: ffffffff80544d00 RDI: 000000000000003a
> [   36.811700] RBP: ffffffff804f4fb0 R08: ffffffff8054e000 R09: 000000000000002f
> [   36.842745] R10: ffff810003002970 R11: ffffffff80512300 R12: 000000000000003a
> [   36.873626] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [   36.904373] FS:  0000000000000000(0000) GS:ffffffff80542000(0000) knlGS:0000000000000000
> [   36.937031] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> [   36.964797] CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006e0
> [   36.995261] Process idle (pid: 0, threadinfo ffffffff8054e000, task ffffffff80441800)
> [   37.027224] Stack: ffffffff8010b711 ffffffff80107d21 0000000000000000 ffffffff8054fef0 
> [   37.043298]        ffffffff80109708  <EOI> 000020250cff65fa 10250c8b4865c900 1fd8e98148000000 
> [   37.076996]        0003582444f70000 00fe6ebf12740000 
> [   37.103370] Call Trace:
> [   37.140640]  <IRQ> [<ffffffff8010b711>] do_IRQ+0x4f/0x5e
> [   37.167285]  [<ffffffff80107d21>] mwait_idle+0x0/0x53
> [   37.193322]  [<ffffffff80109708>] ret_from_intr+0x0/0xa
> [   37.219723]  <EOI>
> [   37.239638] 
> [   37.239639] Code:  Bad RIP value.
> [   37.280189] RIP  [<0000000000000000>] stext+0x7feff0e8/0xe8 RSP <ffffffff804f4f98>
> [   37.310891] CR2: 0000000000000000
> [   37.332934]  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
> [   37.362625]  BUG: warning at kernel/panic.c:138/panic()
> [   37.388627] 
> [   37.388629] Call Trace:
> [   37.426958]  <IRQ> [<ffffffff8012a29b>] panic+0x1f9/0x21e
> [   37.453041]  [<ffffffff801f7dd8>] __up_read+0xaa/0xb2
> [   37.478499]  [<ffffffff80137d51>] blocking_notifier_call_chain+0x47/0x51
> [   37.507365]  [<ffffffff8012ca06>] do_exit+0x8e/0x8e1
> [   37.532615]  [<ffffffff803b03ce>] do_page_fault+0x77a/0x806
> [   37.559092]  [<ffffffff801244b4>] move_tasks+0xf1/0x2a8
> [   37.584878]  [<ffffffff803ae0a3>] _spin_unlock+0x9/0xb
> [   37.610360]  [<ffffffff80109edd>] error_exit+0x0/0x84
> [   37.635490]  [<ffffffff8010b711>] do_IRQ+0x4f/0x5e
> [   37.659887]  [<ffffffff80107d21>] mwait_idle+0x0/0x53
> [   37.684661]  [<ffffffff80109708>] ret_from_intr+0x0/0xa
> [   37.709657]  <EOI>

OK, I think Martin said something about the machine going down early
inside the CPU scheduler.

Are you able to work out what file-n-line move_tasks+0xf1/0x2a8 is at?

gdb vmlinux
(gdb) l *0xffffffff801244b4

Or, if CONFIG_DEBUG_INFO wasn't set:

- Enable CONFIG_DEBUG_INFO
- make vmlinux
- gdb vmlinux
(gdb) p move_tasks
(gdb) l *(0x<address of move_tasks> + 0xf1)

