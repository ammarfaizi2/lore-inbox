Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264238AbUHIPjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264238AbUHIPjZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUHIPhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:37:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8437 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264238AbUHIPez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:34:55 -0400
Date: Mon, 9 Aug 2004 17:34:46 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: mikem@beardog.cca.cpqcorp.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix CCISS with PROC_FS=n
Message-ID: <20040809153446.GS26174@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error in 2.6.8-rc3-mm2 with 
CONFIG_PROC_FS=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x1b221c): In function `do_cciss_intr':
: undefined reference to `complete_scsi_command'
drivers/built-in.o(.text+0x1b2d18): In function `cciss_init_one':
: undefined reference to `cciss_scsi_setup'
drivers/built-in.o(.text+0x1b2fd3): In function `cciss_remove_one':
: undefined reference to `cciss_unregister_scsi'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


The following patch fixes this issue:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc3-mm2-full/drivers/block/cciss.c.old	2004-08-09 17:26:58.000000000 +0200
+++ linux-2.6.8-rc3-mm2-full/drivers/block/cciss.c	2004-08-09 17:27:14.000000000 +0200
@@ -185,10 +185,11 @@
         }
         return c;
 }
-#ifdef CONFIG_PROC_FS
 
 #include "cciss_scsi.c"		/* For SCSI tape support */
 
+#ifdef CONFIG_PROC_FS
+
 /*
  * Report information about this controller.
  */

