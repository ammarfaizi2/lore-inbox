Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262731AbVCDBnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVCDBnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 20:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbVCDAGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:06:22 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262723AbVCCXV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:21:57 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][1/26] IB: fix ib_find_cached_gid() port numbering
In-Reply-To: <2005331520.b7ycIGGfSwBBRSED@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:26 -0800
Message-Id: <2005331520.OFd0tTycEIjc5XlW@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0003 (UTC) FILETIME=[955464B0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Hefty <sean.hefty@intel.com>

Fix ib_find_cached_gid() to return the correct port number relative to
the port numbering used by the device.

Signed-off-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-export.orig/drivers/infiniband/core/cache.c	2005-03-02 20:53:21.000000000 -0800
+++ linux-export/drivers/infiniband/core/cache.c	2005-03-03 15:02:57.180310444 -0800
@@ -114,7 +114,7 @@
 		cache = device->cache.gid_cache[p];
 		for (i = 0; i < cache->table_len; ++i) {
 			if (!memcmp(gid, &cache->table[i], sizeof *gid)) {
-				*port_num = p;
+				*port_num = p + start_port(device);
 				if (index)
 					*index = i;
 				ret = 0;

