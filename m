Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTLALrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 06:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTLALrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 06:47:14 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:63543 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S262094AbTLALq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 06:46:59 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: usb2 issues
Date: Mon, 1 Dec 2003 11:46:23 +0000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312011146.23719.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Whenever I load the ehci-hcd driver for my USB2 card, I get the following 
(kernel 2.4.22):

Dec  1 11:28:58 mwatts kernel: usb.c: USB disconnect on device 02:07.0-1 
address 2
Dec  1 11:29:19 mwatts kernel: ehci_hcd 02:07.2: VIA Technologies, Inc. USB 
2.0
Dec  1 11:29:19 mwatts kernel: ehci_hcd 02:07.2: irq 18, pci mem e0ab9c00
Dec  1 11:29:19 mwatts kernel: usb.c: new USB bus registered, assigned bus 
number 5
Dec  1 11:29:19 mwatts kernel: PCI: 02:07.2 PCI cache line size set 
incorrectly (64 bytes) by BIOS/FW.
Dec  1 11:29:19 mwatts kernel: PCI: 02:07.2 cache line size too large - 
expecting 32.
Dec  1 11:29:19 mwatts kernel: ehci_hcd 02:07.2: USB 2.0 enabled, EHCI 0.95, 
driver 2003-Jun-19/2.4
Dec  1 11:29:19 mwatts kernel: hub.c: USB hub found
Dec  1 11:29:19 mwatts kernel: hub.c: 4 ports detected

Is the stuff about the cache line normal?

Also, I get massive amounts of errors whenever I try and do anything to a 
20Gig drive connected via usb2 (fat32 filesystem)
If I simply unload the ehci-hcd driver, it works fine in usb1 on the same 
hardware (lspci -v follows).

02:07.0 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at ece0 [size=32]
        Capabilities: [80] Power Management version 2

02:07.1 USB Controller: VIA Technologies, Inc. USB (rev 50) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 64, IRQ 17
        I/O ports at ecc0 [size=32]
        Capabilities: [80] Power Management version 2

02:07.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51) (prog-if 20 
[EHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
        Flags: bus master, medium devsel, latency 64, IRQ 18
        Memory at fe9ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2





This is what happens when I plug in the drive:

Dec  1 11:37:03 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 2
Dec  1 11:37:03 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:03 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 3
Dec  1 11:37:03 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:04 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 4
Dec  1 11:37:04 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:04 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 5
Dec  1 11:37:04 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:05 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 6
Dec  1 11:37:05 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:05 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 7
Dec  1 11:37:05 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:06 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 8
Dec  1 11:37:06 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:06 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 9
Dec  1 11:37:06 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:07 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 10
Dec  1 11:37:07 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:07 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 11
Dec  1 11:37:07 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:08 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 12
Dec  1 11:37:08 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:08 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 13
Dec  1 11:37:08 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:09 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 14
Dec  1 11:37:09 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:09 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 15
Dec  1 11:37:09 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:10 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 16
Dec  1 11:37:10 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:37:10 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 17
Dec  1 11:37:10 mwatts kernel: scsi2 : SCSI emulation for USB Mass Storage 
devices
Dec  1 11:37:10 mwatts kernel:   Vendor: IC25N020  Model: ATMR04-0          
Rev: 0811
Dec  1 11:37:10 mwatts kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 02
Dec  1 11:37:10 mwatts kernel: Attached scsi disk sda at scsi2, channel 0, id 
0, lun 0
Dec  1 11:37:10 mwatts /etc/hotplug/scsi.agent: sd_mod allready loaded

Followed a few moments later by:

Dec  1 11:38:21 mwatts kernel: usb_control/bulk_msg: timeout
Dec  1 11:38:26 mwatts kernel: usb_control/bulk_msg: timeout
Dec  1 11:38:31 mwatts kernel: usb-storage: host_reset() requested but not 
implemented
Dec  1 11:38:41 mwatts kernel: scsi: device set offline - command error 
recover failed: host 2 channel 0 id 0 lun 0

As soon as I unplug the device, I get this:

Dec  1 11:39:19 mwatts kernel: sda: Unit Not Ready, error = 0x70000
Dec  1 11:39:19 mwatts kernel: sda : READ CAPACITY failed.
Dec  1 11:39:19 mwatts kernel: sda : status = 0, message = 00, host = 7, 
driver = 00
Dec  1 11:39:19 mwatts kernel: sda : sense not available.
Dec  1 11:39:19 mwatts kernel: sda : block size assumed to be 512 bytes, disk 
size 1GB.
Dec  1 11:39:19 mwatts kernel:  /dev/scsi/host2/bus0/target0/lun0: I/O error: 
dev 08:00, sector 0
Dec  1 11:39:19 mwatts kernel:  I/O error: dev 08:00, sector 0
Dec  1 11:39:19 mwatts kernel:  I/O error: dev 08:00, sector 2097144
Dec  1 11:39:19 mwatts kernel:  I/O error: dev 08:00, sector 2097144
Dec  1 11:39:19 mwatts kernel:  I/O error: dev 08:00, sector 0
Dec  1 11:39:19 mwatts kernel:  I/O error: dev 08:00, sector 0
Dec  1 11:39:19 mwatts kernel: ldm_validate_partition_table(): Disk read 
failed.
Dec  1 11:39:19 mwatts kernel:  I/O error: dev 08:00, sector 0
Dec  1 11:39:19 mwatts kernel:  unable to read partition table
Dec  1 11:39:19 mwatts kernel: WARNING: USB Mass Storage data integrity not 
assured
Dec  1 11:39:19 mwatts kernel: USB Mass Storage device found at 17
Dec  1 11:39:19 mwatts kernel: usb.c: USB disconnect on device 02:07.2-1 
address 17
Dec  1 11:39:22 mwatts /etc/hotplug/usb.agent: Setup usb-storage for USB 
product 5e3/702/2




Interestingly, the first time I plug the device in, I get the following:

Dec  1 11:43:00 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 2
Dec  1 11:43:00 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:43:00 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 3
Dec  1 11:43:00 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:43:01 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 4
Dec  1 11:43:01 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:43:01 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 5
Dec  1 11:43:01 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:43:02 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 6
Dec  1 11:43:02 mwatts kernel: usb.c: USB device not responding, giving up 
(error=-71)
Dec  1 11:43:02 mwatts kernel: hub.c: new USB device 02:07.2-1, assigned 
address 7
Dec  1 11:43:02 mwatts kernel: usb.c: USB device 7 (vend/prod 0x5e3/0x702) is 
not claimed by any active driver.
Dec  1 11:43:05 mwatts /etc/hotplug/usb.agent: Setup usb-storage for USB 
product 5e3/702/2
Dec  1 11:43:06 mwatts kernel: Initializing USB Mass Storage driver...
Dec  1 11:43:06 mwatts kernel: usb.c: registered new driver usb-storage
Dec  1 11:43:06 mwatts kernel: scsi2 : SCSI emulation for USB Mass Storage 
devices
Dec  1 11:43:06 mwatts kernel:   Vendor: IC25N020  Model: ATMR04-0          
Rev: 0811
Dec  1 11:43:06 mwatts kernel:   Type:   Direct-Access                      
ANSI SCSI revision: 02
Dec  1 11:43:06 mwatts kernel: Attached scsi disk sda at scsi2, channel 0, id 
0, lun 0
Dec  1 11:43:06 mwatts kernel: SCSI device sda: 39070080 512-byte hdwr sectors 
(20004 MB)
Dec  1 11:43:06 mwatts /etc/hotplug/scsi.agent: sd_mod allready loaded
Dec  1 11:43:06 mwatts kernel:  /dev/scsi/host2/bus0/target0/lun0: p1
Dec  1 11:43:06 mwatts kernel: WARNING: USB Mass Storage data integrity not 
assured
Dec  1 11:43:06 mwatts kernel: USB Mass Storage device found at 7
Dec  1 11:43:06 mwatts kernel: USB Mass Storage support registered.
Dec  1 11:43:06 mwatts /etc/hotplug/usb.agent: Module setup usb-storage for 
USB product 5e3/702/2
Dec  1 11:43:06 mwatts /etc/hotplug/usb/usb-storage: Load scsimon
Dec  1 11:43:06 mwatts /etc/hotplug/usb/usb-storage: scsimon allready loaded

After a few more errors, the drive will eventually be marked offline again.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/yyoPBn4EFUVUIO0RAinoAJ9ArI7yq8ThSqRn+3XvpT029q9wCgCg+wcv
RcVoh12fuYy9PncADYx6owc=
=E3wm
-----END PGP SIGNATURE-----

