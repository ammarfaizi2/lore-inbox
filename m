Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264471AbTCXWjO>; Mon, 24 Mar 2003 17:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264480AbTCXWjN>; Mon, 24 Mar 2003 17:39:13 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:13804 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264471AbTCXWjH>; Mon, 24 Mar 2003 17:39:07 -0500
Message-ID: <20030324225003.12958.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: ciarrocchi@linuxmail.org
Date: Tue, 25 Mar 2003 06:50:02 +0800
Subject: [BUG] can not load ide-cs
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
kernel is 2.5.65.

I'm playing with a pcmcia card, if look at it I see: "Flashdisk 10MB, Mass Storage System, SanDisk PCMCIA PC CARD ATA"

I've compiled the module ide-cs.ko, then I've ran /etc/init.d/pcmcia start and inserted the card,
this is what /var/log/message reported

Mar 25 00:25:27 frodo cardmgr[872]: watching 2 sockets
Mar 25 00:25:27 frodo kernel: cs: IO port probe 0x0c00-0x0cff: clean.
Mar 25 00:25:27 frodo cardmgr[873]: starting, version is 3.2.0
Mar 25 00:25:27 frodo kernel: cs: IO port probe 0x0100-0x04ff: excluding 0x2f8-0x2ff 0x398-0x39f 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
Mar 25 00:25:27 frodo kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Mar 25 00:25:27 frodo kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Mar 25 00:25:27 frodo cardmgr[873]: socket 1: ATA/IDE Fixed Disk
Mar 25 00:25:27 frodo cardmgr[873]: executing: 'modprobe ide-cs'
Mar 25 00:25:29 frodo kernel: hde: SunDisk SDP3B-10, CFA DISK drive
Mar 25 00:25:29 frodo kernel: hdf: SunDisk SDP3B-10, CFA DISK drive
Mar 25 00:25:29 frodo kernel: ide2 at 0x100-0x107,0x10e on irq 3
Mar 25 00:25:29 frodo kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Mar 25 00:25:29 frodo kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Mar 25 00:25:29 frodo kernel: hde: 20480 sectors (10 MB) w/1KiB Cache, CHS=320/2/32
Mar 25 00:25:30 frodo kernel:  hde: hde1
Mar 25 00:25:30 frodo kernel:  hde: hde1
Mar 25 00:25:30 frodo kernel: Badness in kobject_register at lib/kobject.c:152
Mar 25 00:25:30 frodo kernel: Call Trace:
Mar 25 00:25:30 frodo kernel:  [kobject_register+88/112] kobject_register+0x58/0x70
Mar 25 00:25:30 frodo kernel:  [<c01d7ee8>] kobject_register+0x58/0x70
Mar 25 00:25:30 frodo kernel:  [register_disk+329/352] register_disk+0x149/0x160
Mar 25 00:25:30 frodo kernel:  [<c01819b9>] register_disk+0x149/0x160
Mar 25 00:25:30 frodo kernel:  [blk_register_region+72/224] blk_register_region+0x48/0xe0
Mar 25 00:25:30 frodo kernel:  [<c022a4a8>] blk_register_region+0x48/0xe0
Mar 25 00:25:30 frodo kernel:  [add_disk+81/96] add_disk+0x51/0x60
Mar 25 00:25:30 frodo kernel:  [<c022a671>] add_disk+0x51/0x60
Mar 25 00:25:30 frodo kernel:  [exact_match+0/16] exact_match+0x0/0x10
Mar 25 00:25:30 frodo kernel:  [<c022a5f0>] exact_match+0x0/0x10
Mar 25 00:25:30 frodo kernel:  [exact_lock+0/32] exact_lock+0x0/0x20
Mar 25 00:25:30 frodo kernel:  [<c022a600>] exact_lock+0x0/0x20
Mar 25 00:25:30 frodo kernel:  [idedisk_attach+283/416] idedisk_attach+0x11b/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c02475fb>] idedisk_attach+0x11b/0x1a0
Mar 25 00:25:30 frodo kernel:  [ata_attach+158/480] ata_attach+0x9e/0x1e0
Mar 25 00:25:30 frodo kernel:  [<c0242e9e>] ata_attach+0x9e/0x1e0
Mar 25 00:25:30 frodo kernel:  [ideprobe_init+175/256] ideprobe_init+0xaf/0x100
Mar 25 00:25:30 frodo kernel:  [<c023bcaf>] ideprobe_init+0xaf/0x100
Mar 25 00:25:30 frodo kernel:  [ide_probe_module+19/32] ide_probe_module+0x13/0x20
Mar 25 00:25:30 frodo kernel:  [<c02414b3>] ide_probe_module+0x13/0x20
Mar 25 00:25:30 frodo kernel:  [ide_register_hw+361/416] ide_register_hw+0x169/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c0242009>] ide_register_hw+0x169/0x1a0
Mar 25 00:25:30 frodo kernel:  [<d092b2a3>] idecs_register+0x63/0x80 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [CardServices+528/864] CardServices+0x210/0x360
Mar 25 00:25:30 frodo kernel:  [<c0269c30>] CardServices+0x210/0x360
Mar 25 00:25:30 frodo kernel:  [<d092b7db>] ide_config+0x51b/0x870 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [vesafb_setcolreg+112/240] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [<c0262100>] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [read_cis_mem+303/416] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c026230f>] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_tuple_data+145/160] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [<c02632c1>] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [pcmcia_parse_tuple+268/368] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [<c02645fc>] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [read_tuple+116/128] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [<c02646d4>] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [yenta_set_mem_map+432/512] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [<c026c7a0>] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_next_tuple+596/688] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c02631d4>] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_first_tuple+181/384] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [<c0262d15>] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [__find_get_block+100/224] __find_get_block+0x64/0xe0
Mar 25 00:25:30 frodo kernel:  [<c01561b4>] __find_get_block+0x64/0xe0
Mar 25 00:25:30 frodo kernel:  [yenta_set_mem_map+432/512] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [<c026c7a0>] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [vesafb_setcolreg+112/240] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [<c0262100>] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [read_cis_mem+303/416] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c026230f>] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_tuple_data+145/160] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [<c02632c1>] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [pcmcia_parse_tuple+268/368] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [<c02645fc>] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [read_tuple+116/128] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [<c02646d4>] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [yenta_set_mem_map+432/512] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [<c026c7a0>] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_next_tuple+596/688] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c02631d4>] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_first_tuple+181/384] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [<c0262d15>] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [read_cis_mem+303/416] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c026230f>] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_next_tuple+596/688] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c02631d4>] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [pcmcia_validate_cis+255/480] pcmcia_validate_cis+0xff/0x1e0
Mar 25 00:25:30 frodo kernel:  [<c02647df>] pcmcia_validate_cis+0xff/0x1e0
Mar 25 00:25:30 frodo kernel:  [reiserfs_get_block+1821/4736] reiserfs_get_block+0x71d/0x1280
Mar 25 00:25:30 frodo kernel:  [<c01b2ccd>] reiserfs_get_block+0x71d/0x1280
Mar 25 00:25:30 frodo kernel:  [<d092bcc8>] ide_event+0x68/0x100 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [pcmcia_register_client+530/688] pcmcia_register_client+0x212/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c0268662>] pcmcia_register_client+0x212/0x2b0
Mar 25 00:25:30 frodo kernel:  [<d092c540>] dev_info+0x0/0x20 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [do_IRQ+283/352] do_IRQ+0x11b/0x160
Mar 25 00:25:30 frodo kernel:  [<c010d5ab>] do_IRQ+0x11b/0x160
Mar 25 00:25:30 frodo kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 25 00:25:30 frodo kernel:  [<c010bb38>] common_interrupt+0x18/0x20
Mar 25 00:25:30 frodo kernel:  [CardServices+427/864] CardServices+0x1ab/0x360
Mar 25 00:25:30 frodo kernel:  [<c0269bcb>] CardServices+0x1ab/0x360
Mar 25 00:25:30 frodo kernel:  [<d092b137>] ide_attach+0x107/0x150 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [<d092c540>] dev_info+0x0/0x20 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [<d092bc60>] ide_event+0x0/0x100 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [pcmcia_bind_device+87/208] pcmcia_bind_device+0x57/0xd0
Mar 25 00:25:30 frodo kernel:  [<c02678c7>] pcmcia_bind_device+0x57/0xd0
Mar 25 00:25:30 frodo kernel:  [bind_request+388/496] bind_request+0x184/0x1f0
Mar 25 00:25:30 frodo kernel:  [<c026abf4>] bind_request+0x184/0x1f0
Mar 25 00:25:30 frodo kernel:  [ds_ioctl+1490/1824] ds_ioctl+0x5d2/0x720
Mar 25 00:25:30 frodo kernel:  [<c026b802>] ds_ioctl+0x5d2/0x720
Mar 25 00:25:30 frodo kernel:  [preempt_schedule+54/80] preempt_schedule+0x36/0x50
Mar 25 00:25:30 frodo kernel:  [<c011df66>] preempt_schedule+0x36/0x50
Mar 25 00:25:30 frodo kernel:  [unix_dgram_sendmsg+857/1376] unix_dgram_sendmsg+0x359/0x560
Mar 25 00:25:30 frodo kernel:  [<c0322aa9>] unix_dgram_sendmsg+0x359/0x560
Mar 25 00:25:30 frodo kernel:  [proc_alloc_inode+77/128] proc_alloc_inode+0x4d/0x80
Mar 25 00:25:30 frodo kernel:  [<c017b65d>] proc_alloc_inode+0x4d/0x80
Mar 25 00:25:30 frodo kernel:  [sock_sendmsg+142/176] sock_sendmsg+0x8e/0xb0
Mar 25 00:25:30 frodo kernel:  [<c02d4f2e>] sock_sendmsg+0x8e/0xb0
Mar 25 00:25:30 frodo kernel:  [get_new_inode_fast+64/240] get_new_inode_fast+0x40/0xf0
Mar 25 00:25:30 frodo kernel:  [<c016c4d0>] get_new_inode_fast+0x40/0xf0
Mar 25 00:25:30 frodo kernel:  [schedule+420/944] schedule+0x1a4/0x3b0
Mar 25 00:25:30 frodo kernel:  [<c011dd24>] schedule+0x1a4/0x3b0
Mar 25 00:25:30 frodo kernel:  [zap_pmd_range+78/112] zap_pmd_range+0x4e/0x70
Mar 25 00:25:30 frodo kernel:  [<c0143fce>] zap_pmd_range+0x4e/0x70
Mar 25 00:25:30 frodo kernel:  [unmap_page_range+78/144] unmap_page_range+0x4e/0x90
Mar 25 00:25:30 frodo kernel:  [<c014403e>] unmap_page_range+0x4e/0x90
Mar 25 00:25:30 frodo kernel:  [unmap_vmas+227/624] unmap_vmas+0xe3/0x270
Mar 25 00:25:30 frodo kernel:  [<c0144163>] unmap_vmas+0xe3/0x270
Mar 25 00:25:30 frodo kernel:  [unmap_vma+67/128] unmap_vma+0x43/0x80
Mar 25 00:25:30 frodo kernel:  [<c0147aa3>] unmap_vma+0x43/0x80
Mar 25 00:25:30 frodo kernel:  [unmap_vma_list+31/48] unmap_vma_list+0x1f/0x30
Mar 25 00:25:30 frodo kernel:  [<c0147aff>] unmap_vma_list+0x1f/0x30
Mar 25 00:25:30 frodo kernel:  [do_munmap+356/448] do_munmap+0x164/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0147ec4>] do_munmap+0x164/0x1c0
Mar 25 00:25:30 frodo kernel:  [sys_ioctl+282/672] sys_ioctl+0x11a/0x2a0
Mar 25 00:25:30 frodo kernel:  [<c01651da>] sys_ioctl+0x11a/0x2a0
Mar 25 00:25:30 frodo kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 25 00:25:30 frodo kernel:  [<c010b1cb>] syscall_call+0x7/0xb
Mar 25 00:25:30 frodo kernel: 
Mar 25 00:25:30 frodo kernel: hdf: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Mar 25 00:25:30 frodo kernel: hdf: task_no_data_intr: error=0x04 { DriveStatusError }
Mar 25 00:25:30 frodo kernel: hdf: 20480 sectors (10 MB) w/1KiB Cache, CHS=320/2/32
Mar 25 00:25:30 frodo kernel:  hdf: hdf1
Mar 25 00:25:30 frodo kernel:  hdf: hdf1
Mar 25 00:25:30 frodo kernel: Badness in kobject_register at lib/kobject.c:152
Mar 25 00:25:30 frodo kernel: Call Trace:
Mar 25 00:25:30 frodo kernel:  [kobject_register+88/112] kobject_register+0x58/0x70
Mar 25 00:25:30 frodo kernel:  [<c01d7ee8>] kobject_register+0x58/0x70
Mar 25 00:25:30 frodo kernel:  [register_disk+329/352] register_disk+0x149/0x160
Mar 25 00:25:30 frodo kernel:  [<c01819b9>] register_disk+0x149/0x160
Mar 25 00:25:30 frodo kernel:  [blk_register_region+72/224] blk_register_region+0x48/0xe0
Mar 25 00:25:30 frodo kernel:  [<c022a4a8>] blk_register_region+0x48/0xe0
Mar 25 00:25:30 frodo kernel:  [add_disk+81/96] add_disk+0x51/0x60
Mar 25 00:25:30 frodo kernel:  [<c022a671>] add_disk+0x51/0x60
Mar 25 00:25:30 frodo kernel:  [exact_match+0/16] exact_match+0x0/0x10
Mar 25 00:25:30 frodo kernel:  [<c022a5f0>] exact_match+0x0/0x10
Mar 25 00:25:30 frodo kernel:  [exact_lock+0/32] exact_lock+0x0/0x20
Mar 25 00:25:30 frodo kernel:  [<c022a600>] exact_lock+0x0/0x20
Mar 25 00:25:30 frodo kernel:  [idedisk_attach+283/416] idedisk_attach+0x11b/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c02475fb>] idedisk_attach+0x11b/0x1a0
Mar 25 00:25:30 frodo kernel:  [ata_attach+158/480] ata_attach+0x9e/0x1e0
Mar 25 00:25:30 frodo kernel:  [<c0242e9e>] ata_attach+0x9e/0x1e0
Mar 25 00:25:30 frodo kernel:  [ideprobe_init+175/256] ideprobe_init+0xaf/0x100
Mar 25 00:25:30 frodo kernel:  [<c023bcaf>] ideprobe_init+0xaf/0x100
Mar 25 00:25:30 frodo kernel:  [ide_probe_module+19/32] ide_probe_module+0x13/0x20
Mar 25 00:25:30 frodo kernel:  [<c02414b3>] ide_probe_module+0x13/0x20
Mar 25 00:25:30 frodo kernel:  [ide_register_hw+361/416] ide_register_hw+0x169/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c0242009>] ide_register_hw+0x169/0x1a0
Mar 25 00:25:30 frodo kernel:  [<d092b2a3>] idecs_register+0x63/0x80 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [CardServices+528/864] CardServices+0x210/0x360
Mar 25 00:25:30 frodo kernel:  [<c0269c30>] CardServices+0x210/0x360
Mar 25 00:25:30 frodo kernel:  [<d092b7db>] ide_config+0x51b/0x870 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [vesafb_setcolreg+112/240] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [<c0262100>] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [read_cis_mem+303/416] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c026230f>] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_tuple_data+145/160] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [<c02632c1>] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [pcmcia_parse_tuple+268/368] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [<c02645fc>] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [read_tuple+116/128] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [<c02646d4>] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [yenta_set_mem_map+432/512] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [<c026c7a0>] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_next_tuple+596/688] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c02631d4>] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_first_tuple+181/384] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [<c0262d15>] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [__find_get_block+100/224] __find_get_block+0x64/0xe0
Mar 25 00:25:30 frodo kernel:  [<c01561b4>] __find_get_block+0x64/0xe0
Mar 25 00:25:30 frodo kernel:  [yenta_set_mem_map+432/512] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [<c026c7a0>] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [vesafb_setcolreg+112/240] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [<c0262100>] vesafb_setcolreg+0x70/0xf0
Mar 25 00:25:30 frodo kernel:  [read_cis_mem+303/416] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c026230f>] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_tuple_data+145/160] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [<c02632c1>] pcmcia_get_tuple_data+0x91/0xa0
Mar 25 00:25:30 frodo kernel:  [pcmcia_parse_tuple+268/368] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [<c02645fc>] pcmcia_parse_tuple+0x10c/0x170
Mar 25 00:25:30 frodo kernel:  [read_tuple+116/128] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [<c02646d4>] read_tuple+0x74/0x80
Mar 25 00:25:30 frodo kernel:  [yenta_set_mem_map+432/512] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [<c026c7a0>] yenta_set_mem_map+0x1b0/0x200
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_next_tuple+596/688] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c02631d4>] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_first_tuple+181/384] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [<c0262d15>] pcmcia_get_first_tuple+0xb5/0x180
Mar 25 00:25:30 frodo kernel:  [pci_set_mem_map+61/64] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [<c026bbed>] pci_set_mem_map+0x3d/0x40
Mar 25 00:25:30 frodo kernel:  [read_cis_mem+303/416] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [<c026230f>] read_cis_mem+0x12f/0x1a0
Mar 25 00:25:30 frodo kernel:  [read_cis_cache+379/448] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0262a2b>] read_cis_cache+0x17b/0x1c0
Mar 25 00:25:30 frodo kernel:  [pcmcia_get_next_tuple+596/688] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c02631d4>] pcmcia_get_next_tuple+0x254/0x2b0
Mar 25 00:25:30 frodo kernel:  [pcmcia_validate_cis+255/480] pcmcia_validate_cis+0xff/0x1e0
Mar 25 00:25:30 frodo kernel:  [<c02647df>] pcmcia_validate_cis+0xff/0x1e0
Mar 25 00:25:30 frodo kernel:  [reiserfs_get_block+1821/4736] reiserfs_get_block+0x71d/0x1280
Mar 25 00:25:30 frodo kernel:  [<c01b2ccd>] reiserfs_get_block+0x71d/0x1280
Mar 25 00:25:30 frodo kernel:  [<d092bcc8>] ide_event+0x68/0x100 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [pcmcia_register_client+530/688] pcmcia_register_client+0x212/0x2b0
Mar 25 00:25:30 frodo kernel:  [<c0268662>] pcmcia_register_client+0x212/0x2b0
Mar 25 00:25:30 frodo kernel:  [<d092c540>] dev_info+0x0/0x20 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [do_IRQ+283/352] do_IRQ+0x11b/0x160
Mar 25 00:25:30 frodo kernel:  [<c010d5ab>] do_IRQ+0x11b/0x160
Mar 25 00:25:30 frodo kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
Mar 25 00:25:30 frodo kernel:  [<c010bb38>] common_interrupt+0x18/0x20
Mar 25 00:25:30 frodo kernel:  [CardServices+427/864] CardServices+0x1ab/0x360
Mar 25 00:25:30 frodo kernel:  [<c0269bcb>] CardServices+0x1ab/0x360
Mar 25 00:25:30 frodo kernel:  [<d092b137>] ide_attach+0x107/0x150 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [<d092c540>] dev_info+0x0/0x20 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [<d092bc60>] ide_event+0x0/0x100 [ide_cs]
Mar 25 00:25:30 frodo kernel:  [pcmcia_bind_device+87/208] pcmcia_bind_device+0x57/0xd0
Mar 25 00:25:30 frodo kernel:  [<c02678c7>] pcmcia_bind_device+0x57/0xd0
Mar 25 00:25:30 frodo kernel:  [bind_request+388/496] bind_request+0x184/0x1f0
Mar 25 00:25:30 frodo kernel:  [<c026abf4>] bind_request+0x184/0x1f0
Mar 25 00:25:30 frodo kernel:  [ds_ioctl+1490/1824] ds_ioctl+0x5d2/0x720
Mar 25 00:25:30 frodo kernel:  [<c026b802>] ds_ioctl+0x5d2/0x720
Mar 25 00:25:30 frodo kernel:  [preempt_schedule+54/80] preempt_schedule+0x36/0x50
Mar 25 00:25:30 frodo kernel:  [<c011df66>] preempt_schedule+0x36/0x50
Mar 25 00:25:30 frodo kernel:  [unix_dgram_sendmsg+857/1376] unix_dgram_sendmsg+0x359/0x560
Mar 25 00:25:30 frodo kernel:  [<c0322aa9>] unix_dgram_sendmsg+0x359/0x560
Mar 25 00:25:30 frodo kernel:  [proc_alloc_inode+77/128] proc_alloc_inode+0x4d/0x80
Mar 25 00:25:30 frodo kernel:  [<c017b65d>] proc_alloc_inode+0x4d/0x80
Mar 25 00:25:30 frodo kernel:  [sock_sendmsg+142/176] sock_sendmsg+0x8e/0xb0
Mar 25 00:25:30 frodo kernel:  [<c02d4f2e>] sock_sendmsg+0x8e/0xb0
Mar 25 00:25:30 frodo kernel:  [get_new_inode_fast+64/240] get_new_inode_fast+0x40/0xf0
Mar 25 00:25:30 frodo kernel:  [<c016c4d0>] get_new_inode_fast+0x40/0xf0
Mar 25 00:25:30 frodo kernel:  [schedule+420/944] schedule+0x1a4/0x3b0
Mar 25 00:25:30 frodo kernel:  [<c011dd24>] schedule+0x1a4/0x3b0
Mar 25 00:25:30 frodo kernel:  [zap_pmd_range+78/112] zap_pmd_range+0x4e/0x70
Mar 25 00:25:30 frodo kernel:  [<c0143fce>] zap_pmd_range+0x4e/0x70
Mar 25 00:25:30 frodo kernel:  [unmap_page_range+78/144] unmap_page_range+0x4e/0x90
Mar 25 00:25:30 frodo kernel:  [<c014403e>] unmap_page_range+0x4e/0x90
Mar 25 00:25:30 frodo kernel:  [unmap_vmas+227/624] unmap_vmas+0xe3/0x270
Mar 25 00:25:30 frodo kernel:  [<c0144163>] unmap_vmas+0xe3/0x270
Mar 25 00:25:30 frodo kernel:  [unmap_vma+67/128] unmap_vma+0x43/0x80
Mar 25 00:25:30 frodo kernel:  [<c0147aa3>] unmap_vma+0x43/0x80
Mar 25 00:25:30 frodo kernel:  [unmap_vma_list+31/48] unmap_vma_list+0x1f/0x30
Mar 25 00:25:30 frodo kernel:  [<c0147aff>] unmap_vma_list+0x1f/0x30
Mar 25 00:25:30 frodo kernel:  [do_munmap+356/448] do_munmap+0x164/0x1c0
Mar 25 00:25:30 frodo kernel:  [<c0147ec4>] do_munmap+0x164/0x1c0
Mar 25 00:25:30 frodo kernel:  [sys_ioctl+282/672] sys_ioctl+0x11a/0x2a0
Mar 25 00:25:30 frodo kernel:  [<c01651da>] sys_ioctl+0x11a/0x2a0
Mar 25 00:25:30 frodo kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 25 00:25:30 frodo kernel:  [<c010b1cb>] syscall_call+0x7/0xb
Mar 25 00:25:30 frodo kernel: 

Here I try to /etc/init.d/pcmcia stop

Mar 25 00:25:30 frodo kernel: Module ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:457
Mar 25 00:25:30 frodo kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Mar 25 00:25:30 frodo cardmgr[873]: executing: './ide start hde'
Mar 25 00:25:33 frodo cardmgr[873]: executing: './ide check hde'
Mar 25 00:25:34 frodo cardmgr[873]: executing: './ide stop hde'
Mar 25 00:25:34 frodo cardmgr[873]: executing: 'modprobe -r ide-cs'
Mar 25 00:25:34 frodo cardmgr[873]: + FATAL: Error removing ide_cs (/lib/modules/2.5.65/kernel/drivers/ide/legacy/ide-cs.ko): Device or resource busy
Mar 25 00:25:34 frodo cardmgr[873]: modprobe exited with status 1
Mar 25 00:25:34 frodo cardmgr[873]: exiting

Let me know if I have to provide more information

Ciao,
        Paolo

P.S Please cc me ;-)
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
