Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVBIBdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVBIBdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVBIBdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:33:43 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:15296 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261734AbVBIBdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:33:21 -0500
From: "Gerd v. Egidy" <gerd@egidy.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc3: oops in pdflush
Date: Wed, 9 Feb 2005 02:32:52 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502090232.52550.gerd@egidy.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4b4daea3f4422cce71613c46111f294e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

rc3 vanilla oopses within 2 or 3 hours of heavy io load (rdiff-backup of ide disk 
(reiserfs3) to usb-storage (reiserfs3 on dm-crypt) and listening to internet radio in 
parallel). This is 100% reproducable here.

Usually there occur 4 or 5 of very similar looking oopses within 3 hours until the 
machine is not usable anymore (all commands stuck, sysrq-sync not completing) 
and I have to reboot.

To me the error message looks like a lock imbalance but I'm not a kernel hacker...

Does anybody have an idea whats going on here?

Please CC me as I'm not subscribed. Thank you.

Kind regards,

Gerd

Feb  8 16:00:38 fire kernel: Unable to handle kernel paging request at virtual address 0002ba10
Feb  8 16:00:38 fire kernel:  printing eip:
Feb  8 16:00:38 fire kernel: c01a8377
Feb  8 16:00:38 fire kernel: *pde = 00000000
Feb  8 16:00:38 fire kernel: Oops: 0000 [#4]
Feb  8 16:00:38 fire kernel: Modules linked in: aes_i586 dm_crypt sd_mod usb_storage scsi_mod nfsd exportfs lockd sunrpc md5
 ipv6 autofs4 dm_mod video button battery ac uhci_hcd ehci_hcd parport_pc parport i2c_viapro i2c_core snd_via82xx snd_ac97_codec
 snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
 8139too mii reiserfs
Feb  8 16:00:38 fire kernel: CPU:    0
Feb  8 16:00:38 fire kernel: EIP:    0060:[<c01a8377>]    Not tainted VLI
Feb  8 16:00:38 fire kernel: EFLAGS: 00010282   (2.6.11-rc3) 
Feb  8 16:00:38 fire kernel: EIP is at sync_sb_inodes+0x3b7/0x3e0
Feb  8 16:00:38 fire kernel: eax: d746df48   ebx: c8534570   ecx: d8ac8a40   edx: cbc46fdc
Feb  8 16:00:38 fire kernel: esi: c8534568   edi: cbc46f30   ebp: d680db3c   esp: d746dec0
Feb  8 16:00:38 fire kernel: ds: 007b   es: 007b   ss: 0068
Feb  8 16:00:38 fire kernel: Process pdflush (pid: 141, threadinfo=d746c000 task=d74346f0)
Feb  8 16:00:38 fire kernel: Stack: c047007b d7d1105c 00000063 c03eed60 d746defc c0152200 c02955bf cbc46fe4 
Feb  8 16:00:38 fire kernel:        00000246 c013c580 0011903f d746df48 cbc46f30 d746df48 d746df38 c0152200 
Feb  8 16:00:38 fire kernel:        c01a8536 c013c580 c0150910 d746df38 c015093d d746df34 fffff0da d746df48 
Feb  8 16:00:38 fire kernel: Call Trace:
Feb  8 16:00:38 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 16:00:38 fire kernel:  [<c02955bf>] blk_congestion_wait+0x7f/0x90
Feb  8 16:00:38 fire kernel:  [<c013c580>] autoremove_wake_function+0x0/0x50
Feb  8 16:00:38 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 16:00:38 fire kernel:  [<c01a8536>] writeback_inodes+0x196/0x470
Feb  8 16:00:38 fire kernel:  [<c013c580>] autoremove_wake_function+0x0/0x50
Feb  8 16:00:38 fire kernel:  [<c0150910>] get_writeback_state+0x30/0x40
Feb  8 16:00:38 fire kernel:  [<c015093d>] get_dirty_limits+0x1d/0xe0
Feb  8 16:00:38 fire kernel:  [<c0150be6>] background_writeout+0x76/0xb0
Feb  8 16:00:38 fire kernel:  [<c0151e29>] __pdflush+0x219/0x5f0
Feb  8 16:00:38 fire kernel:  [<c015221a>] pdflush+0x1a/0x20
Feb  8 16:00:38 fire kernel:  [<c0150b70>] background_writeout+0x0/0xb0
Feb  8 16:00:38 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 16:00:38 fire kernel:  [<c013ba54>] kthread+0x94/0xa0
Feb  8 16:00:38 fire kernel:  [<c013b9c0>] kthread+0x0/0xa0
Feb  8 16:00:38 fire kernel:  [<c010130d>] kernel_thread_helper+0x5/0x18
Feb  8 16:00:38 fire kernel: Code: 97 ac 00 00 00 e9 1c fe ff ff 0f 0b 6b 01 8a 4d 39 c0 e9 e4 fd ff ff 89 e8 e8 66 10 00 00 85 c0 0f 85 c8 fd ff ff e9 0a fd ff ff <8b> 05 10 ba 02 00 00 00 ff d1 e9 25 fd ff ff 8b 9f b4 00 00 00 
Feb  8 16:00:38 fire kernel:  fs/inode.c:785: spin_lock(fs/inode.c:c03d8350) already locked by fs/fs-writeback.c/430


Feb  8 16:54:52 fire kernel: Unable to handle kernel paging request at virtual address 0002ba10
Feb  8 16:54:52 fire kernel:  printing eip:
Feb  8 16:54:52 fire kernel: c01a8377
Feb  8 16:54:52 fire kernel: *pde = 00000000
Feb  8 16:54:52 fire kernel: Oops: 0000 [#5]
Feb  8 16:54:52 fire kernel: Modules linked in: aes_i586 dm_crypt sd_mod usb_storage scsi_mod nfsd exportfs lockd sunrpc md5 
ipv6 autofs4 dm_mod video button battery ac uhci_hcd ehci_hcd parport_pc parport i2c_viapro i2c_core snd_via82xx snd_ac97_codec
 snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore 8139too mii reiserfs
Feb  8 16:54:52 fire kernel: CPU:    0
Feb  8 16:54:52 fire kernel: EIP:    0060:[<c01a8377>]    Not tainted VLI
Feb  8 16:54:52 fire kernel: EFLAGS: 00010282   (2.6.11-rc3) 
Feb  8 16:54:52 fire kernel: EIP is at sync_sb_inodes+0x3b7/0x3e0
Feb  8 16:54:52 fire kernel: eax: ce69bf38   ebx: c8e640f8   ecx: d8ac8a40   edx: ce69bf38
Feb  8 16:54:52 fire kernel: esi: c8e640f0   edi: cbc46f30   ebp: d680db3c   esp: ce69bec8
Feb  8 16:54:52 fire kernel: ds: 007b   es: 007b   ss: 0068
Feb  8 16:54:52 fire kernel: Process pdflush (pid: 3136, threadinfo=ce69a000 task=d74346f0)
Feb  8 16:54:52 fire kernel: Stack: cbc46f30 d8878140 cbc46f30 00000000 00000000 00000000 cbc46f30 cbc46fe4 
Feb  8 16:54:52 fire kernel:        ce69a000 00000000 004339b2 ce69bf38 cbc46f30 ce69bf38 00001bf5 c0152200 
Feb  8 16:54:52 fire kernel:        c01a8536 00000000 00000000 ce69bf2c c03cec20 d74346f0 c03cec20 d74346f0 
Feb  8 16:54:52 fire kernel: Call Trace:
Feb  8 16:54:52 fire kernel:  [<d8878140>] reiserfs_sync_fs+0x50/0x60 [reiserfs]
Feb  8 16:54:52 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 16:54:52 fire kernel:  [<c01a8536>] writeback_inodes+0x196/0x470
Feb  8 16:54:52 fire kernel:  [<c0150ce4>] wb_kupdate+0x94/0x100
Feb  8 16:54:52 fire kernel:  [<c0151e29>] __pdflush+0x219/0x5f0
Feb  8 16:54:52 fire kernel:  [<c015221a>] pdflush+0x1a/0x20
Feb  8 16:54:52 fire kernel:  [<c0150c50>] wb_kupdate+0x0/0x100
Feb  8 16:54:52 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 16:54:52 fire kernel:  [<c013ba54>] kthread+0x94/0xa0
Feb  8 16:54:52 fire kernel:  [<c013b9c0>] kthread+0x0/0xa0
Feb  8 16:54:52 fire kernel:  [<c010130d>] kernel_thread_helper+0x5/0x18
Feb  8 16:54:52 fire kernel: Code: 97 ac 00 00 00 e9 1c fe ff ff 0f 0b 6b 01 8a 4d 39 c0 e9 e4 fd ff ff 89 e8 e8 66 10 00 00 85 c0 0f 85 c8 fd ff ff e9 0a fd ff ff <8b> 05 10 ba 02 00 00 00 ff d1 e9 25 fd ff ff 8b 9f b4 00 00 00 
Feb  8 16:54:52 fire kernel:  lib/dec_and_lock.c:32: spin_lock(fs/inode.c:c03d8350) already locked by fs/fs-writeback.c/383


Feb  8 17:33:21 fire kernel: Unable to handle kernel paging request at virtual address 0002ba10
Feb  8 17:33:21 fire kernel:  printing eip:
Feb  8 17:33:21 fire kernel: c01a8377
Feb  8 17:33:21 fire kernel: *pde = 00000000
Feb  8 17:33:21 fire kernel: Oops: 0000 [#6]
Feb  8 17:33:21 fire kernel: Modules linked in: aes_i586 dm_crypt sd_mod usb_storage scsi_mod nfsd exportfs lockd sunrpc md5 
ipv6 autofs4 dm_mod video button battery ac uhci_hcd ehci_hcd parport_pc parport i2c_viapro i2c_core snd_via82xx snd_ac97_codec
 snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore 8139too mii reiserfs
Feb  8 17:33:21 fire kernel: CPU:    0
Feb  8 17:33:21 fire kernel: EIP:    0060:[<c01a8377>]    Not tainted VLI
Feb  8 17:33:21 fire kernel: EFLAGS: 00010282   (2.6.11-rc3) 
Feb  8 17:33:21 fire kernel: EIP is at sync_sb_inodes+0x3b7/0x3e0
Feb  8 17:33:21 fire kernel: eax: cc42df48   ebx: c8eebb74   ecx: d8ac8a40   edx: c8eeb948
Feb  8 17:33:21 fire kernel: esi: c8eebb6c   edi: cbc46f30   ebp: d680db3c   esp: cc42dec0
Feb  8 17:33:21 fire kernel: ds: 007b   es: 007b   ss: 0068
Feb  8 17:33:21 fire kernel: Process pdflush (pid: 3037, threadinfo=cc42c000 task=d59c4cd0)
Feb  8 17:33:21 fire kernel: Stack: c012538c 00000046 00000000 cc42df38 00000046 cc42def0 c010559b cbc46fe4 
Feb  8 17:33:21 fire kernel:        00000246 00000000 006675c4 cc42df48 cbc46f30 cc42df48 cc42df38 c0152200 
Feb  8 17:33:21 fire kernel:        c01a8536 c0152200 c0150910 cc42df38 c015093d cc42df34 ffffcb64 cc42df48 
Feb  8 17:33:21 fire kernel: Call Trace:
Feb  8 17:33:21 fire kernel:  [<c012538c>] __do_softirq+0x7c/0x90
Feb  8 17:33:21 fire kernel:  [<c010559b>] do_IRQ+0x3b/0x70
Feb  8 17:33:21 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 17:33:21 fire kernel:  [<c01a8536>] writeback_inodes+0x196/0x470
Feb  8 17:33:21 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 17:33:21 fire kernel:  [<c0150910>] get_writeback_state+0x30/0x40
Feb  8 17:33:21 fire kernel:  [<c015093d>] get_dirty_limits+0x1d/0xe0
Feb  8 17:33:21 fire kernel:  [<c0150be6>] background_writeout+0x76/0xb0
Feb  8 17:33:21 fire kernel:  [<c0151e29>] __pdflush+0x219/0x5f0
Feb  8 17:33:21 fire kernel:  [<c015221a>] pdflush+0x1a/0x20
Feb  8 17:33:21 fire kernel:  [<c0150b70>] background_writeout+0x0/0xb0
Feb  8 17:33:21 fire kernel:  [<c0152200>] pdflush+0x0/0x20
Feb  8 17:33:21 fire kernel:  [<c013ba54>] kthread+0x94/0xa0
Feb  8 17:33:21 fire kernel:  [<c013b9c0>] kthread+0x0/0xa0
Feb  8 17:33:21 fire kernel:  [<c010130d>] kernel_thread_helper+0x5/0x18
Feb  8 17:33:21 fire kernel: Code: 97 ac 00 00 00 e9 1c fe ff ff 0f 0b 6b 01 8a 4d 39 c0 e9 e4 fd ff ff 89 e8 e8 66 10 00 00 85 c0 0f 85 c8 fd ff ff e9 0a fd ff ff <8b> 05 10 ba 02 00 00 00 ff d1 e9 25 fd ff ff 8b 9f b4 00 00 00 
Feb  8 17:33:21 fire kernel:  lib/dec_and_lock.c:32: spin_lock(fs/inode.c:c03d8350) already locked by fs/fs-writeback.c/430
