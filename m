Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTEZEPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 00:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbTEZEOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 00:14:35 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:25093 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S264256AbTEZEOT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 00:14:19 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1053923250348@movementarian.org>
Subject: [PATCH 5/5] OProfile update
In-Reply-To: <10539232503071@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Mon, 26 May 2003 05:27:30 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19K9a6-000OEC-Qx*5jk2SYvsMPA*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


d_path() can return -ENAMETOOLONG these days. Pass it upstream.

diff -Naur -X dontdiff linux-cvs/fs/dcookies.c linux-me/fs/dcookies.c
--- linux-cvs/fs/dcookies.c	2003-05-19 19:57:28.000000000 +0100
+++ linux-me/fs/dcookies.c	2003-05-19 20:05:16.000000000 +0100
@@ -175,6 +175,11 @@
 	/* FIXME: (deleted) ? */
 	path = d_path(dcs->dentry, dcs->vfsmnt, kbuf, PAGE_SIZE);
 
+	if (IS_ERR(path)) {
+		err = PTR_ERR(path);
+		goto out_free;
+	}
+
 	err = -ERANGE;
  
 	pathlen = kbuf + PAGE_SIZE - path;
@@ -184,6 +189,7 @@
 			err = -EFAULT;
 	}
 
+out_free:
 	kfree(kbuf);
 out:
 	up(&dcookie_sem);

