Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312989AbSDCCSx>; Tue, 2 Apr 2002 21:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313007AbSDCCSn>; Tue, 2 Apr 2002 21:18:43 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:28413 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S312989AbSDCCSa>;
	Tue, 2 Apr 2002 21:18:30 -0500
Date: Tue, 2 Apr 2002 18:18:26 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] : ir256_w83977af_bus_to_virt.diff
Message-ID: <20020402181826.B24912@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir256_w83977af_bus_to_virt.diff :
-------------------------------
	o [CRITICA] Fix w83977af_ir FIR drivers for new DMA API
	<PCI FIR drivers are still broken and need fixing>

diff -u -p linux/drivers/net/irda/w83977af_ir.d5.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda/w83977af_ir.d5.c	Tue Mar  5 18:44:13 2002
+++ linux/drivers/net/irda/w83977af_ir.c	Tue Mar  5 18:46:00 2002
@@ -612,7 +612,7 @@ static void w83977af_dma_write(struct w8
 	disable_dma(self->io.dma);
 	clear_dma_ff(self->io.dma);
 	set_dma_mode(self->io.dma, DMA_MODE_READ);
-	set_dma_addr(self->io.dma, virt_to_bus(self->tx_buff.data));
+	set_dma_addr(self->io.dma, isa_virt_to_bus(self->tx_buff.data));
 	set_dma_count(self->io.dma, self->tx_buff.len);
 #else
 	setup_dma(self->io.dma, self->tx_buff.data, self->tx_buff.len, 
@@ -770,7 +770,7 @@ int w83977af_dma_receive(struct w83977af
 	disable_dma(self->io.dma);
 	clear_dma_ff(self->io.dma);
 	set_dma_mode(self->io.dma, DMA_MODE_READ);
-	set_dma_addr(self->io.dma, virt_to_bus(self->rx_buff.data));
+	set_dma_addr(self->io.dma, isa_virt_to_bus(self->rx_buff.data));
 	set_dma_count(self->io.dma, self->rx_buff.truesize);
 #else
 	setup_dma(self->io.dma, self->rx_buff.data, self->rx_buff.truesize, 
