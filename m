Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTBAXO6>; Sat, 1 Feb 2003 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265058AbTBAXO6>; Sat, 1 Feb 2003 18:14:58 -0500
Received: from pc2-cmbg2-4-cust80.cmbg.cable.ntl.com ([80.2.247.80]:37112 "EHLO
	flat") by vger.kernel.org with ESMTP id <S265051AbTBAXOy>;
	Sat, 1 Feb 2003 18:14:54 -0500
From: Charles Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PCMCIA] [IDE] [2.5.59-mm7] Badness in  kobject_register call trace
Date: Sat, 1 Feb 2003 23:25:07 +0000
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302012325.07397.cb-lkml@fish.zetnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On inserting a PCMCIA compact flash adapter, I get this backtrace. I presume 
this fits in the "yes, 2.5 IDE isn't finished yet" category. Other 
information available on request.

--------------------------
hde: , CFA DISK drive
ide2 at 0x100-0x107,0x10e on irq 11
hde: lost interrupt
hde: task_no_data_intr: status=0x58 { DriveReady SeekComplete DataRequest }

hde: 253440 sectors (130 MB) w/1KiB Cache, CHS=495/16/32
 hde:hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hde: drive not ready for command
 hde1
 hde: hde1
Badness in kobject_register at lib/kobject.c:152
Call Trace:
 [<c018c994>] kobject_register+0x3c/0x54
 [<c01698bb>] add_partition+0x4f/0x58
 [<c01699ed>] register_disk+0xed/0x11c
 [<c01ab503>] add_disk+0x33/0x40
 [<c01ab4ac>] exact_match+0x0/0x8
 [<c01ab4b4>] exact_lock+0x0/0x1c
 [<c01bb387>] idedisk_attach+0x183/0x194
 [<c01b7aea>] ata_attach+0x7e/0x178
 [<c01b1d66>] ideprobe_init+0xbe/0xf0
 [<c01b66fa>] ide_probe_module+0xe/0x10
 [<c01b7137>] ide_register_hw+0x11f/0x154
 [<c8d64272>] idecs_register+0x56/0x3729bde4 [ide_cs]
 [<c011d0ac>] __release_region+0x24/0x68
 [<c8d6477a>] ide_config+0x4fe/0x3729bd84 [ide_cs]
 [<c8cd22a3>] pci_set_mem_map+0x27/0x3732dd84 [yenta_socket]
 [<c8d4f000>] +0x0/0x372b1000 [pcmcia_core]
 [<c8d4f14b>] read_cis_mem+0x103/0x372b0fb8 [pcmcia_core]
 [<c8d4f6c2>] read_cis_cache+0x132/0x372b0a70 [pcmcia_core]
 [<c8d4fdb5>] pcmcia_get_tuple_data+0x69/0x372b02b4 [pcmcia_core]
 [<c8d50ee7>] pcmcia_parse_tuple+0xcf/0x372af1e8 [pcmcia_core]
 [<c8d50ff1>] read_tuple+0x75/0x372af084 [pcmcia_core]
 [<c0115774>] remap_area_pages+0x1c4/0x1fc
 [<c8cd2d29>] yenta_set_mem_map+0x18d/0x3732d464 [yenta_socket]
 [<c8cd5340>] +0x0/0x3732acc0 [yenta_socket]
 [<c8d4fbd3>] pcmcia_get_next_tuple+0xa3/0x372b04d0 [pcmcia_core]
 [<c8d4f9c9>] pcmcia_get_first_tuple+0x121/0x372b0758 [pcmcia_core]
 [<c8d4f14b>] read_cis_mem+0x103/0x372b0fb8 [pcmcia_core]
 [<c8d50fb2>] read_tuple+0x36/0x372af084 [pcmcia_core]
 [<c8cd2d29>] yenta_set_mem_map+0x18d/0x3732d464 [yenta_socket]
 [<c8cd5340>] +0x0/0x3732acc0 [yenta_socket]
 [<c8cd22a3>] pci_set_mem_map+0x27/0x3732dd84 [yenta_socket]
 [<c8d4f000>] +0x0/0x372b1000 [pcmcia_core]
 [<c8d4f14b>] read_cis_mem+0x103/0x372b0fb8 [pcmcia_core]
 [<c8d4f6c2>] read_cis_cache+0x132/0x372b0a70 [pcmcia_core]
 [<c8d4fdb5>] pcmcia_get_tuple_data+0x69/0x372b02b4 [pcmcia_core]
 [<c8d50ee7>] pcmcia_parse_tuple+0xcf/0x372af1e8 [pcmcia_core]
 [<c8d50ff1>] read_tuple+0x75/0x372af084 [pcmcia_core]
 [<c0115774>] remap_area_pages+0x1c4/0x1fc
 [<c8cd2d29>] yenta_set_mem_map+0x18d/0x3732d464 [yenta_socket]
 [<c8cd5340>] +0x0/0x3732acc0 [yenta_socket]
 [<c8d4fbd3>] pcmcia_get_next_tuple+0xa3/0x372b04d0 [pcmcia_core]
 [<c8d4f9c9>] pcmcia_get_first_tuple+0x121/0x372b0758 [pcmcia_core]
 [<c8d4f14b>] read_cis_mem+0x103/0x372b0fb8 [pcmcia_core]
 [<c8d50fb2>] read_tuple+0x36/0x372af084 [pcmcia_core]
 [<c8d4f6c2>] read_cis_cache+0x132/0x372b0a70 [pcmcia_core]
 [<c8d4fbab>] pcmcia_get_next_tuple+0x7b/0x372b04d0 [pcmcia_core]
 [<c8d4fbd3>] pcmcia_get_next_tuple+0xa3/0x372b04d0 [pcmcia_core]
 [<c8d51132>] pcmcia_validate_cis+0x132/0x372af000 [pcmcia_core]
 [<c01418c3>] wake_up_buffer+0xb/0x28
 [<c01418c3>] wake_up_buffer+0xb/0x28
 [<c0179ce7>] do_get_write_access+0x583/0x5a4
 [<c8d64a31>] ide_event+0x75/0x3729b644 [ide_cs]
 [<c8d54489>] pcmcia_register_client+0x1fd/0x372abd74 [pcmcia_core]
 [<c0171c45>] ext3_mark_iloc_dirty+0x21/0x54
 [<c0171c56>] ext3_mark_iloc_dirty+0x32/0x54
 [<c8cd2d29>] yenta_set_mem_map+0x18d/0x3732d464 [yenta_socket]
 [<c8cd5340>] +0x0/0x3732acc0 [yenta_socket]
 [<c8d5561e>] CardServices+0x1a6/0x372aab88 [pcmcia_core]
 [<c8d4f017>] +0x17/0x372b1000 [pcmcia_core]
 [<c8d64167>] ide_attach+0x13f/0x3729bfd8 [ide_cs]
 [<c8d653a0>] dev_info+0x0/0x3729ac60 [ide_cs]
 [<c8d649bc>] ide_event+0x0/0x3729b644 [ide_cs]
 [<c8d3e5f7>] bind_request+0x15f/0x372c1b68 [ds]
 [<c8d3e639>] bind_request+0x1a1/0x372c1b68 [ds]
 [<c8d3f05d>] ds_ioctl+0x4d5/0x372c1478 [ds]
 [<c01169fd>] __wake_up+0x41/0x60
 [<c01d2964>] sock_def_readable+0x30/0x70
 [<c0214090>] unix_dgram_sendmsg+0x380/0x3f8
 [<c012d4ba>] __alloc_pages+0x7e/0x25c
 [<c01cfc88>] __sock_sendmsg+0xa8/0xd4
 [<c01cfd20>] sock_sendmsg+0x6c/0x88
 [<c012d990>] get_page_state+0xc/0x10
 [<c0133cfd>] zap_pmd_range+0x35/0x50
 [<c0133d52>] unmap_page_range+0x3a/0x5c
 [<c0133e58>] unmap_vmas+0xe4/0x1dc
 [<c0136d49>] unmap_region+0x81/0xc4
 [<c0136c99>] unmap_vma+0x69/0x70
 [<c0136cba>] unmap_vma_list+0x1a/0x28
 [<c0136feb>] do_munmap+0x127/0x134
 [<c014f799>] sys_ioctl+0x20d/0x264
 [<c0108a43>] syscall_call+0x7/0xb


