Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269904AbUJTGmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269904AbUJTGmi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269614AbUJSXLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:11:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:6794 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270114AbUJSWq1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:27 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257322457@kroah.com>
Date: Tue, 19 Oct 2004 15:42:12 -0700
Message-Id: <10982257321712@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.3, 2004/10/06 11:18:21-07:00, greg@kroah.com

[PATCH] PCI: make pci_find_subsys() static, as it should not be used anymore

Use pci_get_subsys() if you want this functionality.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/search.c |   10 +++++-----
 include/linux/pci.h  |    7 -------
 2 files changed, 5 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2004-10-19 15:27:42 -07:00
+++ b/drivers/pci/search.c	2004-10-19 15:27:42 -07:00
@@ -156,10 +156,11 @@
  * the pci device returned by this function can disappear at any moment in
  * time.
  */
-struct pci_dev *
-pci_find_subsys(unsigned int vendor, unsigned int device,
-		unsigned int ss_vendor, unsigned int ss_device,
-		const struct pci_dev *from)
+static struct pci_dev * pci_find_subsys(unsigned int vendor,
+				        unsigned int device,
+					unsigned int ss_vendor,
+					unsigned int ss_device,
+					const struct pci_dev *from)
 {
 	struct list_head *n;
 	struct pci_dev *dev;
@@ -351,7 +352,6 @@
 EXPORT_SYMBOL(pci_find_device);
 EXPORT_SYMBOL(pci_find_device_reverse);
 EXPORT_SYMBOL(pci_find_slot);
-EXPORT_SYMBOL(pci_find_subsys);
 EXPORT_SYMBOL(pci_get_device);
 EXPORT_SYMBOL(pci_get_subsys);
 EXPORT_SYMBOL(pci_get_slot);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-10-19 15:27:42 -07:00
+++ b/include/linux/pci.h	2004-10-19 15:27:42 -07:00
@@ -719,9 +719,6 @@
 
 struct pci_dev *pci_find_device (unsigned int vendor, unsigned int device, const struct pci_dev *from);
 struct pci_dev *pci_find_device_reverse (unsigned int vendor, unsigned int device, const struct pci_dev *from);
-struct pci_dev *pci_find_subsys (unsigned int vendor, unsigned int device,
-				 unsigned int ss_vendor, unsigned int ss_device,
-				 const struct pci_dev *from);
 struct pci_dev *pci_find_class (unsigned int class, const struct pci_dev *from);
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
@@ -886,10 +883,6 @@
 { return NULL; }
 
 static inline struct pci_dev *pci_find_slot(unsigned int bus, unsigned int devfn)
-{ return NULL; }
-
-static inline struct pci_dev *pci_find_subsys(unsigned int vendor, unsigned int device,
-unsigned int ss_vendor, unsigned int ss_device, const struct pci_dev *from)
 { return NULL; }
 
 static inline struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from)

