Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbUDUTAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUDUTAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 15:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUDUTAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 15:00:00 -0400
Received: from outmx006.isp.belgacom.be ([195.238.2.99]:51090 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263623AbUDUS7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:59:07 -0400
Subject: [PATCH 2.6.6-rc2-mm1] BUGFIX - autofs4
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ggBWd/WTAP6EqPlHzMnn"
Message-Id: <1082574181.11705.6.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 21:03:02 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx006.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ggBWd/WTAP6EqPlHzMnn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a bugfix against autofs4 (AFAICS, we parse_int to fd without
check) and parser optimization.

Could you apply ?

Regards,
Fabian

--=-ggBWd/WTAP6EqPlHzMnn
Content-Disposition: attachment; filename=autofs41.diff
Content-Type: text/x-patch; name=autofs41.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/autofs4/inode.c edited/fs/autofs4/inode.c
--- orig/fs/autofs4/inode.c	2004-04-21 18:11:01.000000000 +0200
+++ edited/fs/autofs4/inode.c	2004-04-21 20:56:30.000000000 +0200
@@ -132,34 +132,25 @@
 			continue;
 
 		token = match_token(p, tokens, args);
+		if (match_int(args, pipefd))
+			return 1;
 		switch (token) {
 		case Opt_fd:
-			if (match_int(args, pipefd))
-				return 1;
+			*pipefd = option;
 			break;
 		case Opt_uid:
-			if (match_int(args, &option))
-				return 1;
 			*uid = option;
 			break;
 		case Opt_gid:
-			if (match_int(args, &option))
-				return 1;
 			*gid = option;
 			break;
 		case Opt_pgrp:
-			if (match_int(args, &option))
-				return 1;
 			*pgrp = option;
 			break;
 		case Opt_minproto:
-			if (match_int(args, &option))
-				return 1;
 			*minproto = option;
 			break;
 		case Opt_maxproto:
-			if (match_int(args, &option))
-				return 1;
 			*maxproto = option;
 			break;
 		default:

--=-ggBWd/WTAP6EqPlHzMnn--

