Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269044AbTBXBUu>; Sun, 23 Feb 2003 20:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269052AbTBXBUu>; Sun, 23 Feb 2003 20:20:50 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:50828 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S269044AbTBXBUs>; Sun, 23 Feb 2003 20:20:48 -0500
Date: Sun, 23 Feb 2003 20:30:49 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302240130.h1O1UnWk027874@locutus.cmf.nrl.navy.mil>
To: davem@redhat.com
Subject: [PATCH][ATM] get skb->len right after adjusting head
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when the lane client strips off the lec it should also adjust the length
of skb 

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -d -b -w -r1.3 -r1.4
--- linux/net/atm/lec.c	22 Feb 2003 17:38:23 -0000	1.3
+++ linux/net/atm/lec.c	22 Feb 2003 17:43:41 -0000	1.4
@@ -714,6 +714,7 @@
                 }
                 skb->dev = dev;
                 skb->data += 2; /* skip lec_id */
+                skb->len -= 2;
 #ifdef CONFIG_TR
                 if (priv->is_trdev) skb->protocol = tr_type_trans(skb, dev);
                 else
