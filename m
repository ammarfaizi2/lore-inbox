Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbTEKK0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 06:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTEKKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 06:25:11 -0400
Received: from amsfep13-int.chello.nl ([213.46.243.24]:41000 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S261252AbTEKKVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 06:21:41 -0400
Date: Sun, 11 May 2003 12:31:07 +0200
Message-Id: <200305111031.h4BAV7an019742@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Ataflop fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ataflop: fix breakage after recent cleanups

--- linux-2.5.x/drivers/block/ataflop.c	Mon May  5 10:30:51 2003
+++ linux-m68k-2.5.x/drivers/block/ataflop.c	Thu May  8 09:16:18 2003
@@ -1570,7 +1571,7 @@
 		 */
 
 		/* get the parameters from user space */
-		if (p->ref != 1 && p->ref != -1)
+		if (floppy->ref != 1 && floppy->ref != -1)
 			return -EBUSY;
 		if (copy_from_user(&setprm, (void *) param, sizeof(setprm)))
 			return -EFAULT;
@@ -1617,7 +1618,7 @@
 				    printk (KERN_INFO "floppy%d: setting %s %p!\n",
 				        drive, dtp->name, dtp);
 				UDT = dtp;
-				set_capacity(p->disk, UDT->blocks);
+				set_capacity(floppy->disk, UDT->blocks);
 
 				if (cmd == FDDEFPRM) {
 				  /* save settings as permanent default type */
@@ -1663,7 +1664,7 @@
 		}
 
 		UDT = dtp;
-		set_capacity(p->disk, UDT->blocks);
+		set_capacity(floppy->disk, UDT->blocks);
 
 		return 0;
 	case FDMSGON:
@@ -1677,7 +1678,7 @@
 	case FDFMTBEG:
 		return 0;
 	case FDFMTTRK:
-		if (p->ref != 1 && p->ref != -1)
+		if (floppy->ref != 1 && floppy->ref != -1)
 			return -EBUSY;
 		if (copy_from_user(&fmt_desc, (void *) param, sizeof(fmt_desc)))
 			return -EFAULT;
@@ -1686,7 +1687,7 @@
 		UDT = NULL;
 		/* MSch: invalidate default_params */
 		default_params[drive].blocks  = 0;
-		set_capacity(p->disk, MAX_DISK_SIZE * 2);
+		set_capacity(floppy->disk, MAX_DISK_SIZE * 2);
 	case FDFMTEND:
 	case FDFLUSH:
 		/* invalidate the buffer track to force a reread */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
