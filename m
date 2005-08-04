Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVHDGTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVHDGTU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVHDGJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:09:42 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:51341 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261907AbVHDGIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:08:21 -0400
Date: Thu, 4 Aug 2005 01:08:16 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Reply-To: youssef@ece.utexas.edu
To: linux-kernel@vger.kernel.org
cc: linux-ppp@vger.kernel.org, youssef@ece.utexas.edu
Subject: [PATCH][PPP] ppp_generic: Add checks for NULL pointers
Message-ID: <Pine.LNX.4.61.0508040053050.14176@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds two checks for NULL pointers.

Signed-off-by: Youssef Hmamouche <hyoussef@gmail.com>



--- a/drivers/net/ppp_generic.c 2005-07-15 14:18:57.000000000 -0700
+++ b/drivers/net/ppp_generic.c 2005-08-03 21:11:14.000000000 -0700
@@ -2644,6 +2644,11 @@
                 do {
                         /* need a new top level */
                         struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
+                       if(np == NULL) {
+                               printk(KERN_ERR "ppp_generic: Couldn't allocate "
+                                       "memory for cardmap.\n");
+                               continue;
+                       }
                         memset(np, 0, sizeof(*np));
                         np->ptr[0] = p;
                         if (p != NULL) {
@@ -2659,6 +2664,11 @@
                 i = (nr >> p->shift) & CARDMAP_MASK;
                 if (p->ptr[i] == NULL) {
                         struct cardmap *np = kmalloc(sizeof(*np), GFP_KERNEL);
+                       if(np == NULL) {
+                               printk(KERN_ERR "ppp_generic: Couldn't allocate "
+                                       "memory for cardmap.\n");
+                               continue;
+                       }
                         memset(np, 0, sizeof(*np));
                         np->shift = p->shift - CARDMAP_ORDER;
                         np->parent = p;

