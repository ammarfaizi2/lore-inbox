Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264687AbUDVVdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbUDVVdq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbUDVVdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:33:46 -0400
Received: from ulysses.news.tiscali.de ([195.185.185.36]:64773 "EHLO
	ulysses.news.tiscali.de") by vger.kernel.org with ESMTP
	id S264687AbUDVVdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:33:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Andreas Weber <and_weber_and@web.de>
Newsgroups: linux.kernel
Subject: problems with usb mass storage flash memory
Date: Thu, 22 Apr 2004 23:39:24 +0200
Organization: Tiscali Germany
Message-ID: <c69dnb$1mm2$1@ulysses.news.tiscali.de>
NNTP-Posting-Host: p213.54.193.31.tisdip.tiscali.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: ulysses.news.tiscali.de 1082669612 56002 213.54.193.31 (22 Apr 2004 21:33:32 GMT)
X-Complaints-To: abuse@tiscali.de
NNTP-Posting-Date: Thu, 22 Apr 2004 21:33:32 +0000 (UTC)
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I had/have problems with my usb flash memory devices (a Verbatim 32MB usb
stick and a NOKIA 5510 Mobilephone/mp3 Player)
I am able to mount both devices and copy small files (<100KB) to them. A
subsequent sync/umount works. If I copy larger files (>=1MB) the cp works
but a sync/umount takes forever and my syslog gets filled with SCSI errors.
(tested under 2.6.5, 2.6.5-mm6, 2.6.6-rc1 and 2.6.6-rc2 with the
anticipatory io scheduler as well as the cfq)
After appling the patch from

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108238832020721&q=raw

things are working with the Verbatim 32MB usb stick. The NOKIA is still
broken. 

Under linux 2.4.25 both devices are working (with the uhci as well as the
usb-uhci module)
I think kernel 2.6 uses the uhci driver so my log output under 2.4 was
created using this one.

Here is the output from patched 2.6.6-rc2:
<--------------------------snip------------------------------>
Apr 22 22:21:22 mobilin kernel: usb 1-1: new full speed USB device using
address 3
Apr 22 22:21:22 mobilin kernel: SCSI subsystem initialized
Apr 22 22:21:22 mobilin kernel: Initializing USB Mass Storage driver...
Apr 22 22:21:22 mobilin kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Apr 22 22:21:22 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 22 22:21:22 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 22 22:21:22 mobilin usb.agent[2545]:      usb-storage: loaded
sucessfully
Apr 22 22:21:22 mobilin kernel: USB Mass Storage device found at 3
Apr 22 22:21:22 mobilin kernel: usbcore: registered new driver usb-storage
Apr 22 22:21:22 mobilin kernel: USB Mass Storage support registered.
Apr 22 22:21:23 mobilin scsi.agent[2579]: disk
at /devices/pci0000:00/0000:00:07.2/usb1/1-1/1-1:1.0/host0/0:0:0:0
Apr 22 22:21:23 mobilin kernel: SCSI device sda: 124896 512-byte hdwr
sectors (64 MB)
Apr 22 22:21:23 mobilin kernel: sda: assuming Write Enabled
Apr 22 22:21:23 mobilin kernel: sda: assuming drive cache: write through
Apr 22 22:21:23 mobilin kernel: Device not ready.  Make sure there is a disc
in the drive.
Apr 22 22:21:23 mobilin kernel:  sda: sda1
Apr 22 22:21:23 mobilin kernel: Device not ready.  Make sure there is a disc
in the drive.
Apr 22 22:21:23 mobilin kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Apr 22 22:21:24 mobilin udev[2621]: creating device node '/dev/sda'
Apr 22 22:21:24 mobilin udev[2622]: creating device node '/dev/sda1'
Apr 22 22:21:31 mobilin kernel: Device not ready.  Make sure there is a disc
in the drive.
Apr 22 22:22:12 mobilin last message repeated 3 times
Apr 22 22:22:32 mobilin last message repeated 7 times
Apr 22 22:26:53 mobilin kernel: SCSI error : <0 0 0 0> return code =
0x6000000
Apr 22 22:26:53 mobilin kernel: end_request: I/O error, dev sda, sector 319
Apr 22 22:26:53 mobilin kernel: Buffer I/O error on device sda1, logical
block 288
Apr 22 22:26:53 mobilin kernel: lost page write due to I/O error on sda1
Apr 22 22:27:43 mobilin kernel: SCSI error : <0 0 0 0> return code =
0x6000000
Apr 22 22:27:43 mobilin kernel: end_request: I/O error, dev sda, sector 320
Apr 22 22:27:43 mobilin kernel: Buffer I/O error on device sda1, logical
block 289
Apr 22 22:27:43 mobilin kernel: lost page write due to I/O error on sda1
Apr 22 22:28:33 mobilin kernel: SCSI error : <0 0 0 0> return code =
0x6000000
Apr 22 22:28:33 mobilin kernel: end_request: I/O error, dev sda, sector 321
Apr 22 22:28:33 mobilin kernel: Buffer I/O error on device sda1, logical
block 290
Apr 22 22:28:33 mobilin kernel: lost page write due to I/O error on sda1
Apr 22 22:29:23 mobilin kernel: SCSI error : <0 0 0 0> return code =
0x6000000
Apr 22 22:29:23 mobilin kernel: end_request: I/O error, dev sda, sector 322
Apr 22 22:29:23 mobilin kernel: Buffer I/O error on device sda1, logical
block 291
Apr 22 22:29:23 mobilin kernel: lost page write due to I/O error on sda1
<------------------------------------------snap----------------------------------------------->

For comparison the same thing under 2.4.25 where things are working:
<-----------------------------------------snip------------------------------------------------>
Apr 22 22:12:35 mobilin kernel: hub.c: new USB device 00:07.2-1, assigned
address 3
Apr 22 22:12:35 mobilin kernel: usb.c: USB device 3 (vend/prod 0x421/0x404)
is not claimed by any active driver.
Apr 22 22:12:38 mobilin kernel: SCSI subsystem driver Revision: 1.00
Apr 22 22:12:38 mobilin kernel: Initializing USB Mass Storage driver...
Apr 22 22:12:38 mobilin kernel: usb.c: registered new driver usb-storage
Apr 22 22:12:43 mobilin kernel: usb_control/bulk_msg: timeout
Apr 22 22:12:43 mobilin kernel: scsi0 : SCSI emulation for USB Mass Storage
devices
Apr 22 22:12:43 mobilin kernel:   Vendor: Nokia     Model: 5510             
Rev: 0001
Apr 22 22:12:43 mobilin kernel:   Type:   Direct-Access                     
ANSI SCSI revision: 02
Apr 22 22:12:43 mobilin kernel: WARNING: USB Mass Storage data integrity not
assured
Apr 22 22:12:43 mobilin kernel: USB Mass Storage device found at 3
Apr 22 22:12:43 mobilin kernel: USB Mass Storage support registered.
Apr 22 22:12:43 mobilin usb.agent[911]:      usb-storage: loaded sucessfully
Apr 22 22:12:49 mobilin kernel: Attached scsi removable disk sda at scsi0,
channel 0, id 0, lun 0
Apr 22 22:12:49 mobilin kernel: SCSI device sda: 124896 512-byte hdwr
sectors (64 MB)
Apr 22 22:12:49 mobilin kernel: sda: test WP failed, assume Write Enabled
Apr 22 22:12:49 mobilin kernel:  sda: sda1
Apr 22 22:12:50 mobilin kernel: Device not ready.  Make sure there is a disc
in the drive.
Apr 22 22:13:06 mobilin last message repeated 3 times
Apr 22 22:13:11 mobilin kernel: usb.c: USB disconnect on device 00:07.2-1
address 3
<--------------------------------snap------------------------------------->

The NOKIA 5510 seems a bit strage. A fdisk /dev/sda and a "p" (print
partition table) under 2.4.25 shows:
Disk /dev/sda: 63 MB, 63946752 bytes
8 heads, 32 sectors/track, 487 cylinders
Units = cylinders of 256 * 512 = 131072 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1         489       62576    6  FAT16
Partition 1 has different physical/logical beginnings (non-Linux?):
     phys=(0, 1, 1) logical=(0, 0, 32)
Partition 1 has different physical/logical endings:
     phys=(488, 7, 32) logical=(488, 7, 31)

The creation of a new partiontable seems to work (a fdisk "w" complete
without errors) but a subsequent fdisk /dev/sda and a "p" prints the same
as before.

Any Ideas?

Regards
Andreas Weber
