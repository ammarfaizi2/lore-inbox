Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWC0Ved@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWC0Ved (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWC0Ved
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:34:33 -0500
Received: from mail.charite.de ([160.45.207.131]:41140 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751439AbWC0Vec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:34:32 -0500
Date: Mon, 27 Mar 2006 23:34:29 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Cc: Fridtjof Busse <fridtjof@fbunet.de>
Subject: kernel BUG at fs/buffer.c:2790!
Message-ID: <20060327213429.GK19434@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Fridtjof Busse <fridtjof@fbunet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens when umount'ing an intact softraid-5 with vanila 2.6.16.

------------[ cut here ]------------
kernel BUG at fs/buffer.c:2790!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: sata_sil vmnet vmmon snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sk98lin
CPU:    0
EIP:    0060:[<b015fda9>]    Tainted: P      VLI
EFLAGS: 00010246   (2.6.16 #1)
EIP is at submit_bh+0x109/0x130
eax: 00000005   ebx: d5e0ed54   ecx: 00000001   edx: 0000002b
esi: c9a0e000   edi: 00000001   ebp: 000040cd   esp: be715cb8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 7011, threadinfo=be714000 task=e0be3ab0)
Stack: <0>b13341c0 eeacc160 d5e0ed54 c9a0e000 ed772960 b015fe12 00000001 d5e0ed54
       ed772960 c9a0e000 ed772960 c9a0e000 b01b3da1 d5e0ed54 be714000 ef2d8ae0
       d5e0ed54 be714000 00000a61 b01b25f0 ed772960 00000001 b03b8bf6 0000032a
Call Trace:
 [<b015fe12>] sync_dirty_buffer+0x42/0xe0
 [<b01b3da1>] journal_update_superblock+0xc1/0xe0
 [<b01b25f0>] cleanup_journal_tail+0xc0/0x190
 [<b03b8bf6>] preempt_schedule_irq+0x46/0x70
 [<b01b2914>] log_do_checkpoint+0x24/0x490
 [<b0142ac2>] __pagevec_free+0x32/0x50
 [<b0144963>] release_pages+0x33/0x220
 [<b03b87c5>] schedule+0x315/0x640
 [<b03b8c6d>] preempt_schedule+0x4d/0x60
 [<b012e22f>] autoremove_wake_function+0x2f/0x60
 [<b01b4e5b>] journal_destroy+0x12b/0x2c0
 [<b0178cc2>] dispose_list+0x82/0x120
 [<b01a767a>] ext3_put_super+0x2a/0x1f0
 [<b01790b3>] invalidate_inodes+0xd3/0x110
 [<b0164132>] generic_shutdown_super+0x92/0x170
 [<b0164239>] kill_block_super+0x29/0x50
 [<b01644b8>] deactivate_super+0x68/0x90
 [<b017c02b>] sys_umount+0x4b/0x260
 [<b01141c6>] do_page_fault+0x136/0x63f
 [<b017c257>] sys_oldumount+0x17/0x20
 [<b0102d27>] sysenter_past_esp+0x54/0x75
Code: 19 db f7 d3 83 e3 a1 e8 f6 2f 00 00 89 d8 83 c4 08 5b 5e 5f c3 0f ba 33 0b e9 64 ff ff ff 0f 0b e7 0a 7c dd 3c b0 e9 24 ff ff ff <0f> 0b e6 0a 7c dd 3c b0 e9 0c ff ff ff 0f 0b e5 0a 7c dd 3c b0
 Badness in do_exit at kernel/exit.c:802
 [<b011c7b3>] do_exit+0x7a3/0x900
 [<b03b8c6d>] preempt_schedule+0x4d/0x60
 [<b0104505>] die+0x235/0x240
 [<b0104a00>] do_invalid_op+0x0/0xc0
 [<b0104aab>] do_invalid_op+0xab/0xc0
 [<b015fda9>] submit_bh+0x109/0x130
 [<b012e22f>] autoremove_wake_function+0x2f/0x60
 [<b0115653>] __wake_up_common+0x43/0x70
 [<b01626c1>] bio_free+0x31/0x60
 [<b0103817>] error_code+0x4f/0x54
 [<b015fda9>] submit_bh+0x109/0x130
 [<b015fe12>] sync_dirty_buffer+0x42/0xe0
 [<b01b3da1>] journal_update_superblock+0xc1/0xe0
 [<b01b25f0>] cleanup_journal_tail+0xc0/0x190
 [<b03b8bf6>] preempt_schedule_irq+0x46/0x70
 [<b01b2914>] log_do_checkpoint+0x24/0x490
 [<b0142ac2>] __pagevec_free+0x32/0x50
 [<b0144963>] release_pages+0x33/0x220
 [<b03b87c5>] schedule+0x315/0x640
 [<b03b8c6d>] preempt_schedule+0x4d/0x60
 [<b012e22f>] autoremove_wake_function+0x2f/0x60
 [<b01b4e5b>] journal_destroy+0x12b/0x2c0
 [<b0178cc2>] dispose_list+0x82/0x120
 [<b01a767a>] ext3_put_super+0x2a/0x1f0
 [<b01790b3>] invalidate_inodes+0xd3/0x110
 [<b0164132>] generic_shutdown_super+0x92/0x170
 [<b0164239>] kill_block_super+0x29/0x50
 [<b01644b8>] deactivate_super+0x68/0x90
 [<b017c02b>] sys_umount+0x4b/0x260
 [<b01141c6>] do_page_fault+0x136/0x63f
 [<b017c257>] sys_oldumount+0x17/0x20
 [<b0102d27>] sysenter_past_esp+0x54/0x75

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
