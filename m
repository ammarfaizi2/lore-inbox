Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272422AbTGZFQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 01:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272423AbTGZFQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 01:16:10 -0400
Received: from [159.226.161.126] ([159.226.161.126]:7861 "EHLO sun.itp.ac.cn")
	by vger.kernel.org with ESMTP id S272422AbTGZFQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 01:16:04 -0400
Date: Sat, 26 Jul 2003 13:25:25 +0800 (CST)
From: Yu Ming <yum@itp.ac.cn>
To: linux-kernel@vger.kernel.org
cc: Yu Ming <yum@sun.itp.ac.cn>
Subject: 2.6.0-test1-ac3 Firewire
Message-ID: <Pine.GSO.4.20.0307261257460.14230-100000@hpc3k>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am running RedHat 9.0 with kernel 2.6.0-test1-ac3, everything works fine
with 1394 firewire connected with SONY DVD RW DRU-500A, except of the
following annoying messages from dmesg.
When I plug or unplug the 1394 fireware, I got from dmesg,
ohci1394_0: SelfID received, but NodeID invalid (probably new bus reset
occurred): 0000FFC0
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[01:1023]: Max speed [S400] - Max payload [2048]
Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
Call Trace:
 [<c011a1ee>] __might_sleep+0x5e/0x70
 [<c02ab17c>] hpsb_get_tlabel+0x5c/0x1c0
 [<c02f209a>] serio_interrupt+0x5a/0x60
 [<c02ab5d2>] hpsb_make_writepacket+0xa2/0x140
 [<c02bafe0>] sbp2util_allocate_write_packet+0x40/0x80
 [<c02bcf56>] sbp2_link_orb_command+0x86/0x190
 [<c02bd103>] sbp2_send_command+0xa3/0xf0
 [<c02972a0>] scsi_done+0x0/0x70
 [<c02bd67c>] sbp2scsi_queuecommand+0xbc/0x1a0
 [<c02972a0>] scsi_done+0x0/0x70
 [<c02970e7>] scsi_dispatch_cmd+0x107/0x170
 [<c02972a0>] scsi_done+0x0/0x70
 [<c0299270>] scsi_times_out+0x0/0x60
 [<c029b8ae>] scsi_request_fn+0x16e/0x2c0
 [<c0263403>] __elv_add_request+0x33/0x50
 [<c02656bc>] blk_insert_request+0x6c/0x90
 [<c029a743>] scsi_insert_special_req+0x33/0x40
 [<c029a941>] scsi_wait_req+0x61/0x90
 [<c029a880>] scsi_wait_done+0x0/0x60
 [<c029c3e5>] scsi_probe_lun+0x85/0x210
 [<c029ca0c>] scsi_probe_and_add_lun+0x7c/0x120
 [<c029cbb5>] scsi_add_device+0x35/0x50
 [<c02bb919>] sbp2_start_device+0x219/0x3e0
 [<c02bb6c3>] sbp2_start_ud+0xa3/0xe0
 [<c02bb392>] sbp2_probe+0x32/0x40
 [<c0260e23>] bus_match+0x43/0x80
 [<c0260eaf>] device_attach+0x4f/0x90
 [<c026107e>] bus_add_device+0x7e/0xd0
 [<c025f5fd>] device_add+0xfd/0x110
 [<c02afbc8>] nodemgr_process_unit_directory+0x188/0x490
 [<c02b00b2>] nodemgr_process_root_directory+0x1e2/0x1f0
 [<c02b039e>] nodemgr_process_config_rom+0x8e/0xc0
 [<c02af653>] nodemgr_create_node+0x153/0x1e0
 [<c02b07f6>] nodemgr_node_probe_one+0xe6/0xf0
 [<c02b0951>] nodemgr_node_probe+0x111/0x120
 [<c02b0c88>] nodemgr_host_thread+0x148/0x190
 [<c02b0b40>] nodemgr_host_thread+0x0/0x190
 [<c01073b9>] kernel_thread_helper+0x5/0xc
 
  Vendor: SONY      Model: DVD RW DRU-500A   Rev: 2.0f
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr1: scsi-1 drive
Attached scsi CD-ROM sr1 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0030e00150006f45]
ieee1394: The root node is not cycle master capable; selecting a new root
node and resetting...
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: sbp2: Reconnected to SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023

When I test the 1394 DVD burner read speed, 
readcd dev=1,0,0 f=/dev/null
I got from dmesg,
Debug: sleeping function called from invalid context at
include/asm/semaphore.h:119
Call Trace:
 [<c011a1ee>] __might_sleep+0x5e/0x70
 [<c02ab17c>] hpsb_get_tlabel+0x5c/0x1c0
 [<c02ab5d2>] hpsb_make_writepacket+0xa2/0x140
 [<c02bafe0>] sbp2util_allocate_write_packet+0x40/0x80
 [<c02bcf56>] sbp2_link_orb_command+0x86/0x190
 [<c02bd103>] sbp2_send_command+0xa3/0xf0
 [<c02972a0>] scsi_done+0x0/0x70
 [<c02bd67c>] sbp2scsi_queuecommand+0xbc/0x1a0
 [<c02972a0>] scsi_done+0x0/0x70
 [<c02970e7>] scsi_dispatch_cmd+0x107/0x170
 [<c02972a0>] scsi_done+0x0/0x70
 [<c0299270>] scsi_times_out+0x0/0x60
 [<c029b8ae>] scsi_request_fn+0x16e/0x2c0
 [<c0263403>] __elv_add_request+0x33/0x50
 [<c02656bc>] blk_insert_request+0x6c/0x90
 [<c029a743>] scsi_insert_special_req+0x33/0x40
 [<c02a4ced>] sg_common_write+0x16d/0x1d0
 [<c02a5f50>] sg_cmd_done+0x0/0x270
 [<c02a4afb>] sg_new_write+0x1eb/0x270
 [<c02a58e1>] sg_ioctl+0xb91/0xd70
[<c023a9a6>] con_write+0x36/0x50
 [<c022b3ac>] opost_block+0x11c/0x1f0
 [<c02c2edb>] vgacon_cursor+0xcb/0x1a0
 [<c0237018>] set_cursor+0x78/0x90
 [<c022d43e>] write_chan+0x16e/0x230
 [<c01190c0>] default_wake_function+0x0/0x30
 [<c0123810>] do_timer+0xe0/0xf0
 [<c01190c0>] default_wake_function+0x0/0x30
 [<c0228175>] tty_write+0x215/0x290
 [<c022d2d0>] write_chan+0x0/0x230
 [<c014d6e8>] vfs_write+0xc8/0x120
 [<c010e6aa>] do_gettimeofday+0x1a/0xa0
 [<c015ded1>] sys_ioctl+0xb1/0x230
 [<c01092bd>] sysenter_past_esp+0x52/0x71
 And the messages go on repeatedly.

I also got from dmesg,
UDP: short packet: From 0.0.0.0:68 288/282 to 255.255.255.255:67
repeatedly.

occasionally(very rarely), I got from dmesg,
spurious 8259A interrupt: IRQ7

Regards,
Ming Yu

