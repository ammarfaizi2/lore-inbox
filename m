Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWIYB6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWIYB6D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWIYB6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:58:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59537 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751822AbWIYB6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:58:01 -0400
Date: Mon, 25 Sep 2006 02:57:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pata_pdc2027x iomem annotations
Message-ID: <20060925015757.GG29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/ata/pata_pdc2027x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index 56b8c1e..31ab9c8 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -242,7 +242,7 @@ MODULE_DEVICE_TABLE(pci, pdc2027x_pci_tb
  *	@ap: Port
  *	@offset: offset from mmio base
  */
-static inline void* port_mmio(struct ata_port *ap, unsigned int offset)
+static inline void __iomem *port_mmio(struct ata_port *ap, unsigned int offset)
 {
 	return ap->host->mmio_base + ap->port_no * 0x100 + offset;
 }
@@ -253,7 +253,7 @@ static inline void* port_mmio(struct ata
  *	@adev: device
  *	@offset: offset from mmio base
  */
-static inline void* dev_mmio(struct ata_port *ap, struct ata_device *adev, unsigned int offset)
+static inline void __iomem *dev_mmio(struct ata_port *ap, struct ata_device *adev, unsigned int offset)
 {
 	u8 adj = (adev->devno) ? 0x08 : 0x00;
 	return port_mmio(ap, offset) + adj;
@@ -758,7 +758,7 @@ static int __devinit pdc2027x_init_one(s
 
 	struct ata_probe_ent *probe_ent = NULL;
 	unsigned long base;
-	void *mmio_base;
+	void __iomem *mmio_base;
 	int rc;
 
 	if (!printed_version++)
-- 
1.4.2.GIT

