Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUCPCnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 21:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUCPCmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 21:42:49 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:40407 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S262997AbUCPCgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 21:36:18 -0500
Date: Tue, 16 Mar 2004 03:36:11 +0100
From: Oliver Vogel <oliver.vogel@gmx.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4 - Card Reader not working
Message-Id: <20040316033611.4ca1d088.oliver.vogel@gmx.net>
In-Reply-To: <20040315223957.GC19555@redhat.com>
References: <20040315233106.28bc8b7a.oliver.vogel@gmx.net>
	<20040315223957.GC19555@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__16_Mar_2004_03_36_11_+0100_Ji0rnG6See+19u_i"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__16_Mar_2004_03_36_11_+0100_Ji0rnG6See+19u_i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Mar 2004 22:39:57 +0000, Dave Jones <davej@redhat.com> wrote:

> I had a similar problem recently with a 6-in-1 reader I picked up.
> Using..
> modprobe scsi_mod max_luns=6
> 
> it could see all LUNs on the device (each slot was a seperate LUN).
> 
> If this works for you, send the scsi messages from dmesg output, and
> it can be added to the list of devices to probe all luns.

It works - except one thing:

It successfully detects the Card Reader and I see 4 LUNs.
But when I plug in a card, no "part1" appears on the appropriate LUN.
If I plug in the card before loading the modules, part1 appears on the
LUN and I can mount the card.
(I know devfs is obsolete, but I didn't want to disable it yet)

I now needed to make usb-storage as well as the scsi stuff as modules in
order to load scsi_mod with the param.
Is there a way to pass the param to scsi when I compile usb-storage
and the scsi stuff into the kernel?

As requested, I attached the dmesg output from the modprobing of the usb
and scsi modules, and as this seems to be mainly about what happens with
usb_storage and scsi, I enabled verbose debugging for usb-storage.
The attached output is with the card in the card reader.
I hope this is the output you need.

The kernel is a vanilla 2.6.4. If you need any further information
please let me know.

Thanks for your help,

Regards,

Oliver.

--Multipart=_Tue__16_Mar_2004_03_36_11_+0100_Ji0rnG6See+19u_i
Content-Type: text/plain;
 name="dmesg.txt"
Content-Disposition: attachment;
 filename="dmesg.txt"
Content-Transfer-Encoding: 7bit

ohci_hcd 0000:00:03.0: remove, state 1
usb usb2: USB disconnect, address 1
ohci_hcd 0000:00:03.0: USB bus 2 deregistered
ohci_hcd 0000:00:03.1: remove, state 1
usb usb3: USB disconnect, address 1
usb 3-1: USB disconnect, address 2
usb-storage: storage_disconnect() called
usb-storage: usb_stor_stop_transport called
usb-storage: -- dissociate_dev
usb-storage: -- sending exit command to thread
usb-storage: *** thread awakened.
usb-storage: -- exit command received
usb-storage: -- usb_stor_release_resources finished
ohci_hcd 0000:00:03.1: USB bus 3 deregistered
ohci_hcd 0000:00:03.2: remove, state 1
usb usb4: USB disconnect, address 1
ohci_hcd 0000:00:03.2: USB bus 4 deregistered
usb-storage: usb_stor_exit() called
usb-storage: -- calling usb_deregister()
drivers/usb/core/usb.c: deregistering driver usb-storage
ehci_hcd 0000:00:03.3: remove, state 1
usb usb1: USB disconnect, address 1
ehci_hcd 0000:00:03.3: USB bus 1 deregistered
SCSI subsystem initialized
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 11, pci mem f0adc000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:03.0: OHCI Host Controller
ohci_hcd 0000:00:03.0: irq 9, pci mem f0ade000
ohci_hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.1: OHCI Host Controller
ohci_hcd 0000:00:03.1: irq 3, pci mem f0ae0000
ohci_hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ohci_hcd 0000:00:03.2: OHCI Host Controller
ohci_hcd 0000:00:03.2: irq 13, pci mem f0ae2000
ohci_hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v2.2
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
usb 3-1: new full speed USB device using address 2
usb-storage: USB Mass Storage device detected
usb-storage: act_altsetting is 0, id_index is 117
usb-storage: -- associate_dev
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: Endpoints: In: 0xd9e54dc0 Out: 0xd9e54dd4 Int: 0xd9e54de8 (Period 10)
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 3
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x1 L 36 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x1 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: Medion    Model: Flash XL  MMC/SD  Rev: 2.6D
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x2 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x2 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000002 L 18 F 128 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000002 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x3 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x3 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage:  25 00 00 00 00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x4 L 8 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 8 bytes
usb-storage: Status code 0; transferred 8/8
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x4 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sda: 59776 512-byte hdwr sectors (31 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x5 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x5 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 01 00
usb-storage: Bulk Command S 0x43425355 T 0x6 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x6 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 /dev/scsi/host0/bus0/target0/lun0:<7>usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 00 00 00 00 00 08 00
usb-storage: Bulk Command S 0x43425355 T 0x7 L 4096 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 4096 bytes, 1 entries
usb-storage: Status code 0; transferred 4096/4096
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x7 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
 p1
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
usb-storage:  1e 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x8 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x8 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 20 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x9 L 36 F 128 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x9 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: Medion    Model: Flash XL      CF  Rev: 2.6D
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 20 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xa L 0 F 0 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xa R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x8000000a L 18 F 128 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x8000000a R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x6, ASC: 0x28, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 20 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xb L 0 F 0 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xb R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x8000000b L 18 F 128 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x8000000b R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 20 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xc L 0 F 0 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xc R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x8000000c L 18 F 128 Trg 0 LUN 1 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x8000000c R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
Attached scsi removable disk sdb at scsi0, channel 0, id 0, lun 1
Attached scsi generic sg1 at scsi0, channel 0, id 0, lun 1,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 40 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0xd L 36 F 128 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xd R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: Medion    Model: Flash XL      MS  Rev: 2.6D
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 40 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xe L 0 F 0 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xe R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x8000000e L 18 F 128 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x8000000e R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 40 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0xf L 0 F 0 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0xf R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x8000000f L 18 F 128 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x8000000f R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 40 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x10 L 0 F 0 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x10 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000010 L 18 F 128 Trg 0 LUN 2 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000010 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
Attached scsi removable disk sdc at scsi0, channel 0, id 0, lun 2
Attached scsi generic sg2 at scsi0, channel 0, id 0, lun 2,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 60 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x11 L 36 F 128 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 36 bytes
usb-storage: Status code 0; transferred 36/36
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x11 R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: Medion    Model: Flash XL      SM  Rev: 2.6D
  Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 60 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x12 L 0 F 0 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x12 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000012 L 18 F 128 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000012 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 60 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x13 L 0 F 0 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x13 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000013 L 18 F 128 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000013 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 60 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x14 L 0 F 0 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x14 R 0 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000014 L 18 F 128 Trg 0 LUN 3 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_buf: xfer 18 bytes
usb-storage: Status code 0; transferred 18/18
usb-storage: -- transfer complete
usb-storage: Bulk data transfer result 0x0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x80000014 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x2, ASC: 0x3a, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
Attached scsi removable disk sdd at scsi0, channel 0, id 0, lun 3
Attached scsi generic sg3 at scsi0, channel 0, id 0, lun 3,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad LUN (0:4)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (1:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (2:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (3:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (4:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (5:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (6:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad target number (7:0)
usb-storage: scsi cmd done, result=0x40000
usb-storage: *** thread sleeping.
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 2

--Multipart=_Tue__16_Mar_2004_03_36_11_+0100_Ji0rnG6See+19u_i--
