Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUCQXvM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbUCQXvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:51:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:53459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262190AbUCQXvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:51:10 -0500
Date: Wed, 17 Mar 2004 15:51:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: daniel@osdl.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: 2.6.4-mm2
Message-Id: <20040317155111.49d09a87.akpm@osdl.org>
In-Reply-To: <1079566076.4186.1959.camel@watt.suse.com>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
	<1079474312.4186.927.camel@watt.suse.com>
	<20040316152106.22053934.akpm@osdl.org>
	<20040316152843.667a623d.akpm@osdl.org>
	<20040316153900.1e845ba2.akpm@osdl.org>
	<1079485055.4181.1115.camel@watt.suse.com>
	<1079487710.3100.22.camel@ibm-c.pdx.osdl.net>
	<20040316180043.441e8150.akpm@osdl.org>
	<1079554288.4183.1938.camel@watt.suse.com>
	<20040317123324.46411197.akpm@osdl.org>
	<1079563568.4185.1947.camel@watt.suse.com>
	<20040317150909.7fd121bd.akpm@osdl.org>
	<1079566076.4186.1959.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> Looks good, but I'm still having problems convincing pagevec_lookup_tag
> to return anything other than 0 when called from
> wait_on_page_writeback_range (ext2, ext3, reiserfs).  Any ideas?

This might help.  I'm testing this path now, so there may be more changes..

--- 25/mm/page-writeback.c~x	2004-03-17 15:43:40.102282112 -0800
+++ 25-akpm/mm/page-writeback.c	2004-03-17 15:43:52.317425128 -0800
@@ -702,7 +702,7 @@ int test_set_page_writeback(struct page 
 
 		spin_lock_irqsave(&mapping->tree_lock, flags);
 		ret = TestSetPageWriteback(page);
-		if (ret)
+		if (!ret)
 			radix_tree_tag_set(&mapping->page_tree, page->index,
 						PAGECACHE_TAG_WRITEBACK);
 		if (!PageDirty(page))

_

