Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUKTCvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUKTCvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUKTCuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:50:13 -0500
Received: from baikonur.stro.at ([213.239.196.228]:9450 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S263088AbUKTCq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:46:57 -0500
Subject: [patch 1/4]  __FUNCTION__ string concatenation 	deprecated
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, drizzd@aon.at
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:46:54 +0100
Message-ID: <E1CVLH4-0002Pd-OG@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Description: __FUNCTION__ string concatenation is deprecated

Diff against linux-2.6 up to ChangeSet@1.1938 (04/09/18 20:30:01)

Status: untested

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

# sound/oss/ite8172.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +1 -1
#   __FUNCTION__ string concatenation is deprecated
# 
# sound/oss/au1000.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +1 -1
#   __FUNCTION__ string concatenation is deprecated
# 
# drivers/net/gt96100eth.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +5 -5
#   __FUNCTION__ string concatenation is deprecated
# 
# arch/mips/au1000/common/usbdev.c
#   2004/09/20 14:52:26+02:00 drizzd@aon.at +2 -2
#   __FUNCTION__ string concatenation is deprecated
# 
---

 linux-2.6.10-rc2-bk4-max/arch/mips/au1000/common/usbdev.c |    4 ++--
 linux-2.6.10-rc2-bk4-max/drivers/net/gt96100eth.c         |   10 +++++-----
 linux-2.6.10-rc2-bk4-max/sound/oss/au1000.c               |    2 +-
 linux-2.6.10-rc2-bk4-max/sound/oss/ite8172.c              |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff -puN arch/mips/au1000/common/usbdev.c~function-string-arch-mips arch/mips/au1000/common/usbdev.c
--- linux-2.6.10-rc2-bk4/arch/mips/au1000/common/usbdev.c~function-string-arch-mips	2004-11-19 17:22:34.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/mips/au1000/common/usbdev.c	2004-11-19 17:22:34.000000000 +0100
@@ -349,7 +349,7 @@ endpoint_stall(endpoint_t * ep)
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("%s", __FUNCTION__);
 
 	cs = au_readl(ep->reg->ctrl_stat) | USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
@@ -361,7 +361,7 @@ endpoint_unstall(endpoint_t * ep)
 {
 	u32 cs;
 
-	warn(__FUNCTION__);
+	warn("%s", __FUNCTION__);
 
 	cs = au_readl(ep->reg->ctrl_stat) & ~USBDEV_CS_STALL;
 	au_writel(cs, ep->reg->ctrl_stat);
diff -puN drivers/net/gt96100eth.c~function-string-arch-mips drivers/net/gt96100eth.c
--- linux-2.6.10-rc2-bk4/drivers/net/gt96100eth.c~function-string-arch-mips	2004-11-19 17:22:34.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/net/gt96100eth.c	2004-11-19 17:22:34.000000000 +0100
@@ -73,7 +73,7 @@ static void dump_rx_desc(int dbg_lvl, st
 static void dump_skb(int dbg_lvl, struct net_device *dev,
 		     struct sk_buff *skb);
 static void dump_hw_addr(int dbg_lvl, struct net_device *dev,
-			 const char* pfx, unsigned char* addr_str);
+			 const char* pfx, const char* func, unsigned char* addr_str);
 static void update_stats(struct gt96100_private *gp);
 static void abort(struct net_device *dev, u32 abort_bits);
 static void hard_stop(struct net_device *dev);
@@ -336,13 +336,13 @@ dump_MII(int dbg_lvl, struct net_device 
 
 static void
 dump_hw_addr(int dbg_lvl, struct net_device *dev, const char* pfx,
-	     unsigned char* addr_str)
+	     const char* func, unsigned char* addr_str)
 {
 	int i;
 	char buf[100], octet[5];
     
 	if (dbg_lvl <= GT96100_DEBUG) {
-		strcpy(buf, pfx);
+		sprintf(buf, pfx, func);
 		for (i = 0; i < 6; i++) {
 			sprintf(octet, "%2.2x%s",
 				addr_str[i], i<5 ? ":" : "\n");
@@ -710,7 +710,7 @@ static int __init gt96100_probe1(struct 
 
 	info("%s found at 0x%x, irq %d\n",
 	     chip_name(gp->chip_rev), gtif->iobase, gtif->irq);
-	dump_hw_addr(0, dev, "HW Address ", dev->dev_addr);
+	dump_hw_addr(0, dev, "%s: HW Address ", __FUNCTION__, dev->dev_addr);
 	info("%s chip revision=%d\n", chip_name(gp->chip_rev), gp->chip_rev);
 	info("%s ethernet port %d\n", chip_name(gp->chip_rev), gp->port_num);
 	info("external PHY ID1=0x%04x, ID2=0x%04x\n", phy_id1, phy_id2);
@@ -1490,7 +1490,7 @@ gt96100_set_rx_mode(struct net_device *d
 		gt96100_add_hash_entry(dev, dev->dev_addr);
 
 		for (mcptr = dev->mc_list; mcptr; mcptr = mcptr->next) {
-			dump_hw_addr(2, dev, __FUNCTION__ ": addr=",
+			dump_hw_addr(2, dev, "%s: addr=", __FUNCTION__,
 				     mcptr->dmi_addr);
 			gt96100_add_hash_entry(dev, mcptr->dmi_addr);
 		}
diff -puN sound/oss/au1000.c~function-string-arch-mips sound/oss/au1000.c
--- linux-2.6.10-rc2-bk4/sound/oss/au1000.c~function-string-arch-mips	2004-11-19 17:22:34.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/sound/oss/au1000.c	2004-11-19 17:22:34.000000000 +0100
@@ -1317,7 +1317,7 @@ static int au1000_mmap(struct file *file
 	unsigned long   size;
 	int ret = 0;
 
-	dbg(__FUNCTION__);
+	dbg("%s", __FUNCTION__);
     
 	lock_kernel();
 	down(&s->sem);
diff -puN sound/oss/ite8172.c~function-string-arch-mips sound/oss/ite8172.c
--- linux-2.6.10-rc2-bk4/sound/oss/ite8172.c~function-string-arch-mips	2004-11-19 17:22:34.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/sound/oss/ite8172.c	2004-11-19 17:22:34.000000000 +0100
@@ -1848,7 +1848,7 @@ static int it8172_release(struct inode *
 	struct it8172_state *s = (struct it8172_state *)file->private_data;
 
 #ifdef IT8172_VERBOSE_DEBUG
-	dbg(__FUNCTION__);
+	dbg("%s", __FUNCTION__);
 #endif
 	lock_kernel();
 	if (file->f_mode & FMODE_WRITE)
_
