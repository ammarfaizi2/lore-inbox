Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVB0HHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVB0HHa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 02:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVB0HHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 02:07:30 -0500
Received: from relais.videotron.ca ([24.201.245.36]:38441 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261361AbVB0HHJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 02:07:09 -0500
Date: Sun, 27 Feb 2005 02:04:56 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: ext3 bug
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1109487896.8360.16.camel@localhost>
Organization: =?ISO-8859-1?Q?Universit=E9?= de Sherbrooke
MIME-version: 1.0
X-Mailer: Evolution 2.0.3
Content-type: multipart/mixed; boundary="Boundary_(ID_WvUH4Tm6fT1u6+BQYi40PQ)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_WvUH4Tm6fT1u6+BQYi40PQ)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

Hi,

Looks like I ran into an ext3 bug (or at least the log says so). I got a
bunch of messages like:
ext3_free_blocks_sb: aborting transaction: Journal has aborted in
__ext3_journal_get_undo_access<2>EXT3-fs error (device sda2) in
ext3_free_blocks_sb: Journal has aborted
EXT3-fs error (device sda2): ext3_free_blocks: Freeing blocks in system
zones -Block = 228, count = 1

It happened while I was doing an "rm -rf" on a directory. The "rm" gave
a segfault and now I can't unmount the filesystem: unmount says "device
is busy", even though lsof reports nothing. The filesystem is on a USB
hard disk. The actual dump is in attachment. I'm running Debian unstable
with a custom 2.6.10 kernel on a 1.6 GHz Pentium-M.

	Jean-Marc

-- 
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Université de Sherbrooke

--Boundary_(ID_WvUH4Tm6fT1u6+BQYi40PQ)
Content-type: text/plain; name=ext3_bug; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=ext3_bug

Feb 27 01:15:48 idefix kernel: ------------[ cut here ]------------
Feb 27 01:15:48 idefix kernel: PREEMPT 
Feb 27 01:15:48 idefix kernel: Modules linked in: msdos sd_mod udf isofs sr_mod usb_storage scsi_mod joydev usbhid appletalk ax25 ipx radeon ipt_state iptable_filter iptable_mangle iptable_nat ip_conntrack ip_tables ipv6 orinoco_cs orinoco hermes pcmcia lp binfmt_misc af_packet parport_pc parport uhci_hcd pci_hotplug intel_agp agpgart yenta_socket pcmcia_core tg3 snd_intel8x0 snd_ac97_codec ehci_hcd usbcore nls_iso8859_1 nls_cp437 vfat fat ppp_async ppp_generic slhc crc_ccitt snd_pcm_oss tsdev evdev snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore psmouse thermal fan button ac battery cpufreq_ondemand cpufreq_powersave speedstep_centrino freq_table processor
Feb 27 01:15:48 idefix kernel: CPU:    0
Feb 27 01:15:48 idefix kernel: EIP:    0060:[<b01af540>]    Not tainted VLI
Feb 27 01:15:48 idefix kernel: EFLAGS: 00210286   (2.6.10) 
Feb 27 01:15:48 idefix kernel: EIP is at journal_forget+0x1d0/0x220
Feb 27 01:15:48 idefix kernel: eax: 0000005f   ebx: d1f1c000   ecx: b032c7cc   edx: b032c7cc
Feb 27 01:15:48 idefix kernel: esi: b8932d48   edi: bb2ad41c   ebp: dd668080   esp: d1f1dda0
Feb 27 01:15:48 idefix kernel: ds: 007b   es: 007b   ss: 0068
Feb 27 01:15:48 idefix kernel: Process rm (pid: 10370, threadinfo=d1f1c000 task=c97f49e0)
Feb 27 01:15:48 idefix kernel: Stack: b02f67e0 b02e1027 b02f445b 000004ca b02f4571 00000000 be0a5aac b8932d48 
Feb 27 01:15:48 idefix kernel:        dfc002b8 b019c940 dfc002b8 b8932d48 e73d7980 b275f400 b8932d48 00000006 
Feb 27 01:15:48 idefix kernel:        b0aeb448 dfc002b8 be0a5aac b019f028 dfc002b8 00000000 be0a5aac b8932d48 
Feb 27 01:15:48 idefix kernel: Call Trace:
Feb 27 01:15:48 idefix kernel:  [<b019c940>] ext3_forget+0xf0/0x100
Feb 27 01:15:48 idefix kernel:  [<b019f028>] ext3_clear_blocks+0x118/0x170
Feb 27 01:15:48 idefix kernel:  [<b019f118>] ext3_free_data+0x98/0x150
Feb 27 01:15:48 idefix kernel:  [<b019f2bc>] ext3_free_branches+0xec/0x270
Feb 27 01:15:48 idefix kernel:  [<b019f8ab>] ext3_truncate+0x46b/0x5d0
Feb 27 01:15:48 idefix kernel:  [<b01a08b8>] ext3_mark_iloc_dirty+0x28/0x40
Feb 27 01:15:48 idefix kernel:  [<b01ae12d>] journal_start+0xad/0xe0
Feb 27 01:15:48 idefix kernel:  [<b01a5234>] __ext3_journal_stop+0x24/0x50
Feb 27 01:15:48 idefix kernel:  [<b019c9a9>] start_transaction+0x29/0x70
Feb 27 01:15:48 idefix kernel:  [<b019cb28>] ext3_delete_inode+0xc8/0x100
Feb 27 01:15:48 idefix kernel:  [<b019ca60>] ext3_delete_inode+0x0/0x100
Feb 27 01:15:48 idefix kernel:  [<b01726f5>] generic_delete_inode+0xa5/0x170
Feb 27 01:15:48 idefix kernel:  [<b01729a3>] iput+0x63/0x90
Feb 27 01:15:48 idefix kernel:  [<b0167f27>] sys_unlink+0xd7/0x150
Feb 27 01:15:48 idefix kernel:  [<b016ad40>] sys_getdents64+0xa0/0xaa
Feb 27 01:15:48 idefix kernel:  [<b016aba0>] filldir64+0x0/0x100
Feb 27 01:15:48 idefix kernel:  [<b01030df>] syscall_call+0x7/0xb
Feb 27 01:15:48 idefix kernel: Code: 2f b0 b8 71 45 2f b0 89 44 24 10 b8 ca 04 00 00 89 44 24 0c b8 5b 44 2f b0 89 44 24 08 b8 27 10 2e b0 89 44 24 04 e8 c0 a6 f6 ff <0f> 0b ca 04 5b 44 2f b0 e9 4d ff ff ff c7 04 24 e0 67 2f b0 b8 
Feb 27 01:15:48 idefix kernel:  <6>note: rm[10370] exited with preempt_count 2
Feb 27 01:15:48 idefix kernel:  [<b02d8772>] schedule+0x532/0x540
Feb 27 01:15:48 idefix kernel:  [<b0146c53>] unmap_page_range+0x53/0x80
Feb 27 01:15:48 idefix kernel:  [<b0146e36>] unmap_vmas+0x1b6/0x1d0
Feb 27 01:15:48 idefix kernel:  [<b014b53d>] exit_mmap+0x7d/0x160
Feb 27 01:15:48 idefix kernel:  [<b0117617>] mmput+0x37/0xa0
Feb 27 01:15:48 idefix kernel:  [<b011c06f>] do_exit+0x16f/0x470
Feb 27 01:15:48 idefix kernel:  [<b01046a0>] do_invalid_op+0x0/0xd0
Feb 27 01:15:48 idefix kernel:  [<b01042cb>] die+0x18b/0x190
Feb 27 01:15:48 idefix kernel:  [<b0104752>] do_invalid_op+0xb2/0xd0
Feb 27 01:15:48 idefix kernel:  [<b01af540>] journal_forget+0x1d0/0x220
Feb 27 01:15:48 idefix kernel:  [<b01162d1>] __wake_up_common+0x41/0x70
Feb 27 01:15:48 idefix kernel:  [<b0119e9f>] release_console_sem+0xbf/0xd0
Feb 27 01:15:48 idefix kernel:  [<b0103b17>] error_code+0x2b/0x30
Feb 27 01:15:48 idefix kernel:  [<b01af540>] journal_forget+0x1d0/0x220
Feb 27 01:15:48 idefix kernel:  [<b019c940>] ext3_forget+0xf0/0x100
Feb 27 01:15:48 idefix kernel:  [<b019f028>] ext3_clear_blocks+0x118/0x170
Feb 27 01:15:48 idefix kernel:  [<b019f118>] ext3_free_data+0x98/0x150
Feb 27 01:15:48 idefix kernel:  [<b019f2bc>] ext3_free_branches+0xec/0x270
Feb 27 01:15:48 idefix kernel:  [<b019f8ab>] ext3_truncate+0x46b/0x5d0
Feb 27 01:15:48 idefix kernel:  [<b01a08b8>] ext3_mark_iloc_dirty+0x28/0x40
Feb 27 01:15:48 idefix kernel:  [<b01ae12d>] journal_start+0xad/0xe0
Feb 27 01:15:48 idefix kernel:  [<b01a5234>] __ext3_journal_stop+0x24/0x50
Feb 27 01:15:48 idefix kernel:  [<b019c9a9>] start_transaction+0x29/0x70
Feb 27 01:15:48 idefix kernel:  [<b019cb28>] ext3_delete_inode+0xc8/0x100
Feb 27 01:15:48 idefix kernel:  [<b019ca60>] ext3_delete_inode+0x0/0x100
Feb 27 01:15:48 idefix kernel:  [<b01726f5>] generic_delete_inode+0xa5/0x170
Feb 27 01:15:48 idefix kernel:  [<b01729a3>] iput+0x63/0x90
Feb 27 01:15:48 idefix kernel:  [<b0167f27>] sys_unlink+0xd7/0x150
Feb 27 01:15:48 idefix kernel:  [<b016ad40>] sys_getdents64+0xa0/0xaa
Feb 27 01:15:48 idefix kernel:  [<b016aba0>] filldir64+0x0/0x100
Feb 27 01:15:48 idefix kernel:  [<b01030df>] syscall_call+0x7/0xb

--Boundary_(ID_WvUH4Tm6fT1u6+BQYi40PQ)--
