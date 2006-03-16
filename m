Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752090AbWCPDBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbWCPDBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbWCPDBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:01:47 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:7353 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1752090AbWCPDBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:01:46 -0500
Date: Thu, 16 Mar 2006 11:00:04 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: [PATCH] Fix vfs_inode dereference before NULL check
To: linux-kernel@vger.kernel.org
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316030004.GA21357@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__getname, which in turn will call kmem_cache_alloc, may return NULL.

Coverity bug #977

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/fs/9p/vfs_inode.c~	2006-03-15 10:05:37.000000000 +0800
+++ linux-2.6/fs/9p/vfs_inode.c	2006-03-16 10:54:33.000000000 +0800
@@ -1254,6 +1254,8 @@
 		return -EINVAL;
 
 	name = __getname();
+	if (!name)
+		return -EINVAL;
 	/* build extension */
 	if (S_ISBLK(mode))
 		sprintf(name, "b %u %u", MAJOR(rdev), MINOR(rdev));
		
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

