Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282961AbRK0Xdc>; Tue, 27 Nov 2001 18:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282990AbRK0XdY>; Tue, 27 Nov 2001 18:33:24 -0500
Received: from www.transvirtual.com ([206.14.214.140]:28172 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282961AbRK0XdH>; Tue, 27 Nov 2001 18:33:07 -0500
Date: Tue, 27 Nov 2001 15:32:54 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] excess code removal
Message-ID: <Pine.LNX.4.10.10111271531160.8427-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PROC_CONSOLE is defined in fbcon.c. No need for duplicate code. Please
apply.

--- linux-2.5.0/drivers/video/modedb.c	Tue Nov 27 16:05:02 2001
+++ linux/drivers/video/modedb.c	Tue Nov 27 16:10:04 2001
@@ -14,9 +14,9 @@
 #include <linux/module.h>
 #include <linux/tty.h>
 #include <linux/fb.h>
-#include <linux/console_struct.h>
 #include <linux/sched.h>
 
+#include <video/fbcon.h>
 
 #undef DEBUG
 
@@ -256,29 +256,6 @@
 	}
     }
 }
-
-static int PROC_CONSOLE(const struct fb_info *info)
-{
-	int fgc;
-	
-	if (info->display_fg != NULL)
-		fgc = info->display_fg->vc_num;
-	else
-		return -1;
-		
-	if (!current->tty)
-		return fgc;
-
-	if (current->tty->driver.type != TTY_DRIVER_TYPE_CONSOLE)
-		/* XXX Should report error here? */
-		return fgc;
-
-	if (MINOR(current->tty->device) < 1)
-		return fgc;
-
-	return MINOR(current->tty->device) - 1;
-}
-
 
 /**
  *	__fb_try_mode - test a video mode

