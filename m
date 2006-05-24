Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWEXEYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWEXEYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWEXEYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:24:33 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20702 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932559AbWEXEYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:24:31 -0400
Message-ID: <4473DFFB.1030100@garzik.org>
Date: Wed, 24 May 2006 00:24:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [Fwd: [PATCH] Revive pci_find_ext_capability]
Content-Type: multipart/mixed;
 boundary="------------010808040608000702000306"
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010808040608000702000306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

FYI...  I'll be applying this via netdev, since the Myri net driver 
requires it.

	Jeff



--------------010808040608000702000306
Content-Type: message/rfc822;
 name="[PATCH] Revive pci_find_ext_capability"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH] Revive pci_find_ext_capability"

X-Account-Key: account2
Return-path: <bgoglin@myri.com>
Envelope-to: jeff@garzik.org
Delivery-date: Tue, 23 May 2006 10:11:06 +0000
Received: from srv1.dvmed.net ([207.234.209.181])
	by mail.dvmed.net with esmtps (Exim 4.60 #1 (Red Hat Linux))
	id 1FiTr0-0000tZ-Ji
	for jeff@garzik.org; Tue, 23 May 2006 10:11:06 +0000
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70] helo=myri.com)
	by srv1.dvmed.net with esmtp (Exim 4.60 #1 (Red Hat Linux))
	id 1FiTqg-0008MS-QE
	for jeff@garzik.org; Tue, 23 May 2006 10:11:01 +0000
Received: from ice.sw.myri.com (ice.sw.myri.com [172.31.160.2])
	by myri.com (8.12.9+Sun/8.12.9) with ESMTP id k4NA9xMv004799
	for <jeff@garzik.org>; Tue, 23 May 2006 03:10:00 -0700 (PDT)
Received: from bgoglin by ice.sw.myri.com with local (Exim 3.36 #1 (Debian))
	id 1FiTpx-0004Pz-00
	for <jeff@garzik.org>; Tue, 23 May 2006 06:10:01 -0400
Date: Tue, 23 May 2006 06:10:01 -0400
From: Brice Goglin <brice@myri.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] Revive pci_find_ext_capability
Message-ID: <20060523101000.GA15817@myri.com>
References: <20060523070919.GB30499@myri.com> <4472D8CE.8070007@garzik.org> <4472D9FC.1080708@myri.com> <4472DBEE.5060802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4472DBEE.5060802@garzik.org>
User-Agent: Mutt/1.5.9i
Sender: Brice Goglin <bgoglin@myri.com>
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.1.1 on srv1.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)

[PATCH] Revive pci_find_ext_capability

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


--------------010808040608000702000306--
