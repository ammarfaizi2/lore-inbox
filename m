Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263613AbUDUTDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263613AbUDUTDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUDUTDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:03:51 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:29878 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263613AbUDUTDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 15:03:41 -0400
Subject: [PATCH 2.6.6-rc2-mm1] autofs parser simplified
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-qBmQ/v/n21FJtEpcd3fE"
Message-Id: <1082574046.1847.2.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 21:00:47 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx004.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qBmQ/v/n21FJtEpcd3fE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch to avoid int parse redundancy in autofs.
Could you apply ?

Regards,
Fabian

--=-qBmQ/v/n21FJtEpcd3fE
Content-Disposition: attachment; filename=autofs1.diff
Content-Type: text/x-patch; name=autofs1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/autofs/inode.c edited/fs/autofs/inode.c
--- orig/fs/autofs/inode.c	2004-04-04 05:37:38.000000000 +0200
+++ edited/fs/autofs/inode.c	2004-04-21 20:29:26.000000000 +0200
@@ -58,7 +58,7 @@
 	{Opt_err, NULL}
 };
 
-static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid, pid_t *pgrp, int *minproto, int *maxproto)
+static int parse_options(char *options, int *pipefd, uid_t *uid, gid_t *gid, pid_t *pgrp, int *minproto, int *maxproto) 
 {
 	char *p;
 	substring_t args[MAX_OPT_ARGS];
@@ -79,37 +79,28 @@
 		int token;
 		if (!*p)
 			continue;
-
 		token = match_token(p, autofs_tokens, args);
+
+		/*We only have %u tokens so...*/
+		if (match_int(&args[0], &option))
+			return 1;
 		switch (token) {
 		case Opt_fd:
-			if (match_int(&args[0], &option))
-				return 1;
 			*pipefd = option;
 			break;
 		case Opt_uid:
-			if (match_int(&args[0], &option))
-				return 1;
 			*uid = option;
 			break;
 		case Opt_gid:
-			if (match_int(&args[0], &option))
-				return 1;
 			*gid = option;
 			break;
 		case Opt_pgrp:
-			if (match_int(&args[0], &option))
-				return 1;
 			*pgrp = option;
 			break;
 		case Opt_minproto:
-			if (match_int(&args[0], &option))
-				return 1;
 			*minproto = option;
 			break;
 		case Opt_maxproto:
-			if (match_int(&args[0], &option))
-				return 1;
 			*maxproto = option;
 			break;
 		default:

--=-qBmQ/v/n21FJtEpcd3fE--

