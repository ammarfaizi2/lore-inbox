Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbSIZCgy>; Wed, 25 Sep 2002 22:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262146AbSIZCgy>; Wed, 25 Sep 2002 22:36:54 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:11726 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262145AbSIZCgx>;
	Wed, 25 Sep 2002 22:36:53 -0400
Date: Wed, 25 Sep 2002 19:42:09 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.20-pre8] Minor Wavelan update
Message-ID: <20020926024209.GB17708@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Trivial Wavelan patch that dropped in my mailbox. Plus bloat
reduction. Low risk, 2.4.X ready (this fix is already going in 2.5.X).
	Regards,

	Jean

----------------------------------------------------

--- linux/drivers/net/pcmcia/wavelan_cs.b2.c	Wed Sep 25 19:22:40 2002
+++ linux/drivers/net/pcmcia/wavelan_cs.c	Wed Sep 25 19:25:15 2002
@@ -707,7 +707,7 @@ void wl_cell_expiry(unsigned long data)
   
   while(wavepoint!=NULL)
     {
-      if(wavepoint->last_seen < jiffies-CELL_TIMEOUT)
+      if(time_after(jiffies, wavepoint->last_seen + CELL_TIMEOUT))
 	{
 #ifdef WAVELAN_ROAMING_DEBUG
 	  printk(KERN_DEBUG "WaveLAN: Bye bye %.4X\n",wavepoint->nwid);
@@ -1890,7 +1890,8 @@ wl_his_gather(device *	dev,
 }
 #endif	/* HISTOGRAM */
 
-static int netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
+static inline int
+wl_netdev_ethtool_ioctl(struct net_device *dev, void *useraddr)
 {
 	u32 ethcmd;
 		
@@ -1933,7 +1934,7 @@ wavelan_ioctl(struct net_device *	dev,	/
 #endif
 
   if (cmd == SIOCETHTOOL)
-    return netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
+    return wl_netdev_ethtool_ioctl(dev, (void *) rq->ifr_data);
 
   /* Disable interrupts & save flags */
   wv_splhi(lp, &flags);
