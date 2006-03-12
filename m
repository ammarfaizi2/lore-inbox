Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWCLWsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWCLWsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWCLWsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:48:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53934 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751254AbWCLWsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:48:23 -0500
Date: Sun, 12 Mar 2006 22:48:20 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] dm: store md name
Message-ID: <20060312224820.GF4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Anderson <andmike@us.ibm.com>

The patch stores a printable device number in struct mapped_device 
for use in warning messages and with a proposed netlink interface.

Signed-off-by: Mike Anderson <andmike@us.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc5/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm.c	2006-03-12 18:08:57.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm.c	2006-03-12 18:14:57.000000000 +0000
@@ -68,6 +68,7 @@ struct mapped_device {
 
 	request_queue_t *queue;
 	struct gendisk *disk;
+	char name[16];
 
 	void *interface_ptr;
 
@@ -828,6 +829,7 @@ static struct mapped_device *alloc_dev(u
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 	add_disk(md->disk);
+	format_dev_t(md->name, MKDEV(_major, minor));
 
 	atomic_set(&md->pending, 0);
 	init_waitqueue_head(&md->wait);
