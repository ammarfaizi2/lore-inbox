Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUF3KRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUF3KRd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 06:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUF3KRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 06:17:14 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:35228 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265960AbUF3KQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 06:16:08 -0400
Date: Wed, 30 Jun 2004 03:16:05 -0700
From: Sean Champ <gimbal@sdf.lonestar.org>
To: linux-kernel@vger.kernel.org
Subject: problems with CF card reader, kernel 2.6.7
Message-ID: <20040630101605.GA3568@tokamak.homeunix.net>
Mail-Followup-To: Sean Champ <gimbal@sdf.lonestar.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having some troubles with a USB-based 6-in-1 "smart media" reader,
in kernel 2.6.7. 

While using kernel 2.6.6, a couple of days ago, I was able to mount a
CF card in the reader, successfully, and to move all of the files off
of it. Then, I unmounted the chip, removed it from the reader, and
tried to mount another. That, it seems, is when the problems started.

I've only been able to mount a card in the reader once, in the past
few days  (and that was done with an install of MSWindows'98, which
seems to be having its own problems about things, such that it's about
as useless as ever.) 

I've hoped that I might be able to help, at least, in offering som
debug data, about whatever might be wrong with the software side of
things.

So, I compiled the usb-storage module, in my 2.6.7 kernel, with the
extra debugging flag turned on. I started a little debugging session,
then -- using 'logger' to record notes to the syslog, before each
action with the reader (e.g.: plugging the reader in; plugging the
card into the reader; unplugging each). I've included the syslog
output, below. My own notes were added by user "sc"


If I would need to provide any more information (e.g.: boot-time
'dmesg' output; other shell-command output; names of motherbord/usb
components, etc), so that this might make more sense, then I'll be
more than glad to send it along.


Thank you!

--
Sean Champ




Here's what I can think to include of syslog messages about the
hardware

(I'd be glad to include more hardware-identification info, if it would
be of help. I'm not terribly sure of all of what's in the box,
really, but Gateway should still have a record of it.)
  

Jun 28 21:17:02 tokamak kernel: ACPI disabled because your bios is from 1995 and too old
{...}
Jun 28 21:17:02 tokamak kernel: CPU:     After generic identify, caps: 008021bf 808029bf 00000000 00000000
Jun 28 21:17:02 tokamak kernel: CPU:     After vendor identify, caps: 008021bf 808029bf 00000000 00000000
Jun 28 21:17:02 tokamak kernel: CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
Jun 28 21:17:02 tokamak kernel: CPU:     After all inits, caps: 008021bf 808029bf 00000000 00000002
Jun 28 21:17:02 tokamak kernel: CPU: AMD-K6(tm) 3D processor stepping 0c
{...}
Jun 28 21:17:02 tokamak kernel: PCI: Using ALI IRQ Router
Jun 28 21:17:02 tokamak kernel: PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
Jun 28 21:17:02 tokamak kernel: PCI: IRQ 0 for device 0000:00:0e.0 doesn't match PIRQ mask - try pci=usepirqmask
{...}
Jun 28 21:17:02 tokamak kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Jun 28 21:17:02 tokamak kernel: ALI15X3: IDE controller at PCI slot 0000:00:0e.0
Jun 28 21:17:02 tokamak kernel: PCI: Hardcoded IRQ 14 for device 0000:00:0e.0
Jun 28 21:17:02 tokamak kernel: ALI15X3: chipset revision 193
Jun 28 21:17:02 tokamak kernel: ALI15X3: not 100%% native mode: will probe irqs later






Here's the syslog output from the debugging session, for when I did
the following:

1)  attached the card-reader to the USB root hub
2)  put a usable CF card in the reader
3)  tried to mount partition 1 from the CF card
4)  failed
5)  removed the CF card
6)  unplugged the reader




Jun 29 23:17:59 tokamak sc: MARK
Jun 29 23:18:08 tokamak sc: attaching IWill 6-in-1 card reader
Jun 29 23:18:14 tokamak kernel: hub 1-0:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
Jun 29 23:18:15 tokamak kernel: hub 1-0:1.0: Cannot enable port 2.  Maybe the USB cable is bad?
Jun 29 23:18:15 tokamak kernel: usb 1-2: new full speed USB device using address 3
Jun 29 23:18:15 tokamak kernel: usb-storage: USB Mass Storage device detected
Jun 29 23:18:15 tokamak kernel: usb-storage: altsetting is 0, id_index is 92
Jun 29 23:18:15 tokamak kernel: usb-storage: -- associate_dev
Jun 29 23:18:15 tokamak kernel: usb-storage: Transport: Bulk
Jun 29 23:18:15 tokamak kernel: usb-storage: Protocol: Transparent SCSI
Jun 29 23:18:15 tokamak kernel: usb-storage: Endpoints: In: 0xd3fe5994 Out: 0xd3fe59a8 Int: 0x00000000 (Period 0)
Jun 29 23:18:15 tokamak kernel: usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Jun 29 23:18:16 tokamak kernel: usb-storage: GetMaxLUN command result is 1, data is 3
Jun 29 23:18:16 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:16 tokamak kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jun 29 23:18:16 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:16 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:16 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 29 23:18:16 tokamak kernel: usb-storage:  12 00 00 00 24 00
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xc L 36 F 128 Trg 0 LUN 0 CL 6
Jun 29 23:18:16 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:16 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:16 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:16 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 29 23:18:16 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 29 23:18:16 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:16 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:16 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:16 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:16 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x0
Jun 29 23:18:16 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 29 23:18:16 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 29 23:18:16 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:16 tokamak kernel:   Vendor: 6-in-1    Model: CF/MD             Rev: 0202
Jun 29 23:18:16 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 29 23:18:16 tokamak kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Jun 29 23:18:16 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:16 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:16 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 29 23:18:16 tokamak kernel: usb-storage:  12 20 00 00 24 00
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xd L 36 F 128 Trg 0 LUN 1 CL 6
Jun 29 23:18:16 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:16 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:16 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:16 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 29 23:18:16 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 29 23:18:16 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:16 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:16 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:16 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:17 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:17 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xd R 0 Stat 0x0
Jun 29 23:18:17 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 29 23:18:17 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 29 23:18:17 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:17 tokamak kernel:   Vendor: 6-in-1    Model: SM                Rev: 0202
Jun 29 23:18:17 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 29 23:18:17 tokamak kernel: Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 1,  type 0
Jun 29 23:18:17 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:17 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:17 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 29 23:18:17 tokamak kernel: usb-storage:  12 40 00 00 24 00
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xe L 36 F 128 Trg 0 LUN 2 CL 6
Jun 29 23:18:17 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:17 tokamak scsi.agent[1797]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:0
Jun 29 23:18:17 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:17 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:17 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 29 23:18:17 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 29 23:18:17 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:17 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:17 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:17 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:17 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:17 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xe R 0 Stat 0x0
Jun 29 23:18:17 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 29 23:18:17 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 29 23:18:17 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:17 tokamak kernel:   Vendor: 6-in-1    Model: SD/MMC            Rev: 0202
Jun 29 23:18:17 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 29 23:18:18 tokamak kernel: Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 2,  type 0
Jun 29 23:18:18 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:18 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 29 23:18:18 tokamak kernel: usb-storage:  12 60 00 00 24 00
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xf L 36 F 128 Trg 0 LUN 3 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xf R 0 Stat 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 29 23:18:18 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:18 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:18 tokamak kernel:   Vendor: 6-in-1    Model: MS                Rev: 0202
Jun 29 23:18:18 tokamak scsi.agent[1815]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:1
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:18 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:18 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x10 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x10 R 0 Stat 0x1
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:18 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000010 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000010 R 0 Stat 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:18 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:18 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:18 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:18 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:18 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x11 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x11 R 0 Stat 0x1
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:18 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000011 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:18 tokamak usb.agent[1774]:      usb-storage: already loaded
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000011 R 0 Stat 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:18 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:18 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:18 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:18 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:18 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x12 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x12 R 0 Stat 0x1
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:18 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000012 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000012 R 0 Stat 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:18 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:18 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:18 tokamak kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Jun 29 23:18:18 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:18 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:18 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:18 tokamak kernel: usb-storage:  00 20 00 00 00 00
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x13 L 0 F 0 Trg 0 LUN 1 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x13 R 0 Stat 0x1
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:18 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000013 L 18 F 128 Trg 0 LUN 1 CL 6
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:18 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:18 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:18 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:18 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:18 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000013 R 0 Stat 0x0
Jun 29 23:18:19 tokamak scsi.agent[1838]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:2
Jun 29 23:18:18 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 20 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x14 L 0 F 0 Trg 0 LUN 1 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x14 R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000014 L 18 F 128 Trg 0 LUN 1 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000014 R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 20 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x15 L 0 F 0 Trg 0 LUN 1 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x15 R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000015 L 18 F 128 Trg 0 LUN 1 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000015 R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 1
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 40 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x16 L 0 F 0 Trg 0 LUN 2 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x16 R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000016 L 18 F 128 Trg 0 LUN 2 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000016 R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 40 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x17 L 0 F 0 Trg 0 LUN 2 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x17 R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000017 L 18 F 128 Trg 0 LUN 2 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000017 R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 40 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x18 L 0 F 0 Trg 0 LUN 2 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x18 R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000018 L 18 F 128 Trg 0 LUN 2 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000018 R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 2
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 60 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x19 L 0 F 0 Trg 0 LUN 3 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x19 R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000019 L 18 F 128 Trg 0 LUN 3 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000019 R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 60 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x1a L 0 F 0 Trg 0 LUN 3 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x1a R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x8000001a L 18 F 128 Trg 0 LUN 3 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x8000001a R 0 Stat 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:19 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:19 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:19 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:19 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:19 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:19 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:18:19 tokamak kernel: usb-storage:  00 60 00 00 00 00
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x1b L 0 F 0 Trg 0 LUN 3 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:19 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:19 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x1b R 0 Stat 0x1
Jun 29 23:18:19 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:18:19 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:18:19 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x8000001b L 18 F 128 Trg 0 LUN 3 CL 6
Jun 29 23:18:19 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:18:20 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:18:20 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:20 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:18:20 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:18:20 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:18:20 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:20 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:18:20 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:18:20 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:18:20 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:18:20 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:18:20 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:18:20 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x8000001b R 0 Stat 0x0
Jun 29 23:18:20 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:18:20 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 29 23:18:20 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: Attached scsi removable disk sdd at scsi1, channel 0, id 0, lun 3
Jun 29 23:18:20 tokamak kernel: Attached scsi generic sg4 at scsi1, channel 0, id 0, lun 3,  type 0
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad LUN (0:4)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (1:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (2:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (3:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (4:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (5:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (6:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:18:20 tokamak kernel: usb-storage: Bad target number (7:0)
Jun 29 23:18:20 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 29 23:18:20 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:18:20 tokamak kernel: USB Mass Storage device found at 3
Jun 29 23:18:21 tokamak scsi.agent[1883]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:3
Jun 29 23:18:32 tokamak sc: done: card reader attached
Jun 29 23:18:39 tokamak sc: plugging cf chip into card reader
Jun 29 23:19:01 tokamak sc: mounting cf chip : sda1
Jun 29 23:19:04 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:19:04 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:19:04 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:19:04 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x24 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:19:04 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x24 R 0 Stat 0x1
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 29 23:19:04 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000024 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 29 23:19:04 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000024 R 0 Stat 0x0
Jun 29 23:19:04 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 29 23:19:04 tokamak kernel: usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
Jun 29 23:19:04 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 29 23:19:04 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 29 23:19:04 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:19:04 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:19:04 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:19:04 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:19:04 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x25 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:19:04 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk status result = 0
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x25 R 0 Stat 0x0
Jun 29 23:19:04 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 29 23:19:04 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:19:04 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:19:04 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:19:04 tokamak kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jun 29 23:19:04 tokamak kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x26 L 8 F 128 Trg 0 LUN 0 CL 10
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:19:04 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 29 23:19:04 tokamak kernel: usb-storage: -- transfer complete
Jun 29 23:19:04 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 29 23:19:04 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
Jun 29 23:19:34 tokamak kernel: usb-storage: command_abort called
Jun 29 23:19:34 tokamak kernel: usb-storage: usb_stor_stop_transport called
Jun 29 23:19:34 tokamak kernel: usb-storage: -- cancelling URB
Jun 29 23:19:34 tokamak kernel: usb-storage: Status code -104; transferred 0/8
Jun 29 23:19:34 tokamak kernel: usb-storage: -- transfer cancelled
Jun 29 23:19:34 tokamak kernel: usb-storage: Bulk data transfer result 0x4
Jun 29 23:19:34 tokamak kernel: usb-storage: -- command was aborted
Jun 29 23:19:34 tokamak kernel: usb-storage: usb_stor_Bulk_reset called
Jun 29 23:19:34 tokamak kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 29 23:19:54 tokamak kernel: usb-storage: Timeout -- cancelling URB
Jun 29 23:19:54 tokamak kernel: usb-storage: Soft reset failed: -104
Jun 29 23:19:54 tokamak kernel: usb-storage: scsi command aborted
Jun 29 23:19:54 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:19:54 tokamak kernel: usb-storage: queuecommand called
Jun 29 23:19:54 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:19:54 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 29 23:19:54 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 29 23:19:54 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x26 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 29 23:19:54 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 29 23:20:04 tokamak kernel: usb-storage: command_abort called
Jun 29 23:20:04 tokamak kernel: usb-storage: usb_stor_stop_transport called
Jun 29 23:20:04 tokamak kernel: usb-storage: -- cancelling URB
Jun 29 23:20:04 tokamak kernel: usb-storage: Status code -104; transferred 0/31
Jun 29 23:20:04 tokamak kernel: usb-storage: -- transfer cancelled
Jun 29 23:20:04 tokamak kernel: usb-storage: Bulk command transfer result=4
Jun 29 23:20:04 tokamak kernel: usb-storage: -- command was aborted
Jun 29 23:20:04 tokamak kernel: usb-storage: usb_stor_Bulk_reset called
Jun 29 23:20:04 tokamak kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 29 23:20:04 tokamak kernel: usb-storage: Soft reset failed: -110
Jun 29 23:20:04 tokamak kernel: usb-storage: scsi command aborted
Jun 29 23:20:04 tokamak kernel: usb-storage: *** thread sleeping.
Jun 29 23:20:04 tokamak kernel: usb-storage: device_reset called
Jun 29 23:20:04 tokamak kernel: usb-storage: usb_stor_Bulk_reset called
Jun 29 23:20:04 tokamak kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 29 23:20:04 tokamak kernel: usb-storage: Soft reset failed: -110
Jun 29 23:20:04 tokamak kernel: usb-storage: bus_reset called
Jun 29 23:20:04 tokamak kernel: usb 1-2: reset full speed USB device using address 3
Jun 29 23:20:05 tokamak kernel: usb 1-2: device not accepting address 3, error -110
Jun 29 23:20:05 tokamak kernel: usb-storage: usb_reset_device returns -19
Jun 29 23:20:05 tokamak kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Jun 29 23:20:05 tokamak kernel: scsi1 (0:0): rejecting I/O to offline device
Jun 29 23:20:05 tokamak kernel: scsi1 (0:0): rejecting I/O to offline device
Jun 29 23:20:05 tokamak kernel: sda : READ CAPACITY failed.
Jun 29 23:20:05 tokamak kernel: sda : status=0, message=00, host=5, driver=04 
Jun 29 23:20:05 tokamak kernel: sda : sense not available. 
Jun 29 23:20:05 tokamak kernel: sda: assuming Write Enabled
Jun 29 23:20:05 tokamak kernel: sda: assuming drive cache: write through
Jun 29 23:20:40 tokamak sc: done: failure: 'mount' message was "mount: /dev/sda1 is not a vaid block device"
Jun 29 23:25:55 tokamak sc: removing cf chip from reader
Jun 29 23:26:08 tokamak sc: unplugging card reader
Jun 29 23:26:11 tokamak kernel: usb 1-2: USB disconnect, address -1
Jun 29 23:26:11 tokamak kernel: usb-storage: storage_disconnect() called
Jun 29 23:26:11 tokamak kernel: usb-storage: usb_stor_stop_transport called
Jun 29 23:26:11 tokamak kernel: usb-storage: -- dissociate_dev
Jun 29 23:26:11 tokamak kernel: usb-storage: -- sending exit command to thread
Jun 29 23:26:11 tokamak kernel: usb-storage: *** thread awakened.
Jun 29 23:26:11 tokamak kernel: usb-storage: -- exit command received
Jun 29 23:26:11 tokamak kernel: usb-storage: -- usb_stor_release_resources finished
