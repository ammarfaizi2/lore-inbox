Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWDOFmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWDOFmO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 01:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWDOFmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 01:42:14 -0400
Received: from xenotime.net ([66.160.160.81]:20160 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030260AbWDOFmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 01:42:13 -0400
Date: Fri, 14 Apr 2006 22:44:39 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] parport_pc: fix section mismatch warnings
Message-Id: <20060414224439.b9a91323.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix modpost section mismatch warnings in parport_pc:

WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x230)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x283)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x3e6)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x400)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x463)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.text: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x488)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.data:superios from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x54c)
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.data: from .text.parport_pc_probe_port after 'parport_pc_probe_port' (at offset 0x56a)

This still leaves 5 other PCI-related section mismatches, but I
don't think that they are a real problem unless there are some
hotplug-parport cards out there.  If needed, I'll fix those too.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/parport/parport_pc.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2617-rc1g8.orig/drivers/parport/parport_pc.c
+++ linux-2617-rc1g8/drivers/parport/parport_pc.c
@@ -97,7 +97,7 @@ static struct superio_struct {	/* For Su
 	int io;
 	int irq;
 	int dma;
-} superios[NR_SUPERIOS] __devinitdata = { {0,},};
+} superios[NR_SUPERIOS] = { {0,},};
 
 static int user_specified;
 #if defined(CONFIG_PARPORT_PC_SUPERIO) || \
@@ -1557,7 +1557,7 @@ static int __devinit get_superio_dma (st
 	return PARPORT_DMA_NONE;
 }
 
-static int __devinit get_superio_irq (struct parport *p)
+static int get_superio_irq (struct parport *p)
 {
 	int i=0;
         while( (superios[i].io != p->base) && (i<NR_SUPERIOS))
@@ -1579,7 +1579,7 @@ static int __devinit get_superio_irq (st
  *                         this shall always be the case!)
  *
  */
-static int __devinit parport_SPP_supported(struct parport *pb)
+static int parport_SPP_supported(struct parport *pb)
 {
 	unsigned char r, w;
 
@@ -1660,7 +1660,7 @@ static int __devinit parport_SPP_support
  * two bits of ECR aren't writable, so we check by writing ECR and
  * reading it back to see if it's what we expect.
  */
-static int __devinit parport_ECR_present(struct parport *pb)
+static int parport_ECR_present(struct parport *pb)
 {
 	struct parport_pc_private *priv = pb->private_data;
 	unsigned char r = 0xc;
@@ -1712,7 +1712,7 @@ static int __devinit parport_ECR_present
  * be misdetected here is rather academic. 
  */
 
-static int __devinit parport_PS2_supported(struct parport *pb)
+static int parport_PS2_supported(struct parport *pb)
 {
 	int ok = 0;
   
@@ -1868,7 +1868,7 @@ static int __devinit parport_ECP_support
 }
 #endif
 
-static int __devinit parport_ECPPS2_supported(struct parport *pb)
+static int parport_ECPPS2_supported(struct parport *pb)
 {
 	const struct parport_pc_private *priv = pb->private_data;
 	int result;
@@ -1886,7 +1886,7 @@ static int __devinit parport_ECPPS2_supp
 
 /* EPP mode detection  */
 
-static int __devinit parport_EPP_supported(struct parport *pb)
+static int parport_EPP_supported(struct parport *pb)
 {
 	const struct parport_pc_private *priv = pb->private_data;
 
@@ -1931,7 +1931,7 @@ static int __devinit parport_EPP_support
 	return 1;
 }
 
-static int __devinit parport_ECPEPP_supported(struct parport *pb)
+static int parport_ECPEPP_supported(struct parport *pb)
 {
 	struct parport_pc_private *priv = pb->private_data;
 	int result;
@@ -2073,7 +2073,7 @@ static int __devinit irq_probe_SPP(struc
  * When ECP is available we can autoprobe for IRQs.
  * NOTE: If we can autoprobe it, we can register the IRQ.
  */
-static int __devinit parport_irq_probe(struct parport *pb)
+static int parport_irq_probe(struct parport *pb)
 {
 	struct parport_pc_private *priv = pb->private_data;
 


---
