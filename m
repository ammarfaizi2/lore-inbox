Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbTCaQGP>; Mon, 31 Mar 2003 11:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261697AbTCaQGP>; Mon, 31 Mar 2003 11:06:15 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:26240 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261696AbTCaQGO>; Mon, 31 Mar 2003 11:06:14 -0500
Date: Tue, 1 Apr 2003 01:16:04 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-ac1] Update PC-9800 support (1/3) keyboard driver
Message-ID: <20030331161604.GA1124@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture
against 2.5.66-ac1. (1/3)
Please apply.

Update keyboard driver for PC-98.
Bug fix, CAPS key send scancode like mechanical lock keyboard.

diff -Nru linux-2.5.66-ac1/drivers/input/keyboard/98kbd.c linux98-2.5.66-ac1/drivers/input/keyboard/98kbd.c
--- linux-2.5.66-ac1/drivers/input/keyboard/98kbd.c	2003-03-25 07:00:18.000000000 +0900
+++ linux98-2.5.66-ac1/drivers/input/keyboard/98kbd.c	2003-03-31 16:04:48.000000000 +0900
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
 
Regards,
Osamu Tomita

