Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUILLiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUILLiv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268669AbUILLe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:34:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:38909 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S268697AbUILLbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:31:11 -0400
Date: Sun, 12 Sep 2004 13:31:00 +0200 (MEST)
Message-Id: <200409121131.i8CBV09H015246@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: R.E.Wolff@BitWizard.nl, marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.28-pre3] Specialix RIO driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
kernel's Specialix RIO driver. The 2.6 version of the code has not
been fixed for gcc-3.4, so the changes are all new.

/Mikael

--- linux-2.4.28-pre3/drivers/char/rio/rio_linux.c.~1~	2002-02-26 13:26:56.000000000 +0100
+++ linux-2.4.28-pre3/drivers/char/rio/rio_linux.c	2004-09-12 01:56:20.000000000 +0200
@@ -1206,7 +1206,7 @@
       if (((1 << hp->Ivec) & rio_irqmask) == 0)
               hp->Ivec = 0;
       hp->CardP	= (struct DpRam *)
-      hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+      (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy; 
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1278,7 +1278,7 @@
       	hp->Ivec = 0;
       hp->Ivec |= 0x8000; /* Mark as non-sharable */
       hp->CardP	= (struct DpRam *)
-      hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+      (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy;
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1330,7 +1330,7 @@
     /* There was something about the IRQs of these cards. 'Forget what.--REW */
     hp->Ivec = 0;
     hp->CardP = (struct DpRam *)
-    hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+    (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
     hp->Type = RIO_AT;
     hp->Copy = rio_pcicopy; /* AT card PCI???? - PVDL
                              * -- YES! this is now a normal copy. Only the 
