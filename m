Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTDSL5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 07:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263382AbTDSL5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 07:57:39 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:22436 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S263381AbTDSL5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 07:57:33 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: kobject Badness while attaching ide-cs
Date: Sat, 19 Apr 2003 14:07:03 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304191407.03555.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I saw today when inserting a flash memory card to the pcmcia
slot (thursday's 2.5.67-bk, i386, preempt, no-smp). No idea what exactly 
went wrong, but an 80 line call trace sure looks scary.

	Arnd <><

Apr 19 09:28:33 b551138y kernel: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Apr 19 09:28:35 b551138y kernel: hde: CF Card 128MB, CFA DISK drive
Apr 19 09:28:35 b551138y kernel: ide2 at 0x100-0x107,0x10e on irq 3
Apr 19 09:29:05 b551138y kernel: hde: lost interrupt
Apr 19 09:29:05 b551138y kernel: hde: task_no_data_intr: status=0x58 { DriveReady SeekComplete DataRequest }
Apr 19 09:29:05 b551138y kernel: 
Apr 19 09:29:05 b551138y kernel: hde: 253440 sectors (130 MB) w/1KiB Cache, CHS=495/16/32
Apr 19 09:29:05 b551138y kernel:  hde:hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }
Apr 19 09:29:05 b551138y kernel: 
Apr 19 09:29:05 b551138y kernel:  hde1
Apr 19 09:29:05 b551138y kernel:  hde: hde1
Apr 19 09:29:05 b551138y kernel: Badness in kobject_register at lib/kobject.c:288
Apr 19 09:29:05 b551138y kernel: Call Trace:
Apr 19 09:29:05 b551138y kernel:  [kobject_register+88/112] kobject_register+0x58/0x70
Apr 19 09:29:05 b551138y kernel:  [register_disk+297/320] register_disk+0x129/0x140
Apr 19 09:29:05 b551138y kernel:  [blk_register_region+138/256] blk_register_region+0x8a/0x100
Apr 19 09:29:05 b551138y kernel:  [add_disk+81/96] add_disk+0x51/0x60
Apr 19 09:29:05 b551138y kernel:  [exact_match+0/16] exact_match+0x0/0x10
Apr 19 09:29:05 b551138y kernel:  [exact_lock+0/32] exact_lock+0x0/0x20
Apr 19 09:29:05 b551138y kernel:  [idedisk_attach+283/416] idedisk_attach+0x11b/0x1a0
Apr 19 09:29:05 b551138y kernel:  [ata_attach+355/1520] ata_attach+0x163/0x5f0
Apr 19 09:29:05 b551138y kernel:  [hwif_init+428/592] hwif_init+0x1ac/0x250
Apr 19 09:29:05 b551138y kernel:  [ideprobe_init+254/285] ideprobe_init+0xfe/0x11d
Apr 19 09:29:05 b551138y kernel:  [ide_probe_module+19/32] ide_probe_module+0x13/0x20
Apr 19 09:29:05 b551138y kernel:  [ide_register_hw+357/400] ide_register_hw+0x165/0x190
Apr 19 09:29:05 b551138y kernel:  [<ea8542e2>] idecs_register+0x62/0x80 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea88c230>] CardServices+0x210/0x360 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea854829>] ide_config+0x529/0x8a0 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea844200>] pci_set_mem_map+0x0/0x40 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea884000>] +0x0/0x80 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea8842a9>] read_cis_mem+0x119/0x190 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [update_process_times+70/80] update_process_times+0x46/0x50
Apr 19 09:29:05 b551138y kernel:  [run_timer_softirq+747/1056] run_timer_softirq+0x2eb/0x420
Apr 19 09:29:05 b551138y kernel:  [timer_interrupt+188/656] timer_interrupt+0xbc/0x290
Apr 19 09:29:05 b551138y kernel:  [<ea84007c>] copy_entries_to_user+0x8c/0x280 [ip_tables]
Apr 19 09:29:05 b551138y kernel:  [<ea884d9e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea8848e5>] pcmcia_get_first_tuple+0xb5/0x160 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [__wake_up_common+58/96] __wake_up_common+0x3a/0x60
Apr 19 09:29:05 b551138y kernel:  [<ea844c00>] yenta_set_mem_map+0x1a0/0x1f0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea884001>] +0x1/0x80 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea844200>] pci_set_mem_map+0x0/0x40 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea884000>] +0x0/0x80 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea8842a9>] read_cis_mem+0x119/0x190 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [update_process_times+70/80] 
Apr 19 09:29:05 b551138y kernel:  [run_timer_softirq+747/1056] run_timer_softirq+0x2eb/0x420
Apr 19 09:29:05 b551138y kernel:  [timer_interrupt+188/656] timer_interrupt+0xbc/0x290
Apr 19 09:29:05 b551138y kernel:  [<ea84007c>] copy_entries_to_user+0x8c/0x280 [ip_tables]
Apr 19 09:29:05 b551138y kernel:  [<ea884d9e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea8848e5>] pcmcia_get_first_tuple+0xb5/0x160 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea8820ff>] radeon_cp_microcode+0x71f/0x800 [radeon]
Apr 19 09:29:05 b551138y kernel:  [<ea8845eb>] read_cis_cache+0x16b/0x1c0 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea884d9e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea88641f>] pcmcia_validate_cis+0xff/0x1e0 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [journal_dirty_metadata+640/880] journal_dirty_metadata+0x280/0x370
Apr 19 09:29:05 b551138y kernel:  [__bread+31/64] __bread+0x1f/0x40
Apr 19 09:29:05 b551138y kernel:  [<ea854d38>] ide_event+0x68/0x100 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea88aa16>] pcmcia_register_client+0x206/0x2a0 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea8555c0>] dev_info+0x0/0x20 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea844c00>] yenta_set_mem_map+0x1a0/0x1f0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [do_get_write_access+1105/2720] do_get_write_access+0x451/0xaa0
Apr 19 09:29:05 b551138y kernel:  [<ea84423d>] pci_set_mem_map+0x3d/0x40 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea84767c>] +0xfc/0x7e0 [yenta_socket]
Apr 19 09:29:05 b551138y kernel:  [<ea8840c2>] set_cis_map+0x42/0x110 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea88c1cb>] CardServices+0x1ab/0x360 [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea854174>] ide_attach+0x144/0x190 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea8555c0>] dev_info+0x0/0x20 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea854cd0>] ide_event+0x0/0x100 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea88d35a>] +0x546/0x5cc [pcmcia_core]
Apr 19 09:29:05 b551138y kernel:  [<ea849640>] bind_request+0x110/0x160 [ds]
Apr 19 09:29:05 b551138y kernel:  [<ea8555c0>] dev_info+0x0/0x20 [ide_cs]
Apr 19 09:29:05 b551138y kernel:  [<ea84a1c0>] ds_ioctl+0x5e0/0x6f0 [ds]
Apr 19 09:29:05 b551138y kernel:  [buffered_rmqueue+188/672] buffered_rmqueue+0xbc/0x2a0
Apr 19 09:29:05 b551138y kernel:  [sock_def_readable+145/160] sock_def_readable+0x91/0xa0
Apr 19 09:29:05 b551138y kernel:  [__alloc_pages+142/736] __alloc_pages+0x8e/0x2e0
Apr 19 09:29:05 b551138y kernel:  [cache_grow+493/1120] cache_grow+0x1ed/0x460
Apr 19 09:29:05 b551138y kernel:  [sock_sendmsg+142/176] sock_sendmsg+0x8e/0xb0
Apr 19 09:29:05 b551138y kernel:  [cache_alloc_refill+509/752] cache_alloc_refill+0x1fd/0x2f0
Apr 19 09:29:05 b551138y kernel:  [copy_files+599/2064] copy_files+0x257/0x810
Apr 19 09:29:05 b551138y kernel:  [zap_pmd_range+78/112] zap_pmd_range+0x4e/0x70
Apr 19 09:29:05 b551138y kernel:  [unmap_page_range+78/144] unmap_page_range+0x4e/0x90
Apr 19 09:29:05 b551138y kernel:  [unmap_vmas+227/896] unmap_vmas+0xe3/0x380
Apr 19 09:29:05 b551138y kernel:  [free_task_struct+56/144] free_task_struct+0x38/0x90
Apr 19 09:29:05 b551138y kernel:  [unmap_vma+73/144] unmap_vma+0x49/0x90
Apr 19 09:29:05 b551138y kernel:  [unmap_vma_list+31/48] unmap_vma_list+0x1f/0x30
Apr 19 09:29:05 b551138y kernel:  [do_munmap+520/752] do_munmap+0x208/0x2f0
Apr 19 09:29:05 b551138y kernel:  [sys_ioctl+514/992] sys_ioctl+0x202/0x3e0
Apr 19 09:29:05 b551138y kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Apr 19 09:29:05 b551138y kernel: 
Apr 19 09:29:05 b551138y kernel: Module ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:428
Apr 19 09:29:05 b551138y kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Apr 19 09:32:33 b551138y kernel:  hde: hde1
Apr 19 09:32:34 b551138y kernel:  hde: hde1

