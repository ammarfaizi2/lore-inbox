Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVDAXsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVDAXsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVDAXsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:48:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:25052 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262804AbVDAXsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:08 -0500
Cc: gregkh@suse.de
Subject: PCI: clean up the dynamic id logic a little bit.
In-Reply-To: <11123992742611@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:54 -0800
Message-Id: <11123992741405@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.25, 2005/03/28 22:00:24-08:00, gregkh@suse.de

PCI: clean up the dynamic id logic a little bit.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/pci-driver.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2005-04-01 15:31:02 -08:00
+++ b/drivers/pci/pci-driver.c	2005-04-01 15:31:02 -08:00
@@ -49,13 +49,6 @@
 	return error;
 }
 
-static inline void
-dynid_init(struct dynid *dynid)
-{
-	memset(dynid, 0, sizeof(*dynid));
-	INIT_LIST_HEAD(&dynid->node);
-}
-
 /**
  * store_new_id
  *
@@ -82,8 +75,9 @@
 	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
 	if (!dynid)
 		return -ENOMEM;
-	dynid_init(dynid);
 
+	memset(dynid, 0, sizeof(*dynid));
+	INIT_LIST_HEAD(&dynid->node);
 	dynid->id.vendor = vendor;
 	dynid->id.device = device;
 	dynid->id.subvendor = subvendor;
@@ -167,7 +161,6 @@
 {
 	return -ENODEV;
 }
-static inline void dynid_init(struct dynid *dynid) {}
 static inline void pci_init_dynids(struct pci_dynids *dynids) {}
 static inline void pci_free_dynids(struct pci_driver *drv) {}
 static inline int pci_create_newid_file(struct pci_driver *drv)

