Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUDIVrh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUDIVrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 17:47:37 -0400
Received: from mail.cyclades.com ([64.186.161.6]:39386 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261210AbUDIVre
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 17:47:34 -0400
Date: Fri, 9 Apr 2004 18:21:23 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20040409212123.GB18694@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Subject: [PATCH] drivers/char/KConfig: Remove "BROKEN_ON_SMP" tag on CYCLADES entry
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew, 

The cyclades.c driver was marked BROKEN_ON_SMP during early 2.6. It was fixed later
on but the tag was left in Kconfig.

The driver is not very smart wrt SMP locking, it can be improved. There is only 
one spinlock percard which guarantees command block ordering and protects different
shared data, which can be held for long periods.

_But_ the locking works reliably, so remove the BROKEN_ON_SMP tag.

Please apply.


--- linux-2.6.5-mc2.orig/drivers/char/Kconfig	2004-04-09 17:49:22.703814096 -0300
+++ linux-2.6.5-mc2/drivers/char/Kconfig	2004-04-08 18:04:21.000000000 -0300
@@ -110,7 +110,7 @@
 
 config CYCLADES
 	tristate "Cyclades async mux support"
-	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
+	depends on SERIAL_NONSTANDARD
 	---help---
 	  This is a driver for a card that gives you many serial ports. You
 	  would need something like this to connect more than two modems to




