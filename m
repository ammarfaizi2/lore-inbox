Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVBSANZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVBSANZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVBSALj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:11:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23556 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261575AbVBSAKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:10:21 -0500
Date: Sat, 19 Feb 2005 01:10:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/shaper.c: cleanups
Message-ID: <20050219001018.GK4337@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- remove an unused #define SHAPER_BANNER
- remove the sh_debug flag

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/shaper.c |   30 +++++-------------------------
 1 files changed, 5 insertions(+), 25 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/shaper.c.old	2005-02-16 18:20:33.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/shaper.c	2005-02-16 18:22:48.000000000 +0100
@@ -96,10 +96,6 @@
 }; 
 #define SHAPERCB(skb) ((struct shaper_cb *) ((skb)->cb))
 
-int sh_debug;		/* Debug flag */
-
-#define SHAPER_BANNER	"CymruNet Traffic Shaper BETA 0.04 for Linux 2.1\n"
-
 /*
  *	Locking
  */
@@ -252,8 +248,6 @@
 			skb_queue_tail(&shaper->sendq, skb);
 	}
 #endif 	
-	if(sh_debug)
- 		printk("Frame queued.\n");
  	if(skb_queue_len(&shaper->sendq)>SHAPER_QLEN)
  	{
  		ptr=skb_dequeue(&shaper->sendq);
@@ -271,22 +265,16 @@
 static void shaper_queue_xmit(struct shaper *shaper, struct sk_buff *skb)
 {
 	struct sk_buff *newskb=skb_clone(skb, GFP_ATOMIC);
-	if(sh_debug)
-		printk("Kick frame on %p\n",newskb);
 	if(newskb)
 	{
 		newskb->dev=shaper->dev;
 		newskb->priority=2;
-		if(sh_debug)
-			printk("Kick new frame to %s, %d\n",
-				shaper->dev->name,newskb->priority);
+
 		dev_queue_xmit(newskb);
 
                 shaper->stats.tx_bytes += skb->len;
 		shaper->stats.tx_packets++;
 
-                if(sh_debug)
-			printk("Kicked new frame out.\n");
 		dev_kfree_skb(skb);
 	}
 }
@@ -316,8 +304,6 @@
 	 
 	if (test_and_set_bit(0, &shaper->locked))
 	{
-		if(sh_debug)
-			printk("Shaper locked.\n");
 		mod_timer(&shaper->timer, jiffies);
 		return;
 	}
@@ -334,8 +320,6 @@
 		 *	of SHAPER_BURST) gets kicked onto the link 
 		 */
 		 
-		if(sh_debug)
-			printk("Clock = %ld, jiffies = %ld\n", SHAPERCB(skb)->shapeclock, jiffies);
 		if(time_before_eq(SHAPERCB(skb)->shapeclock, jiffies + SHAPER_BURST))
 		{
 			/*
@@ -444,8 +428,7 @@
 {
 	struct shaper *sh=dev->priv;
 	int v;
-	if(sh_debug)
-		printk("Shaper header\n");
+
 	skb->dev=sh->dev;
 	v=sh->hard_header(skb,sh->dev,type,daddr,saddr,len);
 	skb->dev=dev;
@@ -457,8 +440,7 @@
 	struct shaper *sh=skb->dev->priv;
 	struct net_device *dev=skb->dev;
 	int v;
-	if(sh_debug)
-		printk("Shaper rebuild header\n");
+
 	skb->dev=sh->dev;
 	v=sh->rebuild_header(skb);
 	skb->dev=dev;
@@ -471,8 +453,7 @@
 	struct shaper *sh=neigh->dev->priv;
 	struct net_device *tmp;
 	int ret;
-	if(sh_debug)
-		printk("Shaper header cache bind\n");
+
 	tmp=neigh->dev;
 	neigh->dev=sh->dev;
 	ret=sh->hard_header_cache(neigh,hh);
@@ -484,8 +465,7 @@
 	unsigned char *haddr)
 {
 	struct shaper *sh=dev->priv;
-	if(sh_debug)
-		printk("Shaper cache update\n");
+
 	sh->header_cache_update(hh, sh->dev, haddr);
 }
 #endif

