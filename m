Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVGEEqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVGEEqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 00:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVGEEqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 00:46:12 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:57604 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S261503AbVGEEpz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 00:45:55 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C334F9364@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "'linux-usb-devel@lists.sourceforge.net'" 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Kernel unable to read partition table on USB Memory Key
Date: Tue, 5 Jul 2005 16:45:00 +1200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to diagnose an issue with a USB "Memory Key" (128Mb Flash drive)
on my workstation (i386 Linux 2.6.12 kernel, using udev 058).

When connecting the key, the kernel fails to read the partition table, and
therefore the block device /dev/sda1 isn't created, so I can't mount the
volume.  Calling "fdisk" manually, however, makes it all work.

When I plug the device into the USB port, the kernel prints the following:

Jul  5 16:18:38 pc196344 kernel: usb 1-6: new high speed USB device using
ehci_hcd and address 3
Jul  5 16:18:39 pc196344 kernel: Initializing USB Mass Storage driver...
Jul  5 16:18:39 pc196344 kernel: scsi2 : SCSI emulation for USB Mass Storage
devices
Jul  5 16:18:39 pc196344 kernel: usbcore: registered new driver usb-storage
Jul  5 16:18:39 pc196344 kernel: USB Mass Storage support registered.
Jul  5 16:18:39 pc196344 kernel: usb-storage: device found at 3
Jul  5 16:18:39 pc196344 kernel: usb-storage: waiting for device to settle
before scanning
Jul  5 16:18:44 pc196344 kernel:   Vendor: OTi       Model: Flash Disk
Rev: 2.00
Jul  5 16:18:44 pc196344 kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Jul  5 16:18:44 pc196344 kernel: Attached scsi generic sg1 at scsi2, channel
0, id 0, lun 0,  type 0
Jul  5 16:18:44 pc196344 kernel: usb-storage: device scan complete
Jul  5 16:18:44 pc196344 scsi.agent[12708]: disk at
/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.0/host2/target2:0:0/2:0:0:0
Jul  5 16:18:44 pc196344 kernel: sda: Unit Not Ready, sense:
Jul  5 16:18:44 pc196344 kernel: : Current: sense key: Unit Attention
Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  5 16:18:44 pc196344 kernel: sda : READ CAPACITY failed.
Jul  5 16:18:44 pc196344 kernel: sda : status=1, message=00, host=0,
driver=08
Jul  5 16:18:44 pc196344 kernel: sd: Current: sense key: Unit Attention
Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  5 16:18:44 pc196344 kernel: sda: test WP failed, assume Write Enabled
Jul  5 16:18:44 pc196344 kernel: sda: assuming drive cache: write through
Jul  5 16:18:44 pc196344 kernel: sda: Unit Not Ready, sense:
Jul  5 16:18:44 pc196344 kernel: : Current: sense key: Unit Attention
Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  5 16:18:44 pc196344 kernel: sda : READ CAPACITY failed.
Jul  5 16:18:44 pc196344 kernel: sda : status=1, message=00, host=0,
driver=08
Jul  5 16:18:44 pc196344 kernel: sd: Current: sense key: Unit Attention
Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  5 16:18:44 pc196344 kernel: sda: test WP failed, assume Write Enabled
Jul  5 16:18:44 pc196344 kernel: sda: assuming drive cache: write through
Jul  5 16:18:44 pc196344 kernel: sda: Unit Not Ready, sense:
Jul  5 16:18:44 pc196344 kernel: : Current: sense key: Unit Attention
Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  5 16:18:44 pc196344 kernel: sda : READ CAPACITY failed.
Jul  5 16:18:44 pc196344 kernel: sda : status=1, message=00, host=0,
driver=08
Jul  5 16:18:44 pc196344 kernel: sd: Current: sense key: Unit Attention
Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
change, medium may have changed
Jul  5 16:18:44 pc196344 kernel: sda: test WP failed, assume Write Enabled
Jul  5 16:18:44 pc196344 kernel: sda: assuming drive cache: write through
Jul  5 16:18:44 pc196344 kernel:
/dev/scsi/host2/bus0/target0/lun0:end_request: I/O error, dev sda, sector 0
Jul  5 16:18:44 pc196344 kernel: Buffer I/O error on device sda, logical
block 0
Jul  5 16:18:44 pc196344 kernel: Buffer I/O error on device sda, logical
block 0
Jul  5 16:18:44 pc196344 kernel:  unable to read partition table
Jul  5 16:18:44 pc196344 kernel: Attached scsi removable disk sda at scsi2,
channel 0, id 0, lun 0

Clearly, something isn't right here, and the kernel is unable to read block
0 (the parition table).  I've tried using the "delay_use" parameter to the
usb-storage module to increase the delay time to 10 seconds, but still no
difference.

If I run "fdisk /dev/sda" however, then the kernel realises there is a
partition table and it all just works, thus:

Jul  5 16:24:27 pc196344 sudo:  james : TTY=pts/1 ;
PWD=/usr/src/linux-2.6.12-jrt1 ; USER=root ; COMMAND=/sbin/fdisk /dev/sda
Jul  5 16:24:27 pc196344 kernel: SCSI device sda: 255488 512-byte hdwr
sectors (131 MB)
Jul  5 16:24:27 pc196344 kernel: sda: Write Protect is off
Jul  5 16:24:27 pc196344 kernel: sda: Mode Sense: 03 00 00 00
Jul  5 16:24:27 pc196344 kernel: sda: assuming drive cache: write through
Jul  5 16:24:27 pc196344 kernel: SCSI device sda: 255488 512-byte hdwr
sectors (131 MB)
Jul  5 16:24:27 pc196344 kernel: sda: Write Protect is off
Jul  5 16:24:27 pc196344 kernel: sda: Mode Sense: 03 00 00 00
Jul  5 16:24:27 pc196344 kernel: sda: assuming drive cache: write through
Jul  5 16:24:27 pc196344 kernel:  /dev/scsi/host2/bus0/target0/lun0: p1

In the case above, I'd not done anything inside fdisk apart from "q" to
exit.  

However, I have tried reparitioning the device; using "dd if=/dev/zero
of=/dev/sda bs=512 count=1" to zero the partition table and recreate;
returning the device to the vendor and getting another one - no difference
at all.

The key itself is a NZ vendor "own-name" rebadge, made in Taiwan.  According
to the vendor's (Dick Smith Electronics, if anyone is interested) website,
<http://www.dse.co.nz/cgi-bin/dse.storefront/42ca0f440021d23e273fc0a87f9906a
8/Product/View/XH8250> the product is based on an "OTi-2168 USB2.0 mass
storage class controller".

lsusb -v identifies the following:

Bus 001 Device 004: ID 0ea0:2168 Ours Technology, Inc. Transcend JetFlash
2.0
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x0ea0 Ours Technology, Inc.
  idProduct          0x2168 Transcend JetFlash 2.0
  bcdDevice            2.00
  iManufacturer           1 USB
  iProduct                2 Flash Disk
  iSerial                 3 A8933C31BB2C00E2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval               1
  Language IDs: (length=4)
     0409 English(US)

My previous USB-Key (an IBM 32Mb device which developed a memory "hole" and
died) worked fine.  This new key also fails to work in a colleagues Fedora
Core 2 2.4.x kernel machine which much the same issue.  It "just works" when
used in Windows XP.

Any help highly valued at this point, and a direct "cc" on any reply would
also be appreciated.

Thanks,

James Roberts-Thomson
----------
Hardware:  The parts of a computer system that can be kicked.

Mailing list Readers:  Please ignore the following disclaimer - this email
is
explicitly declared to be non confidential and does not contain privileged
information.

This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
