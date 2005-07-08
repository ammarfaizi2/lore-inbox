Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVGHTpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVGHTpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVGHTpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:45:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43450 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262787AbVGHToM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:44:12 -0400
Date: Fri, 8 Jul 2005 20:44:08 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper snapshots: Handle origin extension
Message-ID: <20050708194408.GI12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle writes to a snapshot-origin device that has been extended since
the snapshot was taken.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm-snap.c	2005-07-08 19:01:41.000000000 +0100
+++ source/drivers/md/dm-snap.c	2005-07-08 19:41:00.000000000 +0100
@@ -931,6 +931,10 @@
 		if (!snap->valid)
 			continue;
 
+		/* Nothing to do if writing beyond end of snapshot */
+		if (bio->bi_sector >= dm_table_get_size(snap->table))
+			continue;
+
 		down_write(&snap->lock);
 
 		/*
--- diff/drivers/md/dm-table.c	2005-06-17 20:48:29.000000000 +0100
+++ source/drivers/md/dm-table.c	2005-07-08 19:41:00.000000000 +0100
@@ -943,6 +943,7 @@
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
 EXPORT_SYMBOL(dm_table_event);
+EXPORT_SYMBOL(dm_table_get_size);
 EXPORT_SYMBOL(dm_table_get_mode);
 EXPORT_SYMBOL(dm_table_put);
 EXPORT_SYMBOL(dm_table_get);
