Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTEKJyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 05:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbTEKJyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 05:54:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:16875 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261193AbTEKJyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 05:54:12 -0400
Date: Sun, 11 May 2003 12:06:50 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: mtd@infradead.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] let MTD_UCLINUX depend on !MMU
Message-ID: <20030511100649.GC1107@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile a kernel with MTD_UCLINUX enabled for a computer with
a MMU fails at the final linking because the variable _ebss seems to be
not defined on such machines (it's only defined on m68knommu, h8300 and 
v850).

The following patch (still applies with a few lines offset against 
2.5.69-bk4) tries to correct this issue by letting MTD_UCLINUX depend on 
!MMU.


--- linux-2.5.65-full/drivers/mtd/maps/Kconfig.old	2003-03-20 16:56:25.000000000 +0100
+++ linux-2.5.65-full/drivers/mtd/maps/Kconfig	2003-03-20 16:56:45.000000000 +0100
@@ -348,7 +348,7 @@
 
 config MTD_UCLINUX
 	tristate "Generic uClinux RAM/ROM filesystem support"
-	depends on MTD_PARTITIONS
+	depends on MTD_PARTITIONS && !MMU
 	help
 	  Map driver to support image based filesystems for uClinux.
 


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

