Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUABTtX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265624AbUABTtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:49:23 -0500
Received: from main.gmane.org ([80.91.224.249]:41152 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265619AbUABTs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:48:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <jens-usenet@spamfreemail.de>
Subject: 2.6.0-mjb2 useage report (K7-2400/1G/IDE/ASUS-nForce2)
Date: Fri, 02 Jan 2004 20:48:54 +0100
Message-ID: <3554040.5Ujn9dJA3e@spamfreemail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a simple user's report on switching to 2.6.0 from 2.4.22.

so far, 2.6.0 hasn't made things worse here. I can use my scanner (epson
USB), I can use mouse (USB) XFree86 4.3 and NVIDIA driver (with the patches
from minion.de). I can use MPlayer to play movie files and listen to music
with the new ALSA drivers (I used ALSA before though).

Good work!
2.4.1 (the first 2.4 I used) was much worse. Not to speak of the later 2.4
kernel versions ... ;)

I don't notice any real preformance improvement over 2.4.2x, though.

Most everything works, although there are a few tidbits:


- LOCAL_APIC and PNPBIOS made my laptop crash before it could even write any
boot messages on the screen. (I posted about this earlier).

- Not putting the X server to -10 nice level (as told in the 2.6 HOWTO I dug
up somewhere, that also mentioned module-init-tools etc) makes my mouse
jitter whenever a process eats 100% CPU. That is not nice. XMMS also skips
a second then.
The X server also freezes for a seond from time to time for no apparent
reason (other than the CPU useage going up). I have Folding@Home clients
running on this machine (nice=19) and usually don't notice them at all
though.


- Inserting my external IDE->USB/Firewire harddisk into the internal USB
slot (nForce2 mainboard) made Linux go into an endless loop:

lockd: failed to monitor 192.168.1.100
ehci_hcd 0000:00:02.2: GetStatus port 4 status 003402 POWER OWNER sig=k  CSC
hub 1-0:1.0: port 4, status 0, change 1, 12 Mb/s
ehci_hcd 0000:00:02.2: GetStatus port 5 status 001803 POWER sig=j  CSC
CONNECT
hub 1-0:1.0: port 5, status 501, change 1, 480 Mb/s
hub 1-0:1.0: debounce: port 5: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:02.2: port 5 high speed
ehci_hcd 0000:00:02.2: GetStatus port 5 status 001005 POWER sig=se0  PE
CONNECT
hub 1-0:1.0: new USB device on port 5, assigned address 3
usb 1-5: new device strings: Mfr=1, Product=2, SerialNumber=0
message.c: USB device number 3 default language ID 0x409
usb 1-5: Product: Mass Storage Device
usb 1-5: Manufacturer: Prolific Technology Inc.
usb.c: usb_hotplug
usb 1-5: registering 1-5:1.0 (config #1, interface 0)
usb.c: usb_hotplug
usbscanner 1-5:1.0: usb_probe_interface
usbscanner 1-5:1.0: usb_probe_interface - got id
Initializing USB Mass Storage driver...
usb-storage 1-5:1.0: usb_probe_interface
usb-storage 1-5:1.0: usb_probe_interface - got id
usb-storage: USB Mass Storage device detected
usb-storage: act_altsetting is 0, id_index is 103
usb-storage: -- associate_dev
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: Endpoints: In: 0xed5e9c60 Out: 0xed5e9c4c Int: 0x00000000
(Period 0)
usb-storage: usb_stor_control_msg: rq=fe rqtype=a1 value=0000 index=00 len=1
usb-storage: GetMaxLUN command result is 1, data is 0
usb-storage: *** thread sleeping.
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage:  12 00 00 00 24 00
usb-storage: Bulk Command S 0x43425355 T 0x1b L 36 F 128 Trg 0 LUN 0 CL 6
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
usb-storage: Bulk Status S 0x53425355 T 0x1b R 0 Stat 0x0
usb-storage: Fixing INQUIRY data to show SCSI rev 2 - was 0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
  Vendor: Maxtor 6  Model: Y200P0            Rev: YAR4
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Bad LUN (0:1)
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
USB Mass Storage device found at 3
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
nt[13470]: bogus sysfs DEVPATH=/devices/pci0000:00/0000:00:02.2
usb1/1-5/1-5:1.0/hos

usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage:  00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x24 L 0 F 0 Trg 0 LUN 0 CL 6
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x24 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_CAPACITY (10 bytes)
usb-storage:  25 00 00 00 00 00 00 00 00 00
usb-storage: Bulk Command S 0x43425355 T 0x25 L 8 F 128 Trg 0 LUN 0 CL 10
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
usb-storage: Bulk Status S 0x53425355 T 0x25 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
SCSI device sda: 398297089 512-byte hdwr sectors (203928 MB)
sda: assuming drive cache: write through
 /dev/scsi/host2/bus0/target0/lun0:<7>usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 00 00 00 00 00 00 08 00
usb-storage: Bulk Command S 0x43425355 T 0x26 L 4096 F 128 Trg 0 LUN 0 CL 10
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
usb-storage: Bulk Status S 0x53425355 T 0x26 R 0 Stat 0x0
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 17 bd 88 00 00 00 01 00
usb-storage: Bulk Command S 0x43425355 T 0x27 L 512 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
usb-storage: Status code -32; transferred 0/512
usb-storage: clearing endpoint halt for pipe 0xc0010380
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Bulk data transfer result 0x2
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x27 R 512 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: -- unexpectedly short transfer
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000027 L 18 F 128 Trg 0 LUN 0
CL 6
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
usb-storage: Bulk Status S 0x53425355 T 0x80000027 R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x6, ASC: 0x29, ASCQ: 0x0
usb-storage: Unit Attention: Power on, reset, or bus device reset occurred
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
usb-storage: queuecommand called
usb-storage: *** thread awakened.
usb-storage: Command READ_10 (10 bytes)
usb-storage:  28 00 17 bd 88 00 00 00 01 00
usb-storage: Bulk Command S 0x43425355 T 0x28 L 512 F 128 Trg 0 LUN 0 CL 10
usb-storage: usb_stor_bulk_transfer_buf: xfer 31 bytes
usb-storage: Status code 0; transferred 31/31
usb-storage: -- transfer complete
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_bulk_transfer_sglist: xfer 512 bytes, 1 entries
usb-storage: Status code -32; transferred 0/512
usb-storage: clearing endpoint halt for pipe 0xc0010380
usb-storage: usb_stor_control_msg: rq=01 rqtype=02 value=0000 index=82 len=0
usb-storage: usb_stor_clear_halt: result = 0
usb-storage: Bulk data transfer result 0x2
usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x28 R 512 Stat 0x1
usb-storage: -- transport indicates command failure
usb-storage: -- unexpectedly short transfer
usb-storage: Issuing auto-REQUEST_SENSE
usb-storage: Bulk Command S 0x43425355 T 0x80000028 L 18 F 128 Trg 0 LUN 0
CL 6
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


-- 
Jens Benecke
