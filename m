Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUIUQF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUIUQF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUIUQF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:05:56 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6893 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267783AbUIUQFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:05:43 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Robert Love <rml@novell.com>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095652572.23128.2.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
Content-Type: multipart/mixed; boundary="=-/hXxC+ue0wWyiHPpRc/M"
Date: Tue, 21 Sep 2004 12:04:34 -0400
Message-Id: <1095782674.4944.41.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/hXxC+ue0wWyiHPpRc/M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-19 at 23:56 -0400, John McCutchan wrote:

> I would appreciate design review, code review and testing.

Hey, John.

We are seeing an oops when monitoring a large number of directories.
The system keeps running, but I/O gets flaky and eventually processes
start getting stuck.

Also, the ioctl() stops returning new WD after 1024.  Thereafter, it
keeps returning the same value.

I have attached the relevant bits from the syslog.  I will debug it, but
I thought that perhaps you would immediately see the issue.

Thanks,

	Robert Love


--=-/hXxC+ue0wWyiHPpRc/M
Content-Disposition: attachment; filename=inotify-oops
Content-Type: text/plain; name=inotify-oops; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sep 21 13:46:21 slim kernel: inotify device opened
Sep 21 13:46:21 slim kernel: inotify device released
<repeated many times>
Sep 21 14:06:05 slim kernel: inotify device opened
Sep 21 14:06:09 slim kernel: inotify device released
Sep 21 14:06:32 slim kernel: inotify device opened
Sep 21 14:06:32 slim kernel: GLOBAL INOTIFY STATS
Sep 21 14:06:32 slim kernel: watcher_count = 1
Sep 21 14:06:32 slim kernel: event_object_count = 0
Sep 21 14:06:32 slim kernel: watcher_object_count = 0
Sep 21 14:06:32 slim kernel: inode_ref_count = 0
Sep 21 14:06:32 slim kernel: sizeof(struct inotify_watcher) = 40
Sep 21 14:06:32 slim kernel: sizeof(struct inotify_device) = 68
Sep 21 14:06:32 slim kernel: sizeof(struct inotify_kernel_event) = 272
Sep 21 14:06:32 slim kernel: inotify device: e2b75900
Sep 21 14:06:32 slim kernel: inotify event_count: 0
Sep 21 14:06:32 slim kernel: inotify watch_count: 0
Sep 21 14:07:14 slim kernel: inotify device released
Sep 21 14:08:27 slim kernel: inotify device opened
Sep 21 14:08:27 slim kernel: GLOBAL INOTIFY STATS
Sep 21 14:08:27 slim kernel: watcher_count = 1
Sep 21 14:08:27 slim kernel: event_object_count = 0
Sep 21 14:08:27 slim kernel: watcher_object_count = 0
Sep 21 14:08:27 slim kernel: inode_ref_count = 0
Sep 21 14:08:27 slim kernel: sizeof(struct inotify_watcher) = 40
Sep 21 14:08:27 slim kernel: sizeof(struct inotify_device) = 68
Sep 21 14:08:27 slim kernel: sizeof(struct inotify_kernel_event) = 272
Sep 21 14:08:27 slim kernel: inotify device: f70de900
Sep 21 14:08:27 slim kernel: inotify event_count: 0
Sep 21 14:08:27 slim kernel: inotify watch_count: 0
Sep 21 14:08:41 slim kernel: inotify device released
Sep 21 14:10:57 slim kernel: inotify device opened
Sep 21 14:11:38 slim kernel: inotify device released
Sep 21 14:12:14 slim kernel: inotify device opened
<repeated many times>
Sep 21 14:31:13 slim kernel: inotify device released
Sep 21 14:32:10 slim kernel: inotify device opened
Sep 21 14:32:31 slim kernel: Unable to handle kernel paging request at virtual address 00017f2d
Sep 21 14:32:31 slim kernel:  printing eip:
Sep 21 14:32:31 slim kernel: c02095f4
Sep 21 14:32:31 slim kernel: *pde = 00000000
Sep 21 14:32:31 slim kernel: Oops: 0002 [#1]
Sep 21 14:32:31 slim kernel: CPU:    0
Sep 21 14:32:31 slim kernel: EIP:    0060:[<c02095f4>]    Tainted: P  X
Sep 21 14:32:31 slim kernel: EFLAGS: 00010282   (2.6.5-707.inotify.0-default) 
Sep 21 14:32:31 slim kernel: EIP is at inotify_dev_queue_event+0x74/0xd0
Sep 21 14:32:31 slim kernel: eax: 00017f2d   ebx: 00000200   ecx: 0000000a   edx: c18c38c0
Sep 21 14:32:31 slim kernel: esi: c19bf080   edi: f705ef80   ebp: 00000200   esp: c7e1df64
Sep 21 14:32:31 slim kernel: ds: 007b   es: 007b   ss: 0068
Sep 21 14:32:31 slim kernel: Process mono (pid: 7712, threadinfo=c7e1c000 task=f701c8d0)
Sep 21 14:32:31 slim kernel: Stack: db7bb540 d2c6d534 00000000 c02098af 00000000 00000018 c7e1df90 e62d1480 
Sep 21 14:32:32 slim kernel:        f575e000 c0155c5e 00000000 00000000 00000000 f575e000 00018800 40d354c0 
Sep 21 14:32:32 slim kernel:        c03d6c50 f701c8d0 f701ca7c 081ba728 081ba728 081ba768 c7e1c000 c0107dc9 
Sep 21 14:32:32 slim kernel: Call Trace:
Sep 21 14:32:32 slim kernel:  [<c02098af>] inotify_inode_queue_event+0x2f/0x50
Sep 21 14:32:32 slim kernel:  [<c0155c5e>] sys_open+0x9e/0xf0
Sep 21 14:32:32 slim kernel:  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Sep 21 14:32:32 slim kernel: 
Sep 21 14:32:32 slim kernel: Code: 89 30 f6 05 44 8d 42 c0 02 75 21 90 5b 5e 5f c3 f6 05 44 8d 
Sep 21 14:33:08 slim kernel:  <1>inotify device released
Sep 21 14:33:13 slim kernel: Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:610: "transaction->t_state == T_FINISHED"
Sep 21 14:33:13 slim kernel: ------------[ cut here ]------------
Sep 21 14:33:13 slim kernel: kernel BUG at fs/jbd/checkpoint.c:610!
Sep 21 14:33:13 slim kernel: invalid operand: 0000 [#2]
Sep 21 14:33:13 slim kernel: CPU:    0
Sep 21 14:33:13 slim kernel: EIP:    0060:[<fa83dee6>]    Tainted: P  X
Sep 21 14:33:13 slim kernel: EFLAGS: 00010286   (2.6.5-707.inotify.0-default) 
Sep 21 14:33:13 slim kernel: EIP is at __journal_drop_transaction+0x46/0x330 [jbd]
Sep 21 14:33:13 slim kernel: eax: 00000076   ebx: f705ef80   ecx: 00000002   edx: f731ff38
Sep 21 14:33:13 slim kernel: esi: f7eb0580   edi: f5f3d8a0   ebp: f705ef80   esp: f7a2bdac
Sep 21 14:33:13 slim kernel: ds: 007b   es: 007b   ss: 0068
Sep 21 14:33:13 slim kernel: Process kjournald (pid: 874, threadinfo=f7a2a000 task=f7a2d7c0)
Sep 21 14:33:13 slim kernel: Stack: fa842a94 fa8413f3 fa841b28 00000262 fa842afc f705ef80 f7eb0580 fa83e20c 
Sep 21 14:33:13 slim kernel:        d0410250 f5f3d8a0 fa83e26b f5f3d8a0 fa83e2c3 00000003 e5874f80 f7567500 
Sep 21 14:33:13 slim kernel:        f7eb0580 e2b75c00 00000000 00000000 fa83c239 f7a2a000 f7a2a000 00000000 
Sep 21 14:33:13 slim kernel: Call Trace:
Sep 21 14:33:13 slim kernel:  [<fa83e20c>] __journal_remove_checkpoint+0x3c/0x70 [jbd]
Sep 21 14:33:13 slim kernel:  [<fa83e26b>] __try_to_free_cp_buf+0x2b/0x40 [jbd]
Sep 21 14:33:13 slim kernel:  [<fa83e2c3>] __journal_clean_checkpoint_list+0x43/0x60 [jbd]
Sep 21 14:33:13 slim kernel:  [<fa83c239>] journal_commit_transaction+0x1b9/0x1310 [jbd]
Sep 21 14:33:13 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:33:13 slim kernel:  [<c011b9fa>] recalc_task_prio+0x1da/0x470
Sep 21 14:33:13 slim kernel:  [<c011ca76>] schedule+0x1f6/0x6d0
Sep 21 14:33:13 slim kernel:  [<fa840f03>] kjournald+0xc3/0x310 [jbd]
Sep 21 14:33:13 slim kernel:  [<c0121dfa>] do_exit+0x86a/0xa50
Sep 21 14:33:13 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:33:13 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:33:13 slim kernel:  [<c0107d16>] ret_from_fork+0x6/0x20
Sep 21 14:33:13 slim kernel:  [<fa841150>] commit_timeout+0x0/0x10 [jbd]
Sep 21 14:33:13 slim kernel:  [<fa840e40>] kjournald+0x0/0x310 [jbd]
Sep 21 14:33:13 slim kernel:  [<c0106005>] kernel_thread_helper+0x5/0x10
Sep 21 14:33:13 slim kernel: 
Sep 21 14:33:13 slim kernel: Code: 0f 0b 62 02 28 1b 84 fa 83 c4 14 8b 4b 1c 85 c9 0f 85 24 02 


----------------------------------------------------------


Sep 21 14:39:00 slim kernel: inotify device opened
Sep 21 14:41:04 slim kernel: inotify device released
Sep 21 14:41:11 slim kernel: inotify device opened
Sep 21 14:41:24 slim kernel: Unable to handle kernel paging request at virtual address 00200200
Sep 21 14:41:24 slim kernel:  printing eip:
Sep 21 14:41:24 slim kernel: c02095f4
Sep 21 14:41:24 slim kernel: *pde = 00000000
Sep 21 14:41:24 slim kernel: Oops: 0002 [#1]
Sep 21 14:41:24 slim kernel: CPU:    0
Sep 21 14:41:24 slim kernel: EIP:    0060:[<c02095f4>]    Tainted: P  X
Sep 21 14:41:24 slim kernel: EFLAGS: 00010282   (2.6.5-707.inotify.0-default) 
Sep 21 14:41:24 slim kernel: EIP is at inotify_dev_queue_event+0x74/0xd0
Sep 21 14:41:24 slim kernel: eax: 00200200   ebx: 00000200   ecx: 00000000   edx: 00000020
Sep 21 14:41:24 slim kernel: esi: e4387080   edi: eefa2600   ebp: 00000200   esp: e4b97f58
Sep 21 14:41:24 slim kernel: ds: 007b   es: 007b   ss: 0068
Sep 21 14:41:24 slim kernel: Process mono (pid: 5987, threadinfo=e4b96000 task=e66448e0)
Sep 21 14:41:24 slim kernel: Stack: df826608 e65dcb34 e1691758 c02098af e1691758 e8632114 e16916dc e43c6080 
Sep 21 14:41:24 slim kernel:        f6a51000 c020a2ae 00000018 e4b97f90 c0155c6e 00000000 00000000 00000000 
Sep 21 14:41:24 slim kernel:        f6a51000 00018800 000002e0 c03d70c8 e66448e0 e6644a8c 081c5348 081c5348 
Sep 21 14:41:24 slim kernel: Call Trace:
Sep 21 14:41:24 slim kernel:  [<c02098af>] inotify_inode_queue_event+0x2f/0x50
Sep 21 14:41:24 slim kernel:  [<c020a2ae>] inotify_dentry_parent_queue_event+0x1e/0x40
Sep 21 14:41:24 slim kernel:  [<c0155c6e>] sys_open+0xae/0xf0
Sep 21 14:41:24 slim kernel:  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Sep 21 14:41:24 slim kernel: 
Sep 21 14:41:24 slim kernel: Code: 89 30 f6 05 44 8d 42 c0 02 75 21 90 5b 5e 5f c3 f6 05 44 8d 
Sep 21 14:41:44 slim kernel:  <1>inotify device released
Sep 21 14:42:09 slim kernel: inotify device opened
Sep 21 14:42:09 slim kernel: Unable to handle kernel paging request at virtual address 00029507
Sep 21 14:42:09 slim kernel:  printing eip:
Sep 21 14:42:09 slim kernel: c02095f4
Sep 21 14:42:09 slim kernel: *pde = 00000000
Sep 21 14:42:09 slim kernel: Oops: 0002 [#2]
Sep 21 14:42:09 slim kernel: CPU:    0
Sep 21 14:42:09 slim kernel: EIP:    0060:[<c02095f4>]    Tainted: P  X
Sep 21 14:42:09 slim kernel: EFLAGS: 00010286   (2.6.5-707.inotify.0-default) 
Sep 21 14:42:09 slim kernel: EIP is at inotify_dev_queue_event+0x74/0xd0
Sep 21 14:42:09 slim kernel: eax: 00029507   ebx: 00000200   ecx: 0000000f   edx: c18c38c0
Sep 21 14:42:09 slim kernel: esi: e4387e50   edi: eefa2600   ebp: 00000200   esp: e82bdf64
Sep 21 14:42:09 slim kernel: ds: 007b   es: 007b   ss: 0068
Sep 21 14:42:09 slim kernel: Process mono (pid: 6081, threadinfo=e82bc000 task=e66448e0)
Sep 21 14:42:09 slim kernel: Stack: df826518 f37c0b34 00000000 c02098af 00000000 00000018 e82bdf90 df3fcc80 
Sep 21 14:42:09 slim kernel:        f4eb6000 c0155c5e 00000000 00000000 00000000 f4eb6000 00018800 400172d0 
Sep 21 14:42:09 slim kernel:        c03d70c8 4022e578 00000004 081bae50 081bae50 081b91e0 e82bc000 c0107dc9 
Sep 21 14:42:09 slim kernel: Call Trace:
Sep 21 14:42:09 slim kernel:  [<c02098af>] inotify_inode_queue_event+0x2f/0x50
Sep 21 14:42:09 slim kernel:  [<c0155c5e>] sys_open+0x9e/0xf0
Sep 21 14:42:09 slim kernel:  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Sep 21 14:42:09 slim kernel: 
Sep 21 14:42:09 slim kernel: Code: 89 30 f6 05 44 8d 42 c0 02 75 21 90 5b 5e 5f c3 f6 05 44 8d 
Sep 21 14:42:18 slim trow: spamd starting 
Sep 21 14:42:21 slim kernel:  <1>Unable to handle kernel paging request at virtual address 00017f76
Sep 21 14:42:21 slim kernel:  printing eip:
Sep 21 14:42:21 slim kernel: c02095f4
Sep 21 14:42:21 slim kernel: *pde = 00000000
Sep 21 14:42:21 slim kernel: Oops: 0002 [#3]
Sep 21 14:42:21 slim kernel: CPU:    0
Sep 21 14:42:21 slim kernel: EIP:    0060:[<c02095f4>]    Tainted: P  X
Sep 21 14:42:21 slim kernel: EFLAGS: 00010286   (2.6.5-707.inotify.0-default) 
Sep 21 14:42:21 slim kernel: EIP is at inotify_dev_queue_event+0x74/0xd0
Sep 21 14:42:21 slim kernel: eax: 00017f76   ebx: 00000002   ecx: 00000000   edx: c18c38c0
Sep 21 14:42:21 slim kernel: esi: df0c6e50   edi: eefa2600   ebp: 00000002   esp: eb33bf30
Sep 21 14:42:21 slim kernel: ds: 007b   es: 007b   ss: 0068
Sep 21 14:42:21 slim kernel: Process evolution-2.0 (pid: 5467, threadinfo=eb33a000 task=eb32f410)
Sep 21 14:42:21 slim kernel: Stack: df826518 f37c0b34 f3c9d7ec c02098af f3c9d7ec f3bc4364 f3c9d770 c1a993a4 
Sep 21 14:42:21 slim kernel:        c1a993a4 c020a2ae 0000001d c1a99380 c0158ab4 41553c98 00000002 eb33bf90 
Sep 21 14:42:21 slim kernel:        c1a99380 0000001d c0158ce1 c1a993a4 00000001 fffffff7 c01555e3 f5fcc180 
Sep 21 14:42:21 slim kernel: Call Trace:
Sep 21 14:42:21 slim kernel:  [<c02098af>] inotify_inode_queue_event+0x2f/0x50
Sep 21 14:42:21 slim kernel:  [<c020a2ae>] inotify_dentry_parent_queue_event+0x1e/0x40
Sep 21 14:42:21 slim kernel:  [<c0158ab4>] vfs_write+0xc4/0x120
Sep 21 14:42:21 slim kernel:  [<c0158ce1>] sys_write+0x81/0xd0
Sep 21 14:42:21 slim kernel:  [<c01555e3>] filp_close+0x43/0x70
Sep 21 14:42:21 slim kernel:  [<c0107dc9>] sysenter_past_esp+0x52/0x79
Sep 21 14:42:21 slim kernel: 
Sep 21 14:42:21 slim kernel: Code: 89 30 f6 05 44 8d 42 c0 02 75 21 90 5b 5e 5f c3 f6 05 44 8d 
Sep 21 14:42:30 slim kernel:  <1>inotify device released
Sep 21 14:42:42 slim kernel: Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:610: "transaction->t_state == T_FINISHED"
Sep 21 14:42:42 slim kernel: ------------[ cut here ]------------
Sep 21 14:42:42 slim kernel: kernel BUG at fs/jbd/checkpoint.c:610!
Sep 21 14:42:42 slim kernel: invalid operand: 0000 [#4]
Sep 21 14:42:42 slim kernel: CPU:    0
Sep 21 14:42:42 slim kernel: EIP:    0060:[<fa83dee6>]    Tainted: P  X
Sep 21 14:42:42 slim kernel: EFLAGS: 00010286   (2.6.5-707.inotify.0-default) 
Sep 21 14:42:42 slim kernel: EIP is at __journal_drop_transaction+0x46/0x330 [jbd]
Sep 21 14:42:42 slim kernel: eax: 00000076   ebx: eefa2600   ecx: 00000002   edx: f6371f38
Sep 21 14:42:42 slim kernel: esi: f7eb0580   edi: ee3b4360   ebp: eefa2600   esp: c1a55dac
Sep 21 14:42:42 slim kernel: ds: 007b   es: 007b   ss: 0068
Sep 21 14:42:42 slim kernel: Process kjournald (pid: 874, threadinfo=c1a54000 task=c1a5c670)
Sep 21 14:42:42 slim kernel: Stack: fa842a94 fa8413f3 fa841b28 00000262 fa842afc eefa2600 f7eb0580 fa83e20c 
Sep 21 14:42:42 slim kernel:        ded9e284 ee3b4360 fa83e26b ee3b4360 fa83e2c3 00000009 e063f280 f5d9b780 
Sep 21 14:42:42 slim kernel:        f7eb0580 e1aa3480 00000000 00000000 fa83c239 c1a54000 c1a54000 00000000 
Sep 21 14:42:42 slim kernel: Call Trace:
Sep 21 14:42:42 slim kernel:  [<fa83e20c>] __journal_remove_checkpoint+0x3c/0x70 [jbd]
Sep 21 14:42:42 slim kernel:  [<fa83e26b>] __try_to_free_cp_buf+0x2b/0x40 [jbd]
Sep 21 14:42:42 slim kernel:  [<fa83e2c3>] __journal_clean_checkpoint_list+0x43/0x60 [jbd]
Sep 21 14:42:42 slim kernel:  [<fa83c239>] journal_commit_transaction+0x1b9/0x1310 [jbd]
Sep 21 14:42:42 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:42:42 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:42:42 slim kernel:  [<c011b9fa>] recalc_task_prio+0x1da/0x470
Sep 21 14:42:42 slim kernel:  [<c011ca76>] schedule+0x1f6/0x6d0
Sep 21 14:42:42 slim kernel:  [<fa840f03>] kjournald+0xc3/0x310 [jbd]
Sep 21 14:42:42 slim kernel:  [<c0121dfa>] do_exit+0x86a/0xa50
Sep 21 14:42:42 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:42:42 slim kernel:  [<c011f1c0>] autoremove_wake_function+0x0/0x30
Sep 21 14:42:42 slim kernel:  [<c0107d16>] ret_from_fork+0x6/0x20
Sep 21 14:42:42 slim kernel:  [<fa841150>] commit_timeout+0x0/0x10 [jbd]
Sep 21 14:42:42 slim kernel:  [<fa840e40>] kjournald+0x0/0x310 [jbd]
Sep 21 14:42:42 slim kernel:  [<c0106005>] kernel_thread_helper+0x5/0x10
Sep 21 14:42:42 slim kernel: 
Sep 21 14:42:42 slim kernel: Code: 0f 0b 62 02 28 1b 84 fa 83 c4 14 8b 4b 1c 85 c9 0f 85 24 02 
Sep 21 14:44:22 slim syslogd 1.4.1: restart.

--=-/hXxC+ue0wWyiHPpRc/M--

