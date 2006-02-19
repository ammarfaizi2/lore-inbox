Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWBSOMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBSOMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 09:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWBSOMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 09:12:08 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:16655 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932437AbWBSOMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 09:12:07 -0500
Date: Sun, 19 Feb 2006 22:11:31 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: [PATCH] autofs4 - fix comms packet struct size
Message-ID: <Pine.LNX.4.64.0602192206440.24506@eagle.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set userspace communication struct fields to fixed size.

Signed-off-by: Ian Kent <raven@themaw.net>

--- linux-2.6.16-rc3-mm1/include/linux/auto_fs4.h.fix-v5-packet-size	2006-02-17 19:15:49.000000000 +0800
+++ linux-2.6.16-rc3-mm1/include/linux/auto_fs4.h	2006-02-17 19:12:09.000000000 +0800
@@ -65,10 +65,10 @@ struct autofs_v5_packet {
 	autofs_wqt_t wait_queue_token;
 	__u32 dev;
 	__u64 ino;
-	uid_t uid;
-	gid_t gid;
-	pid_t pid;
-	pid_t tgid;
+	__u64 uid;
+	__u64 gid;
+	__u64 pid;
+	__u64 tgid;
 	int len;
 	char name[NAME_MAX+1];
 };
--- linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h.fix-v5-packet-size	2006-02-17 19:17:03.000000000 +0800
+++ linux-2.6.16-rc3-mm1/fs/autofs4/autofs_i.h	2006-02-17 19:17:25.000000000 +0800
@@ -79,10 +79,10 @@ struct autofs_wait_queue {
 	char *name;
 	u32 dev;
 	u64 ino;
-	uid_t uid;
-	gid_t gid;
-	pid_t pid;
-	pid_t tgid;
+	u64 uid;
+	u64 gid;
+	u64 pid;
+	u64 tgid;
 	/* This is for status reporting upon return */
 	int status;
 	atomic_t notified;

