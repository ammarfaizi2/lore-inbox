Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTJFWOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 18:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJFWOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 18:14:11 -0400
Received: from f17.mail.ru ([194.67.57.47]:12298 "EHLO f17.mail.ru")
	by vger.kernel.org with ESMTP id S261775AbTJFWOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 18:14:09 -0400
From: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	<adobriyan@mail.ru>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ext2/acl.c '< 0' comparison make sense only with signed variable.
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [194.85.64.37]
Date: Tue, 07 Oct 2003 02:14:08 +0400
Reply-To: =?koi8-r?Q?=22?=Alexey Dobriyan=?koi8-r?Q?=22=20?= 
	  <adobriyan@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1A6dcG-0007zt-00.adobriyan-mail-ru@f17.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext2_acl_count() returns int and posix_acl_alloc() wants int as the first argument.

diff -urN a/fs/ext2/acl.c b/fs/ext2/acl.c
--- a/fs/ext2/acl.c	2003-09-28 04:50:40.000000000 +0400
+++ b/fs/ext2/acl.c	2003-10-07 00:29:10.000000000 +0400
@@ -19,7 +19,8 @@
 ext2_acl_from_disk(const void *value, size_t size)
 {
 	const char *end = (char *)value + size;
-	size_t n, count;
+	size_t n;
+	int count;
 	struct posix_acl *acl;
 
 	if (!value)

