Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbTDLCGY (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 22:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTDLCGY (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 22:06:24 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:42137 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263050AbTDLCGS (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 22:06:18 -0400
Date: Sat, 12 Apr 2003 12:16:38 +1000
From: CaT <cat@zip.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@zip.com.au,
       adilger@clusterfs.com
Subject: Re: 2.5.66: slow to friggin slow journal recover
Message-ID: <20030412021638.GA650@zip.com.au>
References: <20030401100237.GA459@zip.com.au> <20030401022844.2dee1fe8.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030401022844.2dee1fe8.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 02:28:44AM -0800, Andrew Morton wrote:
> If the journal recovery is still slow then try capturing the state when it is
> stuck with sysrq-T.

It finally didn't kill it. This is what it's like when it's not doing
anything (ie no disk access). Once Again, after this I had to ^c it to
get some progress on the booting (ie let mount handle journal recovery).

Something I realised last night though is that this happens when I get
sudden power off. Not everytime but most of the time and as such reboot
-f wont help as I think that lets everything finish nicely.

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S FFFBB2FE 39392     1      0     2               (NOTLB)
Call Trace:
 [<c0120b5e>] schedule_timeout+0x7a/0xa0
 [<c0120ad4>] process_timeout+0x0/0x10
 [<c0151227>] do_select+0x1a3/0x1dc
 [<c0150f38>] __pollwait+0x0/0x9c
 [<c0151590>] sys_select+0x304/0x424
 [<c0108cf3>] syscall_call+0x7/0xb

ksoftirqd/0   S C12AC000 4294955984     2      1             3       (L-TLB)
Call Trace:
 [<c011d93c>] ksoftirqd+0x24/0x9c
 [<c011d974>] ksoftirqd+0x5c/0x9c
 [<c011d918>] ksoftirqd+0x0/0x9c
 [<c0107211>] kernel_thread_helper+0x5/0xc

events/0      S CFFE889C 4294946240     3      1             4     2 (L-TLB)
Call Trace:
 [<c0125bd9>] worker_thread+0x105/0x238
 [<c0125ad4>] worker_thread+0x0/0x238
 [<c0287b60>] fb_flashcursor+0x0/0x34
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0107211>] kernel_thread_helper+0x5/0xc

khubd         S C1396000 944048     4      1             5     3 (L-TLB)
Call Trace:
 [<c029ca10>] usb_hub_thread+0x0/0xe0
 [<c029ca97>] usb_hub_thread+0x87/0xe0
 [<c029ca10>] usb_hub_thread+0x0/0xe0
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0107211>] kernel_thread_helper+0x5/0xc

pdflush       S C1387FE0 876960     5      1             6     4 (L-TLB)
Call Trace:
 [<c013156b>] __pdflush+0x7b/0x160
 [<c0131650>] pdflush+0x0/0x14
 [<c013165f>] pdflush+0xf/0x14
 [<c0107211>] kernel_thread_helper+0x5/0xc

pdflush       S C1385FE0  6592     6      1             7     5 (L-TLB)
Call Trace:
 [<c013156b>] __pdflush+0x7b/0x160
 [<c0131650>] pdflush+0x0/0x14
 [<c013165f>] pdflush+0xf/0x14
 [<c0107211>] kernel_thread_helper+0x5/0xc

kswapd0       S C1381F44 4294951296     7      1             8     6 (L-TLB)
Call Trace:
 [<c0135e8e>] kswapd+0xd2/0xf8
 [<c0135dbc>] kswapd+0x0/0xf8
 [<c0108d1a>] work_resched+0x5/0x16
 [<c0119088>] autoremove_wake_function+0x0/0x3c
 [<c0119088>] autoremove_wake_function+0x0/0x3c
 [<c0107211>] kernel_thread_helper+0x5/0xc

aio/0         S C13BB9DC 4294944656     8      1             9     7 (L-TLB)
Call Trace:
 [<c0125bd9>] worker_thread+0x105/0x238
 [<c0125ad4>] worker_thread+0x0/0x238
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0107211>] kernel_thread_helper+0x5/0xc

kpnpbiosd     S FFFBB59F 4294823328     9      1            10     8 (L-TLB)
Call Trace:
 [<c0120b5e>] schedule_timeout+0x7a/0xa0
 [<c0120ad4>] process_timeout+0x0/0x10
 [<c0219767>] pnp_dock_thread+0x53/0xf0
 [<c0219714>] pnp_dock_thread+0x0/0xf0
 [<c0107211>] kernel_thread_helper+0x5/0xc

kseriod       S CFDC0000 245617584    10      1            11     9 (L-TLB)
Call Trace:
 [<c02c051c>] serio_thread+0x0/0xf0
 [<c02c05a7>] serio_thread+0x8b/0xf0
 [<c02c051c>] serio_thread+0x0/0xf0
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0107211>] kernel_thread_helper+0x5/0xc

kjournald     S CFD12000   352    11      1            12    10 (L-TLB)
Call Trace:
 [<c0118218>] interruptible_sleep_on+0x48/0x5c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c017dc58>] kjournald+0x130/0x1b4
 [<c017db28>] kjournald+0x0/0x1b4
 [<c017db10>] commit_timeout+0x0/0x10
 [<c0107211>] kernel_thread_helper+0x5/0xc

init          S CFD1134C 4293920624    12      1    13            11 (NOTLB)
Call Trace:
 [<c011c814>] sys_wait4+0xa8/0x218
 [<c011c94d>] sys_wait4+0x1e1/0x218
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0108cf3>] syscall_call+0x7/0xb

rcS           S CFD10D3C 4293856640    13     12    34               (NOTLB)
Call Trace:
 [<c011c814>] sys_wait4+0xa8/0x218
 [<c011c94d>] sys_wait4+0x1e1/0x218
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0108cf3>] syscall_call+0x7/0xb

rcS           S CFD1072C 4292703120    34     13    37               (NOTLB)
Call Trace:
 [<c011c814>] sys_wait4+0xa8/0x218
 [<c011c94d>] sys_wait4+0x1e1/0x218
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0108cf3>] syscall_call+0x7/0xb

fsck          S current  4291623328    37     34    40               (NOTLB)
Call Trace:
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0118040>] default_wake_function+0x0/0x1c
 [<c0108cf3>] syscall_call+0x7/0xb

fsck.ext3     R CF971E28 4293902656    40     37                     (NOTLB)
Call Trace:
 [<c0118a2e>] io_schedule+0xe/0x18
 [<c012cde8>] wait_on_page_bit+0x9c/0xb8
 [<c0119088>] autoremove_wake_function+0x0/0x3c
 [<c0119088>] autoremove_wake_function+0x0/0x3c
 [<c012d3a2>] do_generic_mapping_read+0x1be/0x328
 [<c012d7a0>] __generic_file_aio_read+0x184/0x1a0
 [<c012d50c>] file_read_actor+0x0/0x110
 [<c012d887>] generic_file_read+0x7f/0x9c
 [<c0138618>] handle_mm_fault+0x68/0xfc
 [<c0116960>] do_page_fault+0x0/0x3fe
 [<c01494ee>] blkdev_file_write+0x26/0x30
 [<c0142f4e>] vfs_read+0xa2/0xd4
 [<c014312a>] sys_read+0x2a/0x40
 [<c0108cf3>] syscall_call+0x7/0xb

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
