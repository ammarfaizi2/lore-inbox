Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUBJRGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266029AbUBJRD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:03:57 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:54287 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266025AbUBJRBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:20 -0500
Date: Tue, 10 Feb 2004 17:01:42 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 7/10] dm: Correct GFP flag in dm_table_create()
Message-ID: <20040210170142.GM27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason dm_table_create() was allocating GFP_NOIO rather than
GFP_KERNEL.
--- diff/drivers/md/dm-table.c	2004-02-10 16:11:17.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-02-10 16:11:58.000000000 +0000
@@ -205,7 +205,7 @@
 
 int dm_table_create(struct dm_table **result, int mode, unsigned num_targets)
 {
-	struct dm_table *t = kmalloc(sizeof(*t), GFP_NOIO);
+	struct dm_table *t = kmalloc(sizeof(*t), GFP_KERNEL);
 
 	if (!t)
 		return -ENOMEM;
