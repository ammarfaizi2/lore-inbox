Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTH3UDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 16:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTH3UDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 16:03:17 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:10932 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262081AbTH3UDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 16:03:12 -0400
Date: Sat, 30 Aug 2003 22:03:09 +0200 (MEST)
Message-Id: <200308302003.h7UK39v3001763@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.23-pre2] fix PPC for wait_hwif_ready() change
Cc: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.23-pre2 doesn't link on PPC because of an unresolved
reference to wait_hwif_ready(). This function changed name
in -pre2 but one PPC-specific use of it wasn't updated.
Fixed by the patch below.

/Mikael

--- linux-2.4.23-pre2/drivers/ide/ide-probe.c.~1~	2003-08-30 20:25:39.000000000 +0200
+++ linux-2.4.23-pre2/drivers/ide/ide-probe.c	2003-08-30 21:47:26.000000000 +0200
@@ -879,7 +879,7 @@
 	 *  
 	 *  BenH.
 	 */
-	if (wait_hwif_ready(hwif))
+	if (ide_wait_hwif_ready(hwif))
 		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
 #endif /* CONFIG_PPC */
 
