Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268039AbUJVVoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268039AbUJVVoN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUJVVoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 17:44:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:29878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268040AbUJVVfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 17:35:54 -0400
Date: Fri, 22 Oct 2004 14:35:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] uninline __sigqueue_alloc
Message-ID: <20041022143551.Z2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph suggests letting the compiler choose.  No real compelling reason
to inline anyhow.  I had some vmlinux size numbers suggesting inline was
better, but re-running them on newer kernel is giving different results,
favoring uninline.  Best let compiler choose.  Un-inline __sigqueue_alloc.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/signal.c 1.140 vs edited =====
--- 1.140/kernel/signal.c	2004-10-21 13:46:54 -07:00
+++ edited/kernel/signal.c	2004-10-22 14:00:00 -07:00
@@ -265,7 +265,7 @@
 	return sig;
 }
 
-static inline struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
+static struct sigqueue *__sigqueue_alloc(struct task_struct *t, int flags)
 {
 	struct sigqueue *q = NULL;
 
