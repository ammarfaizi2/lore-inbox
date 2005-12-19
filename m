Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932716AbVLSKUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbVLSKUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 05:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbVLSKUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 05:20:09 -0500
Received: from koto.vergenet.net ([210.128.90.7]:16074 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932716AbVLSKUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 05:20:07 -0500
Date: Mon, 19 Dec 2005 19:16:12 +0900
From: Horms <horms@verge.net.au>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] SECURITY,VFS,2.4: local denial-of-service with file lease
Message-ID: <20051219101610.GA427@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    [PATCH] VFS: local denial-of-service with file leases
    
    Remove time_out_leases() printk that's easily triggered by users.
    
    Signed-off-by: Chris Wright <chrisw@osdl.org>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
    
    Above is the signoff information for
    f3a9388e4ebea57583272007311fffa26ebbb305 included in Linus's 2.6 tree.
    As this is CVE-2005-3857 I am proposing its inclusion in 2.4
    
    Signed-off-by: Horms <horms@verge.net.au>
    
diff --git a/fs/locks.c b/fs/locks.c
index 370ed4c..2f21d25 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1087,7 +1087,6 @@ static void time_out_leases(struct inode
 			before = &fl->fl_next;
 			continue;
 		}
-		printk(KERN_INFO "lease broken - owner pid = %d\n", fl->fl_pid);
 		lease_modify(before, fl->fl_type & ~F_INPROGRESS);
 		if (fl == *before)	/* lease_modify may have freed fl */
 			before = &fl->fl_next;
