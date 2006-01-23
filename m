Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWAWUbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWAWUbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWAWU1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:27:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27333 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964934AbWAWU12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:27:28 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, Randy Dunlap <rdunlap@xenotime.net>,
       Michael Krufky <mkrufky@m1k.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 15/16] Fix printk type warning
Date: Mon, 23 Jan 2006 18:24:45 -0200
Message-id: <20060123202445.PS68913400015@infradead.org>
In-Reply-To: <20060123202404.PS66974000000@infradead.org>
References: <20060123202404.PS66974000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

- Fix printk type warning:
drivers/media/dvb/b2c2/flexcop-pci.c:164: warning:
format '%08x' expects type 'unsigned int', but argument 4 has type 'dma_addr_t'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/b2c2/flexcop-pci.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

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

