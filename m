Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUHNO3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUHNO3W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUHNO3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:29:22 -0400
Received: from verein.lst.de ([213.95.11.210]:21163 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263003AbUHNO2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:28:40 -0400
Date: Sat, 14 Aug 2004 16:28:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: ajoshi@shell.unixbox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] avoid riva_get_EDID unused variable warnings
Message-ID: <20040814142828.GC25939@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, ajoshi@shell.unixbox.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

split the three versions of the function into separate blocks, makes
the code much cleaner aswell.


--- 1.62/drivers/video/riva/fbdev.c	2004-07-29 06:58:37 +02:00
+++ edited/drivers/video/riva/fbdev.c	2004-08-14 16:05:47 +02:00
@@ -1860,20 +1860,22 @@
 	var->accel_flags |= FB_ACCELF_TEXT;
 	NVTRACE_LEAVE();
 }
-
-
+#ifdef CONFIG_PPC_OF
 static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
-	struct riva_par *par;
-	int i;
-
 	NVTRACE_ENTER();
-#ifdef CONFIG_PPC_OF
 	if (!riva_get_EDID_OF(info, pdev))
 		printk("rivafb: could not retrieve EDID from OF\n");
+	NVTRACE_LEAVE();
+}
 #else
-	/* XXX use other methods later */
 #ifdef CONFIG_FB_RIVA_I2C
+static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
+{
+	struct riva_par *par;
+	int i;
+
+	NVTRACE_ENTER();
 
 	par = (struct riva_par *) info->par;
 	riva_create_i2c_busses(par);
@@ -1885,11 +1887,14 @@
 		}
 	}
 	riva_delete_i2c_busses(par);
-#endif
-#endif
 	NVTRACE_LEAVE();
 }
-
+#else
+static void riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
+{
+}
+#endif
+#endif
 
 static void riva_get_edidinfo(struct fb_info *info)
 {
