Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSJCWiQ>; Thu, 3 Oct 2002 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbSJCWiQ>; Thu, 3 Oct 2002 18:38:16 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:27661 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261368AbSJCWiN>;
	Thu, 3 Oct 2002 18:38:13 -0400
Date: Thu, 3 Oct 2002 15:40:56 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
Message-ID: <20021003224055.GB2289@kroah.com>
References: <20021003224011.GA2289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003224011.GA2289@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.682   -> 1.683  
#	drivers/pci/compat.c	1.3     -> 1.4    
#	 include/linux/pci.h	1.42    -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/03	greg@kroah.com	1.683
# PCI: remove pcibios_find_class()
# --------------------------------------------
#
diff -Nru a/drivers/pci/compat.c b/drivers/pci/compat.c
--- a/drivers/pci/compat.c	Thu Oct  3 14:24:18 2002
+++ b/drivers/pci/compat.c	Thu Oct  3 14:24:18 2002
@@ -20,22 +20,6 @@
 }
 
 int
-pcibios_find_class(unsigned int class, unsigned short index, unsigned char *bus, unsigned char *devfn)
-{
-	const struct pci_dev *dev = NULL;
-	int cnt = 0;
-
-	while ((dev = pci_find_class(class, dev)))
-		if (index == cnt++) {
-			*bus = dev->bus->number;
-			*devfn = dev->devfn;
-			return PCIBIOS_SUCCESSFUL;
-		}
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-
-int
 pcibios_find_device(unsigned short vendor, unsigned short device, unsigned short index,
 		    unsigned char *bus, unsigned char *devfn)
 {
@@ -75,5 +59,4 @@
 EXPORT_SYMBOL(pcibios_write_config_byte);
 EXPORT_SYMBOL(pcibios_write_config_word);
 EXPORT_SYMBOL(pcibios_write_config_dword);
-EXPORT_SYMBOL(pcibios_find_class);
 EXPORT_SYMBOL(pcibios_find_device);
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu Oct  3 14:24:18 2002
+++ b/include/linux/pci.h	Thu Oct  3 14:24:18 2002
@@ -533,7 +533,6 @@
 			       unsigned char where, unsigned short val);
 int pcibios_write_config_dword (unsigned char bus, unsigned char dev_fn,
 				unsigned char where, unsigned int val);
-int pcibios_find_class (unsigned int class_code, unsigned short index, unsigned char *bus, unsigned char *dev_fn);
 int pcibios_find_device (unsigned short vendor, unsigned short dev_id,
 			 unsigned short index, unsigned char *bus,
 			 unsigned char *dev_fn);
@@ -661,8 +660,6 @@
 
 #ifndef CONFIG_PCI
 static inline int pcibios_present(void) { return 0; }
-static inline int pcibios_find_class (unsigned int class_code, unsigned short index, unsigned char *bus, unsigned char *dev_fn) 
-{ 	return PCIBIOS_DEVICE_NOT_FOUND; }
 
 #define _PCI_NOP(o,s,t) \
 	static inline int pcibios_##o##_config_##s (u8 bus, u8 dfn, u8 where, t val) \
