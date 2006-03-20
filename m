Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966262AbWCTPNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966262AbWCTPNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966263AbWCTPNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:13:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966248AbWCTPNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:13:31 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 031/141] V4L/DVB (3433): Fix printk type warning
Date: Mon, 20 Mar 2006 12:08:42 -0300
Message-id: <20060320150842.PS181825000031@infradead.org>
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

From: Randy Dunlap <rdunlap@xenotime.net>
Date: 1138043470 -0200

- Fix printk type warning:
drivers/media/dvb/b2c2/flexcop-pci.c:164: warning:
format '%08x' expects type 'unsigned int', but argument 4 has type 'dma_addr_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/dvb/b2c2/flexcop-pci.c b/drivers/media/dvb/b2c2/flexcop-pci.c
diff --git a/drivers/media/dvb/b2c2/flexcop-pci.c b/drivers/media/dvb/b2c2/flexcop-pci.c
index 2f76eb3..9bc40bd 100644
--- a/drivers/media/dvb/b2c2/flexcop-pci.c
+++ b/drivers/media/dvb/b2c2/flexcop-pci.c
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

