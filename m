Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVCVCJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVCVCJI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbVCVCJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:09:00 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:11915 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262327AbVCVBfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:17 -0500
Message-Id: <20050322013459.001083000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:07 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-saa7146-cleanup.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 34/48] saa7146: remove duplicate setgpio
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate setgpio (Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 saa7146_core.c |   29 +++++------------------------
 1 files changed, 5 insertions(+), 24 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/common/saa7146_core.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/common/saa7146_core.c	2005-03-22 00:18:04.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/common/saa7146_core.c	2005-03-22 00:23:38.000000000 +0100
@@ -46,21 +46,15 @@ static void dump_registers(struct saa714
  * gpio and debi helper functions
  ****************************************************************************/
 
-/* write "data" to the gpio-pin "pin" -- unused */
-void saa7146_set_gpio(struct saa7146_dev *dev, u8 pin, u8 data)
+void saa7146_setgpio(struct saa7146_dev *dev, int port, u32 data)
 {
 	u32 value = 0;
 
-	/* sanity check */
-	if(pin > 3)
-		return;
-
-	/* read old register contents */
-	value = saa7146_read(dev, GPIO_CTRL );
-
-	value &= ~(0xff << (8*pin));
-	value |= (data << (8*pin));
+	BUG_ON(port > 3);
 
+	value = saa7146_read(dev, GPIO_CTRL);
+	value &= ~(0xff << (8*port));
+	value |= (data << (8*port));
 	saa7146_write(dev, GPIO_CTRL, value);
 }
 
@@ -236,19 +230,6 @@ int saa7146_pgtable_build_single(struct 
 }
 
 /********************************************************************************/
-/* gpio functions */
-
-void saa7146_setgpio(struct saa7146_dev *dev, int port, u32 data)
-{
-	u32 val = 0;
-
-        val=saa7146_read(dev,GPIO_CTRL);
-        val&=~(0xff << (8*(port)));
-        val|=(data)<<(8*(port));
-        saa7146_write(dev, GPIO_CTRL, val);
-}
-
-/********************************************************************************/
 /* interrupt handler */
 static irqreturn_t interrupt_hw(int irq, void *dev_id, struct pt_regs *regs)
 {

--

