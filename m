Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275202AbTHMO0p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275211AbTHMO0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:26:45 -0400
Received: from mail.cybertrails.com ([162.42.150.35]:12039 "EHLO
	mail4.cybertrails.com") by vger.kernel.org with ESMTP
	id S275202AbTHMOZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:25:07 -0400
Date: Wed, 13 Aug 2003 07:24:56 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: linux-kernel@vger.kernel.org
Subject: Deep call trace from PCMCIA CF eject
Message-Id: <20030813072456.35d62460.dickson@permanentmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did a scan of my message log for something else, and the call trace
below is what I found instead.  Fortunately I remembered what I was doing
at the time, ejecting and reinserting my CF card in my notebook's PCMCIA
slot.  So I did it again without physically removing the card, and the
call trace below is from that verification.

The CF is accessible after the remounting.

Besides the minor concern about the trace itself, a bigger concern on my
part is how deep the call trace is (60+ levels).  How's it doing for stack
space?

What's ext3 doing on the stack of a vfat card?

	-Paul


I did a "cardctl eject 1" here:

Aug 13 06:57:59 violet cardmgr[1559]: executing: './ide check hde'
Aug 13 06:58:00 violet cardmgr[1559]: executing: './ide stop hde'
Aug 13 06:58:01 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 13 06:58:01 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug 13 06:58:01 violet kernel: hde: Write Cache FAILED Flushing!
Aug 13 06:58:01 violet cardmgr[1559]: + /dev/hde1 umounted
Aug 13 06:58:01 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.
Aug 13 06:58:02 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 13 06:58:02 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug 13 06:58:02 violet kernel: hde: Write Cache FAILED Flushing!
Aug 13 06:58:02 violet kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:66
Aug 13 06:58:02 violet kernel: Call Trace:
Aug 13 06:58:02 violet kernel:  [<c011bc81>] __might_sleep+0x61/0x80
Aug 13 06:58:02 violet kernel:  [<c02376dc>] unlink+0x3c/0xa0
Aug 13 06:58:02 violet kernel:  [<c0267a32>] kobj_unmap+0x62/0x110
Aug 13 06:58:02 violet kernel:  [<c026cf62>] blk_unregister_region+0x22/0x30
Aug 13 06:58:02 violet kernel:  [<c0287eb3>] ide_unregister+0x2f3/0x8d0
Aug 13 06:58:02 violet kernel:  [<c011a83a>] default_wake_function+0x2a/0x30
Aug 13 06:58:02 violet kernel:  [<c011a87a>] __wake_up_common+0x3a/0x60
Aug 13 06:58:02 violet kernel:  [<c011e698>] printk+0x118/0x180
Aug 13 06:58:02 violet kernel:  [<c023991f>] sprintf+0x1f/0x30
Aug 13 06:58:02 violet /sbin/hotplug: no runnable /etc/hotplug/ide.agent is installed
Aug 13 06:58:02 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 06:58:02 violet kernel:  [<d096c8d1>] ide_config+0x641/0x880 [ide_cs]
Aug 13 06:58:02 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 06:58:02 violet kernel:  [<d09810be>] set_cis_map+0x3e/0x120 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981595>] read_cis_cache+0xe5/0x170 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981f6d>] pcmcia_get_tuple_data+0x8d/0xa0 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d098332c>] pcmcia_parse_tuple+0x10c/0x170 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0983404>] read_tuple+0x74/0x80 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981e8e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981979>] pcmcia_get_first_tuple+0xa9/0x150 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0921813>] yenta_set_mem_map+0x1b3/0x200 [yenta_socket]
Aug 13 06:58:02 violet kernel:  [<d09810be>] set_cis_map+0x3e/0x120 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d09810be>] set_cis_map+0x3e/0x120 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981595>] read_cis_cache+0xe5/0x170 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981f6d>] pcmcia_get_tuple_data+0x8d/0xa0 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d098332c>] pcmcia_parse_tuple+0x10c/0x170 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0983404>] read_tuple+0x74/0x80 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<d0981e8e>] pcmcia_get_next_tuple+0x26e/0x2c0 [pcmcia_core]
Aug 13 06:58:02 violet kernel:  [<c0153f81>] wake_up_buffer+0x11/0x30
Aug 13 06:58:02 violet kernel:  [<c019f3b3>] do_get_write_access+0x2e3/0x610
Aug 13 06:58:02 violet kernel:  [<c0153f81>] wake_up_buffer+0x11/0x30
Aug 13 06:58:02 violet kernel:  [<c019f3b3>] do_get_write_access+0x2e3/0x610
Aug 13 06:58:02 violet kernel:  [<c0153f81>] wake_up_buffer+0x11/0x30
Aug 13 06:58:02 violet kernel:  [<c019f3b3>] do_get_write_access+0x2e3/0x610
Aug 13 06:58:02 violet kernel:  [<c0153f81>] wake_up_buffer+0x11/0x30
Aug 13 06:58:02 violet kernel:  [<c019f3b3>] do_get_write_access+0x2e3/0x610
Aug 13 06:58:02 violet kernel:  [<c0192ef8>] ext3_get_inode_loc+0x68/0x260
Aug 13 06:58:02 violet kernel:  [<c01935c7>] ext3_do_update_inode+0x177/0x360
Aug 13 06:58:02 violet kernel:  [<c0193ac7>] ext3_mark_iloc_dirty+0x27/0x40
Aug 13 06:58:02 violet kernel:  [<c0193c00>] ext3_mark_inode_dirty+0x50/0x60
Aug 13 06:58:02 violet kernel:  [<c0153f81>] wake_up_buffer+0x11/0x30
Aug 13 06:58:02 violet kernel:  [<c019f3b3>] do_get_write_access+0x2e3/0x610
Aug 13 06:58:02 violet kernel:  [<c0192ef8>] ext3_get_inode_loc+0x68/0x260
Aug 13 06:58:02 violet kernel:  [<c01935c7>] ext3_do_update_inode+0x177/0x360
Aug 13 06:58:02 violet kernel:  [<d096cba4>] ide_release+0x94/0x130 [ide_cs]
Aug 13 06:58:02 violet kernel:  [<d096c1fc>] ide_detach+0xac/0xc0 [ide_cs]
Aug 13 06:58:02 violet kernel:  [<d09727e2>] unbind_request+0xd2/0xe0 [ds]
Aug 13 06:58:02 violet kernel:  [<d0972fa1>] ds_ioctl+0x441/0x770 [ds]
Aug 13 06:58:02 violet kernel:  [<c02cec0a>] memcpy_fromiovec+0xba/0xc0
Aug 13 06:58:02 violet kernel:  [<c0327d5f>] unix_dgram_sendmsg+0x35f/0x560
Aug 13 06:58:02 violet kernel:  [<c013b28d>] __alloc_pages+0x8d/0x340
Aug 13 06:58:02 violet kernel:  [<c02c937e>] sock_sendmsg+0x8e/0xb0
Aug 13 06:58:02 violet kernel:  [<c0144cd8>] do_anonymous_page+0x118/0x200
Aug 13 06:58:02 violet kernel:  [<c011a5bb>] schedule+0x1bb/0x3c0
Aug 13 06:58:02 violet kernel:  [<c0182f9d>] proc_destroy_inode+0x1d/0x30
Aug 13 06:58:02 violet kernel:  [<c0143723>] zap_pte_range+0x143/0x1a0
Aug 13 06:58:02 violet kernel:  [<c01437ce>] zap_pmd_range+0x4e/0x70
Aug 13 06:58:02 violet kernel:  [<c014383e>] unmap_page_range+0x4e/0x80
Aug 13 06:58:02 violet kernel:  [<c014394d>] unmap_vmas+0xdd/0x240
Aug 13 06:58:02 violet kernel:  [<c01470a3>] unmap_vma+0x43/0x80
Aug 13 06:58:02 violet kernel:  [<c01470ff>] unmap_vma_list+0x1f/0x30
Aug 13 06:58:02 violet kernel:  [<c0147473>] do_munmap+0x153/0x190
Aug 13 06:58:02 violet kernel:  [<c01652b0>] sys_ioctl+0x100/0x290
Aug 13 06:58:02 violet kernel:  [<c010b1f9>] sysenter_past_esp+0x52/0x71
Aug 13 06:58:02 violet kernel: 


I did a "cardctl insert 1" here:

Aug 13 06:59:12 violet cardmgr[1559]: socket 1: ATA/IDE Fixed Disk
Aug 13 06:59:16 violet kernel: hde: LEXAR ATA_FLASH, CFA DISK drive
Aug 13 06:59:16 violet kernel: hdf: probing with STATUS(0xc0) instead of ALTSTATUS(0x0a)
Aug 13 06:59:16 violet kernel: hdf: probing with STATUS(0x00) instead of ALTSTATUS(0x0a)
Aug 13 06:59:16 violet kernel: ide2 at 0x100-0x107,0x10e on irq 3
Aug 13 06:59:16 violet kernel: hde: max request size: 128KiB
Aug 13 06:59:16 violet kernel: hde: 62976 sectors (32 MB) w/1KiB Cache, CHS=984/2/32
Aug 13 06:59:16 violet kernel:  hde: hde1
Aug 13 06:59:16 violet /sbin/hotplug: no runnable /etc/hotplug/ide.agent is installed
Aug 13 06:59:16 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 06:59:16 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 06:59:16 violet kernel: hde: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
Aug 13 06:59:16 violet kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError }
Aug 13 06:59:16 violet kernel: hde: Write Cache FAILED Flushing!
Aug 13 06:59:16 violet kernel: ide-cs: hde: Vcc = 3.3, Vpp = 0.0
Aug 13 06:59:16 violet cardmgr[1559]: executing: './ide start hde'
Aug 13 06:59:16 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 06:59:16 violet /sbin/hotplug: no runnable /etc/hotplug/block.agent is installed
Aug 13 06:59:16 violet kernel:  hde: hde1
Aug 13 06:59:16 violet cardmgr[1559]: + /dev/hde1 on /mnt/card type vfat (rw,gid=500,uid=500)
Aug 13 06:59:16 violet kernel: updfstab: numerical sysctl 1 23 is obsolete.


	-Paul

