Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTDGXK7 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbTDGXK7 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:10:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51072
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263722AbTDGW5i (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:57:38 -0400
Date: Tue, 8 Apr 2003 01:16:33 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080016.h380GXLH009031@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix up capslock on pc9800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/input/keyboard/98kbd.c linux-2.5.67-ac1/drivers/input/keyboard/98kbd.c
--- linux-2.5.67/drivers/input/keyboard/98kbd.c	2003-03-26 19:59:51.000000000 +0000
+++ linux-2.5.67-ac1/drivers/input/keyboard/98kbd.c	2003-04-03 23:41:43.000000000 +0100
@@ -189,6 +189,13 @@
 			input_sync(&kbd98->dev);
 			return;
 
+		case KEY_CAPSLOCK:
+			input_report_key(&kbd98->dev, keycode, 1);
+			input_sync(&kbd98->dev);
+			input_report_key(&kbd98->dev, keycode, 0);
+			input_sync(&kbd98->dev);
+			return;
+
 		case KBD98_KEY_NULL:
 			return;
 
