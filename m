Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbTFGPLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTFGPLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:11:08 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:38868 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263084AbTFGPLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:11:04 -0400
Date: Sat, 7 Jun 2003 17:24:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jean Tourrilhes <jt@bougret.hpl.hp.com>, linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [patch] fix vlsi_ir.c compile if !CONFIG_PROC_FS
Message-ID: <20030607152434.GQ15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error with !CONFIG_PROC_FS:

<--  snip  -->

...
  CC      drivers/net/irda/vlsi_ir.o
drivers/net/irda/vlsi_ir.c: In function `vlsi_irda_probe':
drivers/net/irda/vlsi_ir.c:1826: warning: label `out_unregister' defined but not used
drivers/net/irda/vlsi_ir.c: In function `vlsi_mod_exit':
drivers/net/irda/vlsi_ir.c:2047: `PROC_DIR' undeclared (first use in this function)
drivers/net/irda/vlsi_ir.c:2047: (Each undeclared identifier is reported only once
drivers/net/irda/vlsi_ir.c:2047: for each function it appears in.)
make[3]: *** [drivers/net/irda/vlsi_ir.o] Error 1

<--  snip  -->


The following patch fixes it:


--- linux-2.5.70-mm5/drivers/net/irda/vlsi_ir.c.old	2003-06-07 17:01:26.000000000 +0200
+++ linux-2.5.70-mm5/drivers/net/irda/vlsi_ir.c	2003-06-07 17:02:25.000000000 +0200
@@ -2044,7 +2044,11 @@
 static void __exit vlsi_mod_exit(void)
 {
 	pci_unregister_driver(&vlsi_irda_driver);
+
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry(PROC_DIR, 0);
+#endif
+
 }
 
 module_init(vlsi_mod_init);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

