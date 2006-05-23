Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWEWHLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWEWHLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWEWHLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:11:08 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:34263 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932077AbWEWHLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:11:07 -0400
Date: Tue, 23 May 2006 03:11:05 -0400
From: Brice Goglin <brice@myri.com>
To: netdev@vger.kernel.org
Cc: gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] myri10ge - Revive pci_find_ext_capability
Message-ID: <20060523071105.GD30499@myri.com>
References: <20060523070919.GB30499@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523070919.GB30499@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2/5] myri10ge - Revive pci_find_ext_capability

This patch revives pci_find_ext_capability (has been disabled a couple month
ago since it was not used anywhere. See http://lkml.org/lkml/2006/1/20/247).
It will now be used by the myri10ge driver.

Signed-off-by: Brice Goglin <brice@myri.com>
Signed-off-by: Andrew J. Gallatin <gallatin@myri.com>

 drivers/pci/pci.c   |    3 +--
 include/linux/pci.h |    2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

--- linux-mm/drivers/pci/pci.c.old
+++ linux-mm/drivers/pci/pci.c
@@ -164,7 +164,6 @@ int pci_bus_find_capability(struct pci_b
 	return __pci_bus_find_cap(bus, devfn, hdr_type & 0x7f, cap);
 }
 
-#if 0
 /**
  * pci_find_ext_capability - Find an extended capability
  * @dev: PCI device to query
@@ -212,7 +211,7 @@ int pci_find_ext_capability(struct pci_d
 
 	return 0;
 }
-#endif  /*  0  */
+EXPORT_SYMBOL_GPL(pci_find_ext_capability);
 
 /**
  * pci_find_parent_resource - return resource region of parent bus of given region
--- linux-mm/include/linux/pci.h.old
+++ linux-mm/include/linux/pci.h
@@ -442,6 +442,7 @@ struct pci_dev *pci_find_device_reverse 
 struct pci_dev *pci_find_slot (unsigned int bus, unsigned int devfn);
 int pci_find_capability (struct pci_dev *dev, int cap);
 int pci_find_next_capability (struct pci_dev *dev, u8 pos, int cap);
+int pci_find_ext_capability (struct pci_dev *dev, int cap);
 struct pci_bus * pci_find_next_bus(const struct pci_bus *from);
 
 struct pci_dev *pci_get_device (unsigned int vendor, unsigned int device, struct pci_dev *from);
@@ -664,6 +665,7 @@ static inline int pci_register_driver(st
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline int pci_find_next_capability (struct pci_dev *dev, u8 post, int cap) { return 0; }
+static inline int pci_find_ext_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
 
 /* Power management related routines */
