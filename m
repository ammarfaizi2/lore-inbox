Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbUKJDH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbUKJDH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 22:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUKJDH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 22:07:57 -0500
Received: from althea.taco.com ([66.93.168.233]:15744 "EHLO althea.taco.com")
	by vger.kernel.org with ESMTP id S261842AbUKJDHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 22:07:39 -0500
From: Dan Weigert <dlw@althea.taco.com>
Message-Id: <200411100307.iAA37VfD011957@althea.taco.com>
Subject: Kernel BUG from Compaq cpqfc driver
To: linux-kernel@vger.kernel.org
Date: Tue, 9 Nov 2004 22:07:31 -0500 (EST)
Cc: dlw@taco.com
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In trying to ressurect an old Compaq FC array, I tried to use the cpqfc driver.
I managed to compile the driver without trouble, but when modprobing it, I get
the following:


______________________________________________________________________

cpqfc: unsupported module, tainting kernel.
cpqfcTS: New FC port FFFFFCh WWN: 20FC006069401EE9
cpqfcTS: New FC port 011100h WWN: 100000E002004F93 SCSI Chan/Trgt 0/0
cpqfcTS: New FC port 011200h WWN: 10000000C92A7C5F SCSI Chan/Trgt 0/1
------------[ cut here ]------------
kernel BUG at drivers/scsi/scsi_scan.c:1334!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<fa841ab0>]    Tainted: G  U
EFLAGS: 00010213   (2.6.5-7.97-default)
EIP is at scsi_free_host_dev+0x50/0x60 [scsi_mod]
eax: ffffffff   ebx: f67df800   ecx: c1a05210   edx: f6d34000
esi: cd765c00   edi: f67df800   ebp: c1a05200   esp: ce929c90
ds: 007b   es: 007b   ss: 0068
Process cpqfcTS_wt_2 (pid: 32468, threadinfo=ce928000 task=f67a81b0)
Stack: ce929cc0 fa9b7525 f67df800 c1a05200 c8e80d10 c8380000 c8e80b88 c8e80000
       00000011 c8380000 f6d341d0 40000000 00000000 00000209 00000065 00000000
       00000000 cd765c00 c011b9fa 00000000 00000000 00000086 ce929d10 00000086
Call Trace:
 [<fa9b7525>] cpqfcTS_WorkTask+0x5b5/0x1320 [cpqfc]
 [<c011b9fa>] recalc_task_prio+0x1da/0x470
 [<c011b311>] __wake_up_common+0x31/0x60
 [<c011b34e>] __wake_up+0xe/0x20
 [<c011b34e>] __wake_up+0xe/0x20
 [<c0205800>] n_tty_receive_buf+0xa0/0xf60
 [<c0148a8b>] handle_mm_fault+0x10b/0x930
 [<c02082b4>] pty_write+0x164/0x1c0
 [<c012667f>] do_timer+0x2f/0x4b0
 [<c011ca76>] schedule+0x1f6/0x6d0
 [<c011b36f>] __wake_up_locked+0xf/0x20
 [<c011c2c0>] default_wake_function+0x0/0x10
 [<fa9b839f>] cpqfcTSWorkerThread+0x10f/0x159 [cpqfc]
 [<fa9b8290>] cpqfcTSWorkerThread+0x0/0x159 [cpqfc]
 [<c0106005>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 36 05 9e 7a 84 fa eb b6 8d b6 00 00 00 00 55 57 56 53
 <6>scsi2 : Compaq FibreChannel HBA Tachyon Chip/Board Ver??: WWN 500508B2005001C1
 on PCI bus 0 device 0xa0fc irq 5 IObaseL 0xb000, MEMBASE 0xf7e00000
PCI bus width 32 bits, bus speed 33 MHz
FCP-SCSI Driver v2.5.4
GBIC detected: Short-wave.  LPSM 0h Monitor
 @Linux _abort Scsi_Cmnd c1a05200  x_ID 0h, type 3000h
scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 0 lun 0
 @Linux _abort Scsi_Cmnd c1a05200  x_ID 0h, type 3000h
scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 1 lun 0
------------[ cut here ]------------
kernel BUG at drivers/scsi/scsi_scan.c:1334!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<fa841ab0>]    Tainted: G  U
EFLAGS: 00010217   (2.6.5-7.97-default)
EIP is at scsi_free_host_dev+0x50/0x60 [scsi_mod]
eax: ffffffff   ebx: f6837400   ecx: c1a05b10   edx: f6d34000
esi: cfbe5ed8   edi: 00000003   ebp: 00000003   esp: cfbe5e5c
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 32492, threadinfo=cfbe4000 task=f66b9930)
Stack: 00000000 fa9b0ed2 f6d341d4 00000001 f6837400 c1a05b00 f6d34000 4942470a
       65642043 74636574 203a6465 726f6853 61772d74 202e6576 53504c20 6830204d
       6e6f4d20 726f7469 f7ff4200 cfbe5ec8 00000000 cfbe5ec8 f6b029c0 00000000
Call Trace:
 [<fa9b0ed2>] cpqfcTS_proc_info+0x1e2/0x210 [cpqfc]
 [<fa843f7b>] proc_scsi_read+0x1b/0x40 [scsi_mod]
 [<fa843f60>] proc_scsi_read+0x0/0x40 [scsi_mod]
 [<c01864b1>] proc_file_read+0x161/0x270
 [<c0186350>] proc_file_read+0x0/0x270
 [<c0158e3f>] vfs_read+0x9f/0x100
 [<c0159071>] sys_read+0x81/0xd0
 [<c0107dc9>] sysenter_past_esp+0x52/0x79

Code: 0f 0b 36 05 9e 7a 84 fa eb b6 8d b6 00 00 00 00 55 57 56 53
______________________________________________________________

As you can see, the card actually makes it out to the SAN to find devices...

The kernel, in this case is from SLES9, and has the following uname..

Linux sles-test 2.6.5-7.97-default #1 Fri Jul 2 14:21:59 UTC 2004 i686 athlon i386 GNU/Linux

cpqfc is compiled as a module.


Thank you for your help,

Dan Weigert

