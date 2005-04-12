Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVDLS6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVDLS6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVDLSt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:49:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:7626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262229AbVDLKcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:52 -0400
Message-Id: <200504121032.j3CAWlHD005680@shell0.pdx.osdl.net>
Subject: [patch 135/198] undo do_readv_writev() behavior change
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, haveblue@us.ibm.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <haveblue@us.ibm.com>

Bugme bug 4326: http://bugme.osdl.org/show_bug.cgi?id=4326 reports:

executing the systemcall readv with Bad argument
->len == -1) it gives out error EFAULT instead of EINVAL 


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/read_write.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/read_write.c~undo-do_readv_writev-behavior-change fs/read_write.c
--- 25/fs/read_write.c~undo-do_readv_writev-behavior-change	2005-04-12 03:21:36.081651656 -0700
+++ 25-akpm/fs/read_write.c	2005-04-12 03:21:36.084651200 -0700
@@ -467,10 +467,10 @@ static ssize_t do_readv_writev(int type,
 		void __user *buf = iov[seg].iov_base;
 		ssize_t len = (ssize_t)iov[seg].iov_len;
 
-		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
-			goto Efault;
 		if (len < 0)	/* size_t not fitting an ssize_t .. */
 			goto out;
+		if (unlikely(!access_ok(vrfy_dir(type), buf, len)))
+			goto Efault;
 		tot_len += len;
 		if ((ssize_t)tot_len < 0) /* maths overflow on the ssize_t */
 			goto out;
_
