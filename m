Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWJQPpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWJQPpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWJQPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:45:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:29827 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751118AbWJQPpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:45:31 -0400
Message-ID: <4534FA99.2080009@fr.ibm.com>
Date: Tue, 17 Oct 2006 17:45:29 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@suse.de>
Subject: Re: 2.6.19-rc2-mm1
References: <20061016230645.fed53c5b.akpm@osdl.org>
In-Reply-To: <20061016230645.fed53c5b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +mm-fix-pagecache-write-deadlocks.patch

filemap_xip.c needs a fix also.

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
---
 mm/filemap_xip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: 2.6.19-rc2-mm1/mm/filemap_xip.c
===================================================================
--- 2.6.19-rc2-mm1.orig/mm/filemap_xip.c
+++ 2.6.19-rc2-mm1/mm/filemap_xip.c
@@ -317,7 +317,7 @@ __xip_file_write(struct file *filp, cons
 			break;
 		}
 
-		copied = filemap_copy_from_user(page, offset, buf, bytes);
+		copied = filemap_copy_from_user_atomic(page, offset, buf, bytes);
 		flush_dcache_page(page);
 		if (likely(copied > 0)) {
 			status = copied;
