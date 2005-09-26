Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVIZWWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVIZWWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVIZWWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:22:09 -0400
Received: from florence.buici.com ([206.124.142.26]:64178 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S932382AbVIZWWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:22:08 -0400
Date: Mon, 26 Sep 2005 15:22:07 -0700
From: Marc Singer <elf@buici.com>
To: Franck <vagabon.xyz@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: questions on discontgmem.
Message-ID: <20050926222207.GA987@buici.com>
References: <cda58cb8050926114675524d59@mail.gmail.com> <20050926191921.GA25724@buici.com> <cda58cb805092612573bedb88d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb805092612573bedb88d@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 09:57:10PM +0200, Franck wrote:
> 2005/9/26, Marc Singer <elf@buici.com>:
> > On Mon, Sep 26, 2005 at 08:46:34PM +0200, Franck wrote:
> > > Hi,
> > >
> > > I'd like to use discontigmem to access several RAM memories on an _no_
> > > NUMA embedded system. In that case, does a node  mean a single RAM
> > > whose start address is very different from the others ?
> >
> > I don't know what you mean by this.  The difference between
> > discontiguous memory and non-discontiguous [sic] memory is that, well,
> > the latter is contiguous.  If you have 64MiB of RAM, it is addressed
> > starting at a base address and all 64 MiB's of addresses following it
> > are valid.
> >
> > Discontiguous memory means that that isn't true, there is more than
> > one start address with gaps of addresses between them which are either
> > invalid, or which are aliases of other addresses.
> >
> 
> yeah, I know what is discontiguous memory. What I'm trying to ask is:
> in this case (discontiguous memory), the kernel seems to describe each
> memory with a single node (cf alloc_page_node for instance). Unlike
> for NUMA system where several memories can belong to the same node. Is
> that correct ?

I don't know what you mean by a 'memory'.  Are you talking about an
IC?  If so, Linux doesn't care about the physical expression of memory
hardware.  It only cares about the addresses of the RAM and, possibly,
performance characteristics of that access.  I write possibly because
I've not worked with that attribute of discontigmem.

There is a potential misunderstanding in how discontigmem really
works.  There may be a memory system which is truly discontiguous, but
that uses a single node.  It is wasteful because the node tables are
accessed as arrays, so non-existent pages require data structure space
just as existent ones do.

With discontigmem, we can use multiple nodes in order to cluster pages
and eliminate unused array entries.  Assuming that this is *not* done
for the sake of differing memory access times, the advantage is in
saving node table space.  There are macros in the architecture/machine
specific include files that create the mapping between physical
addresses and nodes/pages.  At least, that's how ARM does it.

> If so, how does the kernel select a node when allocating a page for a UMA ?

Perhaps someone else can fill in that part.  I've been assuming that
pages with equivalent access times are put in zones, on free-page
lists and allocated as needed.  Nothing special is done with respect
to the different discontigmem nodes.

Cheers.
