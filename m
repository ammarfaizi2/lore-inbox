Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270043AbUJSSZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270043AbUJSSZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270041AbUJSSYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:24:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270131AbUJSSFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 14:05:23 -0400
Date: Tue, 19 Oct 2004 19:04:58 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2/2: device-mapper trivial: duplicate kfree in error path
Message-ID: <20041019180458.GG6420@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate kfree in dm_register_target error path.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-target.c	2004-06-30 14:25:46.000000000 +0100
+++ source/drivers/md/dm-target.c	2004-10-19 16:53:56.000000000 +0100
@@ -120,10 +120,9 @@
 		return -ENOMEM;
 
 	down_write(&_lock);
-	if (__find_target_type(t->name)) {
-		kfree(ti);
+	if (__find_target_type(t->name))
 		rv = -EEXIST;
-	} else
+	else
 		list_add(&ti->list, &_targets);
 
 	up_write(&_lock);
