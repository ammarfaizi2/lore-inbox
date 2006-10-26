Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423732AbWJZXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423732AbWJZXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423734AbWJZXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:21:57 -0400
Received: from host-233-54.several.ru ([213.234.233.54]:2950 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1423732AbWJZXVz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:21:55 -0400
Date: Fri, 27 Oct 2006 03:21:46 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] taskstats_tgid_alloc: optimization
Message-ID: <20061026232146.GA529@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every subthread (except first) does unneeded kmem_cache_alloc/kmem_cache_free.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/include/linux/taskstats_kern.h~4_alloc	2006-10-27 01:28:31.000000000 +0400
+++ STATS/include/linux/taskstats_kern.h	2006-10-27 01:39:10.000000000 +0400
@@ -32,6 +32,9 @@ static inline void taskstats_tgid_alloc(
 	struct taskstats *stats;
 	unsigned long flags;
 
+	if (sig->stats != NULL)
+		return;
+
 	stats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
 	if (!stats)
 		return;

