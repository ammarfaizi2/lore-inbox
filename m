Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbUKMDBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUKMDBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 22:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUKMDBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 22:01:33 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:62471 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261733AbUKMDB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 22:01:27 -0500
Date: Sat, 13 Nov 2004 04:00:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Philip.Blundell@pobox.com, tim@cyberelk.net, campbell@torque.net,
       andrea@e-mind.com
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] some parport_pc.c cleanups
Message-ID: <20041113030054.GT2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the following changes to 
drivers/parport/parport_pc.c :
- make some needlessly global functions static
- #if 0 two currently unused functions


diffstat output:
 drivers/parport/parport_pc.c |   28 +++++++++++++++-------------
 include/linux/parport_pc.h   |    6 ------
 2 files changed, 15 insertions(+), 19 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/include/linux/parport_pc.h.old	2004-11-13 01:19:54.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/include/linux/parport_pc.h	2004-11-13 01:20:14.000000000 +0100
@@ -228,12 +228,6 @@
 
 extern int parport_pc_claim_resources(struct parport *p);
 
-extern void parport_pc_init_state(struct pardevice *, struct parport_state *s);
-
-extern void parport_pc_save_state(struct parport *p, struct parport_state *s);
-
-extern void parport_pc_restore_state(struct parport *p, struct parport_state *s);
-
 /* PCMCIA code will want to get us to look at a port.  Provide a mechanism. */
 extern struct parport *parport_pc_probe_port (unsigned long base,
 					      unsigned long base_hi,
--- linux-2.6.10-rc1-mm5-full/drivers/parport/parport_pc.c.old	2004-11-13 01:20:23.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/parport/parport_pc.c	2004-11-13 01:34:16.000000000 +0100
@@ -193,6 +193,7 @@
 
 #ifdef CONFIG_PARPORT_1284
 /* Find FIFO lossage; FIFO is reset */
+#if 0
 static int get_fifo_residue (struct parport *p)
 {
 	int residue;
@@ -233,6 +234,7 @@
 	DPRINTK (KERN_DEBUG "*** get_fifo_residue: done residue collecting (ecr = 0x%2.2x)\n", inb (ECONTROL (p)));
 	return residue;
 }
+#endif  /*  0 */
 #endif /* IEEE 1284 support */
 #endif /* FIFO support */
 
@@ -273,7 +275,7 @@
 	return IRQ_HANDLED;
 }
 
-void parport_pc_init_state(struct pardevice *dev, struct parport_state *s)
+static void parport_pc_init_state(struct pardevice *dev, struct parport_state *s)
 {
 	s->u.pc.ctr = 0xc;
 	if (dev->irq_func &&
@@ -285,7 +287,7 @@
 			     * D.Gruszka VScom */
 }
 
-void parport_pc_save_state(struct parport *p, struct parport_state *s)
+static void parport_pc_save_state(struct parport *p, struct parport_state *s)
 {
 	const struct parport_pc_private *priv = p->physport->private_data;
 	s->u.pc.ctr = priv->ctr;
@@ -293,7 +295,7 @@
 		s->u.pc.ecr = inb (ECONTROL (p));
 }
 
-void parport_pc_restore_state(struct parport *p, struct parport_state *s)
+static void parport_pc_restore_state(struct parport *p, struct parport_state *s)
 {
 	struct parport_pc_private *priv = p->physport->private_data;
 	register unsigned char c = s->u.pc.ctr & priv->ctr_writable;
@@ -732,9 +734,9 @@
 }
 
 /* Parallel Port FIFO mode (ECP chipsets) */
-size_t parport_pc_compat_write_block_pio (struct parport *port,
-					  const void *buf, size_t length,
-					  int flags)
+static size_t parport_pc_compat_write_block_pio (struct parport *port,
+						 const void *buf, size_t length,
+						 int flags)
 {
 	size_t written;
 	int r;
@@ -809,9 +811,9 @@
 
 /* ECP */
 #ifdef CONFIG_PARPORT_1284
-size_t parport_pc_ecp_write_block_pio (struct parport *port,
-				       const void *buf, size_t length,
-				       int flags)
+static size_t parport_pc_ecp_write_block_pio (struct parport *port,
+					      const void *buf, size_t length,
+					      int flags)
 {
 	size_t written;
 	int r;
@@ -924,8 +926,10 @@
 	return written;
 }
 
-size_t parport_pc_ecp_read_block_pio (struct parport *port,
-				      void *buf, size_t length, int flags)
+#if 0
+static size_t parport_pc_ecp_read_block_pio (struct parport *port,
+					     void *buf, size_t length,
+					     int flags)
 {
 	size_t left = length;
 	size_t fifofull;
@@ -1143,7 +1147,7 @@
 dump_parport_state ("fwd idle", port);
 	return length - left;
 }
-
+#endif  /*  0  */
 #endif /* IEEE 1284 support */
 #endif /* Allowed to use FIFO/DMA */
 
@@ -1156,7 +1160,7 @@
 
 /* GCC is not inlining extern inline function later overwriten to non-inline,
    so we use outlined_ variants here.  */
-struct parport_operations parport_pc_ops = 
+static struct parport_operations parport_pc_ops = 
 {
 	.write_data	= parport_pc_write_data,
 	.read_data	= parport_pc_read_data,

