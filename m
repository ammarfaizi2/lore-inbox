Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUHTQPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUHTQPS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUHTQPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:15:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:37556 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268305AbUHTQOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:14:53 -0400
Subject: [PATCH] Resolve duplicate/conflicting MODULE_LICENSE tags
From: Andreas Gruenbacher <agruen@suse.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1093018564.17135.33.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 Aug 2004 18:16:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing module licenses I've noticed the following
inconsistencies:

* fs/affs/affs.ko, drivers/media/radio/miropcm20.ko have
  MODULE_LICENSE("GPL") twice.

* drivers/scsi/pcmcia/fdomain_cs.ko, drivers/scsi/pcmcia/aha152x_cs.ko
  have both MODULE_LICENSE("GPL") and MODULE_LICENSE("Dual MPL/GPL").
  The common denominator seems to be MODULE_LICENSE("GPL") -- right?

* drivers/net/ppp_mppe.ko has MODULE_LICENSE("BSD without advertisement
  clause"). This is generally considered a GPL compatible license,
  and should probably be added to license_is_gpl_compatible().


Are we fine with applying the following patch?

Thanks,
Andreas Gruenbacher.


Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.8/fs/affs/inode.c
===================================================================
--- linux-2.6.8.orig/fs/affs/inode.c
+++ linux-2.6.8/fs/affs/inode.c
@@ -427,4 +427,3 @@ err:
 	affs_unlock_link(inode);
 	goto done;
 }
-MODULE_LICENSE("GPL");
Index: linux-2.6.8/drivers/scsi/pcmcia/fdomain_stub.c
===================================================================
--- linux-2.6.8.orig/drivers/scsi/pcmcia/fdomain_stub.c
+++ linux-2.6.8/drivers/scsi/pcmcia/fdomain_stub.c
@@ -59,7 +59,6 @@
 
 MODULE_AUTHOR("David Hinds <dahinds@users.sourceforge.net>");
 MODULE_DESCRIPTION("Future Domain PCMCIA SCSI driver");
-MODULE_LICENSE("Dual MPL/GPL");
 
 /* Bit map of interrupts to choose from */
 static int irq_mask = 0xdeb8;
Index: linux-2.6.8/kernel/module.c
===================================================================
--- linux-2.6.8.orig/kernel/module.c
+++ linux-2.6.8/kernel/module.c
@@ -1380,7 +1380,8 @@ static inline int license_is_gpl_compati
 		|| strcmp(license, "GPL v2") == 0
 		|| strcmp(license, "GPL and additional rights") == 0
 		|| strcmp(license, "Dual BSD/GPL") == 0
-		|| strcmp(license, "Dual MPL/GPL") == 0);
+		|| strcmp(license, "Dual MPL/GPL") == 0
+		|| strcmp(license, "BSD without advertisement clause") == 0);
 }
 
 static void set_license(struct module *mod, const char *license)
Index: linux-2.6.8/drivers/media/radio/miropcm20-radio.c
===================================================================
--- linux-2.6.8.orig/drivers/media/radio/miropcm20-radio.c
+++ linux-2.6.8/drivers/media/radio/miropcm20-radio.c
@@ -258,7 +258,6 @@ static int __init pcm20_init(void)
 
 MODULE_AUTHOR("Ruurd Reitsma");
 MODULE_DESCRIPTION("A driver for the Miro PCM20 radio card.");
-MODULE_LICENSE("GPL");
 
 static void __exit pcm20_cleanup(void)
 {
Index: linux-2.6.8/drivers/scsi/pcmcia/aha152x_stub.c
===================================================================
--- linux-2.6.8.orig/drivers/scsi/pcmcia/aha152x_stub.c
+++ linux-2.6.8/drivers/scsi/pcmcia/aha152x_stub.c
@@ -91,8 +91,6 @@ MODULE_PARM(synchronous, "i");
 MODULE_PARM(reset_delay, "i");
 MODULE_PARM(ext_trans, "i");
 
-MODULE_LICENSE("Dual MPL/GPL");
-
 /*====================================================================*/
 
 typedef struct scsi_info_t {

