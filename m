Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTGFPwv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 11:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTGFPwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 11:52:51 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:1675 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S262482AbTGFPwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 11:52:42 -0400
Date: Sun, 6 Jul 2003 18:07:11 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: usb-storage doesn't recognize a Sony DSC-P92
Message-ID: <20030706160711.GD29016@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030705212021.GB21621@charite.de> <20030706055347.GA3291@kroah.com> <20030706075334.GB30442@charite.de> <20030706111605.GA12809@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030706111605.GA12809@charite.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> With 2.4.22-pre3 it works flawlessly. Well, almost. I can attach the
> camera, mount the camera as /dev/sda1 and read the data. Neat!
> 
> Upon umount, I got a message saying "host controller halted. very bad".

Uh, and the downside: My own DSC-P9 cannot bee mounted anymore.
With 2.4.22-pre3 I get upon plugging it in:

Jul  6 18:05:09 hummus kernel: uhci.c: root-hub INT complete: port1: 93 port2: 80 data: 2
Jul  6 18:05:09 hummus kernel: hub.c: port 1, portstatus 101, change 1, 12 Mb/s
Jul  6 18:05:09 hummus kernel: hub.c: port 1 connection change
Jul  6 18:05:09 hummus kernel: hub.c: port 1, portstatus 101, change 1, 12 Mb/s
Jul  6 18:05:09 hummus kernel: hub.c: port 1, portstatus 101, change 0, 12 Mb/s
Jul  6 18:05:09 hummus last message repeated 3 times
Jul  6 18:05:09 hummus kernel: hub.c: port 1, portstatus 103, change 0, 12 Mb/s
Jul  6 18:05:09 hummus kernel: hub.c: new USB device 00:05.2-1, assigned address 7
Jul  6 18:05:09 hummus kernel: usb.c: kmalloc IF c32f14e0, numif 1
Jul  6 18:05:09 hummus kernel: usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
Jul  6 18:05:09 hummus kernel: usb.c: USB device number 7 default language ID 0x409
Jul  6 18:05:09 hummus kernel: Manufacturer: Sony
Jul  6 18:05:09 hummus kernel: Product: Sony DSC
Jul  6 18:05:09 hummus kernel: usb-storage: act_altsettting is 0
Jul  6 18:05:09 hummus kernel: usb-storage: id_index calculated to be: 30
Jul  6 18:05:09 hummus kernel: usb-storage: Array length appears to be: 106
Jul  6 18:05:09 hummus kernel: usb-storage: Vendor: Sony
Jul  6 18:05:09 hummus kernel: usb-storage: Product: DSC-S30/S70/S75/505V/F505/F707/F717/P8
Jul  6 18:05:09 hummus kernel: usb-storage: USB Mass Storage device detected
Jul  6 18:05:09 hummus kernel: usb-storage: Endpoints: In: 0xc3aa16b4 Out: 0xc3aa16a0 Int: 0xc3aa16c8 (Period 255)
Jul  6 18:05:09 hummus kernel: usb-storage: Found existing GUID 054c00100000000000000000
Jul  6 18:05:09 hummus kernel: WARNING: USB Mass Storage data integrity not assured
Jul  6 18:05:09 hummus kernel: USB Mass Storage device found at 7
Jul  6 18:05:09 hummus kernel: usb.c: usb-storage driver claimed interface c32f14e0
Jul  6 18:05:09 hummus kernel: usb.c: kusbd: /sbin/hotplug add 7
Jul  6 18:05:09 hummus kernel: hub.c: port 2, portstatus 100, change 0, 12 Mb/s

and then:

# mount /camera
mount: wrong fs type, bad option, bad superblock on /dev/sda1,
       or too many mounted file systems

Which is reflected in the log as:

Jul  6 18:06:14 hummus kernel: usb-storage: queuecommand() called
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread awakened.
Jul  6 18:06:14 hummus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jul  6 18:06:14 hummus kernel: usb-storage: 00 00 00 00 00 00 0e 00 02 00 00 00
Jul  6 18:06:14 hummus kernel: usb-storage: Invoking Mode Translation
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: -- CB transport device requiring auto-sense
Jul  6 18:06:14 hummus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul  6 18:06:14 hummus kernel: usb-storage: CB data stage result is 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: -- Result from auto-sense is 0
Jul  6 18:06:14 hummus kernel: usb-storage: -- code: 0x70, key: 0x0, ASC: 0x0, ASCQ: 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: No Sense: no additional sense information
Jul  6 18:06:14 hummus kernel: usb-storage: scsi cmd done, result=0x0
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread sleeping.
Jul  6 18:06:14 hummus kernel: usb-storage: queuecommand() called
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread awakened.
Jul  6 18:06:14 hummus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jul  6 18:06:14 hummus kernel: usb-storage: 00 00 00 00 00 00 00 00 00 00 00 00
Jul  6 18:06:14 hummus kernel: usb-storage: Invoking Mode Translation
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: -- CB transport device requiring auto-sense
Jul  6 18:06:14 hummus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul  6 18:06:14 hummus kernel: usb-storage: CB data stage result is 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: -- Result from auto-sense is 0
Jul  6 18:06:14 hummus kernel: usb-storage: -- code: 0x70, key: 0x0, ASC: 0x0, ASCQ: 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: No Sense: no additional sense information
Jul  6 18:06:14 hummus kernel: usb-storage: scsi cmd done, result=0x0
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread sleeping.
Jul  6 18:06:14 hummus kernel: usb-storage: queuecommand() called
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread awakened.
Jul  6 18:06:14 hummus kernel: usb-storage: Command READ_10 (10 bytes)
Jul  6 18:06:14 hummus kernel: usb-storage: 28 00 00 00 00 19 00 00 01 00 00 00
Jul  6 18:06:14 hummus kernel: usb-storage: Invoking Mode Translation
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 10
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): xfer 512 bytes
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 512/512
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul  6 18:06:14 hummus kernel: usb-storage: CB data stage result is 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: -- CB transport device requiring auto-sense
Jul  6 18:06:14 hummus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul  6 18:06:14 hummus kernel: usb-storage: CB data stage result is 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: -- Result from auto-sense is 0
Jul  6 18:06:14 hummus kernel: usb-storage: -- code: 0x70, key: 0x0, ASC: 0x0, ASCQ: 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: No Sense: no additional sense information
Jul  6 18:06:14 hummus kernel: usb-storage: scsi cmd done, result=0x0
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread sleeping.
Jul  6 18:06:14 hummus kernel: FAT: bogus logical sector size 65535
Jul  6 18:06:14 hummus kernel: VFS: Can't find a valid FAT filesystem on dev 08:01.
Jul  6 18:06:14 hummus kernel: usb-storage: queuecommand() called
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread awakened.
Jul  6 18:06:14 hummus kernel: usb-storage: Command TEST_UNIT_READY (6 bytes)
Jul  6 18:06:14 hummus kernel: usb-storage: 00 00 00 00 00 00 00 00 00 ef fa cb
Jul  6 18:06:14 hummus kernel: usb-storage: Invoking Mode Translation
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: -- CB transport device requiring auto-sense
Jul  6 18:06:14 hummus kernel: usb-storage: Issuing auto-REQUEST_SENSE
Jul  6 18:06:14 hummus kernel: usb-storage: Call to usb_stor_control_msg() returned 6
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
Jul  6 18:06:14 hummus kernel: usb-storage: usb_stor_transfer_partial(): transfer complete
Jul  6 18:06:14 hummus kernel: usb-storage: CB data stage result is 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: -- Result from auto-sense is 0
Jul  6 18:06:14 hummus kernel: usb-storage: -- code: 0x70, key: 0x0, ASC: 0x0, ASCQ: 0x0
Jul  6 18:06:14 hummus kernel: usb-storage: No Sense: no additional sense information
Jul  6 18:06:14 hummus kernel: usb-storage: scsi cmd done, result=0x0
Jul  6 18:06:14 hummus kernel: usb-storage: *** thread sleeping.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
AIM: ralfpostfix
