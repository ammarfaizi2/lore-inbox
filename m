Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTKYA6q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 19:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTKYA6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 19:58:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:39554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261869AbTKYA6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 19:58:45 -0500
Date: Mon, 24 Nov 2003 17:05:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Make balance_dirty_pages zone aware (1/2)
Message-Id: <20031124170506.4024bb30.akpm@osdl.org>
In-Reply-To: <39670000.1069719009@flay>
References: <3FBEB27D.5010007@us.ibm.com>
	<20031123143627.1754a3f0.akpm@osdl.org>
	<1034580000.1069688202@[10.10.2.4]>
	<20031124100043.5416ed4c.akpm@osdl.org>
	<39670000.1069719009@flay>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> > What trouble?
> 
> Well ... not so sure of this as I once was ... so be gentle with me ;-)
> But if the system has been running for a while, memory is full of pagecache,
> etc. We try to allocate from the local node, fail, and fall back to the
> other nodes, which are all full as well. Then we wake up kswapd, but all
> pages in this node are dirty, so we block for ages on writeout, making 
> mem allocate really latent and slow (which was presumably what
> balance_dirty_pages was there to solve in the first place). 

It is possible.  You'd be pretty unlucky to dirty so much lowmem when there
is such a huge amount of highmem floating about, but yes, if you tried hard
enough...

I have a feeling that some observed problem must have prompted this coding
frenzy from Matthew.  Surely some problem was observed, and this patch
fixed it up??

> > If we make the dirty threshold a proportion of the initial amount of free
> > memory in ZONE_NORMAL, as is done in 2.4 it will not be possible to fill
> > any node with dirty pages.
> 
> True. But that seems a bit extreme for a system with 64GB of RAM, and only
> 896Mb in ZONE_NORMAL ;-) Doesn't really seem like the right way to fix it.
> 

Increasing /proc/sys/vm/lower_zone_protection can be used to teach the VM
to not use lowmem for pagecache.  Does this solve the elusive problem too?

