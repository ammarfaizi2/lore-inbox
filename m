Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278672AbRJ1VMH>; Sun, 28 Oct 2001 16:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278676AbRJ1VL6>; Sun, 28 Oct 2001 16:11:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:19979 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S278672AbRJ1VLr>;
	Sun, 28 Oct 2001 16:11:47 -0500
Subject: [PATCH] 2.4.13-ac4: panic.c compile fix
From: Robert Love <rml@tech9.net>
To: laughing@shared-source.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.27.17.24 (Preview Release)
Date: 28 Oct 2001 16:12:16 -0500
Message-Id: <1004303536.866.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/panic.c calls the new panic_blink (blink keybd leds) on panic if
__i386__ is defined.  however, panic_blink is only defined if keyboard
support is compiled in, and that is dependent on CONFIG_VT.  The
attached fixes the problem.  Alan, please apply.


diff -urN linux-2.4.13-ac2/kernel/panic.c linux/kernel/panic.c
--- linux-2.4.13-ac2/kernel/panic.c	Fri Oct 26 15:47:34 2001
+++ linux/kernel/panic.c	Fri Oct 26 23:05:41 2001
@@ -96,7 +96,7 @@
 #endif
 	sti();
 	for(;;) {
-#if defined(__i386__) 
+#if defined(__i386__) && defined(CONFIG_VT) 
 		extern void panic_blink(void);
 		panic_blink(); 
 #endif

	Robert Love

