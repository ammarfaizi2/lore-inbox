Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbULUHjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbULUHjm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 02:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbULUHjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 02:39:42 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:30890
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S261555AbULUHj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 02:39:28 -0500
Message-ID: <41C7D32D.2010809@bio.ifi.lmu.de>
Date: Tue, 21 Dec 2004 08:39:25 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kblockd/1: page allocation failure in 2.6.9
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we got sth. that looks similar to but not exactly like a kernel oops on one
of our hosts saying "kblockd/1: page allocation failure. order:0, mode:0x21"
(the full output is below). The kernel is 2.6.9.

After that happend, "free" told me that 1.7GB of the 2GB was used and nothing
was buffered (i.e., the "-/+ buffers" shopwed the same amount of used memory),
which was strange because there was no process running that did any real
work. A tomcat server and a mysql database are running on this machine, but
the database is still empty and the tomcat does not yet offer any services.

Also, "ps -aux" showed only 2/3 of the processes then hang until I killed it.
I've never seen "ps -aux" hang! I had to reboot to get rid of this.

I guess the problem occured after copying a large amount of data to the disks.
The host is a dual xeon 1.7GHz with an internal 147GB Raid-1 (ICP vortex controlled
with gdth modul) and two external 600GB IDE-Raid5, connected to an Adaptec 29160
with the aic7xxx modul.

Can someone tell me what this kblockd messages mean? What is kblockd? Could
that point to a hardware problem (CPU, memory, mainboard) or a driver problems
with one the scsi controllers or sth.? The log says sth about scsi_get_command.
And are these messages sth. like a kernel oops or not? I've never seen sth.
like this before so I'm a bit lost :-)

Thanks for any hints!
Best regards,
Frank


Dec 20 13:17:21 turing kernel: kblockd/1: page allocation failure. order:0, mode:0x21
Dec 20 13:17:21 turing kernel:  [__alloc_pages+824/832] __alloc_pages+0x338/0x340
Dec 20 13:17:21 turing kernel:  [<c0142648>] __alloc_pages+0x338/0x340
Dec 20 13:17:21 turing kernel:  [__get_free_pages+24/48] __get_free_pages+0x18/0x30
Dec 20 13:17:21 turing kernel:  [<c0142668>] __get_free_pages+0x18/0x30
Dec 20 13:17:21 turing kernel:  [kmem_getpages+36/224] kmem_getpages+0x24/0xe0
Dec 20 13:17:21 turing kernel:  [<c0145884>] kmem_getpages+0x24/0xe0
Dec 20 13:17:21 turing kernel:  [cache_grow+168/352] cache_grow+0xa8/0x160
Dec 20 13:17:21 turing kernel:  [<c0146578>] cache_grow+0xa8/0x160
Dec 20 13:17:21 turing kernel:  [cache_alloc_refill+354/560] 
cache_alloc_refill+0x162/0x230
Dec 20 13:17:21 turing kernel:  [<c0146792>] cache_alloc_refill+0x162/0x230
Dec 20 13:17:21 turing kernel:  [kmem_cache_alloc+52/64] kmem_cache_alloc+0x34/0x40
Dec 20 13:17:22 turing kernel:  [<c0146a54>] kmem_cache_alloc+0x34/0x40
Dec 20 13:17:22 turing kernel:  [__scsi_get_command+21/96] __scsi_get_command+0x15/0x60
Dec 20 13:17:22 turing kernel:  [<c02eba35>] __scsi_get_command+0x15/0x60
Dec 20 13:17:22 turing kernel:  [scsi_get_command+15/144] scsi_get_command+0xf/0x90
Dec 20 13:17:22 turing kernel:  [<c02eba8f>] scsi_get_command+0xf/0x90
Dec 20 13:17:22 turing kernel:  [scsi_prep_fn+227/448] scsi_prep_fn+0xe3/0x1c0
Dec 20 13:17:22 turing kernel:  [<c02f0f93>] scsi_prep_fn+0xe3/0x1c0
Dec 20 13:17:22 turing kernel:  [elv_next_request+85/224] elv_next_request+0x55/0xe0
Dec 20 13:17:22 turing kernel:  [<c029a795>] elv_next_request+0x55/0xe0
Dec 20 13:17:22 turing kernel:  [scsi_request_fn+501/960] scsi_request_fn+0x1f5/0x3c0
Dec 20 13:17:22 turing kernel:  [<c02f1265>] scsi_request_fn+0x1f5/0x3c0
Dec 20 13:17:22 turing kernel:  [__generic_unplug_device+46/48] 
__generic_unplug_device+0x2e/0x30
Dec 20 13:17:22 turing kernel:  [<c029c29e>] __generic_unplug_device+0x2e/0x30
Dec 20 13:17:22 turing kernel:  [generic_unplug_device+21/48] 
generic_unplug_device+0x15/0x30
Dec 20 13:17:22 turing kernel:  [<c029c2b5>] generic_unplug_device+0x15/0x30
Dec 20 13:17:22 turing kernel:  [blk_unplug_work+6/16] blk_unplug_work+0x6/0x10
Dec 20 13:17:22 turing kernel:  [<c029c2f6>] blk_unplug_work+0x6/0x10
Dec 20 13:17:22 turing kernel:  [worker_thread+424/560] worker_thread+0x1a8/0x230
Dec 20 13:17:22 turing kernel:  [<c0130048>] worker_thread+0x1a8/0x230
Dec 20 13:17:22 turing kernel:  [blk_unplug_work+0/16] blk_unplug_work+0x0/0x10
Dec 20 13:17:22 turing kernel:  [<c029c2f0>] blk_unplug_work+0x0/0x10
Dec 20 13:17:22 turing kernel:  [default_wake_function+0/16] 
default_wake_function+0x0/0x10
Dec 20 13:17:22 turing kernel:  [<c011e470>] default_wake_function+0x0/0x10
Dec 20 13:17:22 turing kernel:  [default_wake_function+0/16] 
default_wake_function+0x0/0x10
Dec 20 13:17:22 turing kernel:  [<c011e470>] default_wake_function+0x0/0x10
Dec 20 13:17:22 turing kernel:  [worker_thread+0/560] worker_thread+0x0/0x230
Dec 20 13:17:22 turing kernel:  [<c012fea0>] worker_thread+0x0/0x230
Dec 20 13:17:22 turing kernel:  [kthread+134/176] kthread+0x86/0xb0
Dec 20 13:17:22 turing kernel:  [<c0133b46>] kthread+0x86/0xb0
Dec 20 13:17:22 turing kernel:  [kthread+0/176] kthread+0x0/0xb0
Dec 20 13:17:22 turing kernel:  [<c0133ac0>] kthread+0x0/0xb0
Dec 20 13:17:22 turing kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Dec 20 13:17:22 turing kernel:  [<c0105275>] kernel_thread_helper+0x5/0x10
Dec 20 13:17:22 turing kernel: klogd: page allocation failure. order:0, mode:0x21
Dec 20 13:17:22 turing kernel:  [__alloc_pages+824/832] __alloc_pages+0x338/0x340
Dec 20 13:17:22 turing kernel:  [<c0142648>] __alloc_pages+0x338/0x340
Dec 20 13:17:22 turing kernel:  [__get_free_pages+24/48] __get_free_pages+0x18/0x30
Dec 20 13:17:22 turing kernel:  [<c0142668>] __get_free_pages+0x18/0x30
Dec 20 13:17:22 turing kernel:  [kmem_getpages+36/224] kmem_getpages+0x24/0xe0
Dec 20 13:17:22 turing kernel:  [<c0145884>] kmem_getpages+0x24/0xe0
Dec 20 13:17:22 turing kernel:  [cache_grow+168/352] cache_grow+0xa8/0x160
Dec 20 13:17:22 turing kernel:  [<c0146578>] cache_grow+0xa8/0x160
Dec 20 13:17:22 turing kernel:  [cache_alloc_refill+354/560] 
cache_alloc_refill+0x162/0x230
Dec 20 13:17:22 turing kernel:  [<c0146792>] cache_alloc_refill+0x162/0x230
Dec 20 13:17:22 turing kernel:  [kmem_cache_alloc+52/64] kmem_cache_alloc+0x34/0x40
Dec 20 13:17:22 turing kernel:  [<c0146a54>] kmem_cache_alloc+0x34/0x40
Dec 20 13:17:22 turing kernel:  [__scsi_get_command+21/96] __scsi_get_command+0x15/0x60
Dec 20 13:17:22 turing kernel:  [<c02eba35>] __scsi_get_command+0x15/0x60
Dec 20 13:17:22 turing kernel:  [scsi_get_command+15/144] scsi_get_command+0xf/0x90
Dec 20 13:17:22 turing kernel:  [<c02eba8f>] scsi_get_command+0xf/0x90
Dec 20 13:17:22 turing kernel:  [scsi_prep_fn+227/448] scsi_prep_fn+0xe3/0x1c0
Dec 20 13:17:22 turing kernel:  [<c02f0f93>] scsi_prep_fn+0xe3/0x1c0
Dec 20 13:17:22 turing kernel:  [elv_next_request+85/224] elv_next_request+0x55/0xe0
Dec 20 13:17:22 turing kernel:  [<c029a795>] elv_next_request+0x55/0xe0
Dec 20 13:17:22 turing kernel:  [__generic_unplug_device+34/48] 
__generic_unplug_device+0x22/0x30
Dec 20 13:17:22 turing kernel:  [<c029c292>] __generic_unplug_device+0x22/0x30
Dec 20 13:17:22 turing kernel:  [generic_unplug_device+21/48] 
generic_unplug_device+0x15/0x30
Dec 20 13:17:22 turing kernel:  [<c029c2b5>] generic_unplug_device+0x15/0x30
Dec 20 13:17:22 turing kernel:  [blk_backing_dev_unplug+18/32] 
blk_backing_dev_unplug+0x12/0x20
Dec 20 13:17:22 turing kernel:  [<c029c2e2>] blk_backing_dev_unplug+0x12/0x20
Dec 20 13:17:22 turing kernel:  [swap_unplug_io_fn+90/144] swap_unplug_io_fn+0x5a/0x90
Dec 20 13:17:22 turing kernel:  [<c015347a>] swap_unplug_io_fn+0x5a/0x90
Dec 20 13:17:22 turing kernel:  [swap_unplug_io_fn+0/144] swap_unplug_io_fn+0x0/0x90
Dec 20 13:17:22 turing kernel:  [<c0153420>] swap_unplug_io_fn+0x0/0x90
Dec 20 13:17:22 turing kernel:  [block_sync_page+68/80] block_sync_page+0x44/0x50
Dec 20 13:17:22 turing kernel:  [<c015f284>] block_sync_page+0x44/0x50
Dec 20 13:17:22 turing kernel:  [__lock_page+235/256] __lock_page+0xeb/0x100
Dec 20 13:17:22 turing kernel:  [<c013e42b>] __lock_page+0xeb/0x100
Dec 20 13:17:22 turing kernel:  [page_wake_function+0/64] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [<c013e130>] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [page_wake_function+0/64] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [<c013e130>] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [grab_swap_token+158/176] grab_swap_token+0x9e/0xb0
Dec 20 13:17:22 turing kernel:  [<c015584e>] grab_swap_token+0x9e/0xb0
Dec 20 13:17:22 turing kernel:  [do_swap_page+327/656] do_swap_page+0x147/0x290
Dec 20 13:17:22 turing kernel:  [<c014d077>] do_swap_page+0x147/0x290
Dec 20 13:17:22 turing kernel:  [handle_mm_fault+244/336] handle_mm_fault+0xf4/0x150
Dec 20 13:17:22 turing kernel:  [<c014d7b4>] handle_mm_fault+0xf4/0x150
Dec 20 13:17:22 turing kernel:  [do_page_fault+443/1400] do_page_fault+0x1bb/0x578
Dec 20 13:17:22 turing kernel:  [<c011af4b>] do_page_fault+0x1bb/0x578
Dec 20 13:17:22 turing kernel:  [avc_has_perm_noaudit+188/416] 
avc_has_perm_noaudit+0xbc/0x1a0
Dec 20 13:17:22 turing kernel:  [<c020fb2c>] avc_has_perm_noaudit+0xbc/0x1a0
Dec 20 13:17:22 turing kernel:  [recalc_task_prio+330/480] recalc_task_prio+0x14a/0x1e0
Dec 20 13:17:22 turing kernel:  [<c011c5ea>] recalc_task_prio+0x14a/0x1e0
Dec 20 13:17:22 turing kernel:  [finish_task_switch+50/112] finish_task_switch+0x32/0x70
Dec 20 13:17:22 turing kernel:  [<c011cfa2>] finish_task_switch+0x32/0x70
Dec 20 13:17:22 turing kernel:  [schedule+848/2832] schedule+0x350/0xb10
Dec 20 13:17:22 turing kernel:  [<c03908b0>] schedule+0x350/0xb10
Dec 20 13:17:22 turing kernel:  [do_page_fault+0/1400] do_page_fault+0x0/0x578
Dec 20 13:17:22 turing kernel:  [<c011ad90>] do_page_fault+0x0/0x578
Dec 20 13:17:22 turing kernel:  [error_code+45/64] error_code+0x2d/0x40
Dec 20 13:17:22 turing kernel:  [<c0107f5d>] error_code+0x2d/0x40
Dec 20 13:17:22 turing kernel:  [do_syslog+779/992] do_syslog+0x30b/0x3e0
Dec 20 13:17:22 turing kernel:  [<c012197b>] do_syslog+0x30b/0x3e0
Dec 20 13:17:22 turing kernel:  [autoremove_wake_function+0/48] 
autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [<c011f9e0>] autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [autoremove_wake_function+0/48] 
autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [<c011f9e0>] autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [kmsg_read+0/64] kmsg_read+0x0/0x40
Dec 20 13:17:22 turing kernel:  [<c018a620>] kmsg_read+0x0/0x40
Dec 20 13:17:22 turing kernel:  [vfs_read+174/240] vfs_read+0xae/0xf0
Dec 20 13:17:22 turing kernel:  [<c015aa8e>] vfs_read+0xae/0xf0
Dec 20 13:17:22 turing kernel:  [sys_read+60/112] sys_read+0x3c/0x70
Dec 20 13:17:22 turing kernel:  [<c015acec>] sys_read+0x3c/0x70
Dec 20 13:17:22 turing kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 20 13:17:22 turing kernel:  [<c0106e27>] syscall_call+0x7/0xb
Dec 20 13:17:22 turing kernel: klogd: page allocation failure. order:0, mode:0x21
Dec 20 13:17:22 turing kernel:  [__alloc_pages+824/832] __alloc_pages+0x338/0x340
Dec 20 13:17:22 turing kernel:  [<c0142648>] __alloc_pages+0x338/0x340
Dec 20 13:17:22 turing kernel:  [__get_free_pages+24/48] __get_free_pages+0x18/0x30
Dec 20 13:17:22 turing kernel:  [<c0142668>] __get_free_pages+0x18/0x30
Dec 20 13:17:22 turing kernel:  [kmem_getpages+36/224] kmem_getpages+0x24/0xe0
Dec 20 13:17:22 turing kernel:  [<c0145884>] kmem_getpages+0x24/0xe0
Dec 20 13:17:22 turing kernel:  [cache_grow+168/352] cache_grow+0xa8/0x160
Dec 20 13:17:22 turing kernel:  [<c0146578>] cache_grow+0xa8/0x160
Dec 20 13:17:22 turing kernel:  [cache_alloc_refill+354/560] 
cache_alloc_refill+0x162/0x230
Dec 20 13:17:22 turing kernel:  [<c0146792>] cache_alloc_refill+0x162/0x230
Dec 20 13:17:22 turing kernel:  [kmem_cache_alloc+52/64] kmem_cache_alloc+0x34/0x40
Dec 20 13:17:22 turing kernel:  [<c0146a54>] kmem_cache_alloc+0x34/0x40
Dec 20 13:17:22 turing kernel:  [__scsi_get_command+21/96] __scsi_get_command+0x15/0x60
Dec 20 13:17:22 turing kernel:  [<c02eba35>] __scsi_get_command+0x15/0x60
Dec 20 13:17:22 turing kernel:  [scsi_get_command+15/144] scsi_get_command+0xf/0x90
Dec 20 13:17:22 turing kernel:  [<c02eba8f>] scsi_get_command+0xf/0x90
Dec 20 13:17:22 turing kernel:  [scsi_prep_fn+227/448] scsi_prep_fn+0xe3/0x1c0
Dec 20 13:17:22 turing kernel:  [<c02f0f93>] scsi_prep_fn+0xe3/0x1c0
Dec 20 13:17:22 turing kernel:  [elv_next_request+85/224] elv_next_request+0x55/0xe0
Dec 20 13:17:22 turing kernel:  [<c029a795>] elv_next_request+0x55/0xe0
Dec 20 13:17:22 turing kernel:  [__generic_unplug_device+34/48] 
__generic_unplug_device+0x22/0x30
Dec 20 13:17:22 turing kernel:  [<c029c292>] __generic_unplug_device+0x22/0x30
Dec 20 13:17:22 turing kernel:  [generic_unplug_device+21/48] 
generic_unplug_device+0x15/0x30
Dec 20 13:17:22 turing kernel:  [<c029c2b5>] generic_unplug_device+0x15/0x30
Dec 20 13:17:22 turing kernel:  [blk_backing_dev_unplug+0/32] 
blk_backing_dev_unplug+0x0/0x20
Dec 20 13:17:22 turing kernel:  [<c029c2d0>] blk_backing_dev_unplug+0x0/0x20
Dec 20 13:17:22 turing kernel:  [blk_backing_dev_unplug+18/32] 
blk_backing_dev_unplug+0x12/0x20
Dec 20 13:17:22 turing kernel:  [<c029c2e2>] blk_backing_dev_unplug+0x12/0x20
Dec 20 13:17:22 turing kernel:  [block_sync_page+68/80] block_sync_page+0x44/0x50
Dec 20 13:17:22 turing kernel:  [<c015f284>] block_sync_page+0x44/0x50
Dec 20 13:17:22 turing kernel:  [__lock_page+235/256] __lock_page+0xeb/0x100
Dec 20 13:17:22 turing kernel:  [<c013e42b>] __lock_page+0xeb/0x100
Dec 20 13:17:22 turing kernel:  [page_wake_function+0/64] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [<c013e130>] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [page_wake_function+0/64] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [<c013e130>] page_wake_function+0x0/0x40
Dec 20 13:17:22 turing kernel:  [find_get_page+57/80] find_get_page+0x39/0x50
Dec 20 13:17:22 turing kernel:  [<c013e479>] find_get_page+0x39/0x50
Dec 20 13:17:22 turing kernel:  [filemap_nopage+697/864] filemap_nopage+0x2b9/0x360
Dec 20 13:17:22 turing kernel:  [<c013f489>] filemap_nopage+0x2b9/0x360
Dec 20 13:17:22 turing kernel:  [do_no_page+180/688] do_no_page+0xb4/0x2b0
Dec 20 13:17:22 turing kernel:  [<c014d3f4>] do_no_page+0xb4/0x2b0
Dec 20 13:17:22 turing kernel:  [handle_mm_fault+272/336] handle_mm_fault+0x110/0x150
Dec 20 13:17:22 turing kernel:  [<c014d7d0>] handle_mm_fault+0x110/0x150
Dec 20 13:17:22 turing kernel:  [do_page_fault+443/1400] do_page_fault+0x1bb/0x578
Dec 20 13:17:22 turing kernel:  [<c011af4b>] do_page_fault+0x1bb/0x578
Dec 20 13:17:22 turing kernel:  [do_syslog+722/992] do_syslog+0x2d2/0x3e0
Dec 20 13:17:22 turing kernel:  [<c0121942>] do_syslog+0x2d2/0x3e0
Dec 20 13:17:22 turing kernel:  [autoremove_wake_function+0/48] 
autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [<c011f9e0>] autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [autoremove_wake_function+0/48] 
autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [<c011f9e0>] autoremove_wake_function+0x0/0x30
Dec 20 13:17:22 turing kernel:  [kmsg_read+0/64] kmsg_read+0x0/0x40
Dec 20 13:17:22 turing kernel:  [<c018a620>] kmsg_read+0x0/0x40
Dec 20 13:17:22 turing kernel:  [dnotify_parent+31/112] dnotify_parent+0x1f/0x70
Dec 20 13:17:22 turing kernel:  [<c017463f>] dnotify_parent+0x1f/0x70
Dec 20 13:17:22 turing kernel:  [vfs_read+194/240] vfs_read+0xc2/0xf0
Dec 20 13:17:22 turing kernel:  [<c015aaa2>] vfs_read+0xc2/0xf0
Dec 20 13:17:22 turing kernel:  [sys_read+60/112] sys_read+0x3c/0x70
Dec 20 13:17:22 turing kernel:  [<c015acec>] sys_read+0x3c/0x70
Dec 20 13:17:22 turing kernel:  [do_page_fault+0/1400] do_page_fault+0x0/0x578
Dec 20 13:17:22 turing kernel:  [<c011ad90>] do_page_fault+0x0/0x578
Dec 20 13:17:22 turing kernel:  [error_code+45/64] error_code+0x2d/0x40
Dec 20 13:17:22 turing kernel:  [<c0107f5d>] error_code+0x2d/0x40

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
