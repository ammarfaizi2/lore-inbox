Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273273AbTG3S7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273282AbTG3S7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 14:59:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:6302 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S273273AbTG3S7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 14:59:49 -0400
Date: Wed, 30 Jul 2003 12:00:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sander van Malssen <svm@kozmix.org>
Cc: yoh@onerussian.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3 phantom I/O errors
Message-Id: <20030730120002.29c13b0c.akpm@osdl.org>
In-Reply-To: <20030730170432.GA692@kozmix.org>
References: <20030729153114.GA30071@washoe.rutgers.edu>
	<20030729135025.335de3a0.akpm@osdl.org>
	<20030730170432.GA692@kozmix.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander van Malssen <svm@kozmix.org> wrote:
>
> If I try this on 2.6.0-test2-mm1 with the dump_stack() added (ext3, no
>  initrd) I get the following:
> 
> 
>  Buffer I/O error on device hda1, logical block 25361
>  Call Trace:
>   [<c0150f02>] buffer_io_error+0x42/0x50

OK, looks like the new readahead stuff confused the error reporting.

Does this make the error messages go away?


diff -puN mm/readahead.c~a mm/readahead.c
--- 25/mm/readahead.c~a	2003-07-30 11:58:07.000000000 -0700
+++ 25-akpm/mm/readahead.c	2003-07-30 11:58:20.000000000 -0700
@@ -96,7 +96,7 @@ static int read_pages(struct address_spa
 	struct pagevec lru_pvec;
 	int ret = 0;
 
-	current->flags |= PF_READAHEAD;
+//	current->flags |= PF_READAHEAD;
 
 	if (mapping->a_ops->readpages) {
 		ret = mapping->a_ops->readpages(filp, mapping, pages, nr_pages);

_



Tell me how hard this is to hit.  Does it only happen when there is a large
amount of IO happening?  What is the system doing at the time?
