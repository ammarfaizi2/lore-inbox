Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUBES61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266497AbUBES61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:58:27 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:36785 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S266417AbUBES5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:57:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 5 Feb 2004 10:58:05 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] epoll struct epitem size reduction ...
Message-ID: <Pine.LNX.4.44.0402051053020.6742-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew, as suggested by Eric Dumazet the following patch achieve a more 
compact struct epitem on 64 bit archs.



- Davide




Index: fs/eventpoll.c
===================================================================
RCS file: /usr/src/bkcvs/linux-2.5/fs/eventpoll.c,v
retrieving revision 1.26
diff -u -r1.26 eventpoll.c
--- a/fs/eventpoll.c	21 Jan 2004 03:11:23 -0000	1.26
+++ b/fs/eventpoll.c	5 Feb 2004 18:49:13 -0000
@@ -238,6 +238,9 @@
 	/* List header used to link this structure to the eventpoll ready list */
 	struct list_head rdllink;
 
+	/* The file descriptor this item refers to */
+	int fd;
+
 	/* Number of active wait queue attached to poll operations */
 	int nwait;
 
@@ -246,9 +249,6 @@
 
 	/* The "container" of this item */
 	struct eventpoll *ep;
-
-	/* The file descriptor this item refers to */
-	int fd;
 
 	/* The file this item refers to */
 	struct file *file;

