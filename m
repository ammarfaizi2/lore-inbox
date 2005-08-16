Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVHPSsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVHPSsT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVHPSsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:48:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030293AbVHPSsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:48:18 -0400
Date: Tue, 16 Aug 2005 14:48:13 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] clean up missing overflow check in get_blkdev_list
Message-ID: <20050816184813.GH16120@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to clean up missing overflow check in get_blkdev_list.  the printf which
adds the "Block Devices" string in /proc/devices can overflow the presented page
if get_chrdev_list eats up the entire 4k space. Tested by myself, with good
results.

Signed-off-by: Neil Horman <nhorman@redhat.com>

 genhd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)



--- linux-2.6/drivers/block/genhd.c.orig	2005-08-16 10:12:02.000000000 -0400
+++ linux-2.6/drivers/block/genhd.c	2005-08-16 10:12:27.000000000 -0400
@@ -45,7 +45,7 @@ int get_blkdev_list(char *p, int used)
 	struct blk_major_name *n;
 	int i, len;
 
-	len = sprintf(p, "\nBlock devices:\n");
+	len = snprintf(p, (PAGE_SIZE-used), "\nBlock devices:\n");
 
 	down(&block_subsys_sem);
 	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
