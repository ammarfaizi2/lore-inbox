Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUJEP3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUJEP3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 11:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUJEP3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 11:29:52 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:53671 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S269103AbUJEP3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 11:29:20 -0400
Date: Tue, 5 Oct 2004 17:28:59 +0200 (CEST)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@openx3.frec.bull.fr
To: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] cpusets : fix cpuset_get_dentry()
Message-ID: <Pine.LNX.4.61.0410051727400.19964@openx3.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

This patch fixes a trivial bug, triggered when using the cpusets as a 
non-root user.

Against 2.6.9-rc2-mm1.

	Simon.

Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: 269rc2mm1/kernel/cpuset.c
===================================================================
--- 269rc2mm1.orig/kernel/cpuset.c	2004-10-05 16:35:32.751926987 +0200
+++ 269rc2mm1/kernel/cpuset.c	2004-10-05 16:36:27.769504438 +0200
@@ -235,7 +235,7 @@ static struct dentry *cpuset_get_dentry(
 	qstr.len = strlen(name);
 	qstr.hash = full_name_hash(name, qstr.len);
 	d = lookup_hash(&qstr, parent);
-	if (d)
+	if (!IS_ERR(d))
 		d->d_op = &cpuset_dops;
 	return d;
 }
