Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUKDMLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUKDMLG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbUKDMIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:08:46 -0500
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:17654
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S262170AbUKDMFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:05:02 -0500
Date: Thu, 4 Nov 2004 12:05:00 +0000
From: Patrick Caulfield <pcaulfie@redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org,
       DECnet list <linux-decnet-user@lists.sourceforge.net>
Subject: [PATCH] DECnet route RCU fix
Message-ID: <20041104120500.GI26743@tykepenguin.com>
Mail-Followup-To: davem@redhat.com, linux-kernel@vger.kernel.org,
	DECnet list <linux-decnet-user@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a missing _bh in the 23 August locking update. 
Without this any attempt to read from /proc/net/decnet_cache causes a 
"scheduling while atomic" crash.


Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

===== net/decnet/dn_route.c 1.27 vs edited =====
--- 1.27/net/decnet/dn_route.c	2004-10-28 08:39:57 +01:00
+++ edited/net/decnet/dn_route.c	2004-11-04 11:59:37 +00:00
@@ -1676,7 +1676,7 @@
 		rt = dn_rt_hash_table[s->bucket].chain;
 		if (rt)
 			break;
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 	return rt;
 }
