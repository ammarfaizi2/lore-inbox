Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268091AbUBRVGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUBRVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:06:31 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:47417 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268091AbUBRVG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:06:27 -0500
Date: Wed, 18 Feb 2004 06:00:21 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040218140021.GB1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040216190927.GA2969@us.ibm.com> <20040217073522.A25921@infradead.org> <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077108694.4479.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 01:51:35PM +0100, Arjan van de Ven wrote:
> On Wed, 2004-02-18 at 01:19, Andrew Morton wrote:
> > "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> > >
> > > IBM shipped the promised SAN Filesystem some months ago.
> > 
> > Neat, but it's hard to see the relevance of this to your patch.
> > 
> > I don't see any licensing issues with the patch because the filesystem
> > which needs it clearly meets Linus's "this is not a derived work" criteria.
> 
> it does?

I believe so.

> It needed no changes to work on linux?

There is a small shim layer required, but the bulk of the code
implementing GPFS is common between AIX and Linux.  It was on AIX
first by quite a few years.

> it only uses "core unix" apis ?

If they are made available, yes.  That is the point of this patch,
after all.  ;-)

> it needs no changes to the core kernel? *buzz*

You -can- run GPFS in the 2.4 kernel without core-kernel patches,
as long as you don't mind putting up with mmap/page-fault races and
with NFS exports from different nodes handing out the same lock to two
different NFS clients.  ;-)

> It doesn't require knowledge of deep and changing internals ? *buzz*

That is indeed the idea.

> It doesn't need changing for various kernel versions ?

It is tested on specific kernel versions.  Clearly moving from 2.4 to
2.6 requires some change.

> I remember this baby overriding syscalls and the like not too long
> ago...

???

> The word "clearly" isn't correct imo. Just because something has a few
> lines of code that started on another OS doesn't make it "clearly" not a
> derived work, at least not in my eyes.

Hmmm...  You seem to have a rather expansive definition of
"a few lines of code".  ;-)

						Thanx, Paul
