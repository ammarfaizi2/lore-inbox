Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbTA2Mj6>; Wed, 29 Jan 2003 07:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbTA2Mj6>; Wed, 29 Jan 2003 07:39:58 -0500
Received: from CPE-203-51-26-171.nsw.bigpond.net.au ([203.51.26.171]:28922
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S265865AbTA2Mjz>; Wed, 29 Jan 2003 07:39:55 -0500
Message-ID: <3E37CDC7.8847547E@eyal.emu.id.au>
Date: Wed, 29 Jan 2003 23:49:11 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre4
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
Content-Type: multipart/mixed;
 boundary="------------FFEF6F55F554D30C3DECF4E5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FFEF6F55F554D30C3DECF4E5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Marcelo Tosatti wrote:
> 
> Hi,
> 
> So here goes -pre4...

I needed these two tiny patches (this is nothing new), and

I got these unresolved:

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre4/kernel/drivers/char/ipmi/ipmi_msghandler.o
depmod:         panic_notifier_list
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-pre4/kernel/drivers/char/ipmi/ipmi_watchdog.o
depmod:         panic_notifier_list
depmod:         panic_timeout

.config
=======
CONFIG_IPMI_HANDLER=m
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_KCS=m
CONFIG_IPMI_WATCHDOG=m

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------FFEF6F55F554D30C3DECF4E5
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre4-char.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre4-char.patch"

--- linux/drivers/char/Makefile.orig	Tue Jan  7 20:13:30 2003
+++ linux/drivers/char/Makefile	Tue Jan  7 20:17:16 2003
@@ -24,7 +24,7 @@
 export-objs     :=	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
 			sonypi.o tty_io.o tty_ioctl.o generic_serial.o \
-			au1000_gpio.o hp_psaux.o nvram.o
+			au1000_gpio.o hp_psaux.o nvram.o scx200.o
 
 mod-subdirs	:=	joystick ftape drm drm-4.0 pcmcia
 

--------------FFEF6F55F554D30C3DECF4E5
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre4-sbp2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre4-sbp2.patch"

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

--------------FFEF6F55F554D30C3DECF4E5--

