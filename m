Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265723AbTFNU2v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 16:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbTFNU1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 16:27:32 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:10986 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265731AbTFNU1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 16:27:06 -0400
Date: Sat, 14 Jun 2003 22:40:52 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] input: Turn numlock ON on HP HIL machines [6/13]
Message-ID: <20030614224052.E25997@ucw.cz>
References: <20030614223513.A25948@ucw.cz> <20030614223629.A25997@ucw.cz> <20030614223708.B25997@ucw.cz> <20030614223934.C25997@ucw.cz> <20030614224022.D25997@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030614224022.D25997@ucw.cz>; from vojtech@suse.cz on Sat, Jun 14, 2003 at 10:40:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1215.104.23, 2003-06-09 14:06:54+02:00, deller@gmx.de
  input: Turn on the NumLock ON by default on PARISC HP-HIL machines.


 keyboard.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Sat Jun 14 22:22:58 2003
+++ b/drivers/char/keyboard.c	Sat Jun 14 22:22:58 2003
@@ -52,11 +52,13 @@
 
 /*
  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
- * This seems a good reason to start with NumLock off. On PC9800 however there
- * is no NumLock key and everyone expects the keypad to be used for numbers.
+ * This seems a good reason to start with NumLock off. On PC9800 and HIL keyboards 
+ * of PARISC machines however there is no NumLock key and everyone expects the keypad 
+ * to be used for numbers.
  */
 
-#ifdef CONFIG_X86_PC9800
+#if defined(CONFIG_X86_PC9800) || \
+    defined(CONFIG_PARISC) && (defined(CONFIG_KEYBOARD_HIL) || defined(CONFIG_KEYBOARD_HIL_OLD))
 #define KBD_DEFLEDS (1 << VC_NUMLOCK)
 #else
 #define KBD_DEFLEDS 0
