Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUEKIwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUEKIwV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUEKIwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:52:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:17797 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262422AbUEKIuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:50:19 -0400
Date: Tue, 11 May 2004 01:50:15 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 4/11] add simple get_uid() helper
Message-ID: <20040511015015.C21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511014833.B21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:48:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple helper function to grab a reference to a user_struct.

===== include/linux/sched.h 1.210 vs edited =====
--- 1.210/include/linux/sched.h	Mon May 10 04:25:34 2004
+++ edited/include/linux/sched.h	Mon May 10 18:22:10 2004
@@ -714,6 +714,11 @@
 
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
+static inline struct user_struct *get_uid(struct user_struct *u)
+{
+	atomic_inc(&u->__count);
+	return u;
+}
 extern void free_uid(struct user_struct *);
 extern void switch_uid(struct user_struct *);
 

