Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313556AbSDPDQY>; Mon, 15 Apr 2002 23:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313570AbSDPDQX>; Mon, 15 Apr 2002 23:16:23 -0400
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:26126 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S313556AbSDPDQW>;
	Mon, 15 Apr 2002 23:16:22 -0400
Date: Mon, 15 Apr 2002 22:07:01 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>, <fdavis@si.rr.com>
Subject: [PATCH] 2.5.8-dj1: net/atm/resources.c (rev. 2)
Message-ID: <Pine.LNX.4.33.0204152205050.16694-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  Here's an updated version of the patch that fixes a free_atm_dev() 
warning.
Regards,
Frank

--- net/atm/resources.c.old	Mon Apr 15 21:42:25 2002
+++ net/atm/resources.c	Mon Apr 15 22:02:02 2002
@@ -82,14 +82,14 @@
 	return NULL;
 }
 
-struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops
+struct atm_dev *atm_dev_register(const char *type, const struct atmdev_ops *ops,
 				int number, atm_dev_flags_t *flags)
 {
 	struct atm_dev *dev = NULL;
 
 	spin_lock(&atm_dev_lock);
 
-	dev = alloc_atm_dev(type);
+	dev = __alloc_atm_dev(type);
 	if (!dev) {
 		printk(KERN_ERR "atm_dev_register: no space for dev %s\n",
 		    type);
@@ -97,7 +97,7 @@
 	}
 	if (number != -1) {
 		if (atm_find_dev(number)) {
-			free_atm_dev(dev);
+			__free_atm_dev(dev);
 			dev = NULL;
 			goto done;
 		}

