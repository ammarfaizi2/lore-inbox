Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTJHRxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTJHRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 13:53:31 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:8074 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261500AbTJHRx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 13:53:29 -0400
Date: Wed, 8 Oct 2003 13:52:58 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Hugh Dickins <hugh@veritas.com>, <Matt_Domsch@Dell.com>,
       <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310081440460.1875-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0310081352080.5568-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Marcelo Tosatti wrote:

> > A little of the above explanation in the change comment would be nice.
> 
> Maybe comments on top of the code? 
> 
> Rik? :)

Here you are:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1193  -> 1.1194 
#	        mm/filemap.c	1.89    -> 1.90   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/08	riel@cessna.boston.redhat.com	1.1194
# comment on why the atomic updates are needed, on request
# --------------------------------------------
#
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Wed Oct  8 13:47:12 2003
+++ b/mm/filemap.c	Wed Oct  8 13:47:12 2003
@@ -654,6 +654,12 @@
 	struct address_space *mapping, unsigned long offset,
 	struct page **hash)
 {
+	/*
+	 * Yes this is inefficient, however it is needed.  The problem
+	 * is that we could be adding a page to the swap cache while
+	 * another CPU is also modifying page->flags, so the updates
+	 * really do need to be atomic.  -- Rik
+	 */
 	ClearPageUptodate(page);
 	ClearPageError(page);
 	ClearPageDirty(page);

