Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423691AbWJaRTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423691AbWJaRTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423694AbWJaRTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:19:54 -0500
Received: from rtr.ca ([64.26.128.89]:33289 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1423691AbWJaRTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:19:54 -0500
Message-ID: <454785B7.3040600@rtr.ca>
Date: Tue, 31 Oct 2006 12:19:51 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.19-rc3-git7:  BUG: mutex warning sysfs_dir_open
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if the kernel is getting better at detecting its own bugs,
or if 2.6.19 is shaping up to be the flakiest kernel in recent memory.

I found this in my syslog just now:


kernel: BUG: warning at kernel/mutex.c:132/__mutex_lock_common()
kernel:  [<c0104088>] dump_trace+0x1c8/0x200
kernel:  [<c01040da>] show_trace_log_lvl+0x1a/0x30
kernel:  [<c0104832>] show_trace+0x12/0x20
kernel:  [<c0104999>] dump_stack+0x19/0x20
kernel:  [<c035d8ef>] __mutex_lock_slowpath+0x20f/0x260
kernel:  [<c035d961>] mutex_lock+0x21/0x30
kernel:  [<c01a0286>] sysfs_dir_open+0x26/0x60
kernel:  [<c0164925>] __dentry_open+0xb5/0x1e0
kernel:  [<c0164af5>] nameidata_to_filp+0x35/0x40
kernel:  [<c0164b49>] do_filp_open+0x49/0x50
kernel:  [<c0164b97>] do_sys_open+0x47/0xe0
kernel:  [<c0164c6c>] sys_open+0x1c/0x20
kernel:  [<c0102f4d>] sysenter_past_esp+0x56/0x8d
kernel:  [<b7fc5410>] 0xb7fc5410
kernel:  =======================
kernel: BUG: unable to handle kernel paging request at virtual address 6e726574
kernel:  printing eip:
kernel: c022a8fc
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: SMP
kernel: Modules linked in: button battery ac dm_mod snd_hda_intel snd_hda_codec snd_pcm snd_timer snd soundcore snd_page_alloc r1000 ahci edd fan thermal processor
kernel: CPU:    0
kernel: EIP:    0060:[<c022a8fc>]    Not tainted VLI
kernel: EFLAGS: 00010046   (2.6.19-rc3-git7-ml #9)
kernel: EIP is at __list_add+0x1c/0x80
kernel: eax: 6e726574   ebx: dfe39120   ecx: dfe39120   edx: 6e726574
kernel: esi: 6e726574   edi: f7861ea4   ebp: f7861e88   esp: f7861e70
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process hald (pid: 3360, ti=f7860000 task=f7974af0 task.ti=f7860000)
kernel: Stack: 00000000 00000002 00000001 dfe39100 00000246 f7974af0 f7861ec4 c035d76e
kernel:        00000000 00000002 c035d961 c0362479 dfe39120 f7861ea4 f7861ea4 11111111
kernel:        dfe39100 f7861ea4 dfe39100 f753ac00 dfe3a8a4 f7861ed0 c035d961 f78c0b34
kernel: Call Trace:
kernel:  [<c035d76e>] __mutex_lock_slowpath+0x8e/0x260
kernel:  [<c035d961>] mutex_lock+0x21/0x30
kernel:  [<c01a0286>] sysfs_dir_open+0x26/0x60
kernel:  [<c0164925>] __dentry_open+0xb5/0x1e0
kernel:  [<c0164af5>] nameidata_to_filp+0x35/0x40
kernel:  [<c0164b49>] do_filp_open+0x49/0x50
kernel:  [<c0164b97>] do_sys_open+0x47/0xe0
kernel:  [<c0164c6c>] sys_open+0x1c/0x20
kernel:  [<c0102f4d>] sysenter_past_esp+0x56/0x8d
kernel:  [<b7fc5410>] 0xb7fc5410
kernel:  =======================
kernel: Code: 13 eb a7 8d b6 00 00 00 00 8d bf 00 00 00 00 55 89 e5 83 ec 18 89 5d f4 89 cb 89 75 f8 89 d6 89 7d fc 89 c7 8b 41 04 39 d0 75 1d <8b> 06 39 c3 75 35 89 7b 04 89 1f 8b 5d f4 89 77 04 89 3e 8b 75
kernel: EIP: [<c022a8fc>] __list_add+0x1c/0x80 SS:ESP 0068:f7861e70
kernel:  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
kernel: in_atomic():0, irqs_disabled():1
kernel:  [<c0104088>] dump_trace+0x1c8/0x200
kernel:  [<c01040da>] show_trace_log_lvl+0x1a/0x30
kernel:  [<c0104832>] show_trace+0x12/0x20
kernel:  [<c0104999>] dump_stack+0x19/0x20
kernel:  [<c01166f8>] __might_sleep+0xa8/0xb0
kernel:  [<c0134468>] down_read+0x18/0x60
kernel:  [<c0143869>] acct_collect+0x39/0x150
kernel:  [<c0120715>] do_exit+0xf5/0x8a0
kernel:  [<c0104725>] die+0x2f5/0x300
kernel:  [<c0114c0f>] do_page_fault+0x1ff/0x5f0
kernel:  [<c035f0a9>] error_code+0x39/0x40
kernel:  [<c022a8fc>] __list_add+0x1c/0x80
kernel:  [<c035d76e>] __mutex_lock_slowpath+0x8e/0x260
kernel:  [<c035d961>] mutex_lock+0x21/0x30
kernel:  [<c01a0286>] sysfs_dir_open+0x26/0x60
kernel:  [<c0164925>] __dentry_open+0xb5/0x1e0
kernel:  [<c0164af5>] nameidata_to_filp+0x35/0x40
kernel:  [<c0164b49>] do_filp_open+0x49/0x50
kernel:  [<c0164b97>] do_sys_open+0x47/0xe0
kernel:  [<c0164c6c>] sys_open+0x1c/0x20
kernel:  [<c0102f4d>] sysenter_past_esp+0x56/0x8d
kernel:  [<b7fc5410>] 0xb7fc5410
kernel:  =======================
silvy:~#                                     
