Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVHXGGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVHXGGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVHXGGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:06:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61105 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751464AbVHXGGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:06:36 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.13-rc7] Export pcibios_bus_to_resource
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Aug 2005 16:06:25 +1000
Message-ID: <12744.1124863585@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pcibios_bus_to_resource is exported on all architectures except ia64
and sparc.  Add exports for the two missing architectures.  Needed when
Yenta socket support is compiled as a module.

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

