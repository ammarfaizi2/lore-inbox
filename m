Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbTIOMkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTIOMkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:40:12 -0400
Received: from ozlabs.org ([203.10.76.45]:60070 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261347AbTIOMkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:40:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16229.45091.906515.365451@nanango.paulus.ozlabs.org>
Date: Mon, 15 Sep 2003 22:27:15 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix IDE compile on PPC in 2.4.23-pre4
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo & Bart,

Currently, the IDE code in 2.4.23-pre4 does not compile on PPC because
of a missed symbol name change in drivers/ide/ide-probe.c.  This
instance got missed because it is in a #ifdef CONFIG_PPC section.

The patch below fixes it.  Please apply.

Thanks,
Paul.

diff -urN linux-2.4/drivers/ide/ide-probe.c linuxppc-2.4/drivers/ide/ide-probe.c
--- linux-2.4/drivers/ide/ide-probe.c	2003-08-31 08:17:05.000000000 +1000
+++ linuxppc-2.4/drivers/ide/ide-probe.c	2003-09-12 09:52:09.000000000 +1000
@@ -879,7 +879,7 @@
 	 *  
 	 *  BenH.
 	 */
-	if (wait_hwif_ready(hwif))
+	if (ide_wait_hwif_ready(hwif))
 		printk(KERN_WARNING "%s: Wait for ready failed before probe !\n", hwif->name);
 #endif /* CONFIG_PPC */
 
