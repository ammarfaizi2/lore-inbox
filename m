Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSJCWih>; Thu, 3 Oct 2002 18:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261411AbSJCWih>; Thu, 3 Oct 2002 18:38:37 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:28173 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261407AbSJCWid>;
	Thu, 3 Oct 2002 18:38:33 -0400
Date: Thu, 3 Oct 2002 15:41:16 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021003224116.GC2289@kroah.com>
References: <20021003224011.GA2289@kroah.com> <20021003224055.GB2289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003224055.GB2289@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.683   -> 1.684  
#	drivers/pci/compat.c	1.4     -> 1.5    
#	 include/linux/pci.h	1.43    -> 1.44   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	greg@kroah.com	1.684
# PCI: remove pci_find_device()
# --------------------------------------------
#
diff -Nru a/drivers/pci/compat.c b/drivers/pci/compat.c
--- a/drivers/pci/compat.c	Thu Oct  3 14:24:15 2002
+++ b/drivers/pci/compat.c	Thu Oct  3 14:24:15 2002
@@ -19,22 +19,6 @@
 	return !list_empty(&pci_devices);
 }
 
-int
-pcibios_find_device(unsigned short vendor, unsigned short device, unsigned short index,
-		    unsigned char *bus, unsigned char *devfn)
-{
-	const struct pci_dev *dev = NULL;
-	int cnt = 0;
-
-	while ((dev = pci_find_device(vendor, device, dev)))
-		if (index == cnt++) {
-			*bus = dev->bus->number;
-			*devfn = dev->devfn;
-			return PCIBIOS_SUCCESSFUL;
-		}
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
 #define PCI_OP(rw,size,type)							\
 int pcibios_##rw##_config_##size (unsigned char bus, unsigned char dev_fn,	\
 				  unsigned char where, unsigned type val)	\
@@ -59,4 +43,3 @@
 EXPORT_SYMBOL(pcibios_write_config_byte);
 EXPORT_SYMBOL(pcibios_write_config_word);
 EXPORT_SYMBOL(pcibios_write_config_dword);
-EXPORT_SYMBOL(pcibios_find_device);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Oct  3 14:24:15 2002
+++ b/include/linux/pci.h	Thu Oct  3 14:24:15 2002
@@ -533,9 +533,6 @@
 			       unsigned char where, unsigned short val);
 int pcibios_write_config_dword (unsigned char bus, unsigned char dev_fn,
 				unsigned char where, unsigned int val);
-int pcibios_find_device (unsigned short vendor, unsigned short dev_id,
-			 unsigned short index, unsigned char *bus,
-			 unsigned char *dev_fn);
 
 /* Generic PCI functions used internally */
 
