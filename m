Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbUAIWdf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUAIWdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:33:35 -0500
Received: from mail.augustmail.com ([216.87.129.202]:58758 "EHLO
	mail.augustmail.com") by vger.kernel.org with ESMTP id S264423AbUAIWdc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:33:32 -0500
From: "Michael C. Ferguson" <mcf@augustmail.com>
To: linux-kernel@vger.kernel.org
Subject: Buffer error in fs/buffer.c
Date: Fri, 9 Jan 2004 16:33:31 -0600
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401091633.31202.mcf@augustmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

	I got a strange error in my logs this afternoon. I was upgrading to 2.6.1 as 
usual: mount /boot, copied the bzImage over (from reiserfs to ext3), called 
'sync'... and sync froze. The system is still usable (I'm writing this e-mail 
now on it), but sync has yet to recover. The system has otherwise been very 
stable, both in 2.6.0 and in XP. I'll attach the call trace and my lspci to 
the bottom; also, preemption is on. Let me know if there is anything else I 
can provide. I'm not subscribed to linux-kernel, so please cc: me to any 
replies.


---- Call trace ----

EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
buffer layer error at fs/buffer.c:1818
Call Trace:
 [<c0152ede>] __block_write_full_page+0x22a/0x3e6
 [<c0154647>] block_write_full_page+0xd8/0x101
 [<c015711d>] blkdev_get_block+0x0/0x5a
 [<c015727d>] blkdev_writepage+0x1f/0x23
 [<c015711d>] blkdev_get_block+0x0/0x5a
 [<c017044a>] mpage_writepages+0x217/0x2f1
 [<c015725e>] blkdev_writepage+0x0/0x23
 [<c015840d>] generic_writepages+0x1f/0x23
 [<c013a55e>] do_writepages+0x1e/0x38
 [<c0134e7e>] __filemap_fdatawrite+0xe3/0xec
 [<c0134e9e>] filemap_fdatawrite+0x17/0x1b
 [<c0151436>] sync_blockdev+0x26/0x4c
 [<c016f2e0>] sync_inodes+0x86/0x90
 [<c0151593>] do_sync+0x44/0x64
 [<c01515c2>] sys_sync+0xf/0x15
 [<c010915b>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:2664
Call Trace:
 [<c0154814>] submit_bh+0x126/0x176
 [<c0152eb6>] __block_write_full_page+0x202/0x3e6
 [<c0154647>] block_write_full_page+0xd8/0x101
 [<c015711d>] blkdev_get_block+0x0/0x5a
 [<c015727d>] blkdev_writepage+0x1f/0x23
 [<c015711d>] blkdev_get_block+0x0/0x5a
 [<c017044a>] mpage_writepages+0x217/0x2f1
 [<c015725e>] blkdev_writepage+0x0/0x23
 [<c015840d>] generic_writepages+0x1f/0x23
 [<c013a55e>] do_writepages+0x1e/0x38
 [<c0134e7e>] __filemap_fdatawrite+0xe3/0xec
 [<c0134e9e>] filemap_fdatawrite+0x17/0x1b
 [<c0151436>] sync_blockdev+0x26/0x4c
 [<c016f2e0>] sync_inodes+0x86/0x90
 [<c0151593>] do_sync+0x44/0x64
 [<c01515c2>] sys_sync+0xf/0x15
 [<c010915b>] syscall_call+0x7/0xb

---- End Call trace ----

---- lcpi ----
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB USB (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB USB2 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB Ultra ATA Storage Controller (rev 
02)
00:1f.3 SMBus: Intel Corp. 82801EB SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB AC'97 Audio 
Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti 4600] 
(rev a2)
02:01.0 Ethernet controller: Intel Corp.: Unknown device 1019
03:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller 
(rev 80)
03:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W
03:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
03:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
01)
---- lspci ----


Best regards,



Michael C. Ferguson
