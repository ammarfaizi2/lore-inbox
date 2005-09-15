Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVIOBEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVIOBEa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVIOBEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:04:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030275AbVIOBE3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:04:29 -0400
Message-Id: <20050915010404.660502000@localhost.localdomain>
References: <20050915010343.577985000@localhost.localdomain>
Date: Wed, 14 Sep 2005 18:03:47 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Linus Torvalds <torvalds@osdl.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address, not just low 1 byte
Content-Disposition: inline; filename=hpt366-write-dword-not-byte-for-ROM-resource.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This is one heck of a confused driver.  It uses a byte write to a dword
register to enable a ROM resource that it doesn't even seem to be using.

"Lost and wandering in the desert of confusion"

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 drivers/ide/pci/hpt366.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.13.y/drivers/ide/pci/hpt366.c
===================================================================
--- linux-2.6.13.y.orig/drivers/ide/pci/hpt366.c
+++ linux-2.6.13.y/drivers/ide/pci/hpt366.c
@@ -1334,9 +1334,13 @@ static int __devinit init_hpt366(struct 
 static unsigned int __devinit init_chipset_hpt366(struct pci_dev *dev, const char *name)
 {
 	int ret = 0;
-	/* FIXME: Not portable */
+
+	/*
+	 * FIXME: Not portable. Also, why do we enable the ROM in the first place?
+	 * We don't seem to be using it.
+	 */
 	if (dev->resource[PCI_ROM_RESOURCE].start)
-		pci_write_config_byte(dev, PCI_ROM_ADDRESS,
+		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));

--
