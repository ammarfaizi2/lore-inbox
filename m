Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVL2MoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVL2MoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 07:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVL2MoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 07:44:21 -0500
Received: from mail45.e.nsc.no ([193.213.115.45]:58029 "EHLO mail45.e.nsc.no")
	by vger.kernel.org with ESMTP id S1750703AbVL2MoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 07:44:20 -0500
Subject: 2.6.15-rc7-rt1: bug mounting xfs
From: Vegard Lima <Vegard.Lima@hia.no>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 29 Dec 2005 13:45:34 +0100
Message-Id: <1135860334.2304.7.camel@tordenfugl.lima.heim>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this when booting 2.6.15-rc7-rt1:
(Same setup has worked fine up until 2.6.14-rt22 which was
the last rt-kernel to compile for me.)

Dec 29 13:14:59 tordenfugl kernel: XFS mounting filesystem hdb1
Dec 29 13:14:59 tordenfugl kernel: BUG: Unable to handle kernel NULL
pointer dereference at virtual address 00000018
Dec 29 13:14:59 tordenfugl kernel:  printing eip:
Dec 29 13:14:59 tordenfugl kernel: c0124c33
Dec 29 13:14:59 tordenfugl kernel: *pde = 1e631067
Dec 29 13:14:59 tordenfugl kernel: *pte = 00000000
Dec 29 13:14:59 tordenfugl kernel: Oops: 0002 [#1]
Dec 29 13:14:59 tordenfugl kernel: PREEMPT 
Dec 29 13:14:59 tordenfugl kernel: Modules linked in: snd_emu10k1_synth
snd_emux_synth snd_seq_midi_emul snd_virmidi snd_seq_virmidi snd_hdsp
firmware_class snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus
snd_util_mem snd_hwdep
Dec 29 13:14:59 tordenfugl kernel: CPU:    0
Dec 29 13:14:59 tordenfugl kernel: EIP:    0060:[<c0124c33>]    Not
tainted VLI
Dec 29 13:14:59 tordenfugl kernel: EFLAGS: 00010246   (2.6.15-rc7-rt1) 
Dec 29 13:14:59 tordenfugl kernel: EIP is at atomic_dec_and_spin_lock
+0xf/0x3a
Dec 29 13:14:59 tordenfugl kernel: eax: 00000000   ebx: de042c28   ecx:
df5e71b0   edx: df5df000
Dec 29 13:14:59 tordenfugl kernel: esi: 00000008   edi: 00000000   ebp:
00000200   esp: df5dfc2c
Dec 29 13:14:59 tordenfugl kernel: ds: 007b   es: 007b   ss: 0068
preempt: 00000001
Dec 29 13:14:59 tordenfugl kernel: Process mount (pid: 1052,
threadinfo=df5df000 task=df6805d0 stack_left=3064 worst_left=-1)
Dec 29 13:14:59 tordenfugl kernel: Stack: de042bb4 00000008 c01e80ac
de042bb4 02542960 c01e8731 de042bb4 00000001 
Dec 29 13:14:59 tordenfugl kernel:        c01e7ec5 00000004 00000000
00000000 00000000 c01ecf30 0000000c c01d30f7 
Dec 29 13:14:59 tordenfugl kernel:        de70d400 00000200 de70d600
0000000c 00800004 00009508 de70d400 c01d3f7d 
Dec 29 13:14:59 tordenfugl kernel: Call Trace:
Dec 29 13:14:59 tordenfugl kernel:  [<c01e80ac>] pagebuf_rele+0x14/0x6b
(12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01e8731>] pagebuf_iorequest
+0xf1/0xf9 (12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01e7ec5>]
pagebuf_associate_memory+0x5f/0x194 (12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01ecf30>] xfsbdstrat+0x23/0x27
(20)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d30f7>] xlog_bread+0x98/0xcf
(8)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d3f7d>] xlog_find_zeroed
+0x3f/0x21b (32)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d37fe>] xlog_find_head
+0x25/0x39b (56)
Dec 29 13:14:59 tordenfugl kernel:  [<c0124c6f>] _spin_lock_init
+0x11/0x14 (28)
Dec 29 13:14:59 tordenfugl kernel:  [<c01e7702>] _pagebuf_initialize
+0x111/0x12c (12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d3b8a>] xlog_find_tail
+0x16/0x3ca (24)
Dec 29 13:14:59 tordenfugl kernel:  [<c0124c6f>] _spin_lock_init
+0x11/0x14 (24)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d0fe7>] xlog_alloc_log
+0x2f2/0x33a (12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d7270>] xlog_recover+0x18/0x93
(24)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d048c>] xfs_log_mount+0x8c/0xcc
(36)
Dec 29 13:14:59 tordenfugl kernel:  [<c01d88cc>] xfs_mountfs+0x8b4/0xb6e
(20)
Dec 29 13:14:59 tordenfugl kernel:  [<c01e8a69>]
xfs_setsize_buftarg_flags+0x2a/0x8f (104)
Dec 29 13:14:59 tordenfugl kernel:  [<c01de298>] xfs_mount+0x2bb/0x352
(56)
Dec 29 13:14:59 tordenfugl kernel:  [<c01ddfdd>] xfs_mount+0x0/0x352
(28)
Dec 29 13:14:59 tordenfugl kernel:  [<c01edd53>] vfs_mount+0x17/0x1a
(12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01edc07>] linvfs_fill_super
+0x6f/0x192 (12)
Dec 29 13:14:59 tordenfugl kernel:  [<c0203e9c>] snprintf+0x1b/0x1f (32)
Dec 29 13:14:59 tordenfugl kernel:  [<c0173802>] disk_name+0x56/0x60
(16)
Dec 29 13:14:59 tordenfugl kernel:  [<c014d59f>] get_sb_bdev+0xc0/0xff
(40)
Dec 29 13:14:59 tordenfugl kernel:  [<c0133600>] zone_watermark_ok
+0x85/0x97 (12)
Dec 29 13:14:59 tordenfugl kernel:  [<c01edd38>] linvfs_get_sb+0xe/0x12
(44)
Dec 29 13:14:59 tordenfugl kernel:  [<c01edb98>] linvfs_fill_super
+0x0/0x192 (8)
Dec 29 13:14:59 tordenfugl kernel:  [<c014d781>] do_kern_mount
+0x8a/0x137 (4)
Dec 29 13:14:59 tordenfugl kernel:  [<c015f454>] do_new_mount+0x57/0x8b
(36)
Dec 29 13:15:00 tordenfugl kernel:  [<c015f981>] do_mount+0x177/0x196
(36)
Dec 29 13:15:00 tordenfugl kernel:  [<c015fc48>] sys_mount+0x6d/0xaa
(108)
Dec 29 13:15:00 tordenfugl kernel:  [<c01025ff>] sysenter_past_esp
+0x54/0x75 (32)
Dec 29 13:15:00 tordenfugl kernel: Code: 83 78 10 00 0f 95 c0 0f b6 c0
c3 f0 83 44 24 00 00 83 78 10 00 0f 94 c0 0f b6 c0 c3 56 89 d6 ba 00 f0
ff ff 21 e2 53 89 c3 31 c0 <0f> b1 56 10 85 c0 74 07 89 f0 e8 b3 10 1d
00 ff 0b 0f 94 c0 84 


Thanks,
-- 
Vegard Lima <Vegard.Lima@hia.no>

