Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbWF3NkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWF3NkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 09:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWF3NkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 09:40:16 -0400
Received: from tzec.mtu.ru ([195.34.34.228]:45579 "EHLO tzec.mtu.ru")
	by vger.kernel.org with ESMTP id S932249AbWF3NkP (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 09:40:15 -0400
Subject: [RFC] [PATCH] do_sys_truncate: call do_truncate with
	ATTR_MTIME|ATTR_CTIME
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: lkml <Linux-Kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-xwWA8+DDupCFMfWv7mjo"
Date: Fri, 30 Jun 2006 17:33:29 +0400
Message-Id: <1151674409.6499.52.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xwWA8+DDupCFMfWv7mjo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

do_sys_ftruncate calls do_truncate with time_attrs set to ATTR_MTIME|
ATTR_CTIME. Is there a reason for do_sys_truncate to not set time_attrs
to the same value or it is a bug?




--=-xwWA8+DDupCFMfWv7mjo
Content-Disposition: inline; filename=do_truncate-time_attrs.patch
Content-Type: message/rfc822; name=do_truncate-time_attrs.patch

Date: Fri, 30 Jun 2006 17:33:29 +0400
Subject: No Subject
Message-Id: <1151674409.6499.53.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: 

From: Vladimir Saveliev <vs@namesys.com>

When do_truncate is called from do_sys_truncate it is not given
ATTR_MTIME|ATTR_CTIME as in case when it is called from
do_sys_ftruncate. The patch fixes this unfairness.

Signed-off-by: Vladimir Saveliev <vs@namesys.com>



diff -puN fs/open.c~do_truncate-time_attrs fs/open.c
--- linux-2.6.17-mm3/fs/open.c~do_truncate-time_attrs	2006-06-30 16:41:21.000000000 +0400
+++ linux-2.6.17-mm3-root/fs/open.c	2006-06-30 16:49:54.000000000 +0400
@@ -270,7 +270,7 @@ static long do_sys_truncate(const char _
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length, 0, NULL);
+		error = do_truncate(nd.dentry, length, ATTR_MTIME|ATTR_CTIME, NULL);
 	}
 	put_write_access(inode);
 

_

--=-xwWA8+DDupCFMfWv7mjo--

