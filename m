Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262641AbVAVBPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262641AbVAVBPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 20:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVAVBPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 20:15:05 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:37509 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262641AbVAVBO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 20:14:58 -0500
Message-ID: <41F1A90D.5000809@drzeus.cx>
Date: Sat, 22 Jan 2005 02:14:53 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Page fault in umount
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I yank out my MP3 player, the programs trying to umount the disk 
cause the following page fault:

usb 1-5: USB disconnect, address 2
scsi0 (0:0): rejecting I/O to dead device
FAT bread failed in fat_clusters_flush
Unable to handle kernel paging request at virtual address 6b6b6b6b
  printing eip:
e0a0ecaf
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: radeon pcspkr iptable_filter tun parport_pc lp 
parport irport irnet ppp_generic slhc ircomm_tty ircomm irda crc_ccitt 
sd_mod autofs4 hidp rfcomm l2cap bluetooth pcmcia sunrpc ipt_MASQUERADE 
iptable_nat usb_storage scsi_mod ip_conntrack ip_tables microcode 
binfmt_misc nls_iso8859_1 nls_cp437 vfat fat ext3 jbd video button 
battery ac ohci1394 ieee1394 yenta_socket pcmcia_core uhci_hcd ehci_hcd 
i2c_i801 i2c_core snd_intel8x0m snd_intel8x0 snd_ac97_codec snd_pcm_oss 
snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139cp mii
CPU:    0
EIP:    0060:[<e0a0ecaf>]    Not tainted VLI
EFLAGS: 00010296   (2.6.10)
EIP is at scsi_device_put+0xf/0x70 [scsi_mod]
eax: 6b6b6b6b   ebx: d8994150   ecx: 00000000   edx: 00000000
esi: 6b6b6b6b   edi: dfcae46c   ebp: 00000000   esp: ce6b3ee4
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 7190, threadinfo=ce6b2000 task=cbe5c000)
Stack: d883b9f4 d8994150 d883b9f4 e0b38103 6b6b6b6b e0b3a190 d8994150 
e0b386f7
        d8994150 00000000 dc6a1764 dc6a17f8 c0195e56 dc6a17f8 00000000 
dc6a19b8
        c0472680 00000000 00000000 c0195ed0 dc6a1764 c0193acd d89645f8 
e09f6ec0
Call Trace:
  [<e0b38103>] scsi_disk_put+0x33/0x50 [sd_mod]
  [<e0b3a190>] scsi_disk_release+0x0/0x1b0 [sd_mod]
  [<e0b386f7>] sd_release+0x47/0x90 [sd_mod]
  [<c0195e56>] blkdev_put+0xc6/0x170
  [<c0195ed0>] blkdev_put+0x140/0x170
  [<c0193acd>] kill_block_super+0x3d/0x60
  [<c019144c>] deactivate_super+0xac/0x120
  [<c01b4f95>] __mntput+0x25/0x40
  [<c01b5c9f>] sys_umount+0x3f/0xa0
  [<c01746a4>] sys_munmap+0x44/0x70
  [<c0103c59>] sysenter_past_esp+0x52/0x75
Code: 34 24 e8 05 ba 90 df ba fa ff ff ff eb e0 8d b4 26 00 00 00 00 8d 
bc 27 00 00 00 00 83 ec 0c 89 74 24 08 8b 74 24 10 89 5c 24 04 <8b> 06 
8b 80 b4 00 00 00 8b 00 85 c0 74 1f bb 00 e0 ff ff 21 e3

The device is mounted in sync so shouldn't this be safe as long as the 
device isn't busy? This works on other USB devices I have.
A page fault seems severe either way.

Rgds
Pierre
