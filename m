Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVBUWNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVBUWNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVBUWNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:13:53 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35974 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261369AbVBUWNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:13:51 -0500
Date: Mon, 21 Feb 2005 14:12:52 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mort@wildopensource.com, linux-kernel@vger.kernel.org, raybry@sgi.com
Subject: Re: [PATCH/RFC] A method for clearing out page cache
Message-Id: <20050221141252.6b44f0ea.pj@sgi.com>
In-Reply-To: <20050221134220.2f5911c9.akpm@osdl.org>
References: <20050214154431.GS26705@localhost>
	<20050214193704.00d47c9f.pj@sgi.com>
	<20050221192721.GB26705@localhost>
	<20050221134220.2f5911c9.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> sys_free_node_memory(long node_id, long pages_to_make_free, long what_to_free)
> ...
> - To make the syscall more general, we should be able to reclaim mapped
>   pagecache and anonymous memory as well.

sys_free_node_memory() - nice.

Does it make sense to also have it be able to free up slab cache,
calling shrink_slab()?

Did you mean to pass a nodemask, or a single node id?  Passing a single
node id is easier - we've shown that it is difficult to pass bitmaps
across the user/kernel boundary without confusions.  But if only a
single node id is passed, then you get the thread per node that you just
argued was sometimes overkill.

I'd prefer the single node id, because it's easier to get right.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
