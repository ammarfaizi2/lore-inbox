Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268307AbUHYTNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268307AbUHYTNp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268352AbUHYTNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:13:44 -0400
Received: from proxy.quengel.org ([213.146.113.159]:11139 "EHLO
	gerlin1.quengel.org") by vger.kernel.org with ESMTP id S268307AbUHYTLl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:11:41 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: ext2 / dvd-ram Oops 2.6.8.1-mm4
From: Ralf Gerbig <rge@quengel.org>
Date: Wed, 25 Aug 2004 21:11:41 +0200
Message-ID: <87vff758ya.fsf-news@hsp-law.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

rm /media/cdrw/test which was a 600M file on a DVD-RAM resulted in this Oops:
System: SuSE 9.1, nforce2, Athlon 2.8, the device is an LG GSA-4082B


kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000002c
kernel:  printing eip:
kernel: c01a864b
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: PREEMPT 
kernel: Modules linked in: minix vfat fat iptable_mangle ip6table_filter ip6_tables nls_iso8859_1 isofs zlib_inflate ide_cd cdrom subfs radeon dst dvb_bt8xx dvb_core bt878 tuner bttv video_buf i2c_algo_bit v4l2_common btcx_risc i2c_core videodev usbserial parport_pc lp parport snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss md5 ipv6 snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ohci1394 ieee1394 ehci_hcd nvidia_agp agpgart ohci_hcd evdev pppoe pppox ppp_generic 8139too mii crc32 forcedeth hisax_fcpcipnp hisax_isac hisax isdn slhc iptable_nat ipt_LOG ipt_limit ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables genrtc binfmt_misc sd_mod
kernel: CPU:    0
kernel: EIP:    0060:[ext2_free_blocks+43/720]    Not tainted VLI
kernel: EIP:    0060:[<c01a864b>]    Not tainted VLI
kernel: EFLAGS: 00210282   (2.6.8.1-mm4) 
kernel: EIP is at ext2_free_blocks+0x2b/0x2d0
kernel: eax: dc837c00   ebx: d122370c   ecx: 000001c3   edx: 00000000
kernel: esi: 0000fe3d   edi: 000001c3   ebp: d7f28b0c   esp: d3d15dc8
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process rm (pid: 23699, threadinfo=d3d14000 task=d8df2150)
kernel: Stack: 0000003c 5e14720c 00000014 cddb689c d3d15e14 c0444cf8 cddb689c d3d15e14 
kernel:        c0444cf8 c0152db9 00000000 dc837c00 d8df2150 00000000 d7f28b0c dc837c00 
kernel:        d122370c 000101f6 000001c3 d7f28b0c c01ac1fc c0152be0 d3d15e20 d3d15e20 
kernel: Call Trace:
kernel:  [__wait_on_buffer+153/160] __wait_on_buffer+0x99/0xa0
kernel:  [<c0152db9>] __wait_on_buffer+0x99/0xa0
kernel:  [ext2_free_branches+284/384] ext2_free_branches+0x11c/0x180
kernel:  [<c01ac1fc>] ext2_free_branches+0x11c/0x180
kernel:  [bh_wake_function+0/80] bh_wake_function+0x0/0x50
kernel:  [<c0152be0>] bh_wake_function+0x0/0x50
kernel:  [ext2_free_branches+146/384] ext2_free_branches+0x92/0x180
kernel:  [<c01ac172>] ext2_free_branches+0x92/0x180
kernel:  [ext2_free_branches+146/384] ext2_free_branches+0x92/0x180
kernel:  [<c01ac172>] ext2_free_branches+0x92/0x180
kernel:  [ext2_truncate+946/1056] ext2_truncate+0x3b2/0x420
kernel:  [<c01ac612>] ext2_truncate+0x3b2/0x420
kernel:  [ext2_get_inode+217/320] ext2_get_inode+0xd9/0x140
kernel:  [<c01ac759>] ext2_get_inode+0xd9/0x140
kernel:  [__set_page_dirty_nobuffers+223/288] __set_page_dirty_nobuffers+0xdf/0x120
kernel:  [<c013a11f>] __set_page_dirty_nobuffers+0xdf/0x120
kernel:  [ext2_update_inode+453/848] ext2_update_inode+0x1c5/0x350
kernel:  [<c01accd5>] ext2_update_inode+0x1c5/0x350
kernel:  [ext2_delete_inode+0/112] ext2_delete_inode+0x0/0x70
kernel:  [<c01ab340>] ext2_delete_inode+0x0/0x70
kernel:  [ext2_delete_inode+95/112] ext2_delete_inode+0x5f/0x70
kernel:  [<c01ab39f>] ext2_delete_inode+0x5f/0x70
kernel:  [generic_delete_inode+164/352] generic_delete_inode+0xa4/0x160
kernel:  [<c016c174>] generic_delete_inode+0xa4/0x160
kernel:  [iput+83/112] iput+0x53/0x70
kernel:  [<c016c413>] iput+0x53/0x70
kernel:  [sys_unlink+223/288] sys_unlink+0xdf/0x120
kernel:  [<c0161b8f>] sys_unlink+0xdf/0x120
kernel:  [sys_ioctl+241/704] sys_ioctl+0xf1/0x2c0
kernel:  [<c0164181>] sys_ioctl+0xf1/0x2c0
kernel:  [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71
kernel:  [<c0104029>] sysenter_past_esp+0x52/0x71
kernel: Code: 55 57 89 cf 56 89 d6 53 83 ec 40 89 44 24 38 c7 44 24 34 00 00 00 00 8b 80 94 00 00 00 89 44 24 2c 8b 90 54 01 00 00 89 54 24 28 <8b> 4a 2c c7 44 24 1c 00 00 00 00 89 4c 24 20 8b 41 14 39 c6 72 


Thanks,

Ralf
-- 
 P:     Linus Torvalds			patch-2.2.4
-S:     Buried alive in diapers
+S:     Buried alive in reporters
