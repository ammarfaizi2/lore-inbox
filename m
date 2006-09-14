Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWINVhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWINVhk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWINVhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:37:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751107AbWINVhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:37:39 -0400
Date: Thu, 14 Sep 2006 22:37:33 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>
Subject: [PATCH 02/25] dm snapshot: fix invalidation ENOMEM
Message-ID: <20060914213733.GJ3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Milan Broz <mbroz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

Fix ENOMEM error sign.

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:25:35.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:26:20.000000000 +0100
@@ -1034,7 +1034,7 @@ static int __origin_write(struct list_he
 
 		pe = __find_pending_exception(snap, bio);
 		if (!pe) {
-			__invalidate_snapshot(snap, pe, ENOMEM);
+			__invalidate_snapshot(snap, pe, -ENOMEM);
 			goto next_snapshot;
 		}
 
