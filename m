Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267281AbTB1AGf>; Thu, 27 Feb 2003 19:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267285AbTB1AGf>; Thu, 27 Feb 2003 19:06:35 -0500
Received: from tomts21.bellnexxia.net ([209.226.175.183]:14294 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267281AbTB1AGc>; Thu, 27 Feb 2003 19:06:32 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.63-mm1
Date: Thu, 27 Feb 2003 19:17:10 -0500
User-Agent: KMail/1.5.9
References: <20030227025900.1205425a.akpm@digeo.com>
In-Reply-To: <20030227025900.1205425a.akpm@digeo.com>
Cc: Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302271917.10139.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 27, 2003 05:59 am, Andrew Morton wrote:
> . Tons of changes to the anticipatory scheduler.  It may not be working
>   very well at present.  Please use "elevator=deadline" if it causes
>   problems.

The anticipatory scheduler hangs here at the same place it did in 62-mm2,
cfq continues to work fine.  A sysrq+T of the hang follows:

Hope this helps,
Ed Tomlinson

SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
swapper       D DFF8FB20 11876     1      0     2               (L-TLB)
Call Trace:
 [<c01143aa>] io_schedule+0xe/0x18
 [<c012a105>] __lock_page+0x8d/0xac
 [<c0114ba8>] autoremove_wake_function+0x0/0x38
 [<c0114ba8>] autoremove_wake_function+0x0/0x38
 [<c012a58e>] do_generic_mapping_read+0x13a/0x340
 [<c012aa5a>] __generic_file_aio_read+0x1c6/0x1e4
 [<c012a794>] file_read_actor+0x0/0x100
 [<c012ab3f>] generic_file_read+0x7f/0x9c
 [<c015400c>] dput+0x1c/0x1a0
 [<c015400c>] dput+0x1c/0x1a0
 [<c012ff37>] kmem_cache_alloc+0x23/0x60
 [<c0140e57>] vfs_read+0xab/0x150
 [<c01498c4>] kernel_read+0x3c/0x48
 [<c0161f82>] load_elf_binary+0x2f2/0xbbc
 [<c012ab3f>] generic_file_read+0x7f/0x9c
 [<c012f91c>] cache_init_objs+0x34/0x60
 [<c012d2af>] buffered_rmqueue+0xfb/0x108
 [<c012d33c>] __alloc_pages+0x80/0x264
 [<c014a4ad>] search_binary_handler+0xad/0x23c
 [<c0161c90>] load_elf_binary+0x0/0xbbc
 [<c014a786>] do_execve+0x14a/0x1a8
 [<c0107750>] sys_execve+0x2c/0x60
 [<c0108c47>] syscall_call+0x7/0xb
 [<c0105175>] init+0x109/0x174
 [<c010506c>] init+0x0/0x174
 [<c0107019>] kernel_thread_helper+0x5/0xc

ksoftirqd/0   S DFF8A000 4294963836     2      1             3       (L-TLB)
Call Trace:
 [<c011a1fc>] ksoftirqd+0x24/0xa4
 [<c011a23e>] ksoftirqd+0x66/0xa4
 [<c011a1d8>] ksoftirqd+0x0/0xa4
 [<c0107019>] kernel_thread_helper+0x5/0xc

events/0      D DFF89ED4 4294953708     3      1    12       4     2 (L-TLB)
Call Trace:
 [<c0113985>] wait_for_completion+0x9d/0xe0
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0116363>] do_fork+0x113/0x14c
 [<c010708e>] kernel_thread+0x6e/0x84
 [<c0122b50>] __call_usermodehelper+0x0/0x58
 [<c0122a70>] ____call_usermodehelper+0x0/0x94
 [<c0107014>] kernel_thread_helper+0x0/0xc
 [<c0122b80>] __call_usermodehelper+0x30/0x58
 [<c0122a70>] ____call_usermodehelper+0x0/0x94
 [<c012304f>] worker_thread+0x1a3/0x274
 [<c0122eac>] worker_thread+0x0/0x274
 [<c0122b50>] __call_usermodehelper+0x0/0x58
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0107019>] kernel_thread_helper+0x5/0xc

khubd         D DFD61D94 4292690652     4      1             5     3 (L-TLB)
Call Trace:
 [<c01136a0>] do_schedule+0x2a0/0x348
 [<c0113985>] wait_for_completion+0x9d/0xe0
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0122cb2>] call_usermodehelper+0x10a/0x118
 [<c01f44d8>] usb_hotplug+0x0/0x1c4
 [<c0122b50>] __call_usermodehelper+0x0/0x58
 [<c0122b50>] __call_usermodehelper+0x0/0x58
 [<c01b5a42>] do_hotplug+0x1c2/0x1ec
 [<c01b5a91>] dev_hotplug+0x25/0x30
 [<c01f44d8>] usb_hotplug+0x0/0x1c4
 [<c01b3d9a>] device_add+0x112/0x148
 [<c01f4ef6>] usb_new_device+0x322/0x480
 [<c0117086>] printk+0x122/0x148
 [<c01f6a9f>] usb_hub_port_connect_change+0x233/0x2c4
 [<c01f6c69>] usb_hub_events+0x139/0x2c8
 [<c01f6e25>] usb_hub_thread+0x2d/0xd4
 [<c01f6df8>] usb_hub_thread+0x0/0xd4
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0107019>] kernel_thread_helper+0x5/0xc

pdflush       S DFD2FFD4 4292485228     5      1             6     4 (L-TLB)
Call Trace:
 [<c012e7e5>] __pdflush+0x95/0x1b0
 [<c012e900>] pdflush+0x0/0x14
 [<c012e90f>] pdflush+0xf/0x14
 [<c0107019>] kernel_thread_helper+0x5/0xc

pdflush       S DFD2DFD4 14388     6      1             7     5 (L-TLB)
Call Trace:
 [<c012e7e5>] __pdflush+0x95/0x1b0
 [<c012e900>] pdflush+0x0/0x14
 [<c012e90f>] pdflush+0xf/0x14
 [<c0107019>] kernel_thread_helper+0x5/0xc

kswapd0       S DFD29F44 4294958912     7      1             8     6 (L-TLB)
Call Trace:
 [<c01328fb>] kswapd+0xcb/0xf0
 [<c0132830>] kswapd+0x0/0xf0
 [<c0109d26>] math_state_restore+0x2a/0x3c
 [<c0108f05>] device_not_available+0x25/0x2a
 [<c010e3f5>] save_init_fpu+0x1d/0x3c
 [<c0113770>] preempt_schedule+0x28/0x40
 [<c0112eb3>] schedule_tail+0x2f/0x94
 [<c0108b06>] ret_from_fork+0x6/0x20
 [<c0114ba8>] autoremove_wake_function+0x0/0x38
 [<c0114ba8>] autoremove_wake_function+0x0/0x38
 [<c0107019>] kernel_thread_helper+0x5/0xc

aio/0         S DFFE8EA0 4294952400     8      1             9     7 (L-TLB)
Call Trace:
 [<c0122fa8>] worker_thread+0xfc/0x274
 [<c0122eac>] worker_thread+0x0/0x274
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0107019>] kernel_thread_helper+0x5/0xc

kpnpbiosd     Z DFFEE800 4294880232     9      1            10     8 (L-TLB)
Call Trace:
 [<c0118b99>] do_exit+0x41d/0x428
 [<c01aca44>] pnp_dock_thread+0x0/0xf4
 [<c0118bbb>] complete_and_exit+0x17/0x18
 [<c01acadc>] pnp_dock_thread+0x98/0xf4
 [<c01aca44>] pnp_dock_thread+0x0/0xf4
 [<c0107019>] kernel_thread_helper+0x5/0xc

kseriod       S DFC44000 4294030016    10      1            11     9 (L-TLB)
Call Trace:
 [<c02073e7>] serio_thread+0x9f/0x12c
 [<c0207348>] serio_thread+0x0/0x12c
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0107019>] kernel_thread_helper+0x5/0xc

reiserfs/0    S DFCBD460  8080    11      1                  10 (L-TLB)
Call Trace:
 [<c0122fa8>] worker_thread+0xfc/0x274
 [<c0122eac>] worker_thread+0x0/0x274
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0113788>] default_wake_function+0x0/0x18
 [<c0107019>] kernel_thread_helper+0x5/0xc

events/0      D DFAC7A30 4294892756    12      3                     (L-TLB)
Call Trace:
 [<c01143aa>] io_schedule+0xe/0x18
 [<c012a105>] __lock_page+0x8d/0xac
 [<c0114ba8>] autoremove_wake_function+0x0/0x38
 [<c0114ba8>] autoremove_wake_function+0x0/0x38
 [<c012a58e>] do_generic_mapping_read+0x13a/0x340
 [<c012aa5a>] __generic_file_aio_read+0x1c6/0x1e4
 [<c012a794>] file_read_actor+0x0/0x100
 [<c017f6b0>] reiserfs_get_block+0x0/0x11cc
 [<c012ab3f>] generic_file_read+0x7f/0x9c
 [<c015400c>] dput+0x1c/0x1a0
 [<c015400c>] dput+0x1c/0x1a0
 [<c012ff37>] kmem_cache_alloc+0x23/0x60
 [<c0140e57>] vfs_read+0xab/0x150
 [<c01498c4>] kernel_read+0x3c/0x48
 [<c0161f82>] load_elf_binary+0x2f2/0xbbc
 [<c012ab3f>] generic_file_read+0x7f/0x9c
 [<c014bf83>] real_lookup+0x67/0xd0
 [<c014c254>] do_lookup+0x48/0x84
 [<c015400c>] dput+0x1c/0x1a0
 [<c014c95a>] link_path_walk+0x6ca/0x848
 [<c014a4ad>] search_binary_handler+0xad/0x23c
 [<c0161c90>] load_elf_binary+0x0/0xbbc
 [<c01614c1>] load_script+0x1d1/0x1e0
 [<c012d2af>] buffered_rmqueue+0xfb/0x108
 [<c012d33c>] __alloc_pages+0x80/0x264
 [<c014a4ad>] search_binary_handler+0xad/0x23c
 [<c01612f0>] load_script+0x0/0x1e0
 [<c014a786>] do_execve+0x14a/0x1a8
 [<c0107750>] sys_execve+0x2c/0x60
 [<c0108c47>] syscall_call+0x7/0xb
 [<c0122ae8>] ____call_usermodehelper+0x78/0x94
 [<c0122a70>] ____call_usermodehelper+0x0/0x94
 [<c0107019>] kernel_thread_helper+0x5/0xc



