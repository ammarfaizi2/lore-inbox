Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTKEVQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 16:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTKEVQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 16:16:16 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:24680 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263203AbTKEVQP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 16:16:15 -0500
Date: Wed, 5 Nov 2003 13:16:08 -0800
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] use NODES_SHIFT to calculate ZONE_SHIFT
Message-ID: <20031105211608.GA23560@sgi.com>
Mail-Followup-To: akpm@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a proper NODES_SHIFT value, we need to use it to define
ZONE_SHIFT otherwise we'll spill over 8 bits if we have more than 85
nodes.  How does this look?  The '+2' should really be
log2(MAX_NR_NODES), but I think this is an improvement over what was
there.

Thanks,
Jesse

===== include/linux/mm.h 1.133 vs edited =====
--- 1.133/include/linux/mm.h	Sun Oct  5 01:07:49 2003
+++ edited/include/linux/mm.h	Tue Nov  4 16:45:33 2003
@@ -322,8 +322,10 @@
 /*
  * The zone field is never updated after free_area_init_core()
  * sets it, so none of the operations on it need to be atomic.
+ * We'll have up to log2(MAX_NUMNODES * MAX_NR_ZONES) zones
+ * total, so we use NODES_SHIFT here to get enough bits.
  */
-#define ZONE_SHIFT (BITS_PER_LONG - 8)
+#define ZONE_SHIFT (BITS_PER_LONG - (NODES_SHIFT + 2))
 
 struct zone;
 extern struct zone *zone_table[];
