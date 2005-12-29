Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVL2Oqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVL2Oqx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVL2Oqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:46:52 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27101 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750738AbVL2Oqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:46:52 -0500
Date: Thu, 29 Dec 2005 14:46:50 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: + drop-pagecache.patch added to -mm tree
Message-ID: <20051229144650.GB18833@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <200512020130.jB21UWpS019783@shell0.pdx.osdl.net> <2cd57c900512290154k12a2265cx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900512290154k12a2265cx@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:54:08PM +0800, Coywolf Qi Hunt wrote:
> 2005/12/2, akpm@osdl.org <akpm@osdl.org>:
> >
> > The patch titled
> >
> >      drop-pagecache
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      drop-pagecache.patch
> >
> >
> > From: Andrew Morton <akpm@osdl.org>
> >
> > Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> > to discard as much pagecache and reclaimable slab objects as it can.
> >
> > It won't drop dirty data, so the user should run `sync' first.
> >
> > Caveats:
> >
> > a) Holds inode_lock for exorbitant amounts of time.
> >
> > b) Needs to be taught about NUMA nodes: propagate these all the way through
> >    so the discarding can be controlled on a per-node basis.
> >
> > c) The pagecache shrinking and slab shrinking should probably have separate
> >    controls.

d) it is a total mess.

A lot of code for something that you shouldn't do
except for benchmarking.  If people see problems where pagecache data isn't
dropped enough we should fix the VM instead of adding code that just bloats
the kernel more.
