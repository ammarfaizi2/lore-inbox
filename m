Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312524AbSDOAXp>; Sun, 14 Apr 2002 20:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312525AbSDOAXp>; Sun, 14 Apr 2002 20:23:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:45709 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S312524AbSDOAXn>; Sun, 14 Apr 2002 20:23:43 -0400
Date: Sun, 14 Apr 2002 18:23:20 -0600
Message-Id: <200204150023.g3F0NKi21975@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] for 2.4.19-pre6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Marcelo. The last few pre-patches have broken IDE as modules. I
would have though this would have been fixed by now, but perhaps
no-one else noticed. Here is a patch that fixes the problem.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.4.19-pre6/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.4.19-pre6/drivers/ide/ide-probe.c	Sat Apr  6 14:15:17 2002
+++ linux/drivers/ide/ide-probe.c	Sun Apr 14 15:51:51 2002
@@ -987,7 +987,6 @@
 }
 
 #ifdef MODULE
-extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
 
 int init_module (void)
 {
@@ -997,14 +996,12 @@
 		ide_unregister(index);
 	ideprobe_init();
 	create_proc_ide_interfaces();
-	ide_xlate_1024_hook = ide_xlate_1024;
 	return 0;
 }
 
 void cleanup_module (void)
 {
 	ide_probe = NULL;
-	ide_xlate_1024_hook = 0;
 }
 MODULE_LICENSE("GPL");
 #endif /* MODULE */
