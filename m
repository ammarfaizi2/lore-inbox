Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTLSMZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTLSMZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:25:01 -0500
Received: from mx1.net.titech.ac.jp ([131.112.125.25]:63495 "HELO
	mx1.net.titech.ac.jp") by vger.kernel.org with SMTP id S262765AbTLSMY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:24:59 -0500
Date: Fri, 19 Dec 2003 21:24:56 +0900 (JST)
Message-Id: <20031219.212456.74735601.ryutaroh@it.ss.titech.ac.jp>
To: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] cannot input bar with JP106 keyboards
From: ryutaroh@it.ss.titech.ac.jp
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I found a problem in drivers/input/keyboard/atkbd.c in Linux 2.6.0.

We cannot input | (bar) with the JP 106 keyboards (the standard Japanese
keyboards). This is because the scancode 0x7d (125) is translated to
the keycode 0xb7 (183). The scancode 0x7d corresponds to | (bar) on
the JP 106 keyboard. In Linux 2.4.23, the scancode 0x7d (125) is
translated to the keycode 0x7c (124). Scancodes and keycodes can be
displayed by showkey(1).

The following patch makes the translation rule the same as that in
Linux 2.4.23. We also have to update drivers/char/keyboard.c in order
to get correct scancode.

If you send comments, please send them to
ryutaroh@it.ss.titech.ac.jp. I don't subscribe LKML.

Best regards,

Ryutaroh Matsumoto, Ph.D., Research Associate
Department of Communications and Integrated Systems
Tokyo Institute of Technology, 152-8552 Japan
Web page: http://www.rmatsumoto.org/research.html

--- linux-2.6.0/drivers/input/keyboard/atkbd.c.org	2003-12-18 11:59:19.000000000 +0900
+++ linux-2.6.0/drivers/input/keyboard/atkbd.c	2003-12-19 15:36:52.000000000 +0900
@@ -54,7 +54,7 @@
 	 91, 49, 48, 35, 34, 21,  7,  0,  0,  0, 50, 36, 22,  8,  9,  0,
 	  0, 51, 37, 23, 24, 11, 10,  0,  0, 52, 53, 38, 39, 25, 12,  0,
 	122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
-	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
+	 85, 86, 90, 91, 92, 93, 14, 94, 95, 79,124, 75, 71,121,  0,123,
 	 82, 83, 80, 76, 77, 72,  1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
 	  0,  0,  0, 65, 99,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
 	  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
--- linux-2.6.0/drivers/char/keyboard.c.org	2003-12-18 11:58:46.000000000 +0900
+++ linux-2.6.0/drivers/char/keyboard.c	2003-12-19 17:09:07.000000000 +0900
@@ -943,7 +943,7 @@
 	 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79,
 	 80, 81, 82, 83, 43, 85, 86, 87, 88,115,119,120,121,375,123, 90,
 	284,285,309,298,312, 91,327,328,329,331,333,335,336,337,338,339,
-	367,288,302,304,350, 92,334,512,116,377,109,111,373,347,348,349,
+	367,288,302,304,350, 92,334,512,116,377,109,111,125,347,348,349,
 	360, 93, 94, 95, 98,376,100,101,321,316,354,286,289,102,351,355,
 	103,104,105,275,287,279,306,106,274,107,294,364,358,363,362,361,
 	291,108,381,281,290,272,292,305,280, 99,112,257,258,359,270,114,
