Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbTHWNXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265451AbTHWNXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:23:50 -0400
Received: from [203.145.184.221] ([203.145.184.221]:27147 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S265395AbTHWNXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:23:39 -0400
Subject: Re: [PATCH 2.6.0-test4][NET] sk_mca.c: fix linker error
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061644938.2787.22.camel@lima.royalchallenge.com>
References: <1061644938.2787.22.camel@lima.royalchallenge.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 23 Aug 2003 19:15:15 +0530
Message-Id: <1061646315.1141.26.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 18:52, Vinay K Nallamothu wrote:
> Hi,
> 
> This patch fixes the following linker error due to a typo:
> 
> *** Warning: "spin_lock_irqrestore" [drivers/net/sk_mca.ko] undefined!
Oops. missed out few more. Here is the updated patch.

--- linux-2.6.0-test4/drivers/net/sk_mca.c	2003-07-28 10:43:57.000000000 +0530
+++ linux-2.6.0-test4-nvk/drivers/net/sk_mca.c	2003-08-23 19:12:16.000000000 +0530
@@ -280,7 +280,7 @@
 
 	/* reenable interrupts */
 
-	spin_lock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 /* get LANCE register */
@@ -319,7 +319,7 @@
 
 	/* reenable interrupts */
 
-	spin_lock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return res;
 }
@@ -993,7 +993,7 @@
 	if (priv->txbusy == 0)
 		SetLANCE(dev, LANCE_CSR0, CSR0_INEA | CSR0_TDMD);
 
-	spin_lock_irqrestore(&priv->lock, flags);
+	spin_unlock_irqrestore(&priv->lock, flags);
 
       tx_done:
 

