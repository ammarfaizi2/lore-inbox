Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVL3AMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVL3AMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 19:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVL3AMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 19:12:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbVL3AMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 19:12:07 -0500
Date: Thu, 29 Dec 2005 16:11:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: coywolf@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: + drop-pagecache.patch added to -mm tree
Message-Id: <20051229161158.85606458.akpm@osdl.org>
In-Reply-To: <20051229144650.GB18833@infradead.org>
References: <200512020130.jB21UWpS019783@shell0.pdx.osdl.net>
	<2cd57c900512290154k12a2265cx@mail.gmail.com>
	<20051229144650.GB18833@infradead.org>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Dec 29, 2005 at 05:54:08PM +0800, Coywolf Qi Hunt wrote:
> > 2005/12/2, akpm@osdl.org <akpm@osdl.org>:
> > >
> > > The patch titled
> > >
> > >      drop-pagecache
> > >
> > > has been added to the -mm tree.  Its filename is
> > >
> > >      drop-pagecache.patch
> > >
> > >
> > > From: Andrew Morton <akpm@osdl.org>
> > >
> > > Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> > > to discard as much pagecache and reclaimable slab objects as it can.
> > >
> > > It won't drop dirty data, so the user should run `sync' first.
> > >
> > > Caveats:
> > >
> > > a) Holds inode_lock for exorbitant amounts of time.
> > >
> > > b) Needs to be taught about NUMA nodes: propagate these all the way through
> > >    so the discarding can be controlled on a per-node basis.
> > >
> > > c) The pagecache shrinking and slab shrinking should probably have separate
> > >    controls.
> 
> d) it is a total mess.

Rubbish.

> A lot of code

295 bytes.

> for something that you shouldn't do
> except for benchmarking.

Sure.  It's a debugging feature.

>  If people see problems where pagecache data isn't
> dropped enough we should fix the VM instead of adding code that just bloats
> the kernel more.

It's useful for debugging VM problems, too.


I'm not fussed, really - it's useful for kernel developers and testers.  If
we're so worried about a very small amount of not-at-all-messy code then we
can stick it under CONFIG_DEBUG_VM.  
