Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758300AbWK2BAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300AbWK2BAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 20:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758313AbWK2BAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 20:00:20 -0500
Received: from twin.jikos.cz ([213.151.79.26]:62117 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1758300AbWK2BAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 20:00:18 -0500
Date: Wed, 29 Nov 2006 01:59:46 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm2
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611290147400.28502@twin.jikos.cz>
References: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006, Andrew Morton wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/

md-change-lifetime-rules-for-md-devices.patch gives me the following early 
during boot (first WARNING() inside __mutex_lock_slowpath(), then BUG at 
__mutex_lock_slowpath(), just after that slab corruption).

When I revert md-change-lifetime-rules-for-md-devices.patch, everything 
seems to go fine (this machine does use neither LVM nor RAID, but the 
kernel has DM compiled in).

Config is at http://www.jikos.cz/jikos/junk/.config_md

 WARNING at kernel/mutex.c:132 __mutex_lock_common()
  [<c0103d70>] dump_trace+0x68/0x1b5
  [<c0103ed5>] show_trace_log_lvl+0x18/0x2c
  [<c010445b>] show_trace+0xf/0x11
  [<c01044cd>] dump_stack+0x12/0x14
  [<c036e6ba>] __mutex_lock_slowpath+0xa1/0x213
  [<c0197c7d>] create_dir+0x24/0x1ba
  [<c0198317>] sysfs_create_dir+0x45/0x5f
  [<c01ed1fb>] kobject_add+0xce/0x185
  [<c01ed3c3>] kobject_register+0x19/0x30
  [<c02e10c6>] md_probe+0x11a/0x124
  [<c0261b4c>] kobj_lookup+0xe6/0x122
  [<c01e63b2>] get_gendisk+0xe/0x1b
  [<c0184c0a>] do_open+0x2e/0x298
  [<c018500b>] blkdev_open+0x25/0x4d
  [<c0163e73>] __dentry_open+0xc3/0x17e
  [<c0163fa8>] nameidata_to_filp+0x24/0x33
  [<c0163fe9>] do_filp_open+0x32/0x39
  [<c016402a>] do_sys_open+0x3a/0x66
  [<c016408f>] sys_open+0x1c/0x1e
  [<c0102dbc>] syscall_call+0x7/0xb
 DWARF2 unwinder stuck at syscall_call+0x7/0xb
 Leftover inexact backtrace:
  =======================
 BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
  printing eip:
 c01fc5ab
 *pde = 00000000
 Oops: 0000 [#1]
 SMP
 last sysfs file: /class/input/input5/event5/dev
 Modules linked in: video sony_acpi button battery backlight ac ipv6 floppy i2c_viapro i2c_core snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_seq_dummy via_rhine snd_seq_oss snd_seq_midi_event snd_seq mii snd_pcm_oss snd_mixer_oss snd_pcm pcspkr snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore serio_raw ehci_hcd ohci_hcd uhci_hcd
 CPU:    0
 EIP:    0060:[<c01fc5ab>]    Not tainted VLI
 EFLAGS: 00010046   (2.6.19-rc6-mm2 #1)
 EIP is at __list_add+0x2a/0x5c
 eax: 6b6b6b6b   ebx: edee9de0   ecx: eb8c34d8   edx: 6b6b6b6b
 esi: eb8c34b8   edi: 00000246   ebp: ef60a050   esp: edee9db4
 ds: 007b   es: 007b   ss: 0068
 Process nash (pid: 1321, ti=edee8000 task=ef60a050 task.ti=edee8000)
 Stack: 00000001 c0197c7d edee9de0 edee9de0 edee9de0 eb8c34b8 c036e703 00000000
        00000002 c0197c7d c03752fd edee9de0 edee9de0 11111111 eb8c34b8 edee9de0
        eb882cac ffffffea eb882cac edee9e30 c0197c7d ef60a5a0 00000000 ee8d3404
 Call Trace:
  [<c036e703>] __mutex_lock_slowpath+0xea/0x213
  [<c0197c7d>] create_dir+0x24/0x1ba
  [<c0198317>] sysfs_create_dir+0x45/0x5f
  [<c01ed1fb>] kobject_add+0xce/0x185
  [<c01ed3c3>] kobject_register+0x19/0x30
  [<c02e10c6>] md_probe+0x11a/0x124
  [<c0261b4c>] kobj_lookup+0xe6/0x122
  [<c01e63b2>] get_gendisk+0xe/0x1b
  [<c0184c0a>] do_open+0x2e/0x298
  [<c018500b>] blkdev_open+0x25/0x4d
  [<c0163e73>] __dentry_open+0xc3/0x17e
  [<c0163fa8>] nameidata_to_filp+0x24/0x33
  [<c0163fe9>] do_filp_open+0x32/0x39
  [<c016402a>] do_sys_open+0x3a/0x66
  [<c016408f>] sys_open+0x1c/0x1e
  [<c0102dbc>] syscall_call+0x7/0xb
 DWARF2 unwinder stuck at syscall_call+0x7/0xb
 Leftover inexact backtrace:
  =======================
 no locks held by nash/1321.
 Code: c3 56 53 89 c3 83 ec 10 8b 41 04 39 d0 74 1c 89 4c 24 0c 89 54 24 04 89 44 24 08 c7 04 24 80 94 3a c0 e8 be f9 f1 ff 0f 0b eb fe <8b> 32 39 ce 74 1c 89 54 24 0c 89 74 24 08 89 4c 24 04 c7 04 24
 EIP: [<c01fc5ab>] __list_add+0x2a/0x5c SS:ESP 0068:edee9db4
  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
 in_atomic():0, irqs_disabled():1
 no locks held by nash/1321.
  [<c0103d70>] dump_trace+0x68/0x1b5
  [<c0103ed5>] show_trace_log_lvl+0x18/0x2c
  [<c010445b>] show_trace+0xf/0x11
  [<c01044cd>] dump_stack+0x12/0x14
  [<c012f43e>] down_read+0x15/0x4e
  [<c012733b>] __blocking_notifier_call_chain+0x11/0x3d
  [<c012737e>] blocking_notifier_call_chain+0x17/0x1a
  [<c011dec9>] do_exit+0x19/0x782
  [<c01043fc>] die+0x20c/0x231
  [<c0371762>] do_page_fault+0x450/0x51e
  [<c036ff84>] error_code+0x7c/0x84
 DWARF2 unwinder stuck at error_code+0x7c/0x84
 Leftover inexact backtrace:
  [<c01fc5ab>] __list_add+0x2a/0x5c
  [<c0197c7d>] create_dir+0x24/0x1ba
  [<c036e703>] __mutex_lock_slowpath+0xea/0x213
  [<c0197c7d>] create_dir+0x24/0x1ba
  [<c0197c7d>] create_dir+0x24/0x1ba
  [<c0198317>] sysfs_create_dir+0x45/0x5f
  [<c01ed1fb>] kobject_add+0xce/0x185
  [<c012cae2>] init_waitqueue_head+0x12/0x20
  [<c01ed32f>] kobject_init+0x5b/0x7d
  [<c01ed3c3>] kobject_register+0x19/0x30
  [<c02e10c6>] md_probe+0x11a/0x124
  [<c0261b4c>] kobj_lookup+0xe6/0x122
  [<c02e0fac>] md_probe+0x0/0x124
  [<c0184fe6>] blkdev_open+0x0/0x4d
  [<c01e63b2>] get_gendisk+0xe/0x1b
  [<c0184c0a>] do_open+0x2e/0x298
  [<c0184fe6>] blkdev_open+0x0/0x4d
  [<c0184fe6>] blkdev_open+0x0/0x4d
  [<c018500b>] blkdev_open+0x25/0x4d
  [<c0163e73>] __dentry_open+0xc3/0x17e
  [<c0163fa8>] nameidata_to_filp+0x24/0x33
  [<c0163fe9>] do_filp_open+0x32/0x39
  [<c0163da6>] get_unused_fd+0xaa/0xb4
  [<c036f982>] _spin_unlock+0x14/0x1c
  [<c0163da6>] get_unused_fd+0xaa/0xb4
  [<c016402a>] do_sys_open+0x3a/0x66
  [<c016408f>] sys_open+0x1c/0x1e
  [<c0102dbc>] syscall_call+0x7/0xb
  =======================
 Slab corruption: start=eb8c3428, len=488
 Redzone: 0x5a2cf071/0x5a2cf071.
 Last user: [<c0175216>](iput+0x60/0x62)
 090: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 Single bit error detected. Probably bad RAM.
 Run memtest86+ or a similar memory test tool.
 Prev obj: start=eb8c3234, len=488
 Redzone: 0x5a2cf071/0x5a2cf071.
 Last user: [<c0175216>](iput+0x60/0x62)
 000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 Next obj: start=eb8c361c, len=488
 Redzone: 0x170fc2a5/0x170fc2a5.
 Last user: [<c01755ab>](alloc_inode+0x22/0x15b)
 000: 00 00 00 00 00 00 00 00 28 77 8b eb f4 cd f2 eb
 010: 20 38 8c eb fc cd f2 eb ac 6a f5 eb ac 6a f5 eb
 device-mapper: multipath: version 1.0.5 loaded

-- 
Jiri Kosina
