Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSHJUEJ>; Sat, 10 Aug 2002 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSHJUEJ>; Sat, 10 Aug 2002 16:04:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17003 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317305AbSHJUEI>; Sat, 10 Aug 2002 16:04:08 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>, <frankeh@watson.ibm.com>,
       <davidm@hpl.hp.com>, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
References: <Pine.LNX.4.44L.0208101654270.23404-100000@imladris.surriel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2002 13:54:47 -0600
In-Reply-To: <Pine.LNX.4.44L.0208101654270.23404-100000@imladris.surriel.com>
Message-ID: <m1k7myqyk8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 10 Aug 2002, Eric W. Biederman wrote:
> > Andrew Morton <akpm@zip.com.au> writes:
> > >
> > > The other worry is the ZONE_NORMAL space consumption of pte_chains.
> > > We've halved that, but it will still make high sharing levels
> > > unfeasible on the big ia32 machines.
> 
> > There is a second method to address this.  Pages can be swapped out
> > of the page tables and still remain in the page cache, the virtual
> > scan does this all of the time.  This should allow for arbitrary
> > amounts of sharing.  There is some overhead, in faulting the pages
> > back in but it is much better than cases that do not work.  A simple
> > implementation would have a maximum pte_chain length.
> 
> Indeed.  We need this same thing for page tables too, otherwise
> a high sharing situation can easily "require" more page table
> memory than the total amount of physical memory in the system ;)

It's exactly the same situation.  To remove a pte from the chain you must
remove it from the page table as well.  Then we just need to free
pages with no interesting pte entries.
Eric
