Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271782AbTGROIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 10:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270085AbTGROFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 10:05:12 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23941
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271716AbTGROE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:04:59 -0400
Date: Fri, 18 Jul 2003 15:19:18 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307181419.h6IEJIRh017762@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: undefined shifts in qla1280
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


C doesn't define >> by 32 for 32bit systems, and on some gcc leaves
you with the original value...

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test1/drivers/scsi/qla1280.c linux-2.6.0-test1-ac2/drivers/scsi/qla1280.c
--- linux-2.6.0-test1/drivers/scsi/qla1280.c	2003-07-10 21:15:36.000000000 +0100
+++ linux-2.6.0-test1-ac2/drivers/scsi/qla1280.c	2003-07-14 14:55:46.000000000 +0100
@@ -327,7 +327,7 @@
 /* 3.16 */
 #ifdef QLA_64BIT_PTR
 #define pci_dma_lo32(a)		(a & 0xffffffff)
-#define pci_dma_hi32(a)		(a >> 32)
+#define pci_dma_hi32(a)		((a >> 16)>>16)
 #else
 #define pci_dma_lo32(a)		(a & 0xffffffff)
 #define pci_dma_hi32(a)		0
