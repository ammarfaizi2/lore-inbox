Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUGADEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUGADEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUGADEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:04:41 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:52893 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263743AbUGADEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:04:12 -0400
Date: Wed, 30 Jun 2004 20:04:11 -0700
From: Sean Champ <gimbal@sdf.lonestar.org>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with CF card reader, kernel 2.6.7
Message-ID: <20040701030411.GA2413@tokamak.homeunix.net>
Mail-Followup-To: Sean Champ <gimbal@sdf.lonestar.org>,
	Rudo Thomas <rudo@matfyz.cz>, linux-kernel@vger.kernel.org
References: <20040630101605.GA3568@tokamak.homeunix.net> <200406301108.02618.tcfelker@mtco.com> <20040630162054.GA22476@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630162054.GA22476@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,


On Wed, Jun 30, 2004 at 06:20:54PM +0200, Rudo Thomas wrote:
> > This is a stab in the dark, but try running "eject /dev/sg0" on the generic
> > device coresponding to the card reader (or maybe the disc device, I'm not
> > sure), after putting the new card in.  This forces the kernel to reread the
> > card's partition table.
> 
> Actually, this is better done with "blockdev --rereadpt /dev/sda" or similar.


I appreciate the help, seriouly.

I tried it, but it didn't work. The command sat around for a
while, while some more output went into syslog.  

I see this from the command:
 
# pts12:root> blockdev --rearedapt /dev/sda
/dev/sda: No such device or addres


In case it might be of any help on the list, I've included more of the
syslog output, from when I connected the card-reader (just for
thoroughness) then the card, and when I ran the blockdev command.


Thanks,

--
Sean



Syslog output :

[ logging, from during blockdev command, begins at "* plugged-in the cf chip"]



Jun 30 19:48:48 tokamak sc: plugging-in 6-in-1 media reader
Jun 30 19:48:53 tokamak kernel: usb 1-2: new full speed USB device using address 3
Jun 30 19:48:53 tokamak kernel: usb-storage: USB Mass Storage device detected
Jun 30 19:48:53 tokamak kernel: usb-storage: altsetting is 0, id_index is 92
Jun 30 19:48:53 tokamak kernel: usb-storage: -- associate_dev
Jun 30 19:48:54 tokamak kernel: usb-storage: Transport: Bulk
Jun 30 19:48:54 tokamak kernel: usb-storage: Protocol: Transparent SCSI
Jun 30 19:48:54 tokamak kernel: usb-storage: Endpoints: In: 0xd3fe79d4 Out: 0xd3fe79e8 Int: 0x00000000 (Period 0)
Jun 30 19:48:54 tokamak kernel: usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
Jun 30 19:48:54 tokamak kernel: usb-storage: GetMaxLUN command result is 1, data is 3
Jun 30 19:48:54 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:54 tokamak kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jun 30 19:48:54 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:54 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:54 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 30 19:48:54 tokamak kernel: usb-storage:  12 00 00 00 24 00
Jun 30 19:48:54 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xc L 36 F 128 Trg 0 LUN 0 CL 6
Jun 30 19:48:54 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:54 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:54 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:54 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:54 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 30 19:48:54 tokamak usb.agent[1864]:      usb-storage: already loaded
Jun 30 19:48:54 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 30 19:48:54 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:54 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:54 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:54 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:54 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:54 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:54 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:54 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x0
Jun 30 19:48:54 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 30 19:48:54 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 30 19:48:54 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:55 tokamak kernel:   Vendor: 6-in-1    Model: CF/MD             Rev: 0202
Jun 30 19:48:55 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 30 19:48:55 tokamak kernel: Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Jun 30 19:48:55 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:55 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:55 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 30 19:48:55 tokamak kernel: usb-storage:  12 20 00 00 24 00
Jun 30 19:48:55 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xd L 36 F 128 Trg 0 LUN 1 CL 6
Jun 30 19:48:55 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:55 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:55 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:55 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:55 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 30 19:48:55 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 30 19:48:55 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:55 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:55 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:55 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:55 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:55 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:55 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:55 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xd R 0 Stat 0x0
Jun 30 19:48:55 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 30 19:48:55 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 30 19:48:55 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:55 tokamak scsi.agent[1903]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:0
Jun 30 19:48:56 tokamak kernel:   Vendor: 6-in-1    Model: SM                Rev: 0202
Jun 30 19:48:56 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: Attached scsi generic sg2 at scsi1, channel 0, id 0, lun 1,  type 0
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xe L 0 F 0 Trg 0 LUN 0 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xe R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x8000000e L 18 F 128 Trg 0 LUN 0 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x8000000e R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  12 40 00 00 24 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0xf L 36 F 128 Trg 0 LUN 2 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0xf R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel:   Vendor: 6-in-1    Model: SD/MMC            Rev: 0202
Jun 30 19:48:56 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x10 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x10 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000010 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000010 R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x11 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x11 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000011 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000011 R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 20 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x12 L 0 F 0 Trg 0 LUN 1 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x12 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000012 L 18 F 128 Trg 0 LUN 1 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000012 R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 20 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x13 L 0 F 0 Trg 0 LUN 1 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x13 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000013 L 18 F 128 Trg 0 LUN 1 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000013 R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 20 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x14 L 0 F 0 Trg 0 LUN 1 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x14 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000014 L 18 F 128 Trg 0 LUN 1 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak scsi.agent[1921]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:1
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000014 R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: Attached scsi removable disk sdb at scsi1, channel 0, id 0, lun 1
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 40 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x15 L 0 F 0 Trg 0 LUN 2 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x15 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000015 L 18 F 128 Trg 0 LUN 2 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000015 R 0 Stat 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:56 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:56 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:56 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:56 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:56 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:56 tokamak kernel: usb-storage:  00 40 00 00 00 00
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x16 L 0 F 0 Trg 0 LUN 2 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x16 R 0 Stat 0x1
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:56 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000016 L 18 F 128 Trg 0 LUN 2 CL 6
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:56 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:56 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:56 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:56 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:56 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000016 R 0 Stat 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:57 tokamak kernel: usb-storage:  00 40 00 00 00 00
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x17 L 0 F 0 Trg 0 LUN 2 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x17 R 0 Stat 0x1
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:57 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000017 L 18 F 128 Trg 0 LUN 2 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000017 R 0 Stat 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: Attached scsi removable disk sdc at scsi1, channel 0, id 0, lun 2
Jun 30 19:48:57 tokamak kernel: Attached scsi generic sg3 at scsi1, channel 0, id 0, lun 2,  type 0
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Command INQUIRY (6 bytes)
Jun 30 19:48:57 tokamak kernel: usb-storage:  12 60 00 00 24 00
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x18 L 36 F 128 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 36/36
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x18 R 0 Stat 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel:   Vendor: 6-in-1    Model: MS                Rev: 0202
Jun 30 19:48:57 tokamak kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:57 tokamak kernel: usb-storage:  00 60 00 00 00 00
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x19 L 0 F 0 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x19 R 0 Stat 0x1
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:57 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000019 L 18 F 128 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000019 R 0 Stat 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:57 tokamak kernel: usb-storage:  00 60 00 00 00 00
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x1a L 0 F 0 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak scsi.agent[1943]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:2
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x1a R 0 Stat 0x1
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:57 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x8000001a L 18 F 128 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x8000001a R 0 Stat 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:48:57 tokamak kernel: usb-storage:  00 60 00 00 00 00
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x1b L 0 F 0 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x1b R 0 Stat 0x1
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:48:57 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x8000001b L 18 F 128 Trg 0 LUN 3 CL 6
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:48:57 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:48:57 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:48:57 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:48:57 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x8000001b R 0 Stat 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:48:57 tokamak kernel: usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
Jun 30 19:48:57 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: Attached scsi removable disk sdd at scsi1, channel 0, id 0, lun 3
Jun 30 19:48:57 tokamak kernel: Attached scsi generic sg4 at scsi1, channel 0, id 0, lun 3,  type 0
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Bad LUN (0:4)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Bad target number (1:0)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Bad target number (2:0)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:57 tokamak kernel: usb-storage: Bad target number (3:0)
Jun 30 19:48:57 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:57 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:57 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:58 tokamak kernel: usb-storage: Bad target number (4:0)
Jun 30 19:48:58 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:58 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:58 tokamak kernel: usb-storage: Bad target number (5:0)
Jun 30 19:48:58 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:58 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:58 tokamak kernel: usb-storage: Bad target number (6:0)
Jun 30 19:48:58 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:58 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:48:58 tokamak kernel: usb-storage: Bad target number (7:0)
Jun 30 19:48:58 tokamak kernel: usb-storage: scsi cmd done, result=0x40000
Jun 30 19:48:58 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:48:58 tokamak kernel: USB Mass Storage device found at 3
Jun 30 19:48:58 tokamak scsi.agent[1980]: disk at /devices/pci0000:00/0000:00:02.0/usb1/1-2/1-2:1.0/host1/1:0:0:3

* plugged-in the cf chip here, then... *

Jun 30 19:49:37 tokamak sc: executing blockdev --rereadpt /dev/sda
Jun 30 19:49:46 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:49:46 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:49:46 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:49:46 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x24 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:49:46 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x24 R 0 Stat 0x1
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transport indicates command failure
Jun 30 19:49:46 tokamak kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x80000024 L 18 F 128 Trg 0 LUN 0 CL 6
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 18/18
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk data transfer result 0x0
Jun 30 19:49:46 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x80000024 R 0 Stat 0x0
Jun 30 19:49:46 tokamak kernel: usb-storage: -- Result from auto-sense is 0
Jun 30 19:49:46 tokamak kernel: usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
Jun 30 19:49:46 tokamak kernel: usb-storage: (Unknown Key): (unknown ASC/ASCQ)
Jun 30 19:49:46 tokamak kernel: usb-storage: scsi cmd done, result=0x2
Jun 30 19:49:46 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:49:46 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:49:46 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:49:46 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:49:46 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x25 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:49:46 tokamak kernel: usb-storage: Attempting to get CSW...
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 13/13
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk status result = 0
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Status S 0x53425355 T 0x25 R 0 Stat 0x0
Jun 30 19:49:46 tokamak kernel: usb-storage: scsi cmd done, result=0x0
Jun 30 19:49:46 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:49:46 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:49:46 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:49:46 tokamak kernel: usb-storage: Command READ_CAPACITY (10 bytes)
Jun 30 19:49:46 tokamak kernel: usb-storage:  25 00 00 00 00 00 00 00 00 00
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x26 L 8 F 128 Trg 0 LUN 0 CL 10
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:49:46 tokamak kernel: usb-storage: Status code 0; transferred 31/31
Jun 30 19:49:46 tokamak kernel: usb-storage: -- transfer complete
Jun 30 19:49:46 tokamak kernel: usb-storage: Bulk command transfer result=0
Jun 30 19:49:46 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
Jun 30 19:50:16 tokamak kernel: usb-storage: command_abort called
Jun 30 19:50:16 tokamak kernel: usb-storage: usb_stor_stop_transport called
Jun 30 19:50:16 tokamak kernel: usb-storage: -- cancelling URB
Jun 30 19:50:16 tokamak kernel: usb-storage: Status code -104; transferred 0/8
Jun 30 19:50:16 tokamak kernel: usb-storage: -- transfer cancelled
Jun 30 19:50:16 tokamak kernel: usb-storage: Bulk data transfer result 0x4
Jun 30 19:50:16 tokamak kernel: usb-storage: -- command was aborted
Jun 30 19:50:16 tokamak kernel: usb-storage: usb_stor_Bulk_reset called
Jun 30 19:50:16 tokamak kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 30 19:50:36 tokamak kernel: usb-storage: Timeout -- cancelling URB
Jun 30 19:50:36 tokamak kernel: usb-storage: Soft reset failed: -104
Jun 30 19:50:36 tokamak kernel: usb-storage: scsi command aborted
Jun 30 19:50:36 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:50:36 tokamak kernel: usb-storage: queuecommand called
Jun 30 19:50:36 tokamak kernel: usb-storage: *** thread awakened.
Jun 30 19:50:36 tokamak kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jun 30 19:50:36 tokamak kernel: usb-storage:  00 00 00 00 00 00
Jun 30 19:50:36 tokamak kernel: usb-storage: Bulk Command S 0x43425355 T 0x26 L 0 F 0 Trg 0 LUN 0 CL 6
Jun 30 19:50:36 tokamak kernel: usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
Jun 30 19:50:46 tokamak kernel: usb-storage: command_abort called
Jun 30 19:50:46 tokamak kernel: usb-storage: usb_stor_stop_transport called
Jun 30 19:50:46 tokamak kernel: usb-storage: -- cancelling URB
Jun 30 19:50:46 tokamak kernel: usb-storage: Status code -104; transferred 0/31
Jun 30 19:50:46 tokamak kernel: usb-storage: -- transfer cancelled
Jun 30 19:50:46 tokamak kernel: usb-storage: Bulk command transfer result=4
Jun 30 19:50:46 tokamak kernel: usb-storage: -- command was aborted
Jun 30 19:50:46 tokamak kernel: usb-storage: usb_stor_Bulk_reset called
Jun 30 19:50:46 tokamak kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 30 19:50:46 tokamak kernel: usb-storage: Soft reset failed: -110
Jun 30 19:50:46 tokamak kernel: usb-storage: scsi command aborted
Jun 30 19:50:46 tokamak kernel: usb-storage: *** thread sleeping.
Jun 30 19:50:46 tokamak kernel: usb-storage: device_reset called
Jun 30 19:50:46 tokamak kernel: usb-storage: usb_stor_Bulk_reset called
Jun 30 19:50:46 tokamak kernel: usb-storage: usb_stor_control_msg: rq=ff rqtype=21 value=0000 index=00 len=0
Jun 30 19:50:46 tokamak kernel: usb-storage: Soft reset failed: -110
Jun 30 19:50:46 tokamak kernel: usb-storage: bus_reset called
Jun 30 19:50:47 tokamak kernel: usb 1-2: reset full speed USB device using address 3
Jun 30 19:50:47 tokamak kernel: usb 1-2: device not accepting address 3, error -110
Jun 30 19:50:47 tokamak kernel: usb-storage: usb_reset_device returns -19
Jun 30 19:50:47 tokamak kernel: scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 0 lun 0
Jun 30 19:50:47 tokamak kernel: scsi1 (0:0): rejecting I/O to offline device
Jun 30 19:50:47 tokamak kernel: scsi1 (0:0): rejecting I/O to offline device
Jun 30 19:50:47 tokamak kernel: sda : READ CAPACITY failed.
Jun 30 19:50:47 tokamak kernel: sda : status=0, message=00, host=5, driver=04 
Jun 30 19:50:47 tokamak kernel: sda : sense not available. 
Jun 30 19:50:47 tokamak kernel: sda: assuming Write Enabled
Jun 30 19:50:47 tokamak kernel: sda: assuming drive cache: write through
Jun 30 19:51:18 tokamak sc: failed : blockdev message was : "/dev/sda: No such device or address"
