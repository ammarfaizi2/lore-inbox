Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbWCECwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbWCECwv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWCECwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:52:51 -0500
Received: from havoc.gtf.org ([69.61.125.42]:43669 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751066AbWCECwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:52:50 -0500
Date: Sat, 4 Mar 2006 21:52:42 -0500
From: Jeff Garzik <jeff@garzik.org>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <gregkh@suse.de>, akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] fix pci_request_region[s] arg
Message-ID: <20060305025242.GA11373@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I just checked this fix into the 'res' branch of jgarzik/misc-2.6.git...

arguably it can go into 2.6.16-rc but its low priority.  Without this it
causes a bogus warning in some cases.



commit 3175376926eba8706b8e6b62c9d86cfde92bc15e
Author: Jeff Garzik <jeff@garzik.org>
Date:   Sat Mar 4 21:46:56 2006 -0500

    Add missing 'const' to pci_request_region[s] 'res_name' arg,
    since we pass it directly to __request_region(), whose 'name' arg
    is also const.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2d1879..7fad922 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -639,7 +639,7 @@ void pci_release_region(struct pci_dev *
  *	Returns 0 on success, or %EBUSY on error.  A warning
  *	message is also printed on failure.
  */
-int pci_request_region(struct pci_dev *pdev, int bar, char *res_name)
+int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
@@ -697,7 +697,7 @@ void pci_release_regions(struct pci_dev 
  *	Returns 0 on success, or %EBUSY on error.  A warning
  *	message is also printed on failure.
  */
-int pci_request_regions(struct pci_dev *pdev, char *res_name)
+int pci_request_regions(struct pci_dev *pdev, const char *res_name)
 {
 	int i;
 	
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fe1a2b0..6336e1b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -485,9 +485,9 @@ void pdev_sort_resources(struct pci_dev 
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
-int pci_request_regions(struct pci_dev *, char *);
+int pci_request_regions(struct pci_dev *, const char *);
 void pci_release_regions(struct pci_dev *);
-int pci_request_region(struct pci_dev *, int, char *);
+int pci_request_region(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
