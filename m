Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbUKWIKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUKWIKp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 03:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUKWIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 03:10:44 -0500
Received: from relay-9.cs.interbusiness.it ([151.99.250.89]:18456 "EHLO
	relay-9.cs.interbusiness.it") by vger.kernel.org with ESMTP
	id S262325AbUKWIJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 03:09:13 -0500
From: "Andrea Pusceddu" <a.pusceddu@remosa-valves.com>
Organization: Remosa SpA | www.remosa-valves.com
To: linux-kernel@vger.kernel.org
Date: Tue, 23 Nov 2004 09:05:50 +0100
MIME-Version: 1.0
Subject: USB pendrive: works on kernel 2.4.x but not on 2.6.8
Reply-to: a.pusceddu@remosa-valves.com
Message-ID: <41A2FD6E.5197.39F0BC@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not able to mount a 256 MB USB pendrive (MP3) using Ubuntu Linux, with kernel 
2.6.8. However, on the same PC (AMD K6II 400) the pendrive works perfectly with a 
Debian Woody and a Knoppix, which are based on a kernel 2.4.xx. 
So I guess that there's no HW incompatibilty between Linux and my HW.

The usb chipsetis:
vendor ID 	0x66f (Sigmatel Inc)
chipset ID : 	0x8000 

After plugging the usb pen, all the correct modules get loaded, but then nothing 
happens: in /dev/ no sdaN or sgN device are created.
I have the feeling that the usb-storage module, hangs, because when I unplug the pen, 
then I'm not longer to remove usb-storage: if I make "modprobe -r usb-storage" the 
console hangs. Or may be the culprit is some other module that gets called by usb-
storage. (just guessing, here, my programming skills are at "helloworld.c" levels)


The hotplug service itself seems hanged, and I'm not even able to restart it manually.
When I unplug the pendrive, I have sometimes to remove the battery to reset it that 
otherwise is frozen. If I replug again the pendrive, nothing happens, i.e. in dmesg 
there's no indication of a new attempt of hw recognization


>From DMESG it seems that the kernel at first recognizes correctly the pendrive, then 
something weird happens:
----------------
[.......]
Buffer I/O error on device sda, logical block 0
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
unable to read partition table
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
hub 1-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
[.......]
----------------

(please finde a complete output in the bottom of the message)


I would be more than grateful to someone pointing me in the right direction. 
What puzzles me it that with a 2.4.x kernel I can mount the pendrive on /dev/sda1 and it 
works like a charm!!

Thank you for the time you spent reading my post, and sorry for my english.

Ciao, Andrea



FULL DMESG OUTPUT:
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Found IRQ 10 for device 0000:00:02.0
ohci_hcd 0000:00:02.0: ALi Corporation USB 1.1 Controller
ohci_hcd 0000:00:02.0: irq 10, pci mem e090b000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:0e.0
NET: Registered protocol family 10
Disabled Privacy Extensions on device c02cc0c0(lo)
IPv6 over IPv4 tunneling driver
acpi: Unknown symbol acpi_processor_unregister_performance
acpi: Unknown symbol acpi_processor_register_performance
ohci_hcd 0000:00:02.0: wakeup
usb 1-2: new full speed USB device using address 2
SCSI subsystem initialized
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
 Vendor: SigmaTel  Model: MSCN              Rev: 0100
 Type:   Direct-Access                      ANSI SCSI revision: 02
USB Mass Storage device found at 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
SCSI device sda: 505600 512-byte hdwr sectors (259 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
/dev/scsi/host0/bus0/target0/lun0:SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
SCSI error : <0 0 0 0> return code = 0x70000
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
unable to read partition table
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
hub 1-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
usb 1-2: USB disconnect, address 2
usb 1-2: new full speed USB device using address 3
scsi1 : SCSI emulation for USB Mass Storage devices

