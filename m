Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270691AbTG0Hrm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 03:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbTG0Hrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 03:47:42 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:18145 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP id S270691AbTG0Hrk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 03:47:40 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: linux-kernel@vger.kernel.org
Subject: [bug] ieee1394/sbp2 - sleeping in invalid context
Date: Sat, 26 Jul 2003 22:24:05 +1000
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307262224.13705.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is with 2.6.0-test1-ac3, on a Sony PCG-R505TFP.
This has an i830 chipset, and
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22 1394a-2000 Controller

Compiler:  gcc version 3.2 (Mandrake Linux 9.0 3.2-1mdk)
Version_in_Makefile: 2.6.0-test1-ac3

CONFIG_IEEE1394=y
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
CONFIG_IEEE1394_OHCI1394=y
# CONFIG_IEEE1394_VIDEO1394 is not set
CONFIG_IEEE1394_SBP2=y
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
# CONFIG_IEEE1394_DV1394 is not set
# CONFIG_IEEE1394_RAWIO is not set
# CONFIG_IEEE1394_CMP is not set

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
Call Trace:
 [<c011c61e>] __might_sleep+0x5e/0x62
 [<c031bfad>] hpsb_get_tlabel+0x5d/0x230
 [<c0319d97>] alloc_hpsb_packet+0xa7/0xd0
 [<c031c4e2>] hpsb_make_writepacket+0xa2/0x140
 [<c01283e6>] update_wall_time+0x16/0x40
 [<c032a270>] sbp2util_allocate_write_packet+0x40/0x80
 [<c032c5c6>] sbp2_link_orb_command+0x86/0x190
 [<c032c773>] sbp2_send_command+0xa3/0xf0
 [<c032cd70>] sbp2scsi_queuecommand+0xb0/0x210
 [<c02ff550>] scsi_done+0x0/0x80
 [<c0301b30>] scsi_times_out+0x0/0x60
 [<c02ff33b>] scsi_dispatch_cmd+0x18b/0x250
 [<c02ff550>] scsi_done+0x0/0x80
 [<c0301b30>] scsi_times_out+0x0/0x60
 [<c03037fd>] scsi_init_cmd_errh+0x9d/0xd0
 [<c0304ad1>] scsi_request_fn+0x201/0x460
 [<c02b5133>] __elv_add_request+0x33/0x50
 [<c02b78d4>] blk_insert_request+0x84/0x100
 [<c0303599>] scsi_do_req+0x49/0xa0
 [<c03034a3>] scsi_insert_special_req+0x33/0x40
 [<c0303731>] scsi_wait_req+0x71/0xa0
 [<c03035f0>] scsi_wait_done+0x0/0xd0
 [<c0300322>] ioctl_internal_command+0x52/0x190
 [<c03004c6>] scsi_set_medium_removal+0x66/0x90
 [<c0147001>] invalidate_inode_pages+0x21/0x30
 [<c032e11b>] cdrom_release+0x6b/0x130
 [<c0312a80>] sr_block_release+0x0/0x20
 [<c0166029>] blkdev_put+0x1f9/0x240
 [<c01662ba>] close_bdev_excl+0x1a/0x30
 [<c016443c>] kill_block_super+0x3c/0x50
 [<c0162ebd>] deactivate_super+0x8d/0x140
 [<c017cd65>] __mntput+0x25/0x40
 [<c017d74c>] sys_umount+0x3c/0xa0
 [<c017d7c9>] sys_oldumount+0x19/0x20
 [<c01099d3>] syscall_call+0x7/0xb
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/InLsW6pHgIdAuOMRAn+BAJ0bUhhON0riFKcCrcMjrOPFi8MeeQCcCEaN
RWU40vdfHOdjM1BAdspRvj8=
=cW5Q
-----END PGP SIGNATURE-----
