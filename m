Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268336AbRGWTw4>; Mon, 23 Jul 2001 15:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268333AbRGWTws>; Mon, 23 Jul 2001 15:52:48 -0400
Received: from moline.gci.com ([205.140.80.106]:56849 "EHLO moline.gci.com")
	by vger.kernel.org with ESMTP id <S268336AbRGWTwc>;
	Mon, 23 Jul 2001 15:52:32 -0400
Message-ID: <BF9651D8732ED311A61D00105A9CA315053E11C3@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: linux-kernel@vger.kernel.org
Subject: PAS16/ NCR5380 bug in 2.4.7
Date: Mon, 23 Jul 2001 11:52:29 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

When accessing the cdrom, the system hangs completely.

SAK still works and allows me to reboot, but sync and umount do not
appear to work during this hang.  No other user programs appear
to be functioning, however network activity (this machine is a
firewall/router) passes through and is NAT translated correctly.

It looks as if this driver is no longer actively maintained by
John Weidman as there is no contact information for him in the
header, or in the MAINTAINERS file.


Kernel is 2.4.7, i686-300 128Mb ram
**********************

[root@gw /root]# modprobe pas16
scsi0 : at 0x0388 irq 12 options CAN_QUEUE=32  CMD_PER_LUN=2 release=3
generic options AUTOPROBE_IRQ AUTOSENSE PSEUDO DMA UNSAFE  generic release=7
  Vendor: NEC       Model: CD-ROM DRIVE:501  Rev: 2.2
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
sr0: scsi-1 drive
[root@gw /root]#
[root@gw /root]# eject cdrom
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 4, lun
0 Start/Stop Unit 00 00 00 02 00
scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Start/Stop Unit 00 00 00 02 00
NCR5380 : coroutine isn't running.
STATUS_REG: 07 ,PARITY,IO,SEL
BASR: 10
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine isn't running.
scsi0: no currently connected command
scsi0: issue_queue
scsi0: disconnected_queue
scsi0 : destination target 4, lun 0
        command = 27 (0x1b)00 00 00 02 00

scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Start/Stop Unit 00 00 00 02 00
NCR5380 : coroutine isn't running.
STATUS_REG: 07 ,PARITY,IO,SEL
BASR: 10
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine isn't running.
scsi0: no currently connected command
scsi0: issue_queue
scsi0: disconnected_queue
scsi0 : destination target 4, lun 0
        command = 27 (0x1b)00 00 00 02 00


scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 4, lun
0 Prevent/Allow Medium Removal 00 00 00 00 00
scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: disconnected_queue

scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: disconnected_queue

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 4, lun
0 Prevent/Allow Medium Removal 00 00 00 00 00
scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0: disconnected_queue

scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0: disconnected_queue

***********
The cdrom would eject itself, but the driver never returned control
to the 'eject' application, and hung in the above state.
At this point, i shut down, double-checked termination, and forced
it by adding a hard active terminator on the scsi bus after the
cdrom (only device on the bus) instead of relying on the CDROM's
built-in terminators
***********

[root@gw /root]# modprobe pas16
scsi0 : at 0x0388e irq 12 options CAN_QUEUE=32  CMD_PER_LUN=2 release=3
generic options AUTOPROBE_IRQ AUTOSENSE PSEUDO DMA UNSAFE generic release=7
  Vendor: NEC       Model: CD-ROM DRIVE:501  Rev: 2.2
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
sr0: scsi-1 drive
[root@gw /root]# eject cdrom

INIT: Switching to runscsi : aborting command due to timeout : pid 0, scsi0,
channel 0, id 4, lun 0 Start/Stop Unit 00 00 00 02 00
scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Start/Stop Unit 00 00 00 02 00
NCR5380 : coroutine isn't running.
STATUS_REG: 07 ,PARITY,IO,SEL
BASR: 10
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine isn't running.
scsi0: no currently connected command
scsi0: issue_queue
scsi0: disconnected_queue
scsi0 : destination target 4, lun 0
        command = 27 (0x1b)00 00 00 02 00

scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Start/Stop Unit 00 00 00 02 00
NCR5380 : coroutine isn't running.
STATUS_REG: 07 ,PARITY,IO,SEL
BASR: 10
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine isn't running.
scsi0: no currently connected command
scsi0: issue_queue
scsi0: disconnected_queue
scsi0 : destination target 4, lun 0
        command = 27 (0x1b)00 00 00 02 00

level: 6
INIT: scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id
4, lun 0 Prevent/Allow Medium Removal 00 00 00 00 00
scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: disconnected_queue

scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: disconnected_queue

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 4, lun
0 Prevent/Allow Medium Removal 00 00 00 00 00
scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0: disconnected_queue

scsi0 : aborting command
scsi0 : destination target 4, lun 0
        command = Prevent/Allow Medium Removal 00 00 00 00 00
NCR5380 : coroutine is running.
STATUS_REG: 4d ,PARITY,BSY,CD,IO
BASR: 08
ICR: 00
MODE: 00
scsi0 : REQ not asserted, phase unknown.

NCR5380 core release=7.   PAS16 release=3
Base Addr: 0x00000    io_port: 0388      IRQ: 12.
Highwater I/O busy_spin_counts -- write: 0  read: 0
NCR5380 : coroutine is running.
scsi0 : destination target 4, lun 0
        command = 30 (0x1e)00 00 00 00 00
scsi0: issue_queue
scsi0: disconnected_queue

***********
at this point the system is again unresponse, and requires hard-reset
as before, the cdrom has ejected from the drive, but there has been
no return from the actual command.

