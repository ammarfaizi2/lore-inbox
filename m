Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTEAUd0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTEAUd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:33:26 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:62354 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262382AbTEAUdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:33:20 -0400
Date: Thu, 1 May 2003 16:45:42 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: linux-kernel@vger.kernel.org
Subject: Crash in ide-cs, 2.5.68-bk11, possibly devfs related
Message-ID: <Pine.LNX.4.55.0305011637320.32236@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

IDE CompactFlash cards don't work correctly on 2.5.68-bk11 with devfs
and all debugging enabled.  When the card is inserted in the PCMCIA
socket, following is printed by the kernel:

hde: TOSHIBA THNCF032MAA, CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 5
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 63488 sectors (33 MB) w/2KiB Cache, CHS=496/4/32
 /dev/ide/host2/bus0/target0/lun0: p1
 /dev/ide/host2/bus0/target0/lun0: p1
devfs_mk_dir(ide/host2/bus0/target0/lun0): could not append to dir:
c65fc19c "target0"
devfs_mk_bdev: could not append to parent for
ide/host2/bus0/target0/lun0/part1
Badness in kobject_register at lib/kobject.c:293
Call Trace:
 [<c019c1b8>] kobject_register+0x58/0x70
 [<c01713e9>] register_disk+0x149/0x180
 [<c01c63ba>] blk_register_region+0x8a/0x100
 [<c01c6581>] add_disk+0x51/0x60
 [<c01c6500>] exact_match+0x0/0x10
 [<c01c6510>] exact_lock+0x0/0x20
 [<c01e982f>] idedisk_attach+0x12f/0x1c0
 [<c01e54e6>] ata_attach+0xa6/0x110
 [<c01de94e>] ideprobe_init+0xfe/0x11d
 [<c01f9553>] yenta_set_io_map+0x173/0x1b0
 [<c01e3ad3>] ide_probe_module+0x13/0x20
 [<c01e46b5>] ide_register_hw+0x155/0x180
 [<c8830273>] idecs_register+0x63/0x80 [ide_cs]
 [<c883074a>] ide_config+0x4ba/0x850 [ide_cs]
 [<c88307ab>] ide_config+0x51b/0x850 [ide_cs]
 [<c01f89dd>] pci_set_mem_map+0x3d/0x40
 [<c01ef4f1>] set_cis_map+0x41/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01f04e1>] pcmcia_get_tuple_data+0x91/0xa0
 [<c01f188c>] pcmcia_parse_tuple+0x10c/0x170
 [<c01f8c75>] exca_writew+0x65/0x80
 [<c01f03f4>] pcmcia_get_next_tuple+0x254/0x2b0
 [<c01eff05>] pcmcia_get_first_tuple+0xb5/0x160
 [<c01f97a5>] yenta_set_mem_map+0x215/0x280
 [<c01f89dd>] pci_set_mem_map+0x3d/0x40
 [<c01ef4f1>] set_cis_map+0x41/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01f04e1>] pcmcia_get_tuple_data+0x91/0xa0
 [<c01f188c>] pcmcia_parse_tuple+0x10c/0x170
 [<c01f8c75>] exca_writew+0x65/0x80
 [<c01f03f4>] pcmcia_get_next_tuple+0x254/0x2b0
 [<c01eff05>] pcmcia_get_first_tuple+0xb5/0x160
 [<c01f20ff>] do_mem_probe+0x7f/0x2d0
 [<c019d064>] __delay+0x14/0x20
 [<c01eb3c9>] __ide_dma_begin+0x39/0x50
 [<c01eb588>] __ide_dma_count+0x18/0x20
 [<c01eb380>] __ide_dma_write+0xc0/0xd0
 [<c01ea8d0>] ide_dma_intr+0x0/0xc0
 [<c01eae40>] dma_timer_expiry+0x0/0xe0
 [<c01e75b2>] do_rw_disk+0x412/0x760
 [<c019d064>] __delay+0x14/0x20
 [<c01df7ce>] ide_wait_stat+0xfe/0x130
 [<c01e0883>] SELECT_DRIVE+0x33/0x60
 [<c01dbe61>] start_request+0x101/0x160
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c8830c68>] ide_event+0x68/0x100 [ide_cs]
 [<c01f5576>] pcmcia_register_client+0x206/0x2a0
 [<c88314a0>] dev_info+0x0/0x20 [ide_cs]
 [<c010aed8>] do_IRQ+0xa8/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01f692b>] CardServices+0x1ab/0x360
 [<c883001d>] +0x1d/0x150 [ide_cs]
 [<c8830107>] +0x107/0x150 [ide_cs]
 [<c88314a0>] dev_info+0x0/0x20 [ide_cs]
 [<c8830c00>] ide_event+0x0/0x100 [ide_cs]
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c01f7644>] bind_request+0x104/0x160
 [<c019d4a2>] __copy_from_user_ll+0x72/0x78
 [<c88314a0>] dev_info+0x0/0x20 [ide_cs]
 [<c01f81c0>] ds_ioctl+0x5e0/0x700
 [<c014b9fd>] bio_destructor+0x3d/0x70
 [<c014bc1d>] bio_put+0x2d/0x40
 [<c014b2aa>] end_bio_bh_io_sync+0x3a/0x40
 [<c014c64d>] bio_endio+0x4d/0x80
 [<c01c4502>] __blk_put_request+0xd2/0xf0
 [<c01c520f>] end_that_request_last+0x4f/0x90
 [<c01c2465>] elv_queue_empty+0x25/0x30
 [<c01dbf4e>] ide_do_request+0x5e/0x370
 [<c01ea963>] ide_dma_intr+0x93/0xc0
 [<c01ea8d0>] ide_dma_intr+0x0/0xc0
 [<c010ac7b>] handle_IRQ_event+0x4b/0x120
 [<c010aed8>] do_IRQ+0xa8/0x110
 [<c0138f6e>] zap_pmd_range+0x4e/0x70
 [<c0138fde>] unmap_page_range+0x4e/0x80
 [<c01390fd>] unmap_vmas+0xed/0x250
 [<c013c5ef>] unmap_vma_list+0x1f/0x30
 [<c013c5ef>] unmap_vma_list+0x1f/0x30
 [<c013c978>] do_munmap+0x128/0x160
 [<c0156d9b>] sys_ioctl+0xab/0x220
 [<c01092ff>] syscall_call+0x7/0xb

Running "cardctl eject" causes kernel panic:

# cardctl eject
Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c011717e>] __might_sleep+0x5e/0x70
 [<c01e4a94>] auto_remove_settings+0x24/0x80
 [<c01e61b4>] ide_unregister_subdriver+0x74/0xe0
 [<c01e9475>] idedisk_cleanup+0x25/0x60
 [<c01e44dd>] ide_unregister+0x83d/0x860
 [<c0130192>] mempool_free+0x32/0x70
 [<c014b9fd>] bio_destructor+0x3d/0x70
 [<c014bc1d>] bio_put+0x2d/0x40
 [<c014b2aa>] end_bio_bh_io_sync+0x3a/0x40
 [<c014c64d>] bio_endio+0x4d/0x80
 [<c01c4502>] __blk_put_request+0xd2/0xf0
 [<c01c520f>] end_that_request_last+0x4f/0x90
 [<c0130d52>] buffered_rmqueue+0x92/0x110
 [<c01dbf4e>] ide_do_request+0x5e/0x370
 [<c0130e5d>] __alloc_pages+0x8d/0x320
 [<c0133d54>] cache_init_objs+0x144/0x160
 [<c0134132>] cache_alloc_refill+0x182/0x2a0
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01201f6>] update_process_times+0x46/0x50
 [<c0120066>] update_wall_time+0x16/0x40
 [<c0120460>] do_timer+0xe0/0xf0
 [<c010e9b8>] timer_interrupt+0x28/0xe0
 [<c010af15>] do_IRQ+0xe5/0x110
 [<c010948e>] apic_timer_interrupt+0x1a/0x20
 [<c01bc2c8>] serial_in+0x28/0x70
 [<c019d064>] __delay+0x14/0x20
 [<c01beaf6>] serial8250_console_write+0x176/0x280
 [<c0119400>] __call_console_drivers+0x60/0x70
 [<c01194e5>] call_console_drivers+0x65/0x120
 [<c0119722>] printk+0x112/0x150
 [<c8830d88>] +0x28/0xf4 [ide_cs]
 [<c8830d3d>] +0x4/0x27 [ide_cs]
 [<c019aaff>] sprintf+0x1f/0x30
 [<c88308ae>] ide_config+0x61e/0x850 [ide_cs]
 [<c8830d60>] +0x0/0xf4 [ide_cs]
 [<c01f89dd>] pci_set_mem_map+0x3d/0x40
 [<c01ef4f1>] set_cis_map+0x41/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01f04e1>] pcmcia_get_tuple_data+0x91/0xa0
 [<c01f188c>] pcmcia_parse_tuple+0x10c/0x170
 [<c01f8c75>] exca_writew+0x65/0x80
 [<c01f03f4>] pcmcia_get_next_tuple+0x254/0x2b0
 [<c01eff05>] pcmcia_get_first_tuple+0xb5/0x160
 [<c01f97a5>] yenta_set_mem_map+0x215/0x280
 [<c01f89dd>] pci_set_mem_map+0x3d/0x40
 [<c01ef4f1>] set_cis_map+0x41/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c0130192>] mempool_free+0x32/0x70
 [<c0130192>] mempool_free+0x32/0x70
 [<c014b9fd>] bio_destructor+0x3d/0x70
 [<c014bc1d>] bio_put+0x2d/0x40
 [<c014b2aa>] end_bio_bh_io_sync+0x3a/0x40
 [<c014c64d>] bio_endio+0x4d/0x80
 [<c01c4502>] __blk_put_request+0xd2/0xf0
 [<c01c520f>] end_that_request_last+0x4f/0x90
 [<c01c2465>] elv_queue_empty+0x25/0x30
 [<c01dbf4e>] ide_do_request+0x5e/0x370
 [<c01ea963>] ide_dma_intr+0x93/0xc0
 [<c01ea8d0>] ide_dma_intr+0x0/0xc0
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0148045>] unlock_buffer+0x35/0x60
 [<c0182605>] do_get_write_access+0x2b5/0x5b0
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0148045>] unlock_buffer+0x35/0x60
 [<c0182605>] do_get_write_access+0x2b5/0x5b0
 [<c0182ff5>] journal_dirty_metadata+0x165/0x200
 [<c017a1a7>] ext3_do_update_inode+0x167/0x340
 [<c017a5e7>] ext3_mark_iloc_dirty+0x27/0x40
 [<c017a710>] ext3_mark_inode_dirty+0x50/0x60
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0148045>] unlock_buffer+0x35/0x60
 [<c0182605>] do_get_write_access+0x2b5/0x5b0
 [<c0117495>] autoremove_wake_function+0x25/0x50
 [<c8830b7c>] ide_release+0x9c/0x120 [ide_cs]
 [<c0130192>] mempool_free+0x32/0x70
 [<c88314c0>] dev_list+0x0/0x20 [ide_cs]
 [<c88301fe>] ide_detach+0xae/0xc0 [ide_cs]
 [<c0130192>] mempool_free+0x32/0x70
 [<c88314a7>] dev_info+0x7/0x20 [ide_cs]
 [<c01f7875>] unbind_request+0x95/0xa0
 [<c01f8002>] ds_ioctl+0x422/0x700
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c0201adf>] sock_def_readable+0x5f/0x70
 [<c024b9e6>] unix_dgram_sendmsg+0x316/0x4a0
 [<c01fe85e>] sock_sendmsg+0x8e/0xb0
 [<c01921f9>] devfsd_notify+0x49/0x50
 [<c0192680>] _devfs_unregister+0x50/0x90
 [<c0138f6e>] zap_pmd_range+0x4e/0x70
 [<c0138fde>] unmap_page_range+0x4e/0x80
 [<c01390fd>] unmap_vmas+0xed/0x250
 [<c013c5ef>] unmap_vma_list+0x1f/0x30
 [<c013c5ef>] unmap_vma_list+0x1f/0x30
 [<c013c978>] do_munmap+0x128/0x160
 [<c0156d9b>] sys_ioctl+0xab/0x220
 [<c01092ff>] syscall_call+0x7/0xb

Unable to handle kernel NULL pointer dereference at virtual address
0000001c
 printing eip:
c0192a2a
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0192a2a>]    Not tainted
EFLAGS: 00010082
EIP is at devfs_remove+0x5a/0x80
eax: 00000000   ebx: 00000000   ecx: c65fc19c   edx: 00000000
esi: c032b750   edi: c032b7fc   ebp: c51f137c   esp: c51f1328
ds: 007b   es: 007b   ss: 0068
Process cardmgr (pid: 1097, threadinfo=c51f0000 task=c57960e0)
Stack: 00000000 c51f1338 00000000 c51f1388 2f656469 74736f68 75622f32
742f3073
       65677261 6c2f3074 00306e75 00000005 c032b750 00000001 c51f137c
c01e3c2b
       c5776bd4 00000100 00000008 00000005 c032b750 c51f1c68 c01e44ae
c032b984
Call Trace:
 [<c01e3c2b>] hwif_unregister+0x6b/0xe0
 [<c01e44ae>] ide_unregister+0x80e/0x860
 [<c014b9fd>] bio_destructor+0x3d/0x70
 [<c014bc1d>] bio_put+0x2d/0x40
 [<c014b2aa>] end_bio_bh_io_sync+0x3a/0x40
 [<c014c64d>] bio_endio+0x4d/0x80
 [<c01c4502>] __blk_put_request+0xd2/0xf0
 [<c01c520f>] end_that_request_last+0x4f/0x90
 [<c0130d52>] buffered_rmqueue+0x92/0x110
 [<c01dbf4e>] ide_do_request+0x5e/0x370
 [<c0130e5d>] __alloc_pages+0x8d/0x320
 [<c0133d54>] cache_init_objs+0x144/0x160
 [<c0134132>] cache_alloc_refill+0x182/0x2a0
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01201f6>] update_process_times+0x46/0x50
 [<c0120066>] update_wall_time+0x16/0x40
 [<c0120460>] do_timer+0xe0/0xf0
 [<c010e9b8>] timer_interrupt+0x28/0xe0
 [<c010af15>] do_IRQ+0xe5/0x110
 [<c010948e>] apic_timer_interrupt+0x1a/0x20
 [<c01bc2c8>] serial_in+0x28/0x70
 [<c019d064>] __delay+0x14/0x20
 [<c01beaf6>] serial8250_console_write+0x176/0x280
 [<c0119400>] __call_console_drivers+0x60/0x70
 [<c01194e5>] call_console_drivers+0x65/0x120
 [<c0119722>] printk+0x112/0x150
 [<c8830d88>] +0x28/0xf4 [ide_cs]
 [<c8830d3d>] +0x4/0x27 [ide_cs]
 [<c019aaff>] sprintf+0x1f/0x30
 [<c88308ae>] ide_config+0x61e/0x850 [ide_cs]
 [<c8830d60>] +0x0/0xf4 [ide_cs]
 [<c01f89dd>] pci_set_mem_map+0x3d/0x40
 [<c01ef4f1>] set_cis_map+0x41/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01efb25>] read_cis_cache+0xe5/0x170
 [<c01f04e1>] pcmcia_get_tuple_data+0x91/0xa0
 [<c01f188c>] pcmcia_parse_tuple+0x10c/0x170
 [<c01f8c75>] exca_writew+0x65/0x80
 [<c01f03f4>] pcmcia_get_next_tuple+0x254/0x2b0
 [<c01eff05>] pcmcia_get_first_tuple+0xb5/0x160
 [<c01f97a5>] yenta_set_mem_map+0x215/0x280
 [<c01f89dd>] pci_set_mem_map+0x3d/0x40
 [<c01ef4f1>] set_cis_map+0x41/0x110
 [<c013314b>] check_poison_obj+0x3b/0x1b0
 [<c0130192>] mempool_free+0x32/0x70
 [<c0130192>] mempool_free+0x32/0x70
 [<c014b9fd>] bio_destructor+0x3d/0x70
 [<c014bc1d>] bio_put+0x2d/0x40
 [<c014b2aa>] end_bio_bh_io_sync+0x3a/0x40
 [<c014c64d>] bio_endio+0x4d/0x80
 [<c01c4502>] __blk_put_request+0xd2/0xf0
 [<c01c520f>] end_that_request_last+0x4f/0x90
 [<c01c2465>] elv_queue_empty+0x25/0x30
 [<c01dbf4e>] ide_do_request+0x5e/0x370
 [<c01ea963>] ide_dma_intr+0x93/0xc0
 [<c01ea8d0>] ide_dma_intr+0x0/0xc0
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0148045>] unlock_buffer+0x35/0x60
 [<c0182605>] do_get_write_access+0x2b5/0x5b0
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0148045>] unlock_buffer+0x35/0x60
 [<c0182605>] do_get_write_access+0x2b5/0x5b0
 [<c0182ff5>] journal_dirty_metadata+0x165/0x200
 [<c017a1a7>] ext3_do_update_inode+0x167/0x340
 [<c017a5e7>] ext3_mark_iloc_dirty+0x27/0x40
 [<c017a710>] ext3_mark_inode_dirty+0x50/0x60
 [<c0147ff1>] wake_up_buffer+0x11/0x30
 [<c0148045>] unlock_buffer+0x35/0x60
 [<c0182605>] do_get_write_access+0x2b5/0x5b0
 [<c0117495>] autoremove_wake_function+0x25/0x50
 [<c8830b7c>] ide_release+0x9c/0x120 [ide_cs]
 [<c0130192>] mempool_free+0x32/0x70
 [<c88314c0>] dev_list+0x0/0x20 [ide_cs]
 [<c88301fe>] ide_detach+0xae/0xc0 [ide_cs]
 [<c0130192>] mempool_free+0x32/0x70
 [<c88314a7>] dev_info+0x7/0x20 [ide_cs]
 [<c01f7875>] unbind_request+0x95/0xa0
 [<c01f8002>] ds_ioctl+0x422/0x700
 [<c01347e9>] kmalloc+0x169/0x1c0
 [<c0201adf>] sock_def_readable+0x5f/0x70
 [<c024b9e6>] unix_dgram_sendmsg+0x316/0x4a0
 [<c01fe85e>] sock_sendmsg+0x8e/0xb0
 [<c01921f9>] devfsd_notify+0x49/0x50
 [<c0192680>] _devfs_unregister+0x50/0x90
 [<c0138f6e>] zap_pmd_range+0x4e/0x70
 [<c0138fde>] unmap_page_range+0x4e/0x80
 [<c01390fd>] unmap_vmas+0xed/0x250
 [<c013c5ef>] unmap_vma_list+0x1f/0x30
 [<c013c5ef>] unmap_vma_list+0x1f/0x30
 [<c013c978>] do_munmap+0x128/0x160
 [<c0156d9b>] sys_ioctl+0xab/0x220
 [<c01092ff>] syscall_call+0x7/0xb

Code: 8b 40 1c 89 5c 24 04 89 04 24 e8 f7 fb ff ff 89 1c 24 e8 2f

-- 
Regards,
Pavel Roskin
