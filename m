Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUL3JJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUL3JJx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 04:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUL3JIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 04:08:11 -0500
Received: from smtp.knology.net ([24.214.63.101]:58842 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261596AbUL3Isj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:39 -0500
Date: Thu, 30 Dec 2004 03:48:38 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 22/22] Add some documentation for the IPSEC crypto offload
Message-Id: <20041230035000.31@ori.thedillows.org>
References: <20041230035000.30@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 01:06:37-05:00 dave@thedillows.org 
#   Add some documentation for the IPSEC crypto offload.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# Documentation/networking/netdevices.txt
#   2004/12/30 01:06:19-05:00 dave@thedillows.org +16 -0
#   Add some documentation for the IPSEC crypto offload.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/Documentation/networking/netdevices.txt b/Documentation/networking/netdevices.txt
--- a/Documentation/networking/netdevices.txt	2004-12-30 01:07:40 -05:00
+++ b/Documentation/networking/netdevices.txt	2004-12-30 01:07:40 -05:00
@@ -73,3 +73,19 @@
 		dev_close code and comments in net/core/dev.c for more info.
 	Context: softirq
 
+dev->xfrm_state_add:
+	Synchronization: None, but can be called inside dev_base_lock rwlock
+	Context: nominally process, but don't sleep inside an rwlock
+	Notes: Only called for inbound xfrm_state(s). Can be invoked during
+       		xfrm_accel_add() call.
+
+dev->xfrm_state_del:
+	Synchronization: None, but can be called inside dev->xmit_lock spinlock.
+	Context: BHs disabled/softirq
+	Notes: Called for all offloaded xfrm_state(s). Can be invoked during
+		xfrm_accel_flush() call.
+
+dev->xfrm_bundle_add:
+	Synchronization: None
+	Context: softirq/process
+	Notes: Called for newly created outbound xfrm bundles.
