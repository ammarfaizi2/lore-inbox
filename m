Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTAUAcn>; Mon, 20 Jan 2003 19:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTAUAcn>; Mon, 20 Jan 2003 19:32:43 -0500
Received: from webmail.frogspace.net ([216.222.206.4]:20950 "EHLO
	webmail.frogspace.net") by vger.kernel.org with ESMTP
	id <S262492AbTAUAcl>; Mon, 20 Jan 2003 19:32:41 -0500
Message-ID: <1043109692.3e2c973c61f8f@webmail.cogweb.net>
Date: Mon, 20 Jan 2003 16:41:32 -0800
From: Peter Nome <peter@cogweb.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 USB storage (SCSI emulation)
References: <200301101336.h0ADaDG10038@devserv.devel.redhat.com>
In-Reply-To: <200301101336.h0ADaDG10038@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 128.97.184.97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Booting 2.4.20 (Debian sid official release 5) with an Archos Jukebox Recorder 20, a 
USB storage device running a SCSI emulation with the ISD200 driver, produces a host 
of messages in the log, but it works fine.  I'm getting Bad target number and an 
apparently failed "Attempting to get CSW" -- any ideas what's going on? What I DON'T 
get is a message telling me where the device is, as I should and used to -- e.g., 
"Detected scsi disk sda at scsi1, channel 0, id 0, lun 0". However, mounting 
/dev/sda1 works:

Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
 sda:<7>usb-storage: queuecommand() called
 sda1

In sum, two minor bugs: the queuecommand() is fruitlessly trying to do something, 
and the user is not informed where the device is placed.

Cheers,
Peter

dmesg:

SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 88
usb-storage: Array length appears to be: 90
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xc15c5794 Out: 0xc15c5780 Int: 0xc15c57a8 (Period 9)
usb-storage: New GUID 05ab0060fffffffffff7d96a
usb-storage: GetMaxLUN command result is -32, data is 128
usb-storage: clearing endpoint halt for pipe 0x80000280
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 5b df ac e0 ed de
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 255 F 128 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 36/255
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: clearing endpoint halt for pipe 0xc0010280
usb-storage: usb_stor_clear_halt: result=0
usb-storage: Attempting to get CSW (2nd try)...
usb-storage: Bulk status result = 0
usb-storage: Bulk status Sig 0x53425355 T 0x1 R 219 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: HITACHI_  Model: DK23DA-20     Rev: 00J2
  Type:  Direct-Access            ANSI SCSI revision: 02
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6/0)
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7/0)
usb-storage: *** thread sleeping.
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2
USB Mass Storage support registered.
