Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRHKWvw>; Sat, 11 Aug 2001 18:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268898AbRHKWvn>; Sat, 11 Aug 2001 18:51:43 -0400
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:47009 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268897AbRHKWvi>; Sat, 11 Aug 2001 18:51:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Damon Gunther <guntherd@home.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8, USB storage, and FAT12
Date: Sat, 11 Aug 2001 18:52:10 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081118521000.00364@jonx>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just updated to 2.4.8 and I can no longer access the memory stick in my
Sony DSC-S75 camera via the USB camera connection.  This worked in
2.4.7 with the same config file.

The problem comes when I try and mount the SCSI emulated disk.  It gives me
the error:

jonx:~# mount -t vfat /dev/sda1 /camera
mount: /dev/sda1 is not a valid block device

If I do an fdisk to check the partition information:

jonx:~# fdisk /dev/sda

Command (m for help): p

Disk /dev/sda: 8 heads, 16 sectors, 991 cylinders
Units = cylinders of 128 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1       990     63340+   1  FAT12

I noticed in the CHANGELOG that USB and FAT updates were made, so I don't
know which one of them is causing the problem.  I was using a modified entry
in unusual_devs.h to see the camera in 2.4.7.  This entry made it into 2.4.8.

I have vfat built as a module and I can mount my Windows partitions just fine.

Here is some dmesg output for more information:

hub.c: USB new device connect on bus1/2/1, assigned device number 5
usb.c: USB device 5 (vend/prod 0x54c/0x10) is not claimed by any active
driver.
SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
scsi0 : SCSI emulation for USB Mass Storage devices
  Vendor: Sony      Model: Sony DSC          Rev: 3.22
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 126848 512-byte hdwr sectors (65 MB)
sda: Write Protect is off
 sda: unknown partition table
WARNING: USB Mass Storage data integrity not assured
USB Mass Storage device found at 5
USB Mass Storage support registered.

Please CC: me with your replies/help as I am not on the mailing list.

Thanks,

Damon

-------------------------------------------------------
