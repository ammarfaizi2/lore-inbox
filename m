Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754256AbWKGSbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbWKGSbo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 13:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754255AbWKGSbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 13:31:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40071 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754254AbWKGSbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 13:31:43 -0500
Date: Tue, 7 Nov 2006 18:31:36 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Jonathan E Brassow <jbrassow@redhat.com>
Subject: [PATCH 2.6.19 3/5] dm: multipath: fix rr_add_path order
Message-ID: <20061107183136.GE6993@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com,
	Jonathan E Brassow <jbrassow@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan E Brassow <jbrassow@redhat.com>

When adding paths to the round-robin path selector, their order gets
inverted, which is not desirable.

Fix by replacing list_add() with list_add_tail().

Signed-off-by: Jonathan E Brassow <jbrassow@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Cc: dm-devel@redhat.com

Index: linux-2.6.19-rc4/drivers/md/dm-round-robin.c
===================================================================
--- linux-2.6.19-rc4.orig/drivers/md/dm-round-robin.c	2006-11-07 17:06:19.000000000 +0000
+++ linux-2.6.19-rc4/drivers/md/dm-round-robin.c	2006-11-07 17:07:59.000000000 +0000
@@ -136,7 +136,7 @@ static int rr_add_path(struct path_selec
 
 	path->pscontext = pi;
 
-	list_add(&pi->list, &s->valid_paths);
+	list_add_tail(&pi->list, &s->valid_paths);
 
 	return 0;
 }
