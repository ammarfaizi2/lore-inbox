Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUIUQVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUIUQVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUIUQVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:21:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267807AbUIUQVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:21:35 -0400
Date: Tue, 21 Sep 2004 17:21:31 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: fix minor number check
Message-ID: <20040921162131.GD11810@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor number allocation check: (1 << MINORBITS) is invalid.

--- diff/drivers/md/dm.c	2004-09-20 20:44:03.000000000 +0100
+++ source/drivers/md/dm.c	2004-09-21 16:34:04.000000000 +0100
@@ -647,7 +647,7 @@
 {
 	int r, m;
 
-	if (minor > (1 << MINORBITS))
+	if (minor >= (1 << MINORBITS))
 		return -EINVAL;
 
 	down(&_minor_lock);
@@ -697,7 +697,7 @@
 		goto out;
 	}
 
-	if (m > (1 << MINORBITS)) {
+	if (m >= (1 << MINORBITS)) {
 		idr_remove(&_minor_idr, m);
 		r = -ENOSPC;
 		goto out;
