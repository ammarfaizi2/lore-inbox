Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWJKGSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWJKGSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160998AbWJKGSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:18:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030654AbWJKGSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:18:12 -0400
Date: Tue, 10 Oct 2006 23:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 5/6] generic_file_buffered_write(): max_len cleanup
Message-Id: <20061010231805.3517f5e1.akpm@osdl.org>
In-Reply-To: <20061010231424.db88931f.akpm@osdl.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	<20061010121332.19693.37204.sendpatchset@linux.site>
	<20061010221304.6bef249f.akpm@osdl.org>
	<452C8613.7080708@yahoo.com.au>
	<20061010231150.fb9e30f5.akpm@osdl.org>
	<20061010231243.bc8b834c.akpm@osdl.org>
	<20061010231339.a79c1fae.akpm@osdl.org>
	<20061010231424.db88931f.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

More dirty code.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff -puN mm/filemap.c~generic_file_buffered_write-max_len-cleanup mm/filemap.c
--- a/mm/filemap.c~generic_file_buffered_write-max_len-cleanup
+++ a/mm/filemap.c
@@ -2090,7 +2090,6 @@ generic_file_buffered_write(struct kiocb
 	do {
 		pgoff_t index;		/* Pagecache index for current page */
 		unsigned long offset;	/* Offset into pagecache page */
-		unsigned long maxlen;	/* Bytes remaining in current iovec */
 		size_t bytes;		/* Bytes to write to page */
 		size_t copied;		/* Bytes copied from user */
 
@@ -2100,9 +2099,7 @@ generic_file_buffered_write(struct kiocb
 		if (bytes > count)
 			bytes = count;
 
-		maxlen = cur_iov->iov_len - iov_offset;
-		if (maxlen > bytes)
-			maxlen = bytes;
+		bytes = min(cur_iov->iov_len - iov_offset, bytes);
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
_

