Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVACR33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVACR33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVACR0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:26:46 -0500
Received: from holomorphy.com ([207.189.100.168]:35996 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261515AbVACR0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:26:25 -0500
Date: Mon, 3 Jan 2005 09:26:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [2/8] kill quota_v2.c printk() of size_t warning
Message-ID: <20050103172615.GD29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103172303.GB29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The printk() of a size_t is off, tripping a warning. This patch qualifies
the integer format with a 'z' to suppress the warning.

Signed-off-by: William Irwin <wli@holomorphy.com>


Index: mm1-2.6.10/fs/quota_v2.c
===================================================================
--- mm1-2.6.10.orig/fs/quota_v2.c	2005-01-03 06:44:20.000000000 -0800
+++ mm1-2.6.10/fs/quota_v2.c	2005-01-03 07:51:53.000000000 -0800
@@ -396,7 +396,7 @@
 	/* dq_off is guarded by dqio_sem */
 	if (!dquot->dq_off)
 		if ((ret = dq_insert_tree(dquot)) < 0) {
-			printk(KERN_ERR "VFS: Error %d occurred while creating quota.\n", ret);
+			printk(KERN_ERR "VFS: Error %zd occurred while creating quota.\n", ret);
 			return ret;
 		}
 	spin_lock(&dq_data_lock);
