Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132937AbRAJTqj>; Wed, 10 Jan 2001 14:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135728AbRAJTq3>; Wed, 10 Jan 2001 14:46:29 -0500
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:37576 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132937AbRAJTqY>; Wed, 10 Jan 2001 14:46:24 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101101738.f0AHciY09066@wittsend.ukgateway.net>
Subject: [PATCH] : Mark read-only ISA-PNP function parameters as "const"
To: torvalds@transmeta.com
Date: Wed, 10 Jan 2001 17:38:43 +0000 (GMT)
Cc: perex@suse.cz, linux-kernel@vger.kernel.org
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is an incredibly boring patch that just adds "const" to some of
the ISA-PNP function prototypes. It compiles cleanly with gcc-2.95.2.

Cheers,
Chris

--- linux-vanilla/include/linux/isapnp.h	Sun Dec 31 19:11:06 2000
+++ linux-2.4.0-ac3/include/linux/isapnp.h	Wed Jan 10 17:08:28 2001
@@ -188,7 +188,7 @@
 struct pci_bus *isapnp_find_card(unsigned short vendor,
 				 unsigned short device,
 				 struct pci_bus *from);
-struct pci_dev *isapnp_find_dev(struct pci_bus *card,
+struct pci_dev *isapnp_find_dev(const struct pci_bus *card,
 				unsigned short vendor,
 				unsigned short function,
 				struct pci_dev *from);
@@ -234,7 +234,7 @@
 extern inline struct pci_bus *isapnp_find_card(unsigned short vendor,
 					       unsigned short device,
 					       struct pci_bus *from) { return NULL; }
-extern inline struct pci_dev *isapnp_find_dev(struct pci_bus *card,
+extern inline struct pci_dev *isapnp_find_dev(const struct pci_bus *card,
 					      unsigned short vendor,
 					      unsigned short function,
 					      struct pci_dev *from) { return NULL; }
--- linux-vanilla/drivers/pnp/isapnp.c	Mon Dec 11 20:38:58 2000
+++ linux-2.4.0-ac3/drivers/pnp/isapnp.c	Wed Jan 10 16:49:13 2001
@@ -1058,7 +1058,7 @@
  *  Resource manager.
  */
 
-static struct isapnp_port *isapnp_find_port(struct pci_dev *dev, int index)
+static struct isapnp_port *isapnp_find_port(const struct pci_dev *dev, int index)
 {
 	struct isapnp_resources *res;
 	struct isapnp_port *port;
@@ -1075,7 +1075,7 @@
 	return NULL;
 }
 
-struct isapnp_irq *isapnp_find_irq(struct pci_dev *dev, int index)
+struct isapnp_irq *isapnp_find_irq(const struct pci_dev *dev, int index)
 {
 	struct isapnp_resources *res, *resa;
 	struct isapnp_irq *irq;
@@ -1102,7 +1102,7 @@
 	return NULL;
 }
 
-struct isapnp_dma *isapnp_find_dma(struct pci_dev *dev, int index)
+struct isapnp_dma *isapnp_find_dma(const struct pci_dev *dev, int index)
 {
 	struct isapnp_resources *res;
 	struct isapnp_dma *dma;
@@ -1119,7 +1119,7 @@
 	return NULL;
 }
 
-struct isapnp_mem *isapnp_find_mem(struct pci_dev *dev, int index)
+struct isapnp_mem *isapnp_find_mem(const struct pci_dev *dev, int index)
 {
 	struct isapnp_resources *res;
 	struct isapnp_mem *mem;
@@ -1136,7 +1136,7 @@
 	return NULL;
 }
 
-struct isapnp_mem32 *isapnp_find_mem32(struct pci_dev *dev, int index)
+struct isapnp_mem32 *isapnp_find_mem32(const struct pci_dev *dev, int index)
 {
 	struct isapnp_resources *res;
 	struct isapnp_mem32 *mem32;
@@ -1176,7 +1176,7 @@
 	return NULL;
 }
 
-struct pci_dev *isapnp_find_dev(struct pci_bus *card,
+struct pci_dev *isapnp_find_dev(const struct pci_bus *card,
 				unsigned short vendor,
 				unsigned short function,
 				struct pci_dev *from)
@@ -1549,7 +1549,7 @@
 	return 0;
 }
 
-static int isapnp_check_port(struct isapnp_cfgtmp *cfg, int port, int size, int idx)
+static int isapnp_check_port(const struct isapnp_cfgtmp *cfg, int port, int size, int idx)
 {
 	int i, tmp, rport, rsize;
 	struct isapnp_port *xport;
@@ -1652,7 +1652,7 @@
 {
 }
 
-static int isapnp_check_interrupt(struct isapnp_cfgtmp *cfg, int irq, int idx)
+static int isapnp_check_interrupt(const struct isapnp_cfgtmp *cfg, int irq, int idx)
 {
 	int i;
 	struct pci_dev *dev;
@@ -1739,7 +1739,7 @@
 	return 0;
 }
 
-static int isapnp_check_dma(struct isapnp_cfgtmp *cfg, int dma, int idx)
+static int isapnp_check_dma(const struct isapnp_cfgtmp *cfg, int dma, int idx)
 {
 	int i;
 	struct pci_dev *dev;
@@ -1814,7 +1814,7 @@
 	return 0;
 }
 
-static int isapnp_check_mem(struct isapnp_cfgtmp *cfg, unsigned int addr, unsigned int size, int idx)
+static int isapnp_check_mem(const struct isapnp_cfgtmp *cfg, unsigned int addr, unsigned int size, int idx)
 {
 	int i, tmp;
 	unsigned int raddr, rsize;
@@ -1911,7 +1911,7 @@
 	return 0;
 }
 
-static int isapnp_check_valid(struct isapnp_cfgtmp *cfg)
+static int isapnp_check_valid(const struct isapnp_cfgtmp *cfg)
 {
 	int tmp;
 	
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
