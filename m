Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbTAGKlt>; Tue, 7 Jan 2003 05:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbTAGKlt>; Tue, 7 Jan 2003 05:41:49 -0500
Received: from CPE-203-51-25-222.nsw.bigpond.net.au ([203.51.25.222]:55026
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S267423AbTAGKlr>; Tue, 7 Jan 2003 05:41:47 -0500
Message-ID: <3E1AB0EB.6BDEE053@eyal.emu.id.au>
Date: Tue, 07 Jan 2003 21:50:19 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre2-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3: some compile fixes I needed
References: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------735F9A99841751B605B18140"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------735F9A99841751B605B18140
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

linux/drivers/char/Makefile
===========================
Well, here the build fails with a suggestion that I fix the
Makefile. This trivial change allows the build to continue.


drivers/ieee1394/sbp2.c
=======================
It stil fails as before. The attached fix is a blind hack to
get it to compile rather than an educated fix.


linux/drivers/usb/hcd/ehci-hcd.c
================================
A problem for older gcc.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------735F9A99841751B605B18140
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre3-char.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre3-char.patch"

--- linux/drivers/char/Makefile.orig	Tue Jan  7 20:13:30 2003
+++ linux/drivers/char/Makefile	Tue Jan  7 20:17:16 2003
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o hp_psaux.o nvram.o
+			au1000_gpio.o hp_psaux.o nvram.o scx200.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
 

--------------735F9A99841751B605B18140
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre3-sbp2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre3-sbp2.patch"

--- linux/drivers/ieee1394/sbp2.c.orig	Thu Dec 19 10:22:33 2002
+++ linux/drivers/ieee1394/sbp2.c	Thu Dec 19 10:23:17 2002
@@ -1511,7 +1511,7 @@
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_write(struct hpsb_host *host, int nodeid, int destid, quadlet_t *data,
-                                     u64 addr, unsigned int length)
+                                     u64 addr, unsigned int length, u16 flags)
 {
 
         /*
@@ -1527,7 +1527,7 @@
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_read(struct hpsb_host *host, int nodeid, quadlet_t *data,
-                                    u64 addr, unsigned int length)
+                                    u64 addr, unsigned int length, u16 flags)
 {
 
         /*

--------------735F9A99841751B605B18140
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre3-ehci-dbg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre3-ehci-dbg.patch"

--- linux/drivers/usb/hcd/ehci-dbg.c.orig	Tue Jan  7 20:55:20 2003
+++ linux/drivers/usb/hcd/ehci-dbg.c	Tue Jan  7 21:00:05 2003
@@ -39,6 +39,7 @@
 #define ehci_dbg(ehci, fmt, args...) do { } while (0)
 #endif
 
+#if 0
 #define ehci_err(ehci, fmt, args...) \
 	printk(KERN_ERR "%s %s: " fmt, hcd_name, \
 		(ehci)->hcd.pdev->slot_name, ## args )
@@ -48,6 +49,14 @@
 #define ehci_warn(ehci, fmt, args...) \
 	printk(KERN_WARNING "%s %s: " fmt, hcd_name, \
 		(ehci)->hcd.pdev->slot_name, ## args )
+#else
+#define ehci_err(ehci, fmt, args...) \
+	do { } while (0)
+#define ehci_info(ehci, fmt, args...) \
+	do { } while (0)
+#define ehci_warn(ehci, fmt, args...) \
+	do { } while (0)
+#endif
 #endif
 
 

--------------735F9A99841751B605B18140--

