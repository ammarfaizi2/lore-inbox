Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279567AbRJXTLC>; Wed, 24 Oct 2001 15:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279556AbRJXTKw>; Wed, 24 Oct 2001 15:10:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37810 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S279567AbRJXTKr>;
	Wed, 24 Oct 2001 15:10:47 -0400
Message-ID: <3BD7076E.EF6AB04@arpa.org>
Date: Wed, 24 Oct 2001 11:24:46 -0700
From: erik-lkml@arpa.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: usb interface to Toshiba PDR-M4 cam hasn't worked since 2.4.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there's a usb list this would be more appropriate in, please let me
know.

I have a Toshiba PDR-M4 digital camera with USB interface, which
appeared as
a scsi device attached with usb-storage in linux-2.4.5, but hasn't
worked in
any kernel since then.  Here's a snippet from dmesg from 2.4.5, with a
successful negotiation with the camera (and its 128MB smart media card).
The
usbcore, usb-uhci, usb-storage, and sd modules are already loaded at
this point.

 usb-uhci.c: v1.251 Georg Acher, Deti Fliegl, Thomas Sailer, Roman
Weissgaerber
 usb-uhci.c: USB Universal Host Controller Interface driver
 hub.c: USB new device connect on bus1/1, assigned device number 2
 usb.c: USB device 2 (vend/prod 0x1132/0x4331) is not claimed by any
active driver.
 Initializing USB Mass Storage driver...
 usb.c: registered new driver usb-storage
 usb-uhci.c: interrupt, status 2, frame# 1366
 scsi0 : SCSI emulation for USB Mass Storage devices
   Vendor: TOSHIBA   Model: PDR               Rev: 1.00
   Type:   Direct-Access                      ANSI SCSI revision: 02
 Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 0
 SCSI device sda: 256000 512-byte hdwr sectors (131 MB)
 sda: Write Protect is off
  /dev/scsi/host0/bus0/target0/lun0: p1
 WARNING: USB Mass Storage data integrity not assured
 USB Mass Storage device found at 2
 USB Mass Storage support registered.

And here's dmesg output from the same operation with 2.4.13:

   * turn camera to 'data' mode *
 hub.c: port 2 connection change
 hub.c: port 2, portstatus 101, change 1, 12 Mb/s
 hub.c: port 2, portstatus 103, change 0, 12 Mb/s
 hub.c: USB new device connect on bus1/2, assigned device number 6
   * 4-second pause *
 usb_control/bulk_msg: timeout
 usb.c: USB device not accepting new address=6 (error=-110)
 hub.c: port 2, portstatus 103, change 0, 12 Mb/s
 hub.c: USB new device connect on bus1/2, assigned device number 7
   * 4-second pause *
 usb_control/bulk_msg: timeout
 usb.c: USB device not accepting new address=7 (error=-110)

And no more messages until I turn off or disconnect the camera.  It
never
procedes to initialize usb-storage on this device.

The same errors ("usb_control/bulk_msg: timeout" and "USB device not
accepting
new address=7 (error=-110)") have occurred with every kernel since 2.4.6
when
I attempt to attach this camera.  I don't believe it ever worked with
2.2.18/.19
either, but it did work with 2.2.17 with Alan's usb patches.

-Erik Schorr
