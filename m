Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUGOTRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUGOTRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUGOTRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:17:20 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30694 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266284AbUGOTRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:17:17 -0400
Date: Thu, 15 Jul 2004 21:17:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: carnil@cs.tut.fi
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/atm/lec.c: remove inlines
Message-ID: <20040715191710.GB25633@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile net/atm/lec.c in 2.6.8-rc1-mm1 using gcc 3.4 results 
in the following compile error:

<--  snip  -->

...
  CC      net/atm/lec.o
net/atm/lec.c: In function `lec_atm_send':
net/atm/lec.c:75: sorry, unimplemented: inlining failed in call to 
'lec_arp_find': function body not available
net/atm/lec.c:459: sorry, unimplemented: called from here
net/atm/lec.c:77: sorry, unimplemented: inlining failed in call to 
'lec_arp_remove': function body not available
net/atm/lec.c:460: sorry, unimplemented: called from here
make[2]: *** [net/atm/lec.o] Error 1

<--  snip  -->


The patch below removes the inlines from the functions in question.

An alternative approach would be to move the inline functions above the 
first place where they are used.


diffstat output:
 net/atm/lec.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/net/atm/lec.c.old	2004-07-09 02:12:36.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/net/atm/lec.c	2004-07-09 02:15:16.000000000 +0200
@@ -71,9 +71,9 @@
 static int lec_close(struct net_device *dev);
 static struct net_device_stats *lec_get_stats(struct net_device *dev);
 static void lec_init(struct net_device *dev);
-static inline struct lec_arp_table* lec_arp_find(struct lec_priv *priv,
+static struct lec_arp_table* lec_arp_find(struct lec_priv *priv,
                                                      unsigned char *mac_addr);
-static inline int lec_arp_remove(struct lec_priv *priv,
+static int lec_arp_remove(struct lec_priv *priv,
 				     struct lec_arp_table *to_remove);
 /* LANE2 functions */
 static void lane2_associate_ind (struct net_device *dev, u8 *mac_address,
@@ -1468,7 +1468,7 @@
 /*
  * Remove entry from lec_arp_table
  */
-static inline int 
+static int 
 lec_arp_remove(struct lec_priv *priv,
                struct lec_arp_table *to_remove)
 {
@@ -1755,7 +1755,7 @@
 /* 
  * Find entry by mac_address
  */
-static inline struct lec_arp_table*
+static struct lec_arp_table*
 lec_arp_find(struct lec_priv *priv,
              unsigned char *mac_addr)
 {

