Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFHO1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 10:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTFHO1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 10:27:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:65218 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261843AbTFHO1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 10:27:06 -0400
Date: Sun, 8 Jun 2003 16:40:38 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Gergely Madarasz <gorgo@itc.hu>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] let COMX depend on PROC_FS
Message-ID: <20030608144038.GF16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From drivers/net/wan/comx.c:

<--  snip  -->

...
#ifndef CONFIG_PROC_FS
#error For now, COMX really needs the /proc filesystem
#endif
...

<--  snip  -->


The following patch add a dependency to Kconfig to avoid compile errors 
with CONFIG_COMX and !CONFIG_PROC_FS:


--- linux-2.5.70-mm6/drivers/net/wan/Kconfig.old	2003-06-08 15:54:41.000000000 +0200
+++ linux-2.5.70-mm6/drivers/net/wan/Kconfig	2003-06-08 15:55:14.000000000 +0200
@@ -62,7 +62,7 @@
 #
 config COMX
 	tristate "MultiGate (COMX) synchronous serial boards support"
-	depends on WAN && (ISA || PCI)
+	depends on WAN && (ISA || PCI) && PROC_FS
 	---help---
 	  Say Y if you want to use any board from the MultiGate (COMX) family.
 	  These boards are synchronous serial adapters for the PC,



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

