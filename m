Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274959AbTHFX0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274978AbTHFX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:26:46 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:34555 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S274959AbTHFX0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:26:34 -0400
Date: Wed, 06 Aug 2003 16:29:34 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: juampe@iquis.com
Subject: [Bug 1052] New: ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:482 
Message-ID: <743990000.1060212574@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



http://bugme.osdl.org/show_bug.cgi?id=1052

           Summary: ide_cs cannot be unloaded due to unsafe usage in
                    include/linux/module.h:482
    Kernel Version: 2.4.6-test2
            Status: NEW
          Severity: blocking
             Owner: rmk@arm.linux.org.uk
         Submitter: juampe@iquis.com


Distribution: Debian unstable

Hardware Environment: Dell Inspiron 4100, Yenta socket
Software Environment:Debian unstable

Problem Description:
hde: SanDisk SDCFB-16, CFA DISK drive
ide2 at 0x140-0x147,0x14e on irq 3
hde: max request size: 128KiB
hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hde: task_no_data_intr: error=0x04 { DriveStatusError }
hde: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
 /dev/ide/host2/bus0/target0/lun0: p1
 /dev/ide/host2/bus0/target0/lun0: p1
devfs_mk_bdev: could not append to parent for ide/host2/bus0/target0/lun0/part1
kobject_register failed for hde1 (-17)
Call Trace:
 [<c01f0e99>] kobject_register+0x59/0x60
 [<c01843e9>] register_disk+0x149/0x180
 [<c0283cc1>] add_disk+0x51/0x60
 [<c0283c40>] exact_match+0x0/0x10
 [<c0283c50>] exact_lock+0x0/0x20
 [<c02ae6ba>] idedisk_attach+0x11a/0x1b0
 [<c02aaa01>] ata_attach+0x41/0xd0
 [<c02a3dfe>] ideprobe_init+0x10e/0x12d
 [<c02a8e73>] ide_probe_module+0x13/0x20
 [<c02a9c80>] ide_register_hw+0x150/0x190
 [<e0976265>] idecs_register+0x55/0x70 [ide_cs]
 [<c02d4700>] CardServices+0x210/0x357
 [<e097679e>] ide_config+0x51e/0x850 [ide_cs]
 [<c02cc77e>] set_cis_map+0x3e/0x120
 [<c02cc979>] read_cis_mem+0x119/0x190
 [<c02cd659>] pcmcia_get_tuple_data+0x89/0x90
 [<c02ce978>] pcmcia_parse_tuple+0x108/0x180
 [<c02cea64>] read_tuple+0x74/0x80
 [<c02d6ab6>] yenta_set_mem_map+0x196/0x1e0
 [<c02cd570>] pcmcia_get_next_tuple+0x270/0x2d0
 [<c02cd03c>] pcmcia_get_first_tuple+0xac/0x160
 [<c02d6ab6>] yenta_set_mem_map+0x196/0x1e0
 [<c02cc77e>] set_cis_map+0x3e/0x120
 [<c02cc979>] read_cis_mem+0x119/0x190
 [<c02cd659>] pcmcia_get_tuple_data+0x89/0x90
 [<c02ce978>] pcmcia_parse_tuple+0x108/0x180
 [<c02cea64>] read_tuple+0x74/0x80
 [<c02d6ab6>] yenta_set_mem_map+0x196/0x1e0
 [<c02cd570>] pcmcia_get_next_tuple+0x270/0x2d0
 [<c02cd03c>] pcmcia_get_first_tuple+0xac/0x160
 [<c02ccc48>] read_cis_cache+0xf8/0x190
 [<c02cd570>] pcmcia_get_next_tuple+0x270/0x2d0
 [<c02ceb6f>] pcmcia_validate_cis+0xff/0x1e0
 [<c01aaedc>] _reiserfs_free_block+0x13c/0x150
 [<c01aee27>] free_thrown+0x37/0x70
 [<e0976c5b>] ide_event+0x6b/0x110 [ide_cs]
 [<c02d3211>] pcmcia_register_client+0x221/0x260
 [<c0157799>] bh_lru_install+0xa9/0xe0
 [<c02d469b>] CardServices+0x1ab/0x357
 [<e097610a>] ide_attach+0x10a/0x150 [ide_cs]
 [<e0976bf0>] ide_event+0x0/0x110 [ide_cs]
 [<c02d2528>] pcmcia_bind_device+0x68/0xb0
 [<c02d62e6>] get_pcmcia_driver+0x36/0x50
 [<c02d52ea>] bind_request+0xda/0x1c0
 [<c01f3a00>] __copy_to_user_ll+0x10/0x70
 [<c02d5f1f>] ds_ioctl+0x60f/0x770
 [<c033957f>] sock_def_readable+0x5f/0x70
 [<c038d512>] unix_dgram_sendmsg+0x3c2/0x4a0
 [<c033627e>] sock_sendmsg+0x8e/0xb0
 [<c011c9a0>] do_page_fault+0x140/0x4ad
 [<c016cb01>] wake_up_inode+0x11/0x30
 [<c013f2c1>] buffered_rmqueue+0xb1/0x140
 [<c01214a6>] __mmdrop+0x36/0x47
 [<c0146bfe>] zap_pmd_range+0x4e/0x70
 [<c0146c6e>] unmap_page_range+0x4e/0x90
 [<c0146db3>] unmap_vmas+0x103/0x230
 [<c014a228>] unmap_vma+0x48/0x90
 [<c014a28f>] unmap_vma_list+0x1f/0x30
 [<c014a60e>] do_munmap+0x11e/0x170
 [<c0165881>] sys_ioctl+0xb1/0x230
 [<c010b10f>] syscall_call+0x7/0xb
                                                                              
2Module ide_cs cannot be unloaded due to unsafe usage in include/linux/module.h:
ide-cs: hde: Vcc = 3.3, Vpp = 0.0

Steps to reproduce:

Insert an SAN Disk ide_cs card


