Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVCBPPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVCBPPg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVCBPPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:15:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31748 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262305AbVCBPPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:15:22 -0500
Date: Wed, 2 Mar 2005 16:15:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/pm.c: make pm_send static
Message-ID: <20050302151520.GE4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pm_send is deprecated and has no user except for the deprecated 
pm_send_all in the same file.

Let's make pm_send static before someone might use it again.

This patch was already ACK'ed by Pavel Machek.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 24 Feb 2005

 Documentation/pm.txt |   17 -----------------
 include/linux/pm.h   |   10 ----------
 kernel/power/pm.c    |    2 +-
 3 files changed, 1 insertion(+), 28 deletions(-)

--- linux-2.6.11-rc4-mm1-full/Documentation/pm.txt.old	2005-02-24 01:17:43.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/Documentation/pm.txt	2005-02-24 01:17:59.000000000 +0100
@@ -222,23 +222,6 @@
 management interface.
 
 /*
- * Send a request to a single device
- *
- * Parameters:
- *   dev - PM device previously returned from pm_register or pm_find
- *   rqst - request type
- *   data - data, if any, associated with the request
- *
- * Returns: 0 if the request is successful
- *          See "pm_callback" return for errors
- *
- * Details: Forward request to device callback and, if a suspend
- *          or resume request, update the pm_dev "state" field
- *          appropriately
- */
-int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
-
-/*
  * Send a request to all devices
  *
  * Parameters:
--- linux-2.6.11-rc4-mm1-full/include/linux/pm.h.old	2005-02-24 01:18:17.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/include/linux/pm.h	2005-02-24 01:18:35.000000000 +0100
@@ -116,11 +116,6 @@
 void __deprecated pm_unregister_all(pm_callback callback);
 
 /*
- * Send a request to a single device
- */
-int __deprecated pm_send(struct pm_dev *dev, pm_request_t rqst, void *data);
-
-/*
  * Send a request to all devices
  */
 int __deprecated pm_send_all(pm_request_t rqst, void *data);
@@ -140,11 +135,6 @@
 
 static inline void pm_unregister_all(pm_callback callback) {}
 
-static inline int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	return 0;
-}
-
 static inline int pm_send_all(pm_request_t rqst, void *data)
 {
 	return 0;
--- linux-2.6.11-rc4-mm1-full/kernel/power/pm.c.old	2005-02-24 01:18:43.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/kernel/power/pm.c	2005-02-24 01:19:04.000000000 +0100
@@ -151,7 +151,7 @@
  *	execution and unload yourself.
  */
  
-int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data)
+static int pm_send(struct pm_dev *dev, pm_request_t rqst, void *data)
 {
 	int status = 0;
 	unsigned long prev_state, next_state;

