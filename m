Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVCIIkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVCIIkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 03:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVCIIkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 03:40:23 -0500
Received: from mail.kroah.org ([69.55.234.183]:47541 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261657AbVCIIkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 03:40:03 -0500
Date: Wed, 9 Mar 2005 00:39:53 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309083953.GB20461@kroah.com>
References: <20050309083923.GA20461@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309083923.GA20461@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -Nru a/Makefile b/Makefile
--- a/Makefile	2005-03-09 00:13:29 -08:00
+++ b/Makefile	2005-03-09 00:13:29 -08:00
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION = .1
+EXTRAVERSION = .2
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
diff -Nru a/fs/eventpoll.c b/fs/eventpoll.c
--- a/fs/eventpoll.c	2005-03-09 00:13:29 -08:00
+++ b/fs/eventpoll.c	2005-03-09 00:13:29 -08:00
@@ -619,6 +619,7 @@
 	return error;
 }
 
+#define MAX_EVENTS (INT_MAX / sizeof(struct epoll_event))
 
 /*
  * Implement the event wait interface for the eventpoll file. It is the kernel
@@ -635,7 +636,7 @@
 		     current, epfd, events, maxevents, timeout));
 
 	/* The maximum number of event must be greater than zero */
-	if (maxevents <= 0)
+	if (maxevents <= 0 || maxevents > MAX_EVENTS)
 		return -EINVAL;
 
 	/* Verify that the area passed by the user is writeable */
