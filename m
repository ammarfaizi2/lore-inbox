Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWARFOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWARFOe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWARFOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:14:34 -0500
Received: from xenotime.net ([66.160.160.81]:28329 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030250AbWARFOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:14:33 -0500
Date: Tue, 17 Jan 2006 21:14:26 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, linux-dvb-maintainer@linuxtv.org,
       mchehab@brturbo.com.br
Subject: [PATCH] dvb: fix printk format warning
Message-Id: <20060117211426.573066bb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix printk type warning:
drivers/media/dvb/b2c2/flexcop-pci.c:164: warning: format '%08x' expects type 'unsigned int', but argument 4 has type 'dma_addr_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/media/dvb/b2c2/flexcop-pci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- linux-2616-rc1.orig/drivers/media/dvb/b2c2/flexcop-pci.c
+++ linux-2616-rc1/drivers/media/dvb/b2c2/flexcop-pci.c
@@ -161,8 +161,10 @@ static irqreturn_t flexcop_pci_isr(int i
 			fc->read_ibi_reg(fc,dma1_008).dma_0x8.dma_cur_addr << 2;
 		u32 cur_pos = cur_addr - fc_pci->dma[0].dma_addr0;
 
-		deb_irq("%u irq: %08x cur_addr: %08x: cur_pos: %08x, last_cur_pos: %08x ",
-				jiffies_to_usecs(jiffies - fc_pci->last_irq),v.raw,cur_addr,cur_pos,fc_pci->last_dma1_cur_pos);
+		deb_irq("%u irq: %08x cur_addr: %llx: cur_pos: %08x, last_cur_pos: %08x ",
+				jiffies_to_usecs(jiffies - fc_pci->last_irq),
+				v.raw, (unsigned long long)cur_addr, cur_pos,
+				fc_pci->last_dma1_cur_pos);
 		fc_pci->last_irq = jiffies;
 
 		/* buffer end was reached, restarted from the beginning


---
