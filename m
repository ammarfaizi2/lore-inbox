Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUFFQPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUFFQPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 12:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUFFQPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 12:15:09 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:14990 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263778AbUFFQPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 12:15:02 -0400
Subject: [PATCH] 2.6.6 memory allocation checks in idmap_lookup()
From: Yury Umanets <yury@clusterfs.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086538529.2793.82.camel@firefly>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 19:15:29 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds memory allocation checks in idmap_lookup()

 ./linux-2.6.6-modified/fs/nfsd/nfs4idmap.c |    2 ++
 1 files changed, 2 insertions(+)

Signed-off-by: Yury Umanets <torque@ukrpost.net>

diff -rupN ./linux-2.6.6/fs/nfsd/nfs4idmap.c
./linux-2.6.6-modified/fs/nfsd/nfs4idmap.c
--- ./linux-2.6.6/fs/nfsd/nfs4idmap.c	Mon May 10 05:32:54 2004
+++ ./linux-2.6.6-modified/fs/nfsd/nfs4idmap.c	Wed Jun  2 14:40:17 2004
@@ -474,6 +474,8 @@ idmap_lookup(struct svc_rqst *rqstp,
 	if (!*item)
 		return -ENOMEM;
 	mdr = kmalloc(sizeof(*mdr), GFP_KERNEL);
+	if (!mdr)
+		return -ENOMEM;
 	memset(mdr, 0, sizeof(*mdr));
 	init_waitqueue_head(&mdr->waitq);
 	add_wait_queue(&mdr->waitq, &waitq);


-- 
umka

