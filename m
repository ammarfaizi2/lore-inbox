Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWDGIPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWDGIPm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDGIPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:15:42 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:19694 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932360AbWDGIPl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:15:41 -0400
Date: Fri, 7 Apr 2006 10:15:33 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Frank Pavlic <fpavlic@de.ibm.com>
Subject: [patch] ipv4: initialize arp_tbl rw lock
Message-ID: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The qeth driver makes use of the arp_tbl rw lock. CONFIG_DEBUG_SPINLOCK
detects that this lock is not initialized as it is supposed to be.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 net/ipv4/arp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 041dadd..ea54216 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -202,6 +202,7 @@ struct neigh_table arp_tbl = {
 	.gc_thresh1 =	128,
 	.gc_thresh2 =	512,
 	.gc_thresh3 =	1024,
+	.lock = RW_LOCK_UNLOCKED,
 };
 
 int arp_mc_map(u32 addr, u8 *haddr, struct net_device *dev, int dir)
