Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTBUKfN>; Fri, 21 Feb 2003 05:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267362AbTBUKfN>; Fri, 21 Feb 2003 05:35:13 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:45007 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S267361AbTBUKfJ>; Fri, 21 Feb 2003 05:35:09 -0500
Subject: Problem: Palm Tungsten T + kernel 2.4.20 + Tungsten patch applied
From: Andree Leidenfrost <aleidenf@bigpond.net.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: private
Message-Id: <1045824312.1404.37.camel@aurich.ostfriesland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 21 Feb 2003 21:45:12 +1100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list

I'm having the above problem. In detail, when pressing the hotsync
button, /var/log/syslog says:

Feb 21 21:15:30 aurich kernel: hub.c: new USB device 00:10.0-1, assigned
address 3
Feb 21 21:15:30 aurich kernel: usb.c: USB device 3 (vend/prod
0x830/0x60) is not claimed by any active driver.
Feb 21 21:15:33 aurich /etc/hotplug/usb.agent: Setup visor for USB
product 830/60/100
Feb 21 21:15:33 aurich kernel: usb.c: registered new driver serial
Feb 21 21:15:33 aurich kernel: usbserial.c: USB Serial Driver core v1.4
Feb 21 21:15:33 aurich kernel: usbserial.c: USB Serial support
registered for Handspring Visor / Palm 4.0 / Clié 4.x
Feb 21 21:15:33 aurich kernel: usbserial.c: Handspring Visor / Palm 4.0
/ Clié 4.x converter detected
Feb 21 21:15:36 aurich kernel: usb_control/bulk_msg: timeout
Feb 21 21:15:36 aurich kernel: visor.c: visor_startup - error getting
connection information
Feb 21 21:15:36 aurich kernel: usbserial.c: Handspring Visor / Palm 4.0
/ Clié 4.x converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Feb 21 21:15:36 aurich kernel: usbserial.c: Handspring Visor / Palm 4.0
/ Clié 4.x converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Feb 21 21:15:36 aurich kernel: usbserial.c: USB Serial support
registered for Sony Clié 3.5
Feb 21 21:15:36 aurich kernel: visor.c: USB HandSpring Visor, Palm m50x,
Sony Clié driver v1.6
Feb 21 21:15:36 aurich kernel: usb-uhci.c: interrupt, status 2, frame#
1431
Feb 21 21:15:36 aurich kernel: usbdevfs: USBDEVFS_CONTROL failed dev 3
rqt 128 rq 6 len 0 ret -32
Feb 21 21:15:36 aurich kernel: usbdevfs: USBDEVFS_CONTROL failed dev 3
rqt 128 rq 6 len 0 ret -32

I have applied the following patches:

--- visor.c.orig	Wed Feb 19 22:55:38 2003
+++ visor.c	Wed Feb 19 22:57:00 2003
@@ -174,6 +174,7 @@
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M125_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M130_ID) },
+	{ USB_DEVICE(PALM_VENDOR_ID, PALM_TUNGSTEN_T_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_ZIRE_ID) },
 	{ USB_DEVICE(HANDSPRING_VENDOR_ID, HANDSPRING_VISOR_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_4_0_ID) },
@@ -195,6 +196,7 @@
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_I705_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M125_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_M130_ID) },
+	{ USB_DEVICE(PALM_VENDOR_ID, PALM_TUNGSTEN_T_ID) },
 	{ USB_DEVICE(PALM_VENDOR_ID, PALM_ZIRE_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_3_5_ID) },
 	{ USB_DEVICE(SONY_VENDOR_ID, SONY_CLIE_4_0_ID) },


--- visor.h.orig	Wed Feb 19 22:57:20 2003
+++ visor.h	Wed Feb 19 22:58:04 2003
@@ -27,6 +27,7 @@
 #define PALM_I705_ID			0x0020
 #define PALM_M125_ID			0x0040
 #define PALM_M130_ID			0x0050
+#define PALM_TUNGSTEN_T_ID		0x0060
 #define PALM_ZIRE_ID			0x0070
 
 #define SONY_VENDOR_ID			0x054C

Also I have added the following line to /etc/hotplug/usb.usermap:
visor                0x0003      0x0830   0x0060    0x0000      
0x0000       0x00         0x00            0x00           
0x00            0x00               0x00               0x00000000

I do not think it matters at this stage, but I'm running pilot-link
0.11.7 and jpliot 0.99.4 on Debian woody.

Syncing my m505 works fine, but I'd love to be able to sync my new and
shiny Tungsten T... ;-)

I have searched google and found this patch and success messages of
other people but no clue as to what my problem could.

Cheers
Andree
-- 
Andree Leidenfrost
Sydney - Australia

