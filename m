Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136543AbRAMFjO>; Sat, 13 Jan 2001 00:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136558AbRAMFjF>; Sat, 13 Jan 2001 00:39:05 -0500
Received: from tsukuba.m17n.org ([192.47.44.130]:42412 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S136543AbRAMFi4>;
	Sat, 13 Jan 2001 00:38:56 -0500
Date: Sat, 13 Jan 2001 14:38:49 +0900 (JST)
Message-Id: <200101130538.OAA03419@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CPP ## string concatination is for the token
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that `##' operator for string concatination produces the token.

In pci.h, we have bogus `##' operator which doesn't produce valid
token.  We don't need (must not) have ## between `s' and the open
paren.

Here's the patch.
 
diff -ruN v2.4.1-pre3/include/linux/pci.h linux/include/linux/pci.h
--- v2.4.1-pre3/include/linux/pci.h	Fri Jan  5 07:51:32 2001
+++ linux/include/linux/pci.h	Mon Jan  8 17:36:44 2001
@@ -565,9 +565,9 @@
 { 	return PCIBIOS_DEVICE_NOT_FOUND; }
 
 #define _PCI_NOP(o,s,t) \
-	static inline int pcibios_##o##_config_##s## (u8 bus, u8 dfn, u8 where, t val) \
+	static inline int pcibios_##o##_config_##s (u8 bus, u8 dfn, u8 where, t val) \
 		{ return PCIBIOS_FUNC_NOT_SUPPORTED; } \
-	static inline int pci_##o##_config_##s## (struct pci_dev *dev, int where, t val) \
+	static inline int pci_##o##_config_##s (struct pci_dev *dev, int where, t val) \
 		{ return PCIBIOS_FUNC_NOT_SUPPORTED; }
 #define _PCI_NOP_ALL(o,x)	_PCI_NOP(o,byte,u8 x) \
 				_PCI_NOP(o,word,u16 x) \
-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
