Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTFVSOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 14:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264922AbTFVSOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 14:14:38 -0400
Received: from mail.consultit.no ([213.239.74.125]:23220 "EHLO
	kosat.consultit.no") by vger.kernel.org with ESMTP id S264932AbTFVSOf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 14:14:35 -0400
Date: Sun, 22 Jun 2003 20:28:38 +0200
From: Eivind Tagseth <eivindt@multinet.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
Message-ID: <20030622182838.GA6970@tagseth-trd.consultit.no>
References: <20030620081846.GB2451@tagseth-trd.consultit.no> <20030620211640.B913@flint.arm.linux.org.uk> <20030622114642.GB1785@tagseth-trd.consultit.no> <20030622141541.B16537@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030622141541.B16537@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Russell King <rmk@arm.linux.org.uk> [030622 15:18]:
> There appears to be something of an inconsistency in the naming (again)
> for ide-cs.  This should fix it.

Much better.  At least I think so:

Jun 22 20:22:16 [cardmgr] initializing socket 1
Jun 22 20:22:16 [cardmgr] socket 1: ATA/IDE Fixed Disk
Jun 22 20:22:16 [cardmgr] product info: "SanDisk", "SDP", "5/3 0.6"
Jun 22 20:22:16 [cardmgr] manfid: 0x0045, 0x0401  function: 4 (fixed disk)
Jun 22 20:22:16 [cardmgr] executing: 'modprobe ide-cs'
Jun 22 20:22:19 [kernel] hdc: SanDisk SDCFB-32, CFA DISK drive
Jun 22 20:22:19 [kernel] hdc: max request size: 128KiB
Jun 22 20:22:19 [kernel]  /dev/ide/host1/bus0/target0/lun0: p1
Jun 22 20:22:19 [kernel] devfs_mk_bdev: could not append to parent for ide/host1/bus0/target0/lun0/part1
Jun 22 20:22:19 [kernel] kobject_register failed for hdc1 (-17)
Jun 22 20:22:19 [kernel] Call Trace:
Jun 22 20:22:19 [kernel]  [<c0212640>] kobject_register+0x50/0x60
Jun 22 20:22:19 [kernel]  [<c0186377>] register_disk+0x147/0x180
Jun 22 20:22:19 [kernel]  [<c0245d40>] add_disk+0x50/0x60
Jun 22 20:22:19 [kernel]  [<c0245cc0>] exact_match+0x0/0x10
Jun 22 20:22:19 [kernel]  [<c0245cd0>] exact_lock+0x0/0x20
Jun 22 20:22:19 [kernel]  [<c02643f9>] idedisk_attach+0x129/0x1b0
Jun 22 20:22:19 [kernel]  [<c026032f>] ata_attach+0x9f/0x1c0
Jun 22 20:22:19 [kernel]  [<c02597c3>] ideprobe_init+0xe3/0xff
Jun 22 20:22:19 [kernel]  [<c025e833>] ide_probe_module+0x13/0x20
Jun 22 20:22:19 [kernel]  [<c025f47f>] ide_register_hw+0x15f/0x190
Jun 22 20:22:19 [kernel]  [<d0a98276>] idecs_register+0x66/0x80 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d32c8225>] CardServices+0x215/0x362 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d0a987c8>] ide_config+0x538/0x8a0 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d32c00c4>] set_cis_map+0x44/0x120 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c02cc>] read_cis_mem+0x12c/0x1a0 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0596>] read_cis_cache+0xe6/0x170 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0f1b>] pcmcia_get_tuple_data+0x9b/0xa0 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c225f>] pcmcia_parse_tuple+0x10f/0x180 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c2373>] read_tuple+0xa3/0xb0 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d0a887c3>] yenta_set_mem_map+0x1c3/0x220 [yenta]
Jun 22 20:22:19 [kernel]  [<d32c0e30>] pcmcia_get_next_tuple+0x240/0x290 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0955>] pcmcia_get_first_tuple+0xb5/0x160 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d0a887c3>] yenta_set_mem_map+0x1c3/0x220 [yenta]
Jun 22 20:22:19 [kernel]  [<d0a887c3>] yenta_set_mem_map+0x1c3/0x220 [yenta]
Jun 22 20:22:19 [kernel]  [<d32c00c4>] set_cis_map+0x44/0x120 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c02cc>] read_cis_mem+0x12c/0x1a0 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0596>] read_cis_cache+0xe6/0x170 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0f1b>] pcmcia_get_tuple_data+0x9b/0xa0 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c225f>] pcmcia_parse_tuple+0x10f/0x180 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c2373>] read_tuple+0xa3/0xb0 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d0a887c3>] yenta_set_mem_map+0x1c3/0x220 [yenta]
Jun 22 20:22:19 [kernel]  [<d32c0e30>] pcmcia_get_next_tuple+0x240/0x290 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0955>] pcmcia_get_first_tuple+0xb5/0x160 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0596>] read_cis_cache+0xe6/0x170 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d32c0e30>] pcmcia_get_next_tuple+0x240/0x290 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<c020271a>] set_bit_in_list_bitmap+0x5a/0x70
Jun 22 20:22:19 [kernel]  [<c01f0fd1>] check_left+0x141/0x170
Jun 22 20:22:19 [kernel]  [<c01fcff3>] pathrelse_and_restore+0x43/0x50
Jun 22 20:22:19 [kernel]  [<d0a98cc7>] ide_event+0x67/0x100 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d32c6c83>] pcmcia_register_client+0x213/0x280 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d0a887c3>] yenta_set_mem_map+0x1c3/0x220 [yenta]
Jun 22 20:22:19 [kernel]  [<d32c81be>] CardServices+0x1ae/0x362 [pcmcia_core]
Jun 22 20:22:19 [kernel]  [<d0a9810e>] +0x10e/0x150 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d0a99ac0>] dev_info+0x0/0x20 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d0a98c60>] ide_event+0x0/0x100 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d0a98db5>] +0x1c/0x27 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d0a9447f>] get_pcmcia_driver+0x3f/0x50 [ds]
Jun 22 20:22:19 [kernel]  [<d0a99b00>] ide_cs_driver+0x0/0x80 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d0a93536>] bind_request+0x186/0x220 [ds]
Jun 22 20:22:19 [kernel]  [<d0a98db5>] +0x1c/0x27 [ide_cs]
Jun 22 20:22:19 [kernel]  [<d0a9410a>] ds_ioctl+0x5ca/0x6c0 [ds]
Jun 22 20:22:19 [kernel]  [<c028a260>] sock_def_readable+0x80/0x90
Jun 22 20:22:19 [kernel]  [<c02ddbb7>] unix_dgram_sendmsg+0x377/0x570
Jun 22 20:22:19 [kernel]  [<c0286a9e>] sock_sendmsg+0x9e/0xd0
Jun 22 20:22:19 [kernel]  [<c016e84f>] wake_up_inode+0xf/0x30
Jun 22 20:22:19 [kernel]  [<c017fc41>] proc_get_inode+0x161/0x190
Jun 22 20:22:19 [kernel]  [<c013bb2e>] buffered_rmqueue+0xce/0x1a0
Jun 22 20:22:19 [kernel]  [<c014419b>] zap_pmd_range+0x4b/0x70
Jun 22 20:22:19 [kernel]  [<c014420b>] unmap_page_range+0x4b/0x90
Jun 22 20:22:19 [kernel]  [<c014431f>] unmap_vmas+0xcf/0x240
Jun 22 20:22:19 [kernel]  [<c0148145>] unmap_region+0x95/0xe0
Jun 22 20:22:19 [kernel]  [<c0148042>] unmap_vma+0x42/0x80
Jun 22 20:22:19 [kernel]  [<c014809f>] unmap_vma_list+0x1f/0x30
Jun 22 20:22:19 [kernel]  [<c014848d>] do_munmap+0x15d/0x1c0
Jun 22 20:22:19 [kernel]  [<c0166620>] sys_ioctl+0x100/0x290
Jun 22 20:22:19 [kernel]  [<c01092db>] syscall_call+0x7/0xb
Jun 22 20:22:19 [kernel] 
Jun 22 20:22:19 [cardmgr] executing: './ide start hdc'
Jun 22 20:22:19 [kernel] Module ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:479
Jun 22 20:22:19 [kernel] Unable to handle kernel NULL pointer dereference at virtual address 0000004f
Jun 22 20:22:19 [cardmgr] start cmd exited with status 139


lsmod:

Module                  Size  Used by
ide_cs                  7552  2 [unsafe]
ds                     15200  5 ide_cs
yenta                  13216  2 
pcmcia_core            72224  3 ide_cs,ds,yenta
r128                   95224  2 
agpgart                31752  0 
usbcore               110612  1 
psmouse                 8324  0 
mousedev                9044  1 

ls on /dev/discs/disc1 hangs and is unkillable, and attempting to mount it
hangs forever as well.




Eivind
