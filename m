Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263361AbVCDXIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbVCDXIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbVCDXEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:04:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:45474 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263193AbVCDUy7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:59 -0500
Cc: muneda.takahiro@jp.fujitsu.com
Subject: [PATCH] PCI: fix pci_remove_legacy_files() crash
In-Reply-To: <11099696361878@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:56 -0800
Message-Id: <11099696363673@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.11, 2005/02/07 16:20:26-08:00, muneda.takahiro@jp.fujitsu.com

[PATCH] PCI: fix pci_remove_legacy_files() crash

The legacy_io which is the member of pci_bus struct might be
NULL. It should be checked.

This patch checks 'b->legacy_io', NULL or not.

Signed-off-by: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Acked-by: Jesse Barnes <jbarnes@sgi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/probe.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-03-04 12:42:59 -08:00
+++ b/drivers/pci/probe.c	2005-03-04 12:42:59 -08:00
@@ -64,9 +64,11 @@
 
 void pci_remove_legacy_files(struct pci_bus *b)
 {
-	class_device_remove_bin_file(&b->class_dev, b->legacy_io);
-	class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
-	kfree(b->legacy_io); /* both are allocated here */
+	if (b->legacy_io) {
+		class_device_remove_bin_file(&b->class_dev, b->legacy_io);
+		class_device_remove_bin_file(&b->class_dev, b->legacy_mem);
+		kfree(b->legacy_io); /* both are allocated here */
+	}
 }
 #else /* !HAVE_PCI_LEGACY */
 static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }

