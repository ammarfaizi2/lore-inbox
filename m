Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSE0T6L>; Mon, 27 May 2002 15:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316752AbSE0T6K>; Mon, 27 May 2002 15:58:10 -0400
Received: from [195.39.17.254] ([195.39.17.254]:22172 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316751AbSE0T6K>;
	Mon, 27 May 2002 15:58:10 -0400
Date: Mon, 27 May 2002 19:21:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: fix compilation for other architectures
Message-ID: <20020527172156.GA3907@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently, on machine where suspend is not yet supported, compilation
fails even in case user did not actually requested suspend. This
"fixes" it -- compilation only fails when suspend is needed and not
supported. Please apply,
								Pavel

--- clean/include/asm-i386/suspend.h	Sun May 26 19:32:03 2002
+++ linux-swsusp/include/asm-i386/suspend.h	Mon May 27 19:11:25 2002
@@ -1,13 +1,8 @@
-#ifndef __ASM_I386_SUSPEND_H
-#define __ASM_I386_SUSPEND_H
-#endif
-
 /*
  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
  * Based on code
  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
  */
-#if defined(SUSPEND_C) || defined(ACPI_C)
 #include <asm/desc.h>
 #include <asm/i387.h>
 
@@ -225,7 +220,6 @@
 	do_fpu_end();
 }
 
-#endif
 #ifdef SUSPEND_C
 /* Local variables for do_magic */
 static int loop __nosavedata = 0;
--- clean/include/linux/suspend.h	Sun May 26 19:32:04 2002
+++ linux-swsusp/include/linux/suspend.h	Mon May 27 19:11:45 2002
@@ -1,7 +1,9 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
+#if defined(SUSPEND_C) || defined(ACPI_C)
 #include <asm/suspend.h>
+#endif
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/config.h>

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
