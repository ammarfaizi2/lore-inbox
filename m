Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbVEBB4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbVEBB4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 21:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVEBBzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:55:20 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38160 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261663AbVEBBrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:10 -0400
Date: Mon, 2 May 2005 03:47:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: skystar@moldova.cc
Cc: kraxel@bytesex.org, video4linux-list@redhat.com,
       linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/media/dvb/b2c2/skystar2.c: remove an impossible code path
Message-ID: <20050502014708.GZ3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an impossible code path found by the Coverity 
checker (look at the assignement in the first line of the context).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

 drivers/media/dvb/b2c2/skystar2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm2-full/drivers/media/dvb/b2c2/skystar2.c.old	2005-04-09 22:09:27.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/media/dvb/b2c2/skystar2.c	2005-04-09 22:10:13.000000000 +0200
@@ -1358,49 +1358,49 @@ static int dma_init_dma(struct adapter *
 		subbuffers = 2;
 
 		subbufsize = (((adapter->dmaq1.buffer_size / 2) / 4) << 8) | subbuffers;
 
 		subbuf0 = adapter->dmaq1.bus_addr & 0xfffffffc;
 
 		subbuf1 = ((adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) & 0xfffffffc) | 1;
 
 		dprintk("%s: first subbuffer address = 0x%x\n", __FUNCTION__, subbuf0);
 		udelay(1000);
 		write_reg_dw(adapter, 0x000, subbuf0);
 
 		dprintk("%s: subbuffer size = 0x%x\n", __FUNCTION__, (subbufsize >> 8) * 4);
 		udelay(1000);
 		write_reg_dw(adapter, 0x004, subbufsize);
 
 		dprintk("%s: second subbuffer address = 0x%x\n", __FUNCTION__, subbuf1);
 		udelay(1000);
 		write_reg_dw(adapter, 0x00c, subbuf1);
 
 		dprintk("%s: counter = 0x%x\n", __FUNCTION__, adapter->dmaq1.bus_addr & 0xfffffffc);
 		write_reg_dw(adapter, 0x008, adapter->dmaq1.bus_addr & 0xfffffffc);
 		udelay(1000);
 
-		dma_enable_disable_irq(adapter, 0, 1, subbuffers ? 1 : 0);
+		dma_enable_disable_irq(adapter, 0, 1, 1);
 
 		irq_dma_enable_disable_irq(adapter, 1);
 
 		sram_set_media_dest(adapter, 1);
 		sram_set_net_dest(adapter, 1);
 		sram_set_cai_dest(adapter, 2);
 		sram_set_cao_dest(adapter, 2);
 	}
 
 	if (dma_channel == 1) {
 		dprintk("%s: Initializing DMA2 channel\n", __FUNCTION__);
 
 		subbuffers = 2;
 
 		subbufsize = (((adapter->dmaq2.buffer_size / 2) / 4) << 8) | subbuffers;
 
 		subbuf0 = adapter->dmaq2.bus_addr & 0xfffffffc;
 
 		subbuf1 = ((adapter->dmaq2.bus_addr + adapter->dmaq2.buffer_size / 2) & 0xfffffffc) | 1;
 
 		dprintk("%s: first subbuffer address = 0x%x\n", __FUNCTION__, subbuf0);
 		udelay(1000);
 		write_reg_dw(adapter, 0x010, subbuf0);
 

