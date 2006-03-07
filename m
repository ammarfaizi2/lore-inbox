Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWCGUMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCGUMj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWCGUMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:12:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:14226 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932232AbWCGUMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:12:38 -0500
X-Authenticated: #704063
Subject: [Patch] Dead code in mtd/maps/pci.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Content-Type: text/plain
Date: Tue, 07 Mar 2006 21:12:35 +0100
Message-Id: <1141762355.8065.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this fixed coverity bug #12. The first two gotos
in the function still have the initial value for mtd set.
And the third goto just triggers for !mtd

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.16-rc5-mm1/drivers/mtd/maps/pci.c.orig	2006-03-07 21:08:08.000000000 +0100
+++ linux-2.6.16-rc5-mm1/drivers/mtd/maps/pci.c	2006-03-07 21:08:23.000000000 +0100
@@ -334,9 +334,6 @@ mtd_pci_probe(struct pci_dev *dev, const
 	return 0;
 
 release:
-	if (mtd)
-		map_destroy(mtd);
-
 	if (map) {
 		map->exit(dev, map);
 		kfree(map);


