Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272508AbTGZOmh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272501AbTGZOeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:34:14 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:16989 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272502AbTGZOca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:30 -0400
Date: Sat, 26 Jul 2003 16:51:29 +0200
Message-Id: <200307261451.h6QEpT9s002280@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k wd33c93 locking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k wd33c93: host_lock is a pointer to a spinlock, not a spinlock (from Ralf
Bächle)

--- linux-2.6.x/drivers/scsi/a2091.c	Fri May  9 10:21:34 2003
+++ linux-m68k-2.6.x/drivers/scsi/a2091.c	Fri Jun  6 13:33:13 2003
@@ -43,9 +43,9 @@
 		continue;
 
 	if (status & ISTR_INTS) {
-		spin_lock_irqsave(&instance->host_lock, flags);
+		spin_lock_irqsave(instance->host_lock, flags);
 		wd33c93_intr (instance);
-		spin_unlock_irqrestore(&instance->host_lock, flags);
+		spin_unlock_irqrestore(instance->host_lock, flags);
 		handled = 1;
 	}
     }
--- linux-2.6.x/drivers/scsi/a3000.c	Fri May  9 10:21:34 2003
+++ linux-m68k-2.6.x/drivers/scsi/a3000.c	Fri Jun  6 13:33:13 2003
@@ -36,9 +36,9 @@
 		return IRQ_NONE;
 	if (status & ISTR_INTS)
 	{
-		spin_lock_irqsave(&a3000_host->host_lock, flags);
+		spin_lock_irqsave(a3000_host->host_lock, flags);
 		wd33c93_intr (a3000_host);
-		spin_unlock_irqrestore(&a3000_host->host_lock, flags);
+		spin_unlock_irqrestore(a3000_host->host_lock, flags);
 		return IRQ_HANDLED;
 	}
 	printk("Non-serviced A3000 SCSI-interrupt? ISTR = %02x\n", status);
--- linux-2.6.x/drivers/scsi/gvp11.c	Fri May  9 10:21:34 2003
+++ linux-m68k-2.6.x/drivers/scsi/gvp11.c	Fri Jun  6 13:33:18 2003
@@ -42,9 +42,9 @@
 	if (!(status & GVP11_DMAC_INT_PENDING))
 	    continue;
 
-	spin_lock_irqsave(&instance->host_lock, flags);
+	spin_lock_irqsave(instance->host_lock, flags);
 	wd33c93_intr (instance);
-	spin_unlock_irqrestore(&instance->host_lock, flags);
+	spin_unlock_irqrestore(instance->host_lock, flags);
 	handled = 1;
     }
     return IRQ_RETVAL(handled);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
