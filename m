Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031316AbWI1BFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031316AbWI1BFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031320AbWI1BFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:05:20 -0400
Received: from havoc.gtf.org ([69.61.125.42]:42962 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1031316AbWI1BFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:05:18 -0400
Date: Wed, 27 Sep 2006 21:05:18 -0400
From: Jeff Garzik <jeff@garzik.org>
To: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] device_for_each_child(): kill pointless warning noise
Message-ID: <20060928010518.GA25865@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As the last patch demonstrated, it is quite valid for a caller to ignore
the return value of device_for_each_child(), given that the return value
is wholly dependent on the actor -- which in practice often has a
hardcoded return value.

Please apply, to reduce a portion of the warning explosion seen in
current linux-2.6.git.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/include/linux/device.h b/include/linux/device.h
index 662e6a1..9d4f6a9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -393,7 +393,7 @@ extern void device_unregister(struct dev
 extern void device_initialize(struct device * dev);
 extern int __must_check device_add(struct device * dev);
 extern void device_del(struct device * dev);
-extern int __must_check device_for_each_child(struct device *, void *,
+extern int device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
 extern int device_rename(struct device *dev, char *new_name);
 
