Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTERWpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbTERWpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:45:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:44979 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262246AbTERWpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:45:14 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 19 May 2003 00:57:37 +0200 (MEST)
Message-Id: <UTC200305182257.h4IMvbe09239.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: [PATCH] fix oops in namespace.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Number four in the series of namespace.c fixes:

A familar type of Oops: d_path() can return an error ENAMETOOLONG,
and if we fail to test a segfault occurs.

So we must test. What we do is a different matter.
Rather arbitrarily I return the string " (too long)"
for use in /proc/mounts.

Andries

--- namespace.c~	Mon May 19 01:50:48 2003
+++ namespace.c	Mon May 19 01:51:24 2003
@@ -217,6 +217,8 @@
 	if (!path_buf)
 		return -ENOMEM;
 	path = d_path(mnt->mnt_root, mnt, path_buf, PAGE_SIZE);
+	if (IS_ERR(path))
+		path = " (too long)";
 
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_putc(m, ' ');
