Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267091AbUBGUp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267100AbUBGUpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:45:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4310 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267085AbUBGUpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:45:46 -0500
Date: Sat, 7 Feb 2004 21:45:38 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: klaus.kudielka@ieee.org
Cc: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove kernel 2.2 code from drivers/net/hamradio/dmascc.c
Message-ID: <20040207204538.GD7388@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes some #ifdef'd kernel 2.2 code from 
drivers/net/hamradio/dmascc.c .

cu
Adrian

--- linux-2.6.2-mm1/drivers/net/hamradio/dmascc.c.old	2004-02-07 21:39:39.000000000 +0100
+++ linux-2.6.2-mm1/drivers/net/hamradio/dmascc.c	2004-02-07 21:39:58.000000000 +0100
@@ -48,21 +48,6 @@
 #include "z8530.h"
 
 
-/* Linux 2.2 and 2.3 compatibility */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,14)
-#define net_device device
-#endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,43)
-#define netif_start_queue(dev) { dev->tbusy = 0; }
-#define netif_stop_queue(dev) { dev->tbusy = 1; }
-#define netif_wake_queue(dev) { dev->tbusy = 0; mark_bh(NET_BH); }
-#endif
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,47)
-#define netif_running(dev) (dev->flags & IFF_UP)
-#endif
-
-
 /* Number of buffers per channel */
 
 #define NUM_TX_BUF      2          /* NUM_TX_BUF >= 1 (min. 2 recommended) */
@@ -210,9 +195,6 @@
 };
 
 struct scc_priv {
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0)
-  char name[IFNAMSIZ];
-#endif
   int type;
   int chip;
   struct net_device *dev;
