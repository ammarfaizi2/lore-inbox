Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbTDVTeC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263488AbTDVTeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:34:02 -0400
Received: from home.linuxhacker.ru ([194.67.236.68]:2712 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263483AbTDVTeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:34:01 -0400
Date: Tue, 22 Apr 2003 23:45:28 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: alan@redhat.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: [2.4] Memleak in Aironet 4500 Pcmcia driver
Message-ID: <20030422194528.GA7471@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   There is a memleak in Aironet 4500 Pcmcia driver on error exit path
   that is trivial to fix.
   Please consider following path.
   Found with help of smatch's unfree script.

Bye,
    Oleg
===== drivers/net/pcmcia/aironet4500_cs.c 1.8 vs edited =====
--- 1.8/drivers/net/pcmcia/aironet4500_cs.c	Wed Aug  7 22:27:37 2002
+++ edited/drivers/net/pcmcia/aironet4500_cs.c	Tue Apr 22 23:40:53 2003
@@ -282,7 +282,7 @@
 	};
 	memset(dev,0,sizeof(struct net_device));
 	dev->priv = kmalloc(sizeof(struct awc_private), GFP_KERNEL);
-	if (!dev->priv ) {printk(KERN_CRIT "out of mem on dev priv alloc \n"); return NULL;};
+	if (!dev->priv ) {printk(KERN_CRIT "out of mem on dev priv alloc \n"); kfree(dev); return NULL;};
 	memset(dev->priv,0,sizeof(struct awc_private));
 	
 //	link->dev->minor = dev->minor;
