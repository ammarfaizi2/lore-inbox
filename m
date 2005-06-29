Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVF2OhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVF2OhB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVF2OhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:37:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:40910 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261165AbVF2Ogw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:36:52 -0400
Subject: [PATCH] tpm: fix bug introduced by the /proc/misc
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 29 Jun 2005 09:36:43 -0500
Message-Id: <1120055803.7079.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fixing the /proc/misc problem that was reported last week where the
tpm module name was being obfuscated in /proc/misc I introduced a bug in
the module unloading code.  This patch fixes the problem.

Thanks,
Kylie

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
Index: drivers/char/tpm/tpm.c
===================================================================
RCS file: /cvsroot/tpmdd/tpmdd/drivers/char/tpm/tpm.c,v
retrieving revision 1.28
diff -u -p -r1.28 tpm.c
--- ./drivers/char/tpm/tpm.c	15 Jun 2005 17:15:18 -0000	1.28
+++ ./drivers/char/tpm/tpm.c	23 Jun 2005 21:37:46 -0000
@@ -488,6 +497,6 @@ void __devexit tpm_remove(struct pci_dev
 
 	pci_set_drvdata(pci_dev, NULL);
 	misc_deregister(&chip->vendor->miscdev);
-	kfree(&chip->vendor->miscdev.name);
+	kfree(chip->vendor->miscdev.name);
 
 	sysfs_remove_group(&pci_dev->dev.kobj, chip->vendor->attr_group);


