Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277029AbRJQScx>; Wed, 17 Oct 2001 14:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277030AbRJQScn>; Wed, 17 Oct 2001 14:32:43 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:15113 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S277029AbRJQSck>; Wed, 17 Oct 2001 14:32:40 -0400
Date: Wed, 17 Oct 2001 11:32:45 -0700
From: Chip Salzenberg <chip@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.13pre3aa1: expand_fdset() may use invalid pointer
Message-ID: <20011017113245.A3849@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In 2.4.13pre3aa1, expand_fdset() in fs/file.c has a couple of
execution paths that call kfree() on a pointer that hasn't yet been
initialized.  A minimal patch is attached.
-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aa-files_struct_rcu-2.4.10-04-1-kfree-fix"


Index: linux/fs/file.c
--- linux/fs/file.c.old	Tue Oct 16 23:28:16 2001
+++ linux/fs/file.c	Wed Oct 17 00:29:43 2001
@@ -203,5 +203,5 @@
 	fd_set *new_openset = 0, *new_execset = 0;
 	int error, nfds = 0;
-	struct rcu_fd_set *arg;
+	struct rcu_fd_set *arg = NULL;
 
 	error = -EMFILE;

--u3/rZRmxL6MmkK24--
