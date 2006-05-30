Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWE3Q5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWE3Q5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWE3Q5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:57:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53993 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932329AbWE3Q5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:57:08 -0400
Date: Tue, 30 May 2006 17:57:04 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dm table: get_target: fix last index
Message-ID: <20060530165703.GH4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>

The table is indexed from 0, so an index equal to t->num_targets should
be rejected.

(There is no code in the current tree that would exercise this bug.)

Signed-Off-By: Milan Broz <mbroz@redhat.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm-table.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm-table.c	2006-05-25 19:06:52.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm-table.c	2006-05-30 17:18:50.000000000 +0100
@@ -802,7 +802,7 @@ sector_t dm_table_get_size(struct dm_tab
 
 struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index)
 {
-	if (index > t->num_targets)
+	if (index >= t->num_targets)
 		return NULL;
 
 	return t->targets + index;
