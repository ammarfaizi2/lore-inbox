Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWFUCyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWFUCyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 22:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWFUCyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 22:54:32 -0400
Received: from web33007.mail.mud.yahoo.com ([68.142.206.71]:62136 "HELO
	web33007.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750884AbWFUCyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 22:54:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5hDdA7LIw4D2xd133W5mM+HjArnQTDXu1vXA+FMK75kt+eVBvO3v/HMO1yGsQ0ndmZHblN3A56Ge86DbKzJUAA2zfXoKn2lLLx5MuaIZ3yoRZmx9BespfmVKnzCb8jecAQKqY6E1chtgMCw+KrM+Foe4jd3jEo0U7tgvA37Bv40=  ;
Message-ID: <20060621025431.31837.qmail@web33007.mail.mud.yahoo.com>
Date: Tue, 20 Jun 2006 19:54:31 -0700 (PDT)
From: Stephen Cameron <smcameron@yahoo.com>
Subject: Re: Problem with Sandisk USB CF reader on 2.6.16.20
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete wrote:

> I suppose you kept 2.6.16.11 around. So why don't you do the same
> things on both, collect dmesg output with "dmesg > /tmp/11",
> then diff them with diff -u /tmp/11 /tmp/20. That ought to show
> something.

Ok.  But first let me diff my .configs, in case I failed to 
remember some screwup I did:

--- linux-2.6.16.11/.config     2006-06-08 21:00:00.000000000 -0500
+++ linux-2.6.16.20/.config     2006-06-10 13:06:24.000000000 -0500
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16.11
-# Thu Jun  8 21:00:00 2006
+# Linux kernel version: 2.6.16.20
+# Sat Jun 10 13:06:24 2006
 #
 CONFIG_X86_32=y
 CONFIG_SEMAPHORE_SLEEPERS=y

Er, no, I guess they do seem pretty similar.

Ok, here's the dmesg diffs.

I plugged in the Sandisk usb compaqt flash
card reader (with a valid CF with a filesystem
on it), then when that didn't work, I took it
out, and plugged in a Lexar thumb drive -- which
also didn't work with 2.6.16.20. 

Then booted up 2.6.16.11, and plugged in the Sandisk,
and it worked.  Plugged in the lexar, and it worked
too.

Here's the dmesg diff:
[scameron@zuul ~]$ cat dmesg_diffs.txt
--- dmesg.11.txt        2006-06-20 16:21:05.000000000 -0500
+++ dmesg.20.txt        2006-06-20 16:16:03.000000000 -0500
@@ -1,4 +1,24 @@
-ivers/usb/core/inode.c: creating file '001'
+pports S0 S1 S3 S4 S5)
+Freeing unused kernel memory: 168k freed
+input: ImPS/2 Generic Wheel Mouse as /class/input/input1
+ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800004d8682]
+ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
+PCI: setting IRQ 11 as level-triggered
+ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
+ALSA
/home/scameron/software/alsa-driver-1.0.11/pci/emu10k1/../../alsa-kernel/pci/emu10k1/emu10k1_main.c:186:
Audigy2 value: Special config.
+ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
+PCI: setting IRQ 10 as level-triggered
+ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
+usbcore: registered new driver usbfs
+usbcore: registered new driver hub
+ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
+ACPI: PCI Interrupt 0000:00:10.4[C] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
+ehci_hcd 0000:00:10.4: EHCI Host Controller
+ehci_hcd 0000:00:10.4: reset hcs_params 0x4208 dbg=0 cc=4 pcc=2 ordered !ppc ports=8
+ehci_hcd 0000:00:10.4: reset hcc_params 6872 thresh 7 uframes 256/512/1024
+ehci_hcd 0000:00:10.4: MWI active
+drivers/usb/core/inode.c: creating file 'devices'
+drivers/usb/core/inode.c: creating file '001'
 ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 1
 ehci_hcd 0000:00:10.4: irq 11, io mem 0xeb001000
 ehci_hcd 0000:00:10.4: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
@@ -7,7 +27,7 @@
 usb usb1: default language 0x0409
 usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb1: Product: EHCI Host Controller
-usb usb1: Manufacturer: Linux 2.6.16.11 ehci_hcd
+usb usb1: Manufacturer: Linux 2.6.16.20 ehci_hcd
 usb usb1: SerialNumber: 0000:00:10.4
 usb usb1: uevent
 usb usb1: device is self-powered
@@ -31,7 +51,7 @@
 hub 1-0:1.0: port 7, status 0501, change 0001, 480 Mb/s
 USB Universal Host Controller Interface driver v2.3
 ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
-PCI: Via IRQ fixup for 0000:00:10.0, from 255 to 10
+PCI: VIA IRQ fixup for 0000:00:10.0, from 255 to 10
 uhci_hcd 0000:00:10.0: UHCI Host Controller
 uhci_hcd 0000:00:10.0: detected 2 ports
 uhci_hcd 0000:00:10.0: uhci_check_and_reset_hc: cmd = 0x0000
@@ -42,7 +62,7 @@
 usb usb2: default language 0x0409
 usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb2: Product: UHCI Host Controller
-usb usb2: Manufacturer: Linux 2.6.16.11 uhci_hcd
+usb usb2: Manufacturer: Linux 2.6.16.20 uhci_hcd
 usb usb2: SerialNumber: 0000:00:10.0
 usb usb2: uevent
 usb usb2: device is self-powered
@@ -66,7 +86,7 @@
 uhci_hcd 0000:00:10.0: port 1 portsc 008a,00
 hub 2-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
 ACPI: PCI Interrupt 0000:00:10.1[A] -> Link [LNKA] -> GSI 10 (level, low) -> IRQ 10
-PCI: Via IRQ fixup for 0000:00:10.1, from 255 to 10
+PCI: VIA IRQ fixup for 0000:00:10.1, from 255 to 10
 uhci_hcd 0000:00:10.1: UHCI Host Controller
 uhci_hcd 0000:00:10.1: detected 2 ports
 uhci_hcd 0000:00:10.1: uhci_check_and_reset_hc: cmd = 0x0000
@@ -77,7 +97,7 @@
 usb usb3: default language 0x0409
 usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb3: Product: UHCI Host Controller
-usb usb3: Manufacturer: Linux 2.6.16.11 uhci_hcd
+usb usb3: Manufacturer: Linux 2.6.16.20 uhci_hcd
 usb usb3: SerialNumber: 0000:00:10.1
 usb usb3: uevent
 usb usb3: device is self-powered
@@ -99,7 +119,7 @@
 drivers/usb/core/inode.c: creating file '001'
 ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
 ACPI: PCI Interrupt 0000:00:10.2[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
-PCI: Via IRQ fixup for 0000:00:10.2, from 255 to 11
+PCI: VIA IRQ fixup for 0000:00:10.2, from 255 to 11
 uhci_hcd 0000:00:10.2: UHCI Host Controller
 uhci_hcd 0000:00:10.2: detected 2 ports
 uhci_hcd 0000:00:10.2: uhci_check_and_reset_hc: cmd = 0x0000
@@ -110,7 +130,7 @@
 usb usb4: default language 0x0409
 usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb4: Product: UHCI Host Controller
-usb usb4: Manufacturer: Linux 2.6.16.11 uhci_hcd
+usb usb4: Manufacturer: Linux 2.6.16.20 uhci_hcd
 usb usb4: SerialNumber: 0000:00:10.2
 usb usb4: uevent
 usb usb4: device is self-powered
@@ -131,27 +151,23 @@
 hub 3-0:1.0: state 7 ports 2 chg 0000 evt 0006
 uhci_hcd 0000:00:10.1: port 1 portsc 018a,00
 hub 3-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
-hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
-uhci_hcd 0000:00:10.1: port 2 portsc 018a,00
-hub 3-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
-hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
-hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
 drivers/usb/core/inode.c: creating file '001'
-uhci_hcd 0000:00:10.2: port 1 portsc 008a,00
-hub 4-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
 ACPI: PCI Interrupt 0000:00:10.3[B] -> Link [LNKB] -> GSI 11 (level, low) -> IRQ 11
-PCI: Via IRQ fixup for 0000:00:10.3, from 255 to 11
+PCI: VIA IRQ fixup for 0000:00:10.3, from 255 to 11
 uhci_hcd 0000:00:10.3: UHCI Host Controller
 uhci_hcd 0000:00:10.3: detected 2 ports
 uhci_hcd 0000:00:10.3: uhci_check_and_reset_hc: cmd = 0x0000
 uhci_hcd 0000:00:10.3: Performing full reset
+hub 3-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x300
+uhci_hcd 0000:00:10.1: port 2 portsc 018a,00
+hub 3-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
 drivers/usb/core/inode.c: creating file '005'
 uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 5
 uhci_hcd 0000:00:10.3: irq 11, io base 0x0000c000
 usb usb5: default language 0x0409
 usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
 usb usb5: Product: UHCI Host Controller
-usb usb5: Manufacturer: Linux 2.6.16.11 uhci_hcd
+usb usb5: Manufacturer: Linux 2.6.16.20 uhci_hcd
 usb usb5: SerialNumber: 0000:00:10.3
 usb usb5: uevent
 usb usb5: device is self-powered
@@ -167,18 +183,20 @@
 hub 5-0:1.0: individual port over-current protection
 hub 5-0:1.0: power on to power good time: 2ms
 hub 5-0:1.0: local power source is good
+hub 3-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
+hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0006
+uhci_hcd 0000:00:10.2: port 1 portsc 008a,00
+hub 4-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
+drivers/usb/core/inode.c: creating file '001'
 hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
 uhci_hcd 0000:00:10.2: port 2 portsc 008a,00
 hub 4-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
 hub 4-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
 hub 4-0:1.0: state 7 ports 2 chg 0000 evt 0000
-hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
-drivers/usb/core/inode.c: creating file '001'
+hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0006
 uhci_hcd 0000:00:10.3: port 1 portsc 009b,00
 hub 5-0:1.0: port 1, status 0101, change 0003, 12 Mb/s
-uhci_hcd 0000:00:10.0: suspend_rh (auto-stop)
 hub 5-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
-uhci_hcd 0000:00:10.1: suspend_rh (auto-stop)
 usb 5-1: new full speed USB device using uhci_hcd and address 2
 usb 5-1: ep0 maxpacket = 8
 usb 5-1: default language 0x0409
@@ -194,12 +212,14 @@
 drivers/usb/core/inode.c: creating file '002'
 uhci_hcd 0000:00:10.3: port 2 portsc 018a,00
 hub 5-0:1.0: port 2, status 0300, change 0003, 1.5 Mb/s
+uhci_hcd 0000:00:10.0: suspend_rh (auto-stop)
 hub 5-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x300
 hub 5-0:1.0: state 7 ports 2 chg 0000 evt 0000
-uhci_hcd 0000:00:10.2: suspend_rh (auto-stop)
+uhci_hcd 0000:00:10.1: suspend_rh (auto-stop)
 libusual 5-1:1.0: usb_probe_interface
 libusual 5-1:1.0: usb_probe_interface - got id
 usbcore: registered new driver libusual
+uhci_hcd 0000:00:10.2: suspend_rh (auto-stop)
 Initializing USB Mass Storage driver...
 usb-storage 5-1:1.0: usb_probe_interface
 usb-storage 5-1:1.0: usb_probe_interface - got id
@@ -239,49 +259,36 @@
 ehci_hcd 0000:00:10.4: port 5 high speed
 ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
 usb 1-5: new high speed USB device using ehci_hcd and address 3
+usb 1-5: khubd timed out on ep0in len=18/64
 ehci_hcd 0000:00:10.4: port 5 high speed
 ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
-usb 1-5: default language 0x0409
-usb 1-5: new device strings: Mfr=3, Product=4, SerialNumber=5
-usb 1-5: Product: ImageMate CF Reader/Writer
-usb 1-5: Manufacturer: SanDisk
-usb 1-5: SerialNumber: 0300979105
-usb 1-5: uevent
-usb 1-5: device is bus-powered
-usb 1-5: configuration #1 chosen from 1 choice
-usb 1-5: adding 1-5:1.0 (config #1, interface 0)
-usb 1-5:1.0: uevent
-libusual 1-5:1.0: usb_probe_interface
-libusual 1-5:1.0: usb_probe_interface - got id
-usb-storage 1-5:1.0: usb_probe_interface
-usb-storage 1-5:1.0: usb_probe_interface - got id
-scsi1 : SCSI emulation for USB Mass Storage devices
-usb-storage: device found at 3
-usb-storage: waiting for device to settle before scanning
-drivers/usb/core/inode.c: creating file '003'
-  Vendor: Generic   Model: STORAGE DEVICE    Rev: 9312
-  Type:   Direct-Access                      ANSI SCSI revision: 00
-SCSI device sde: 1001952 512-byte hdwr sectors (513 MB)
-sde: Write Protect is off
-sde: Mode Sense: 03 00 00 00
-sde: assuming drive cache: write through
-SCSI device sde: 1001952 512-byte hdwr sectors (513 MB)
-sde: Write Protect is off
-sde: Mode Sense: 03 00 00 00
-sde: assuming drive cache: write through
- sde: sde1
-sd 1:0:0:0: Attached scsi removable disk sde
-sd 1:0:0:0: Attached scsi generic sg4 type 0
-usb-storage: device scan complete
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: device not accepting address 3, error -110
+ehci_hcd 0000:00:10.4: port 5 high speed
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
+usb 1-5: new high speed USB device using ehci_hcd and address 4
+usb 1-5: khubd timed out on ep0in len=18/64
+ehci_hcd 0000:00:10.4: port 5 high speed
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: device not accepting address 4, error -110
+ehci_hcd 0000:00:10.4: port 5 high speed
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
+usb 1-5: new high speed USB device using ehci_hcd and address 5
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: device not accepting address 5, error -110
+ehci_hcd 0000:00:10.4: port 5 high speed
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
+usb 1-5: new high speed USB device using ehci_hcd and address 6
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: device not accepting address 6, error -110
 hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0020
 ehci_hcd 0000:00:10.4: GetStatus port 5 status 001002 POWER sig=se0 CSC
 hub 1-0:1.0: port 5, status 0100, change 0001, 12 Mb/s
-usb 1-5: USB disconnect, address 3
-usb 1-5: usb_disable_device nuking all URBs
-usb 1-5: unregistering interface 1-5:1.0
-usb 1-5:1.0: uevent
-usb 1-5: unregistering device
-usb 1-5: uevent
 hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x100
 hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0020
 ehci_hcd 0000:00:10.4: GetStatus port 5 status 001803 POWER sig=j CSC CONNECT
@@ -289,48 +296,21 @@
 hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
 ehci_hcd 0000:00:10.4: port 5 high speed
 ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
-usb 1-5: new high speed USB device using ehci_hcd and address 4
+usb 1-5: new high speed USB device using ehci_hcd and address 7
+usb 1-5: khubd timed out on ep0in len=18/64
 ehci_hcd 0000:00:10.4: port 5 high speed
 ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
-usb 1-5: default language 0x0409
-usb 1-5: new device strings: Mfr=1, Product=2, SerialNumber=3
-usb 1-5: Product: JD EXPRESSION
-usb 1-5: Manufacturer: LEXAR MEDIA
-usb 1-5: SerialNumber: 0A4EDA090804571
-usb 1-5: uevent
-usb 1-5: device is bus-powered
-usb 1-5: configuration #1 chosen from 1 choice
-usb 1-5: adding 1-5:1.0 (config #1, interface 0)
-usb 1-5:1.0: uevent
-libusual 1-5:1.0: usb_probe_interface
-libusual 1-5:1.0: usb_probe_interface - got id
-usb-storage 1-5:1.0: usb_probe_interface
-usb-storage 1-5:1.0: usb_probe_interface - got id
-scsi2 : SCSI emulation for USB Mass Storage devices
-usb-storage: device found at 4
-usb-storage: waiting for device to settle before scanning
-drivers/usb/core/inode.c: creating file '004'
-  Vendor: LEXAR     Model: JD EXPRESSION     Rev: 1.00
-  Type:   Direct-Access                      ANSI SCSI revision: 01 CCS
-SCSI device sde: 503808 512-byte hdwr sectors (258 MB)
-sde: Write Protect is off
-sde: Mode Sense: 23 00 00 00
-sde: assuming drive cache: write through
-SCSI device sde: 503808 512-byte hdwr sectors (258 MB)
-sde: Write Protect is off
-sde: Mode Sense: 23 00 00 00
-sde: assuming drive cache: write through
- sde: sde1
-sd 2:0:0:0: Attached scsi removable disk sde
-sd 2:0:0:0: Attached scsi generic sg4 type 0
-usb-storage: device scan complete
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: device not accepting address 7, error -110
+ehci_hcd 0000:00:10.4: port 5 high speed
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
+usb 1-5: new high speed USB device using ehci_hcd and address 8
+usb 1-5: khubd timed out on ep0in len=18/64
+ehci_hcd 0000:00:10.4: port 5 high speed
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001005 POWER sig=se0 PE CONNECT
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: khubd timed out on ep0out len=0/0
+usb 1-5: device not accepting address 8, error -110
+ehci_hcd 0000:00:10.4: GetStatus port 5 status 001000 POWER sig=se0
 hub 1-0:1.0: state 7 ports 8 chg 0000 evt 0020
-ehci_hcd 0000:00:10.4: GetStatus port 5 status 001002 POWER sig=se0 CSC
-hub 1-0:1.0: port 5, status 0100, change 0001, 12 Mb/s
-usb 1-5: USB disconnect, address 4
-usb 1-5: usb_disable_device nuking all URBs
-usb 1-5: unregistering interface 1-5:1.0
-usb 1-5:1.0: uevent
-usb 1-5: unregistering device
-usb 1-5: uevent
-hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x100





__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
