Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSHBXzK>; Fri, 2 Aug 2002 19:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSHBXya>; Fri, 2 Aug 2002 19:54:30 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:53260 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317386AbSHBXxV>;
	Fri, 2 Aug 2002 19:53:21 -0400
Date: Fri, 2 Aug 2002 16:54:54 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI changes for 2.5.30
Message-ID: <20020802235454.GB1999@kroah.com>
References: <20020802235321.GA1999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020802235321.GA1999@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 05 Jul 2002 22:51:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.513   -> 1.514  
#	   drivers/pci/pci.c	1.44    -> 1.45   
#	drivers/pci/compat.c	1.2     -> 1.3    
#	drivers/pci/Makefile	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/02	greg@kroah.com	1.514
# PCI: move the EXPORT_SYMBOL(pcibios_*) declarations to the proper file.
# --------------------------------------------
#
diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Fri Aug  2 16:49:30 2002
+++ b/drivers/pci/Makefile	Fri Aug  2 16:49:30 2002
@@ -2,7 +2,8 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-export-objs := access.o hotplug.o pci-driver.o pci.o pool.o probe.o proc.o search.o
+export-objs	:= access.o hotplug.o pci-driver.o pci.o pool.o \
+			probe.o proc.o search.o compat.o
 
 obj-y		+= access.o probe.o pci.o pool.o quirks.o \
 			compat.o names.o pci-driver.o search.o
diff -Nru a/drivers/pci/compat.c b/drivers/pci/compat.c
--- a/drivers/pci/compat.c	Fri Aug  2 16:49:30 2002
+++ b/drivers/pci/compat.c	Fri Aug  2 16:49:30 2002
@@ -8,8 +8,11 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 
+/* Obsolete functions, these will be going away... */
+
 int
 pcibios_present(void)
 {
@@ -63,3 +66,14 @@
 PCI_OP(write, byte, char)
 PCI_OP(write, word, short)
 PCI_OP(write, dword, int)
+
+
+EXPORT_SYMBOL(pcibios_present);
+EXPORT_SYMBOL(pcibios_read_config_byte);
+EXPORT_SYMBOL(pcibios_read_config_word);
+EXPORT_SYMBOL(pcibios_read_config_dword);
+EXPORT_SYMBOL(pcibios_write_config_byte);
+EXPORT_SYMBOL(pcibios_write_config_word);
+EXPORT_SYMBOL(pcibios_write_config_dword);
+EXPORT_SYMBOL(pcibios_find_class);
+EXPORT_SYMBOL(pcibios_find_device);
diff -Nru a/drivers/pci/pci.c b/drivers/pci/pci.c
--- a/drivers/pci/pci.c	Fri Aug  2 16:49:30 2002
+++ b/drivers/pci/pci.c	Fri Aug  2 16:49:30 2002
@@ -602,18 +602,6 @@
 EXPORT_SYMBOL(pci_restore_state);
 EXPORT_SYMBOL(pci_enable_wake);
 
-/* Obsolete functions */
-
-EXPORT_SYMBOL(pcibios_present);
-EXPORT_SYMBOL(pcibios_read_config_byte);
-EXPORT_SYMBOL(pcibios_read_config_word);
-EXPORT_SYMBOL(pcibios_read_config_dword);
-EXPORT_SYMBOL(pcibios_write_config_byte);
-EXPORT_SYMBOL(pcibios_write_config_word);
-EXPORT_SYMBOL(pcibios_write_config_dword);
-EXPORT_SYMBOL(pcibios_find_class);
-EXPORT_SYMBOL(pcibios_find_device);
-
 /* Quirk info */
 
 EXPORT_SYMBOL(isa_dma_bridge_buggy);
