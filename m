Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272370AbTGYWbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272371AbTGYWbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 18:31:03 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:31500 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S272370AbTGYWbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 18:31:01 -0400
Date: Sat, 26 Jul 2003 00:37:05 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org
Subject: [PATCH] uninitialized spinlock in drivers/net/sk_mca.c
Message-ID: <20030726003705.A1261@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A spinlock was recently added to struct skmca_priv so as to remove
save_flags()/cli() but nothing in the current code initializes it.

If the adequate diplodocus lurks in somebody's kitchen to test the patch...

 drivers/net/sk_mca.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/net/sk_mca.c~drivers-sk_mca-spinlock_init drivers/net/sk_mca.c
--- linux-2.6.0-test1-bk2/drivers/net/sk_mca.c~drivers-sk_mca-spinlock_init	Sat Jul 26 00:12:52 2003
+++ linux-2.6.0-test1-bk2-fr/drivers/net/sk_mca.c	Sat Jul 26 00:15:35 2003
@@ -1155,6 +1155,7 @@ int __init skmca_probe(struct SKMCA_NETD
 	priv->cmdaddr = base + 0x3ff3;
 	priv->medium = medium;
 	memset(&(priv->stat), 0, sizeof(struct net_device_stats));
+	spin_lock_init(&priv->lock);
 
 	/* set base + irq for this device (irq not allocated so far) */
 	dev->irq = 0;

_
