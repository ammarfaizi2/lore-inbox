Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUF3T6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUF3T6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUF3T6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:58:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18368 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262006AbUF3T54
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:57:56 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 4/4: DM: dm-raid1.c: Use fixed-size arrays
Date: Wed, 30 Jun 2004 14:58:46 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406301452.16886.kevcorry@us.ibm.com>
In-Reply-To: <200406301452.16886.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301458.46109.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-raid1.c: Declare fixed-sized (instead of variable-sized) arrays on the
stack in recover() and do_write().

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-raid1.c	2004-06-30 08:48:25.247347928 -0500
+++ source/drivers/md/dm-raid1.c	2004-06-30 08:48:30.101609968 -0500
@@ -602,7 +602,7 @@
 {
 	int r;
 	unsigned int i;
-	struct io_region from, to[ms->nr_mirrors - 1], *dest;
+	struct io_region from, to[KCOPYD_MAX_REGIONS], *dest;
 	struct mirror *m;
 	unsigned long flags = 0;
 
@@ -757,7 +757,7 @@
 static void do_write(struct mirror_set *ms, struct bio *bio)
 {
 	unsigned int i;
-	struct io_region io[ms->nr_mirrors];
+	struct io_region io[KCOPYD_MAX_REGIONS+1];
 	struct mirror *m;
 
 	for (i = 0; i < ms->nr_mirrors; i++) {
