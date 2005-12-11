Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbVLKAsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbVLKAsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 19:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbVLKAsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 19:48:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56784 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161077AbVLKAsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 19:48:16 -0500
Date: Sat, 10 Dec 2005 16:47:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: fujita.tomonori@lab.ntt.co.jp, michaelc@cs.wisc.edu, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       open-iscsi@googlegroups.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: allowed pages in the block later, was Re: [Ext2-devel] [PATCH]
 ext3: avoid sending down non-refcounted pages
Message-Id: <20051210164736.6e4eaa3f.akpm@osdl.org>
In-Reply-To: <20051208134239.GA13376@infradead.org>
References: <20051208180900T.fujita.tomonori@lab.ntt.co.jp>
	<20051208101833.GM14509@schatzie.adilger.int>
	<20051208134239.GA13376@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> The problem we're trying to solve here is how do implement network block
>  devices (nbd, iscsi) efficiently.  The zero copy codepath in the networking
>  layer does need to grab additional references to pages.  So to use sendpage
>  we need a refcountable page.  pages used by the slab allocator are not
>  normally refcounted so try to do get_page/pub_page on them will break.

I don't get it.  Doing get_page/put_page on a slab-allocated page should do
the right thing?
