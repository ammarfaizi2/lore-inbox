Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266044AbRGJJQg>; Tue, 10 Jul 2001 05:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266079AbRGJJQ1>; Tue, 10 Jul 2001 05:16:27 -0400
Received: from ns.tasking.nl ([195.193.207.2]:23563 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S266044AbRGJJQL>;
	Tue, 10 Jul 2001 05:16:11 -0400
Date: Tue, 10 Jul 2001 11:14:17 +0200
From: Dick Streefland <dick.streefland@tasking.com>
To: linux-kernel@vger.kernel.org
Subject: nosmp kernel parameter problems
Message-ID: <20010710111417.A2532@kemi.tasking.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i (Linux)
Organization: TASKING Software BV, Amersfoort, The Netherlands
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running kernel 2.4.6 on a dual Pentium system. When I boot the SMP
kernel with the "nosmp" kernel parameter, The SCSI and USB systems
stop working.

This is the SCSI driver:
Jul  9 20:56:23 two kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.13 
Jul  9 20:56:23 two kernel:         <Adaptec aic7890/91 Ultra2 SCSI adapter> 
Jul  9 20:56:23 two kernel:         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/255 SCBs 

During the bus probe, I get the following sequence of messages for every ID:
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Attempting to queue an ABORT message 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Command already completed 
Jul  9 20:51:13 two kernel: aic7xxx_abort returns 8194 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Attempting to queue an ABORT message 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Command already completed 
Jul  9 20:51:13 two kernel: aic7xxx_abort returns 8194 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Attempting to queue a TARGET RESET message 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Is not an active device 
Jul  9 20:51:13 two kernel: aic7xxx_dev_reset returns 8194 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Attempting to queue an ABORT message 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Command already completed 
Jul  9 20:51:13 two kernel: aic7xxx_abort returns 8194 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Attempting to queue an ABORT message 
Jul  9 20:51:13 two kernel: scsi0:0:0:0: Command already completed 
Jul  9 20:51:13 two kernel: aic7xxx_abort returns 8194 
Jul  9 20:51:13 two kernel: scsi: device set offline - not ready or command retry failed after bus reset: host 0 channel 0 id 0 lun 0 

And here are the USB messages:
Jul  9 20:51:20 two kernel: usb.c: registered new driver usbdevfs 
Jul  9 20:51:20 two kernel: usb.c: registered new driver hub 
Jul  9 20:51:20 two kernel: usb-uhci.c: $Revision: 1.259 $ time 23:33:45 Jul  5 2001 
Jul  9 20:51:20 two kernel: usb-uhci.c: High bandwidth mode enabled 
Jul  9 20:51:20 two kernel: usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 19 
Jul  9 20:51:20 two kernel: usb-uhci.c: Detected 2 ports 
Jul  9 20:51:20 two kernel: usb.c: new USB bus registered, assigned bus number 1 
Jul  9 20:51:20 two kernel: Product: USB UHCI Root Hub 
Jul  9 20:51:20 two kernel: SerialNumber: e000 
Jul  9 20:51:20 two kernel: hub.c: USB hub found 
Jul  9 20:51:20 two kernel: hub.c: 2 ports detected 
Jul  9 20:51:21 two kernel: usb-uhci.c: v1.251:USB Universal Host Controller Interface driver 
Jul  9 20:51:21 two kernel: usb.c: registered new driver hid 
Jul  9 20:51:21 two kernel: hid.c: v1.16:USB HID support drivers 
Jul  9 20:51:21 two kernel: usb.c: registered new driver usbscanner 
Jul  9 20:51:21 two kernel: scanner.c: USB Scanner support registered. 
Jul  9 20:51:21 two kernel: usb.c: registered new driver usblp 
Jul  9 20:51:21 two kernel: printer.c: v0.8:USB Printer Device Class driver 
...
Jul  9 20:51:21 two kernel: hub.c: USB new device connect on bus1/1, assigned device number 2 
Jul  9 20:51:21 two kernel: usb_control/bulk_msg: timeout 
Jul  9 20:51:21 two kernel: usb.c: USB device not accepting new address=2 (error=-110) 
Jul  9 20:51:21 two kernel: hub.c: USB new device connect on bus1/1, assigned device number 3 
Jul  9 20:51:21 two kernel: Adding Swap: 131064k swap-space (priority -1) 
Jul  9 20:51:21 two kernel: usb_control/bulk_msg: timeout 
Jul  9 20:51:21 two kernel: usb.c: USB device not accepting new address=3 (error=-110) 
Jul  9 20:51:21 two kernel: hub.c: USB new device connect on bus1/2, assigned device number 4 
Jul  9 20:51:21 two kernel: eth0: Setting Rx mode to 1 addresses. 
Jul  9 20:51:21 two kernel: usb_control/bulk_msg: timeout 
Jul  9 20:51:21 two kernel: usb.c: USB device not accepting new address=4 (error=-110) 
Jul  9 20:51:21 two kernel: hub.c: USB new device connect on bus1/2, assigned device number 5 
Jul  9 20:51:21 two kernel: eth0: Setting Rx mode to 2 addresses. 
Jul  9 20:51:21 two kernel: usb_control/bulk_msg: timeout 
Jul  9 20:51:21 two kernel: usb.c: USB device not accepting new address=5 (error=-110) 

There should be two devices on the USB bus:
Jul  9 20:56:27 two kernel: hub.c: USB new device connect on bus1/1, assigned device number 2 
Jul  9 20:56:27 two kernel: Manufacturer: Logitech 
Jul  9 20:56:27 two kernel: Product: USB Mouse 
Jul  9 20:56:27 two kernel: mouse0: PS/2 mouse device for input0 
Jul  9 20:56:27 two kernel: input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0 
Jul  9 20:56:27 two kernel: hub.c: USB new device connect on bus1/2, assigned device number 3 
Jul  9 20:56:27 two kernel: Product: Camera 
Jul  9 20:56:27 two kernel: usb.c: USB device 3 (vend/prod 0x46d/0x870) is not claimed by any active driver. 

-- 
Dick Streefland                      ////            TASKING Software BV
dick.streefland@tasking.com         (@ @)         http://www.tasking.com
--------------------------------oOO--(_)--OOo---------------------------
