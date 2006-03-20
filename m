Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965688AbWCTQCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965688AbWCTQCz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWCTQCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:02:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:43672 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966468AbWCTPQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:16:34 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Johannes Stezenbach <js@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 113/141] V4L/DVB (3385): Dvb: fix __init/__exit section
	references in av7110 driver
Date: Mon, 20 Mar 2006 12:08:56 -0300
Message-id: <20060320150855.PS945747000113@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Stezenbach <js@linuxtv.org>
Date: 1141009760 -0300

use __devinit/__devexit/__devexit_p() where appropriate

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
diff --git a/drivers/media/dvb/ttpci/av7110.c b/drivers/media/dvb/ttpci/av7110.c
index 1aa61bf..d982a50 100644
--- a/drivers/media/dvb/ttpci/av7110.c
+++ b/drivers/media/dvb/ttpci/av7110.c
@@ -2476,7 +2476,8 @@ static int frontend_init(struct av7110 *
  * The same behaviour of missing VSYNC can be duplicated on budget
  * cards, by seting DD1_INIT trigger mode 7 in 3rd nibble.
  */
-static int av7110_attach(struct saa7146_dev* dev, struct saa7146_pci_extension_data *pci_ext)
+static int __devinit av7110_attach(struct saa7146_dev* dev,
+				   struct saa7146_pci_extension_data *pci_ext)
 {
 	const int length = TS_WIDTH * TS_HEIGHT;
 	struct pci_dev *pdev = dev->pci;
@@ -2826,7 +2827,7 @@ err_kfree_0:
 	goto out;
 }
 
-static int av7110_detach(struct saa7146_dev* saa)
+static int __devexit av7110_detach(struct saa7146_dev* saa)
 {
 	struct av7110 *av7110 = saa->ext_priv;
 	dprintk(4, "%p\n", av7110);
@@ -2973,7 +2974,7 @@ static struct saa7146_extension av7110_e
 	.module		= THIS_MODULE,
 	.pci_tbl	= &pci_tbl[0],
 	.attach		= av7110_attach,
-	.detach		= av7110_detach,
+	.detach		= __devexit_p(av7110_detach),
 
 	.irq_mask	= MASK_19 | MASK_03 | MASK_10,
 	.irq_func	= av7110_irq,
diff --git a/drivers/media/dvb/ttpci/av7110_ir.c b/drivers/media/dvb/ttpci/av7110_ir.c
diff --git a/drivers/media/dvb/ttpci/av7110_ir.c b/drivers/media/dvb/ttpci/av7110_ir.c
index 617e4f6..d54bbcd 100644
--- a/drivers/media/dvb/ttpci/av7110_ir.c
+++ b/drivers/media/dvb/ttpci/av7110_ir.c
@@ -208,7 +208,7 @@ static void ir_handler(struct av7110 *av
 }
 
 
-int __init av7110_ir_init(struct av7110 *av7110)
+int __devinit av7110_ir_init(struct av7110 *av7110)
 {
 	static struct proc_dir_entry *e;
 
@@ -248,7 +248,7 @@ int __init av7110_ir_init(struct av7110 
 }
 
 
-void __exit av7110_ir_exit(struct av7110 *av7110)
+void __devexit av7110_ir_exit(struct av7110 *av7110)
 {
 	int i;
 

