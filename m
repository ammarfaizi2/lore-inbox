Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUF3T7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUF3T7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUF3T6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:58:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55729 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261875AbUF3T5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:57:46 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] 3/4: DM: dm-raid1.c: Enforce max of 9 mirrors
Date: Wed, 30 Jun 2004 14:58:27 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200406301452.16886.kevcorry@us.ibm.com>
In-Reply-To: <200406301452.16886.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301458.27773.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dm-raid1.c: Since kcopyd can currently only handle 1 source and up to 8
destinations, enforce a max of 9 mirrors when creating a dm-mirror device.

Signed-off-by: Kevin Corry <kevcorry@us.ibm.com>

--- diff/drivers/md/dm-raid1.c	2004-06-30 08:45:34.500305424 -0500
+++ source/drivers/md/dm-raid1.c	2004-06-30 08:48:25.247347928 -0500
@@ -1028,7 +1028,7 @@
 	argc -= args_used;
 
 	if (!argc || sscanf(argv[0], "%u", &nr_mirrors) != 1 ||
-	    nr_mirrors < 2) {
+	    nr_mirrors < 2 || nr_mirrors > KCOPYD_MAX_REGIONS + 1) {
 		ti->error = "dm-mirror: Invalid number of mirrors";
 		dm_destroy_dirty_log(dl);
 		return -EINVAL;
