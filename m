Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTBUJbv>; Fri, 21 Feb 2003 04:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTBUJbv>; Fri, 21 Feb 2003 04:31:51 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:38021 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267263AbTBUJbu>;
	Fri, 21 Feb 2003 04:31:50 -0500
Date: Fri, 21 Feb 2003 10:41:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@digeo.com>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>, t.baetzler@bringe.com,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: xdr nfs highmem deadlock fix [Re: filesystem access slowing system to a crawl]
Message-ID: <20030221094115.GG31480@x30.school.suse.de>
References: <A1FE021ABD24D411BE2D0050DA450B925EEA6C@MERKUR> <200302191742.02275.m.c.p@wolk-project.de> <20030219174940.GJ14633@x30.suse.de> <200302201629.51374.m.c.p@wolk-project.de> <20030220103543.7c2d250c.akpm@digeo.com> <20030220215457.GV31480@x30.school.suse.de> <shs1y22zhm9.fsf@charged.uio.no> <20030220230430.GX9800@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220230430.GX9800@gtf.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 06:04:30PM -0500, Jeff Garzik wrote:
> On Thu, Feb 20, 2003 at 11:56:14PM +0100, Trond Myklebust wrote:
> > >>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:
> > 
> >      > 2.5.62 has the very same deadlock condition in xdr triggered by
> >      >        nfs too.
> >      > Andrew, if you're forward porting it yourself like with the
> >      > filebacked vma merging feature just let me know so we make sure
> >      > not to duplicate effort.
> > 
> > For 2.5.x we should rather fix MSG_MORE so that it actually works
> > instead of messing with hacks to kmap().
> > 
> > For 2.4.x, Hirokazu Takahashi had a patch which allowed for a safe
> > kmap of > 1 page in one call. Appended here as an attachment FYI
> > (Marcelo do *not* apply!).
> 
> 
> One should also consider kmap_atomic...  (bcrl suggest)

impossible, either you submit page structures to the IP layer, or you
*must* have persistence, depending on a sock_sendmsg that can't schedule
would be totally broken (or the preemptive thing is a joke). nfs client
O_DIRET zerocopy would be a nice feature but this is 2.4.

the only option would be the atomic and at the same time persistent
kmaps in the process address space that don't work well with threads...
but again this is 2.4 and we miss it even in 2.5 because of the troubles
they generate.

Andrea
