Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWBYWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWBYWDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWBYWDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:03:11 -0500
Received: from havoc.gtf.org ([69.61.125.42]:60879 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750744AbWBYWDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:03:09 -0500
Date: Sat, 25 Feb 2006 17:03:03 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patch] net driver fix
Message-ID: <20060225220303.GA27133@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/sis900.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Daniele Venzano:
      Fix Wake on LAN support in sis900

diff --git a/drivers/net/sis900.c b/drivers/net/sis900.c
index 3d95fa2..7a952fe 100644
--- a/drivers/net/sis900.c
+++ b/drivers/net/sis900.c
@@ -540,7 +540,7 @@ static int __devinit sis900_probe(struct
 	printk("%2.2x.\n", net_dev->dev_addr[i]);
 
 	/* Detect Wake on Lan support */
-	ret = inl(CFGPMC & PMESP);
+	ret = (inl(net_dev->base_addr + CFGPMC) & PMESP) >> 27;
 	if (netif_msg_probe(sis_priv) && (ret & PME_D3C) == 0)
 		printk(KERN_INFO "%s: Wake on LAN only available from suspend to RAM.", net_dev->name);
 
@@ -2040,7 +2040,7 @@ static int sis900_set_wol(struct net_dev
 
 	if (wol->wolopts == 0) {
 		pci_read_config_dword(sis_priv->pci_dev, CFGPMCSR, &cfgpmcsr);
-		cfgpmcsr |= ~PME_EN;
+		cfgpmcsr &= ~PME_EN;
 		pci_write_config_dword(sis_priv->pci_dev, CFGPMCSR, cfgpmcsr);
 		outl(pmctrl_bits, pmctrl_addr);
 		if (netif_msg_wol(sis_priv))
