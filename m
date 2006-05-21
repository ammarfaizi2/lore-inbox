Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWEUTD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWEUTD5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 15:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWEUTD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 15:03:57 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:57828 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S964912AbWEUTDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 15:03:54 -0400
Date: Sun, 21 May 2006 15:03:36 -0400 (EDT)
From: Ameer Armaly <ameer@bellsouth.net>
X-X-Sender: ameer@sg1
To: linux-kernel@vger.kernel.org
Subject: [patch] fs warning fixes
Message-ID: <Pine.LNX.4.61.0605211502450.2255@sg1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of two uninitialized variable warnings by initializing idx in fs/bio.c and fd in fs/eventpoll.c; both of these are initialized through pointers later on.

diff --git a/fs/bio.c b/fs/bio.c
index eb8fbc5..c4deed9 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -166,7 +166,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_m

  		bio_init(bio);
  		if (likely(nr_iovecs)) {
-			unsigned long idx;
+			unsigned long idx = 0;

  			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
  			if (unlikely(!bvl)) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1b4491c..243c254 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -497,7 +497,7 @@ void eventpoll_release_file(struct file
   */
  asmlinkage long sys_epoll_create(int size)
  {
-	int error, fd;
+	int error, fd = 0;
  	struct eventpoll *ep;
  	struct inode *inode;
  	struct file *file;
