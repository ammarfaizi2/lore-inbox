Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266033AbSKFSz1>; Wed, 6 Nov 2002 13:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266034AbSKFSz1>; Wed, 6 Nov 2002 13:55:27 -0500
Received: from mons.uio.no ([129.240.130.14]:58853 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266033AbSKFSzZ>;
	Wed, 6 Nov 2002 13:55:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.21618.999074.513995@charged.uio.no>
Date: Wed, 6 Nov 2002 18:42:10 +0100
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Convert NFS client to use ->readpages()
In-Reply-To: <3DC8E23A.2578323F@digeo.com>
References: <shssmyfe8nt.fsf@charged.uio.no>
	<3DC8E23A.2578323F@digeo.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton <akpm@digeo.com> writes:

     > Or should it be

     > 	while (!list_empty(...))

Duh. No idea how that crept in.

Concerning your other query: the code is correct as it stands since
nfs_pagein_list() is guaranteed to drain the entire list.

--- linux-2.5.45-02-readpages2/fs/nfs/read.c.orig	2002-11-05 19:45:07.000000000 -0500
+++ linux-2.5.45-02-readpages2/fs/nfs/read.c	2002-11-06 12:35:06.000000000 -0500
@@ -387,7 +387,7 @@
 			       is_sync ? readpage_sync_filler :
 					 readpage_async_filler,
 			       &desc);
-	if (!list_empty(pages)) {
+	while (!list_empty(pages)) {
 		struct page *page = list_entry(pages->prev, struct page, list);
 		list_del(&page->list);
 		page_cache_release(page);
