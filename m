Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269457AbUIRMmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269457AbUIRMmP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 08:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269460AbUIRMmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 08:42:15 -0400
Received: from aun.it.uu.se ([130.238.12.36]:34453 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S269457AbUIRMmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 08:42:09 -0400
Date: Sat, 18 Sep 2004 14:42:00 +0200 (MEST)
Message-Id: <200409181242.i8ICg0c9006579@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: R.E.Wolff@BitWizard.nl, akpm@osdl.org
Subject: [PATCH][2.6.9-rc2] Specialix RIO driver gcc-3.4 fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.6.9-rc2
kernel's Specialix RIO driver. This is a forward port of the fix
I made for the 2.4 kernel.

/Mikael

--- linux-2.6.9-rc2/drivers/char/rio/rio_linux.c.~1~	2004-03-11 14:01:27.000000000 +0100
+++ linux-2.6.9-rc2/drivers/char/rio/rio_linux.c	2004-09-18 14:27:33.000000000 +0200
@@ -1139,7 +1139,7 @@
       if (((1 << hp->Ivec) & rio_irqmask) == 0)
               hp->Ivec = 0;
       hp->CardP	= (struct DpRam *)
-      hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+      (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy; 
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1197,7 +1197,7 @@
       	hp->Ivec = 0;
       hp->Ivec |= 0x8000; /* Mark as non-sharable */
       hp->CardP	= (struct DpRam *)
-      hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+      (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
       hp->Type  = RIO_PCI;
       hp->Copy  = rio_pcicopy;
       hp->Mode  = RIO_PCI_BOOT_FROM_RAM;
@@ -1243,7 +1243,7 @@
     /* There was something about the IRQs of these cards. 'Forget what.--REW */
     hp->Ivec = 0;
     hp->CardP = (struct DpRam *)
-    hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
+    (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));
     hp->Type = RIO_AT;
     hp->Copy = rio_pcicopy; /* AT card PCI???? - PVDL
                              * -- YES! this is now a normal copy. Only the 
