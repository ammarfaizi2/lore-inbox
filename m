Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWJ3UEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWJ3UEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWJ3UEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:04:00 -0500
Received: from mail.parknet.jp ([210.171.160.80]:44039 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932476AbWJ3UD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:03:59 -0500
X-AuthUser: hirofumi@parknet.jp
To: akpm@osdl.org, Trond.Myklebust@netapp.com, miklos@szeredi.hu,
       sfrench@us.ibm.com, cluster-devel@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Cleanup read_pages()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 31 Oct 2006 05:03:48 +0900
Message-ID: <8764e1muzf.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current read_pages() assume ->readpages() frees the passed pages.

This patch free the pages in ->read_pages(), if those were remaining
in the pages_list.  So, readpages() just can ignore the remaining
pages in pages_list.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 mm/readahead.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN mm/readahead.c~readpages-fixes mm/readahead.c
--- linux-2.6/mm/readahead.c~readpages-fixes	2006-10-31 04:45:38.000000000 +0900
+++ linux-2.6-hirofumi/mm/readahead.c	2006-10-31 04:46:37.000000000 +0900
@@ -167,6 +167,8 @@ static int read_pages(struct address_spa
 
 	if (mapping->a_ops->readpages) {
 		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
+		/* Clean up the remaining pages */
+		put_pages_list(pages);
 		goto out;
 	}
 
_
