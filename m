Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVAGHOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVAGHOv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 02:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVAGHOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 02:14:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:11190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261294AbVAGHOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 02:14:46 -0500
Date: Thu, 6 Jan 2005 23:01:35 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>, amax@us.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] ibmasm: fix init/exit sections
Message-Id: <20050106230135.0c368fdd.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix init & exit section usage, started with this diagnostic
from reference_discarded.pl (make buildcheck):
Error: ./drivers/misc/ibmasm/module.o .data refers to 00000058 R_386_32          .exit.text

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/misc/ibmasm/module.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/misc/ibmasm/module.c~ibmasm_devexit ./drivers/misc/ibmasm/module.c
--- ./drivers/misc/ibmasm/module.c~ibmasm_devexit	2004-12-24 13:35:00.000000000 -0800
+++ ./drivers/misc/ibmasm/module.c	2005-01-06 21:33:59.261935440 -0800
@@ -57,7 +57,7 @@
 #include "remote.h"
 
 
-static int __init ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
+static int __devinit ibmasm_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int err, result = -ENOMEM;
 	struct service_processor *sp;
@@ -161,7 +161,7 @@ error_kmalloc:
 	return result;
 }
 
-static void __exit ibmasm_remove_one(struct pci_dev *pdev)
+static void __devexit ibmasm_remove_one(struct pci_dev *pdev)
 {
 	struct service_processor *sp = (struct service_processor *)pci_get_drvdata(pdev);
 


---
