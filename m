Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSKBUsb>; Sat, 2 Nov 2002 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261424AbSKBUsb>; Sat, 2 Nov 2002 15:48:31 -0500
Received: from smtp2.sooninternet.net ([212.246.17.84]:47283 "EHLO
	smtp2.sooninternet.net") by vger.kernel.org with ESMTP
	id <S261419AbSKBUsa>; Sat, 2 Nov 2002 15:48:30 -0500
Date: Sat, 2 Nov 2002 22:54:48 +0200
From: Kari Hameenaho <khaho@koti.soon.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech wheel and 2.5? (PS/2)
Message-Id: <20021102225448.6be90473.khaho@koti.soon.fi>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregoire Favre wrote:

>patched, but I got:
>
>  drivers/input/mouse/psmouse.c drivers/input/mouse/psmouse.c: In
>  function `psmouse_process_packet': drivers/input/mouse/psmouse.c:90:
>  label `out' used but not defined make[3]: ***
>  [drivers/input/mouse/psmouse.o] Error 1 make[2]: ***
>  [drivers/input/mouse] Error 2 make[1]: *** [drivers/input] Error 2
make: *** [drivers] Error 2

There was a line +out: in my patch, maybe you did not apply it correctly
or the mail caused some changes to patch part. Note that it is against 
2.5.45. All os the patch is in one function, so it is quite possible to do 
patching manually (it is only 5 lines anyway), if it somehow gets 
corrupted.

Here it is again:

--- linux-2.5.45/drivers/input/mouse/psmouse.c	Thu Oct 31 02:42:20 2002
+++ linux-2.5.45-usb/drivers/input/mouse/psmouse.c	Fri Nov  1 22:28:25 2002
@@ -85,6 +85,11 @@
 
 	if (psmouse->type == PSMOUSE_PS2PP || psmouse->type == PSMOUSE_PS2TPP) {
 
+		/* Logitech radio/battery status or strangeness ?????? */
+		if (packet[0] == 0xd8) {
+			goto out;
+		}
+
 		if ((packet[0] & 0x40) == 0x40 && (int) packet[1] - (int) ((packet[0] & 0x10) << 4) > 191 ) {
 
 			switch (((packet[1] >> 4) & 0x03) | ((packet[0] >> 2) & 0xc0)) {
@@ -157,6 +162,7 @@
 	input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
 	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
 
+out:
 	input_sync(dev);
 }
 
