Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbTEMQuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbTEMQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:50:24 -0400
Received: from pc1-cmbg4-4-cust110.cmbg.cable.ntl.com ([81.96.70.110]:51975
	"EHLO thekelleys.org.uk") by vger.kernel.org with ESMTP
	id S262256AbTEMQuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:50:21 -0400
Message-ID: <3EC12576.5080300@thekelleys.org.uk>
Date: Tue, 13 May 2003 18:03:50 +0100
From: Simon Kelley <simon@thekelleys.org.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-GB; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] xirc2ps_cs.c got missed in the irqreturn_t swoop.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN linux-2.5.69.orig/drivers/net/pcmcia/xirc2ps_cs.c 
linux-2.5.69/drivers/net/pcmcia/xirc2ps_cs.c
--- linux-2.5.69.orig/drivers/net/pcmcia/xirc2ps_cs.c   Mon May  5 00:53:13 2003
+++ linux-2.5.69/drivers/net/pcmcia/xirc2ps_cs.c        Tue May 13 15:56:31 2003
@@ -317,7 +317,7 @@
   * less on other parts of the kernel.
   */

-static void xirc2ps_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static irqreturn_t xirc2ps_interrupt(int irq, void *dev_id, struct pt_regs *regs);

  /*
   * The dev_info variable is the "key" that is used to match up this
@@ -1296,7 +1296,7 @@
  /****************
   * This is the Interrupt service route.
   */
-static void
+static irqreturn_t
  xirc2ps_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
      struct net_device *dev = (struct net_device *)dev_id;
@@ -1312,7 +1312,7 @@
                                   */

      if (!netif_device_present(dev))
-       return;
+       return IRQ_HANDLED;

      ioaddr = dev->base_addr;
      if (lp->mohawk) { /* must disable the interrupt */
@@ -1514,6 +1514,8 @@
       * force an interrupt with this command:
       *   PutByte(XIRCREG_CR, EnableIntr|ForceIntr);
       */
+
+    return IRQ_HANDLED;
  } /* xirc2ps_interrupt */

  /*====================================================================*/

