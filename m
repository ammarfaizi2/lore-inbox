Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUEAWPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUEAWPj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbUEAWPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:15:39 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:37855 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262422AbUEAWPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:15:32 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: [USBFS PATCH] change extern inline to static inline
Date: Sun, 2 May 2004 00:15:25 +0200
User-Agent: KMail/1.5.4
Cc: linux-usb-devel@lists.sf.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405020015.25851.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And change __inline__ to inline and get rid of an unused function
while at it.

 devio.c |   35 +++++------------------------------
 1 files changed, 5 insertions(+), 30 deletions(-)


diff -Nru a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
--- a/drivers/usb/core/devio.c	Fri Apr 30 23:36:25 2004
+++ b/drivers/usb/core/devio.c	Fri Apr 30 23:36:25 2004
@@ -165,31 +165,6 @@
 	return ret;
 }
 
-extern inline unsigned int ld2(unsigned int x)
-{
-        unsigned int r = 0;
-        
-        if (x >= 0x10000) {
-                x >>= 16;
-                r += 16;
-        }
-        if (x >= 0x100) {
-                x >>= 8;
-                r += 8;
-        }
-        if (x >= 0x10) {
-                x >>= 4;
-                r += 4;
-        }
-        if (x >= 4) {
-                x >>= 2;
-                r += 2;
-        }
-        if (x >= 2)
-                r++;
-        return r;
-}
-
 /*
  * async list handling
  */
@@ -219,7 +194,7 @@
         kfree(as);
 }
 
-extern __inline__ void async_newpending(struct async *as)
+static inline void async_newpending(struct async *as)
 {
         struct dev_state *ps = as->ps;
         unsigned long flags;
@@ -229,7 +204,7 @@
         spin_unlock_irqrestore(&ps->lock, flags);
 }
 
-extern __inline__ void async_removepending(struct async *as)
+static inline void async_removepending(struct async *as)
 {
         struct dev_state *ps = as->ps;
         unsigned long flags;
@@ -239,7 +214,7 @@
         spin_unlock_irqrestore(&ps->lock, flags);
 }
 
-extern __inline__ struct async *async_getcompleted(struct dev_state *ps)
+static inline struct async *async_getcompleted(struct dev_state *ps)
 {
         unsigned long flags;
         struct async *as = NULL;
@@ -253,7 +228,7 @@
         return as;
 }
 
-extern __inline__ struct async *async_getpending(struct dev_state *ps, void __user *userurb)
+static inline struct async *async_getpending(struct dev_state *ps, void __user *userurb)
 {
         unsigned long flags;
         struct async *as;
@@ -321,7 +296,7 @@
 	destroy_async(ps, &hitlist);
 }
 
-extern __inline__ void destroy_all_async(struct dev_state *ps)
+static inline void destroy_all_async(struct dev_state *ps)
 {
 	        destroy_async(ps, &ps->async_pending);
 }
