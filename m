Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946108AbWKAFet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946108AbWKAFet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946111AbWKAFet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:34:49 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:65222 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946108AbWKAFer
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:34:47 -0500
Message-Id: <20061101053449.177834000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jens Axboe <jens.axboe@oracle.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 02/61] splice: fix pipe_to_file() ->prepare_write() error path
Content-Disposition: inline; filename=splice-fix-pipe_to_file-prepare_write-error-path.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jens Axboe <jens.axboe@oracle.com>

Don't jump to the unlock+release path, we already did that.

Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 fs/splice.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18.1.orig/fs/splice.c
+++ linux-2.6.18.1/fs/splice.c
@@ -607,7 +607,7 @@ find_page:
 			ret = -ENOMEM;
 			page = page_cache_alloc_cold(mapping);
 			if (unlikely(!page))
-				goto out_nomem;
+				goto out_ret;
 
 			/*
 			 * This will also lock the page
@@ -666,7 +666,7 @@ find_page:
 		if (sd->pos + this_len > isize)
 			vmtruncate(mapping->host, isize);
 
-		goto out;
+		goto out_ret;
 	}
 
 	if (buf->page != page) {
@@ -698,7 +698,7 @@ find_page:
 out:
 	page_cache_release(page);
 	unlock_page(page);
-out_nomem:
+out_ret:
 	return ret;
 }
 

--
