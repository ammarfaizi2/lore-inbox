Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752461AbWAFQaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbWAFQaf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbWAFQaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:30:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:11455 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752446AbWAFQ3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:29:49 -0500
Date: Fri, 6 Jan 2006 16:29:37 GMT
Message-Id: <200601061629.k06GTbx4011392@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com
Cc: linux-kernel@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 16/17] FRV: Fix uninitialised variable in serverworks driver
In-Reply-To: <dhowells1136564974@warthog.cambridge.redhat.com>
References: <dhowells1136564974@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes an uninitialised variable warning in the serverworks
driver.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 serverworks-2615.diff
 drivers/ide/pci/serverworks.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNrp /warthog/kernels/linux-2.6.15/drivers/ide/pci/serverworks.c linux-2.6.15-frv/drivers/ide/pci/serverworks.c
--- /warthog/kernels/linux-2.6.15/drivers/ide/pci/serverworks.c	2005-08-30 13:56:16.000000000 +0100
+++ linux-2.6.15-frv/drivers/ide/pci/serverworks.c	2006-01-06 14:43:43.000000000 +0000
@@ -69,7 +69,7 @@ static int check_in_drive_lists (ide_dri
 static u8 svwks_ratemask (ide_drive_t *drive)
 {
 	struct pci_dev *dev     = HWIF(drive)->pci_dev;
-	u8 mode;
+	u8 mode = 0;
 
 	if (!svwks_revision)
 		pci_read_config_byte(dev, PCI_REVISION_ID, &svwks_revision);
