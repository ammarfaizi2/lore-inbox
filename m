Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284359AbRLRRvB>; Tue, 18 Dec 2001 12:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284361AbRLRRux>; Tue, 18 Dec 2001 12:50:53 -0500
Received: from daytona.gci.com ([205.140.80.57]:35088 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S284359AbRLRRuj>;
	Tue, 18 Dec 2001 12:50:39 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB4266@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] USB-Storage ZiO (Multitech) update (2.4.16)
Date: Tue, 18 Dec 2001 08:50:24 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The MultiTech, International ZiO CompactFlash reader for USB
has undergone some revisions which render it invisble to the driver.

The following patch brings the unit back into "visible" mode, but only
for rev 1.5 -- as that's what i've got for testing.  This is for 2.4.16,
but should apply to any recent kernel.

please cc any replies directly to me from the USB-devel list, as i'm not on
it..

<----------------->8 Cut Here
--- unusual_devs.h	Mon Dec 17 09:14:53 2001
+++ unusual_devs.h.las	Tue Dec 18 08:42:42 2001
@@ -154,6 +154,20 @@
 		"CD-RW Device",
 		US_SC_8020, US_PR_CB, NULL, 0),
 
+#ifdef CONFIG_USB_STORAGE_DPCM
+/* This allows this adapter to be recognized with Rev 0.05,
+    (which is labled rev 1.5 on the circuit board)
+   however the media is not seen as valid due to some driver
+   issues which are still being worked out.  Perhaps just
+   this little view will spurr some further work by others..
+   12/19/01 - Leif Sawyer <leif@gci.net> */
+UNUSUAL_DEV(  0x04e6, 0x1010, 0x0005, 0x0006, 
+		"Microtech",
+		"ZiO Flash Reader",
+ 		US_SC_SCSI, US_PR_DPCM_USB, NULL,
+		US_FL_SCM_MULT_TARG  | US_FL_IGNORE_SER ),
+#endif
+
 /* Reported by Bob Sass <rls@vectordb.com> -- only rev 1.33 tested */
 UNUSUAL_DEV(  0x050d, 0x0115, 0x0133, 0x0133,
 		"Belkin",
<----------------->8 Cut Here


Note that while it can now be detected reliably, the driver needs some
extra work done that I am not qualified to do.  See the log below for
details, if you grok this mail musing:

<-->8 Cut here for log
hub.c: port 2 connection change
hub.c: port 2, portstatus 101, change 1, 12 Mb/s
hub.c: port 2, portstatus 103, change 10, 12 Mb/s
hub.c: USB new device connect on bus1/1/2, assigned device number 24
usb.c: kmalloc IF cb962760, numif 1
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 24 default language ID 0x409
Manufacturer: SHUTTLE
Product: SCM Micro USBAT-02 
usb.c: unhandled interfaces on device
usb.c: kusbd: /sbin/hotplug add 24
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 19
usb-storage: Array length appears to be: 75
usb-storage: Vendor: Microtech
usb-storage: Product: ZiO Flash Reader
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xcc308fb4 Out: 0xcc308fc8 Int: 0xcc308fa0
(Period 5)
usb-storage: Result from usb_set_configuration is 0
usb-storage: New GUID 04e610100000000000000000
usb-storage: Transport: Control/Bulk-EUSB/SDDR09
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi2 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 03 00 60 d2 ec df
usb-storage: dpcm_transport: LUN=0
usb-storage: command_abort() called
usb-storage: Call to usb_stor_control_msg() returned -2
usb-storage: -- transport indicates command was aborted
usb-storage: Fixing INQUIRY data to show SCSI rev 2
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 03 00 60 d2 ec df
usb-storage: dpcm_transport: LUN=0
usb-storage: command_abort() called
usb-storage: Call to usb_stor_control_msg() returned -2
usb-storage: -- transport indicates command was aborted
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
usb-storage: device_reset() called
usb-storage: CB_reset() called
usb-storage: CB[I] soft reset failed -110
usb-storage: bus_reset() called
hub.c: port 2, portstatus 103, change 10, 12 Mb/s
usb-storage: bus_reset() complete
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command TEST_UNIT_READY (6 bytes)
usb-storage: 00 00 00 00 00 00 03 00 60 d2 ec df
usb-storage: dpcm_transport: LUN=0
usb-storage: command_abort() called
usb-storage: Call to usb_stor_control_msg() returned -2
usb-storage: -- transport indicates command was aborted
usb-storage: scsi command aborted
usb-storage: *** thread sleeping.
scsi: device set offline - not ready or command retry failed after bus
reset: host 2 channel 0 id 0 lun 0
usb-storage: queuecommand() called
usb-storage: *** thread awakened.

<----------------->8 cut here

I've got the rest of the log if you're of the sort to want to see
it in entirety.

I'll also be trying to play with usbsnoop and see if I can figure out
what the devil is going on, but I can't make any promises.. ;-)

Leif
