Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVCLP71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVCLP71 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 10:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVCLP7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 10:59:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33039 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261944AbVCLPzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 10:55:55 -0500
Date: Sat, 12 Mar 2005 16:55:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, venza@brownhat.org
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: [2.6 patch] drivers/net/sis900.c: fix a warning
Message-ID: <20050312155551.GB3814@stusta.de>
References: <20050312034222.12a264c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warning, that comes from Linus' tree #if
CONFIG_NET_POLL_CONTROLLER=n:

<--  snip  -->

...
  CC      drivers/net/sis900.o
drivers/net/sis900.c:199: warning: 'sis900_poll' declared `static' but never defined
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm3/drivers/net/sis900.c.old	2005-03-12 15:55:31.000000000 +0100
+++ linux-2.6.11-mm3/drivers/net/sis900.c	2005-03-12 15:55:53.000000000 +0100
@@ -196,7 +196,9 @@
 MODULE_PARM_DESC(max_interrupt_work, "SiS 900/7016 maximum events handled per interrupt");
 MODULE_PARM_DESC(sis900_debug, "SiS 900/7016 bitmapped debugging message level");
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
 static void sis900_poll(struct net_device *dev);
+#endif
 static int sis900_open(struct net_device *net_dev);
 static int sis900_mii_probe (struct net_device * net_dev);
 static void sis900_init_rxfilter (struct net_device * net_dev);

