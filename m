Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUEONF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUEONF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 09:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUEONF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 09:05:57 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:12437 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262398AbUEONFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 09:05:09 -0400
From: tglx@linutronix.de (Thomas Gleixner)
Reply-To: tglx@linutronix.de
Organization: linutronix
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.26] drivers/char/keyboard.c fix compiler warnings
Date: Sat, 15 May 2004 15:00:02 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405151500.02776.tglx@linutronix.de>
X-Seen: false
X-ID: ZYs0ZMZDYeX6ydnuJwV2DNqtfTuw5gR7RcEjTfbfrYdkqhcOQRBK4j@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following warnings, produced by gcc3.3.3:

keyboard.c: In function `do_fn':
keyboard.c:640: warning: comparison is always true due to limited range of 
data type

SIZE(func_table) is 256. So value can't be >= SIZE(func_table)

-- 
Thomas
________________________________________________________________________
"Free software" is a matter of liberty, not price. To understand the concept,
you should think of "free" as in "free speech,'' not as in "free beer".
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

--- linux-2.4.26.org/drivers/char/keyboard.c	2003-11-28 19:26:20.000000000 
+0100
+++ linux-2.4.26/drivers/char/keyboard.c	2004-05-15 13:35:19.000000000 +0200
@@ -637,11 +637,8 @@
 {
 	if (up_flag)
 		return;
-	if (value < SIZE(func_table)) {
-		if (func_table[value])
-			puts_queue(func_table[value]);
-	} else
-		printk(KERN_ERR "do_fn called with value=%d\n", value);
+	if (func_table[value])
+		puts_queue(func_table[value]);
 }
 
 static void do_pad(unsigned char value, char up_flag)

