Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317435AbSFMDqI>; Wed, 12 Jun 2002 23:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSFMDqH>; Wed, 12 Jun 2002 23:46:07 -0400
Received: from newman.msbb.uc.edu ([129.137.2.198]:58640 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317435AbSFMDqG>;
	Wed, 12 Jun 2002 23:46:06 -0400
From: kuebelr@email.uc.edu
Date: Wed, 12 Jun 2002 23:46:00 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] tdfxfb - compiler warning
Message-Id: <20020613034600.GA3927@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When tdfxfb is compiled into the kernel proper, tdfxfb_remove is not
needed.  Don't compile it if we don't need it.  There is one other
reference to tdfxfb_remove in tdfxfb.c but, __devexit_p() takes care of
it.

Patch is against 2.4.19-pre10.

Rob.

diff -aur linux-clean/drivers/video/tdfxfb.c linux-dirty/drivers/video/tdfxfb.c
--- linux-clean/drivers/video/tdfxfb.c  Mon Feb 25 14:38:07 2002
+++ linux-dirty/drivers/video/tdfxfb.c  Sat Jun  8 12:32:23 2002
@@ -464,7 +464,9 @@
  * PCI driver prototypes
  */
 static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id);
+#ifdef MODULE
 static void tdfxfb_remove(struct pci_dev *pdev);
+#endif

 static int currcon = 0;

@@ -2037,6 +2039,7 @@
        return 0;
 }

+#ifdef MODULE
 /**
  *     tdfxfb_remove - Device removal
  *
@@ -2061,6 +2064,7 @@
        iounmap(fb_info.regbase_virt);
        iounmap(fb_info.bufbase_virt);
 }
+#endif

 int __init tdfxfb_init(void)
 {
