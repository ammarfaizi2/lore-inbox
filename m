Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267939AbTAKRq3>; Sat, 11 Jan 2003 12:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267941AbTAKRq3>; Sat, 11 Jan 2003 12:46:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34772 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267939AbTAKRq2>; Sat, 11 Jan 2003 12:46:28 -0500
Date: Sat, 11 Jan 2003 18:55:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: R.E.Wolff@BitWizard.nl
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] remove kernel 2.0 code from drivers/char/specialix.c
Message-ID: <20030111175508.GT10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some #if'd kernel 2.0 code from 
drivers/char/specialix.c.

Please apply
Adrian

--- linux-2.5.56/drivers/char/specialix.c.old	2003-01-11 18:50:41.000000000 +0100
+++ linux-2.5.56/drivers/char/specialix.c	2003-01-11 18:52:13.000000000 +0100
@@ -93,39 +93,7 @@
 #include <linux/version.h>
 #include <linux/pci.h>
 
-
-/* ************************************************************** */
-/* * This section can be removed when 2.0 becomes outdated....  * */
-/* ************************************************************** */
-
-#if LINUX_VERSION_CODE < 131328    /* Less than 2.1.0 */
-#define TWO_ZERO
-#else
-#if LINUX_VERSION_CODE < 131371   /* less than 2.1.43 */
-/* This has not been extensively tested yet. Sorry. */
-#warning "You're on your own between 2.1.0 and 2.1.43.... "
-#warning "Please use a recent kernel."
-#endif
-#endif
-
-
-#ifdef TWO_ZERO
-#define Get_user(a,b)         a = get_user(b)
-#define copy_from_user(a,b,c) memcpy_fromfs(a,b,c)
-#define copy_to_user(a,b,c)   memcpy_tofs(a,b,c)
-#define queue_task            queue_task_irq_off
-#else
-#define Get_user(a,b)         get_user(a,b)
-#endif
-
-/* ************************************************************** */
-/* *                End of compatibility section..              * */
-/* ************************************************************** */
-
-
-#ifndef TWO_ZERO
 #include <asm/uaccess.h>
-#endif
 
 #include "specialix_io8.h"
 #include "cd1865.h"
@@ -1811,7 +1779,7 @@
 	if (error) 
 		return error;
 
-	Get_user(arg, (unsigned long *) value);
+	get_user(arg, (unsigned long *) value);
 	switch (cmd) {
 	case TIOCMBIS: 
 	   /*	if (arg & TIOCM_RTS) 
@@ -2003,7 +1971,7 @@
 		         (unsigned long *) arg);
 		return 0;
 	 case TIOCSSOFTCAR:
-		Get_user(arg, (unsigned long *) arg);
+		get_user(arg, (unsigned long *) arg);
 		tty->termios->c_cflag =
 			((tty->termios->c_cflag & ~CLOCAL) |
 			(arg ? CLOCAL : 0));

