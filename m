Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTEMXLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTEMXLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:11:19 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:43261 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262228AbTEMXLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:11:17 -0400
Date: Tue, 13 May 2003 16:19:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: Zach Brown <zab@zabbo.net>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Interface to invalidate regions of mmaps
Message-Id: <20030513161938.1fc00a5e.akpm@digeo.com>
In-Reply-To: <3EC17BA3.7060403@zabbo.net>
References: <20030513133636.C2929@us.ibm.com>
	<20030513152141.5ab69f07.akpm@digeo.com>
	<3EC17BA3.7060403@zabbo.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 23:23:59.0725 (UTC) FILETIME=[BB7C31D0:01C319A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown <zab@zabbo.net> wrote:
>
> so what we'd like most is the ability to invalidate a region of the file
> in an efficient go.
> 
> void truncate_inode_pages(struct address_space * mapping, loff_t lstart,
> loff_t end)
> 
> that sort of thing.

That's trivial in 2.5.

>  this might not suck so bad if the page cache was an
> rbtree :)

Or a radix tree.

> but on the other hand, this doesn't solve another problem we have with
> opportunistic lock extents and sparse page cache populations.  Ideally
> we'd like a FS specific pointer in struct page so we can associate pages
> in the cache with a lock,

In 2.5, page->buffers was abstracted out to page->private, and is available
to filesystems for functions such as this.


> but I can't imagine suggesting such a thing
> within earshot of wli. 

wli doesn't have to run your kernel.  If you want to add a pointer to the
pageframe, go add it.  But I'd suggest that you do it with a view to
migrating it to page->private.

When you finally decide to do your development in a development kernel ;)


