Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266029AbUBJRG0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbUBJRDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:03:50 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:24080 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266027AbUBJRBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:24 -0500
Date: Tue, 10 Feb 2004 17:02:09 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 8/10] dm: Zero size target sanity check
Message-ID: <20040210170209.GN27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add sanity check to dm_table_add_target() against zero length targets.  [Christophe Saout]
--- diff/drivers/md/dm-table.c	2004-02-10 16:11:58.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-02-10 16:12:04.000000000 +0000
@@ -655,6 +655,11 @@
 	memset(tgt, 0, sizeof(*tgt));
 	set_default_limits(&tgt->limits);
 
+	if (!len) {
+		tgt->error = "zero-length target";
+		return -EINVAL;
+	}
+
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
 		tgt->error = "unknown target type";
