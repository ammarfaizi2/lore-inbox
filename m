Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVIUXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVIUXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 19:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbVIUXi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 19:38:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49139 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751335AbVIUXi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 19:38:26 -0400
Subject: [PATCH] RT: __MUTEX_INITIALIZER for rt_mutex
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 21 Sep 2005 16:38:23 -0700
Message-Id: <1127345903.19506.47.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add __MUTEX_INITIALIZER macro for rt_mutex types.

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.13/include/linux/rt_lock.h
===================================================================
--- linux-2.6.13.orig/include/linux/rt_lock.h
+++ linux-2.6.13/include/linux/rt_lock.h
@@ -229,10 +229,12 @@ struct semaphore {
 	struct rt_mutex lock;
 };
 
-#define DECLARE_MUTEX(name) \
-struct semaphore name = \
+#define __MUTEX_INITIALIZER(name) \
 	{ .count = { 1 }, .lock = __RT_MUTEX_INITIALIZER(name.lock) }
 
+#define DECLARE_MUTEX(name) \
+struct semaphore name = __MUTEX_INITIALIZER(name)
+
 /*
  * DECLARE_MUTEX_LOCKED() is deprecated: very hard to initialize properly
  * and it also often signals abuse of semaphores. So we redirect it to


