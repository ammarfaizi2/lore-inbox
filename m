Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbSLEU64>; Thu, 5 Dec 2002 15:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267420AbSLEU5t>; Thu, 5 Dec 2002 15:57:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:16132 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267396AbSLEU5A>;
	Thu, 5 Dec 2002 15:57:00 -0500
Date: Wed, 4 Dec 2002 14:02:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: move variables where they belong
Message-ID: <20021204130238.GA8217@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp: Move loop variables into assembly, where they are used. Please
apply,

								Pavel

--- clean/arch/i386/kernel/suspend.c	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend.c	2002-11-30 15:28:40.000000000 +0100
@@ -125,10 +125,3 @@
 	}
 
 }
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-/* Local variables for do_magic */
-int loop __nosavedata = 0;
-int loop2 __nosavedata = 0;
-
-#endif
--- clean/arch/i386/kernel/suspend_asm.S	2002-11-19 16:45:58.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/suspend_asm.S	2002-11-30 15:28:32.000000000 +0100
@@ -1,4 +1,7 @@
 .text
+
+/* Originally gcc generated, modified by hand */
+
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -78,3 +81,11 @@
 .L1449:
 	popl %ebx
 	ret
+
+       .section .data.nosave
+loop:
+       .quad 0
+loop2:
+       .quad 0
+       .previous
+	
\ No newline at end of file

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
