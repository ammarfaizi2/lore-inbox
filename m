Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUIVKHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUIVKHH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 06:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263770AbUIVKHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 06:07:07 -0400
Received: from dialpool1-250.dial.tijd.com ([62.112.10.250]:32385 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S263664AbUIVKHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 06:07:02 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.8.9-rc2] OOPS: kernel BUG at fs/xfs/support/debug.c:106!
Date: Wed, 22 Sep 2004 12:07:03 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409221207.04200.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today this oops happened, and my system froze. 

Kernel 2.6.9-rc2, no other patches applied.

Sep 22 11:42:08 precious kernel: kernel BUG at fs/xfs/support/debug.c:106!
Sep 22 11:42:08 precious kernel: invalid operand: 0000 [#1]
Sep 22 11:42:08 precious kernel: PREEMPT 
Sep 22 11:42:08 precious kernel: Modules linked in: nls_iso8859_15 isofs usb_storage ircomm_tty ircomm sd_mod ide_cd cdrom ppp_deflate zlib_deflate zlib_inflate bsd_comp ppp_async ppp_generic slhc rfcomm l2cap bluetooth nsc_ircc irda crc_ccitt thermal fan button processor ac battery ohci1394 ieee1394 yenta_socket pcmcia_core b44 mii snd_intel8x0m 8250_pci 8250 serial_core snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore ehci_hcd usbhid uhci_hcd usbcore ipt_state iptable_nat iptable_filter ip_tables nls_iso8859_1 nls_cp850 vfat fat ip_conntrack_irc ip_conntrack pcspkr psmouse sg scsi_mod cpufreq_powersave cpufreq_userspace speedstep_centrino freq_table
Sep 22 11:42:08 precious kernel: CPU:    0
Sep 22 11:42:08 precious kernel: EIP:    0060:[cmn_err+164/192]    Not tainted
Sep 22 11:42:08 precious kernel: EFLAGS: 00010246   (2.6.9-rc2) 
Sep 22 11:42:08 precious kernel: EIP is at cmn_err+0xa4/0xc0
Sep 22 11:42:08 precious kernel: eax: 00000000   ebx: d0a9c000   ecx: 00000000   edx: d0a9c000
Sep 22 11:42:08 precious kernel: esi: c0377940   edi: c04596a0   ebp: 00000000   esp: d0a9dbf4
Sep 22 11:42:08 precious kernel: ds: 007b   es: 007b   ss: 0068
Sep 22 11:42:08 precious kernel: Process find (pid: 6666, threadinfo=d0a9c000 task=c8421020)
Sep 22 11:42:08 precious kernel: Stack: c0367f7f c036d2a9 c04596a0 00000293 d18c65b0 c0377940 00000000 d0a9dd34 
Sep 22 11:42:08 precious kernel:        c01eaa37 00000000 c0377940 dfcecda0 00c08d6e 00000000 00000000 00000000 
Sep 22 11:42:08 precious kernel:        00000000 00000101 00000000 00000000 00000000 00000000 00000000 dfc1e000 
Sep 22 11:42:08 precious kernel: Call Trace:
Sep 22 11:42:08 precious kernel:  [xfs_bmap_search_extents+231/272] xfs_bmap_search_extents+0xe7/0x110
Sep 22 11:42:08 precious kernel:  [xfs_bmapi+617/5600] xfs_bmapi+0x269/0x15e0
Sep 22 11:42:08 precious kernel:  [xfs_xlate_dinode_core+318/2128] xfs_xlate_dinode_core+0x13e/0x850
Sep 22 11:42:08 precious kernel:  [pagebuf_free+137/240] pagebuf_free+0x89/0xf0
Sep 22 11:42:08 precious kernel:  [xfs_initialize_vnode+485/768] xfs_initialize_vnode+0x1e5/0x300
Sep 22 11:42:08 precious kernel:  [xfs_iget+282/336] xfs_iget+0x11a/0x150
Sep 22 11:42:08 precious kernel:  [kmem_alloc+89/192] kmem_alloc+0x59/0xc0
Sep 22 11:42:08 precious kernel:  [xfs_dir2_leaf_getdents+2633/2976] xfs_dir2_leaf_getdents+0xa49/0xba0
Sep 22 11:42:08 precious kernel:  [d_splice_alias+73/256] d_splice_alias+0x49/0x100
Sep 22 11:42:08 precious kernel:  [linvfs_lookup+120/160] linvfs_lookup+0x78/0xa0
Sep 22 11:42:08 precious kernel:  [xfs_dir2_put_dirent64_direct+0/160] xfs_dir2_put_dirent64_direct+0x0/0xa0
Sep 22 11:42:08 precious kernel:  [xfs_dir2_put_dirent64_direct+0/160] xfs_dir2_put_dirent64_direct+0x0/0xa0
Sep 22 11:42:08 precious kernel:  [xfs_dir2_getdents+264/352] xfs_dir2_getdents+0x108/0x160
Sep 22 11:42:08 precious kernel:  [xfs_dir2_put_dirent64_direct+0/160] xfs_dir2_put_dirent64_direct+0x0/0xa0
Sep 22 11:42:08 precious kernel:  [xfs_readdir+96/192] xfs_readdir+0x60/0xc0
Sep 22 11:42:08 precious kernel:  [linvfs_readdir+278/592] linvfs_readdir+0x116/0x250
Sep 22 11:42:08 precious kernel:  [vfs_readdir+137/176] vfs_readdir+0x89/0xb0
Sep 22 11:42:08 precious kernel:  [filldir64+0/256] filldir64+0x0/0x100
Sep 22 11:42:08 precious kernel:  [sys_getdents64+110/170] sys_getdents64+0x6e/0xaa
Sep 22 11:42:08 precious kernel:  [filldir64+0/256] filldir64+0x0/0x100
Sep 22 11:42:08 precious kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 22 11:42:08 precious kernel: Code: a0 96 45 c0 89 44 24 08 8b 04 ad e0 05 3b c0 89 44 24 04 e8 2f 6f ed ff ff 74 24 0c 9d ff 4b 14 8b 43 08 a8 08 75 14 85 ed 75 08 <0f> 0b 6a 00 c9 d2 36 c0 83 c4 10 5b 5e 5f 5d c3 e8 47 17 11 00 

Jan
-- 
Is this really happening?
