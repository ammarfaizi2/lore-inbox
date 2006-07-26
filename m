Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWGZGZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWGZGZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWGZGZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:25:38 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:18589 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S1030394AbWGZGZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:25:37 -0400
Date: Wed, 26 Jul 2006 09:26:47 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zach Brown <zach.brown@oracle.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: [PATCH] lockdep: don't pull in includes when lockdep disabled
Message-ID: <20060726062647.GA8711@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060704115656.GA1539@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060704115656.GA1539@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 26 Jul 2006 06:31:09.0453 (UTC) FILETIME=[14E413D0:01C6B07D]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, does the following look good to you?

Do not pull in various includes through lockdep.h if lockdep is disabled.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 316e0fb..39d50c4 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -8,13 +8,13 @@
 #ifndef __LINUX_LOCKDEP_H
 #define __LINUX_LOCKDEP_H
 
+#ifdef CONFIG_LOCKDEP
+
 #include <linux/linkage.h>
 #include <linux/list.h>
 #include <linux/debug_locks.h>
 #include <linux/stacktrace.h>
 
-#ifdef CONFIG_LOCKDEP
-
 /*
  * Lock-class usage-state bits:
  */
-- 
MST
