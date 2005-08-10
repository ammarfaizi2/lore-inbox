Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVHJMMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVHJMMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 08:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965080AbVHJMMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 08:12:55 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:12996 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S965079AbVHJMMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 08:12:54 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net
Subject: [patch 2.6.13-rc6] Export pcibios_bus_to_resource on ia64 and sparc64
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Aug 2005 22:12:33 +1000
Message-ID: <6578.1123675953@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA64 gets *** Warning: "pcibios_bus_to_resource"
[drivers/pcmcia/yenta_socket.ko] undefined!.  Trivial fix, export
pcibios_bus_to_resource.  Also export it on sparc64, which is the only
other architecture that defines pcibios_bus_to_resource but does not
export it.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: linux/arch/ia64/pci/pci.c
===================================================================
--- linux.orig/arch/ia64/pci/pci.c	2005-08-08 21:57:47.415210784 +1000
+++ linux/arch/ia64/pci/pci.c	2005-08-10 22:08:01.218842356 +1000
@@ -380,6 +380,7 @@ void pcibios_bus_to_resource(struct pci_
 	res->start = region->start + offset;
 	res->end = region->end + offset;
 }
+EXPORT_SYMBOL(pcibios_bus_to_resource);
 
 static int __devinit is_valid_resource(struct pci_dev *dev, int idx)
 {
Index: linux/arch/sparc64/kernel/pci.c
===================================================================
--- linux.orig/arch/sparc64/kernel/pci.c	2005-08-10 13:57:47.295579310 +1000
+++ linux/arch/sparc64/kernel/pci.c	2005-08-10 22:09:23.573376709 +1000
@@ -540,6 +540,7 @@ void pcibios_bus_to_resource(struct pci_
 
 	pbm->parent->resource_adjust(pdev, res, root);
 }
+EXPORT_SYMBOL(pcibios_bus_to_resource);
 
 char * __init pcibios_setup(char *str)
 {

