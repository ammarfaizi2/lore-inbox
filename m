Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266024AbTFWNL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266016AbTFWNKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:10:50 -0400
Received: from c149240.vh.plala.or.jp ([210.150.149.240]:34512 "EHLO
	mps6.plala.or.jp") by vger.kernel.org with ESMTP id S266017AbTFWNDP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:03:15 -0400
Date: Mon, 23 Jun 2003 22:17:16 +0900
From: <yokotak@rmail.plala.or.jp>
X-Mailer: EdMax Ver2.85.2F
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] db9.c (Re: [PATCH] gamecon (added support for Sega Saturn controller), kernel 2.4.20)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20030621175955.A29057@ucw.cz>
References: <20030621175955.A29057@ucw.cz>
Message-Id: <20030623131720.ZJDZ13173.mps6.plala.or.jp@rmail.mail.plala.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Thank you very much for your reply and acceptance of my patch.

Vojtech Pavlik <vojtech@suse.cz> wrote:
> Thanks for the patch! I applied it to my kernel tree. How about a
> patch to update for the joystick-parport.txt documentation file?
I updated jostick-parport.txt file. New saturn figure is equivalent
to previous documentation. It might require a review, especially in
language.

Thank you for your reading,
  yokota


--- joystick-parport.txt.orig	Thu Sep 13 07:34:06 2001
+++ joystick-parport.txt	Mon Jun 23 21:53:14 2003
@@ -393,35 +393,66 @@
 
 2.4.3 Sega Saturn
 ~~~~~~~~~~~~~~~~~
-  Sega Saturn has eight buttons, and to transfer that, without hacks like
+  Sega Saturn has nine buttons, and to transfer that, without hacks like
 Genesis 6 pads use, it needs one more select pin. Anyway, it is still
 handled by the db9.c driver. Its pinout is very different from anything
 else.  Use this schematic:
 
-    +-----------> Select 1
-    | +---------> Power
-    | | +-------> Up
-    | | | +-----> Down
-    | | | | +---> Ground
-    | | | | |
-  _____________
-5 \ o o o o o / 1
-   \ o o o o /
-  9 `~~~~~~~' 6
-     | | | |
-     | | | +----> Select 2
-     | | +------> Right
-     | +--------> Left
-     +----------> Power
+  +-------------------> Ground (parallel port pin 18 - 25)
+  | +-----------------> Data 2 (pin 3)
+  | | +---------------> Data 3 (pin 2)
+  | | | +-------------> Power sub (pin 1)
+  | | | | +-----------> Select 1 (pin 14)
+  | | | | | +---------> Select 0 (pin 16)
+  | | | | | | +-------> Data 0 (pin 5)
+  | | | | | | | +-----> Data 1 (pin 4)
+  | | | | | | | | +---> Power (pin 1)
+  | | | | | | | | |
+ /= = = = = = = = =\
+| 1 2 3 4 5 6 7 8 9 |
++-------------------+
 
-  Select 1 is pin 14 on the parallel port, Select 2 is pin 16 on the
+  Select 1 is pin 14 on the parallel port, Select 0 is pin 16 on the
 parallel port.
 
 (pin 14) -----> Select 1
-(pin 16) -----> Select 2
+(pin 16) -----> Select 0
 
-  The other pins (Up, Down, Right, Left, Power, Ground) are the same as for
-Multi joysticks using db9.c
+  Data 2, 3, 0, 1 are connected to pins 3, 2, 5, 4 on the parallel port.
+
+(pin 3)  -----> Data 2
+(pin 2)  -----> Data 3
+(pin 5)  -----> Data 0
+(pin 4)  -----> Data 1
+
+  The other pins (Power, Ground) are the same as for Multi joysticks using
+db9.c
+
+  Power sub might require a resistor, when you use analog controller with
+external +5 volt power supply.
+
++5V supply ------+------------> Power (saturn 9)
+                 |  Resistor
+                 +--[10kOhm]--> Power sub (saturn 4)
+
+  On a side note, if you have already built a different adapter for use with
+DirectPadPro, this is also supported by the db9.c driver, as device type 11
+and 12. Use 11 for a connector, or 12 for two connectors. Two connectors are
+distinguished with its own Ground pins.
+
+  +-------------------> Ground (pin 8 or pin 9)
+  | +-----------------> Data 2 (pin 12)
+  | | +---------------> Data 3 (pin 13)
+  | | | +-------------> Power sub (pin 4)
+  | | | | +-----------> Select 1 (pin 3)
+  | | | | | +---------> Select 0 (pin 2)
+  | | | | | | +-------> Data 0 (pin 11)
+  | | | | | | | +-----> Data 1 (pin 10)
+  | | | | | | | | +---> Power (pin 5)
+  | | | | | | | | |
+ /= = = = = = = = =\
+| 1 2 3 4 5 6 7 8 9 |
++-------------------+
 
 3. The drivers
 ~~~~~~~~~~~~~~
@@ -483,10 +514,12 @@
 	  3  | Genesis pad (3+1 buttons)
 	  5  | Genesis pad (5+1 buttons)
 	  6  | Genesis pad (6+2 buttons)
-	  7  | Saturn pad (8 buttons)
+	  7  | Saturn pad (9 buttons)
 	  8  | Multisystem 1-button joystick (v0.8.0.2 pin-out)
 	  9  | Two Multisystem 1-button joysticks (v0.8.0.2 pin-out) 
 	 10  | Amiga CD32 pad
+	 11  | Saturn pad (DirectPadPro pin-out)
+	 12  | Two Saturn pads (DirectPadPro pin-out)
 
   Should you want to use more than one of these joysticks/pads at once, you
 can use db9_2 and db9_3 as additional command line parameters for two


