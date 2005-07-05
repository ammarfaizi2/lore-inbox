Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVGEP4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVGEP4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVGEP4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:56:49 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:45013
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S261881AbVGEPjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:39:20 -0400
Date: Tue, 5 Jul 2005 11:37:08 -0400
From: Sonny Rao <sonny@burdell.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Lameter'" <christoph@lameter.com>,
       "'Badari Pulavarty'" <pbadari@us.ibm.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>, Lincoln Dale <ltd@cisco.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [rfc] lockless pagecache
Message-ID: <20050705153708.GA13178@kevlar.burdell.org>
References: <Pine.LNX.4.62.0506271221540.21616@graphe.net> <200506271942.j5RJgig23410@unix-os.sc.intel.com> <20050705151119.GA12279@kevlar.burdell.org> <54750000.1120577500@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54750000.1120577500@[10.10.2.4]>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 08:31:40AM -0700, Martin J. Bligh wrote:
> >> > On Mon, 27 Jun 2005, Chen, Kenneth W wrote:
> >> > > I don't recall seeing tree_lock to be a problem for DSS workload either.
> >> > 
> >> > I have seen the tree_lock being a problem a number of times with large 
> >> > scale NUMA type workloads.
> >> 
> >> I totally agree!  My earlier posts are strictly referring to industry
> >> standard db workloads (OLTP, DSS).  I'm not saying it's not a problem
> >> for everyone :-)  Obviously you just outlined a few ....
> > 
> > I'm a bit late to the party here (was gone on vacation), but I do have
> > profiles from DSS workloads using page-cache rather than O_DIRECT and
> > I do see spin_lock_irq() in the profiles which I'm pretty certain are
> > locks spinning for access to the radix_tree.  I'll talk about it a bit
> > more up in Ottawa but here's the top 5 on my profile (sorry don't have
> > the number of ticks at the momement):
> > 
> > 1. dedicated_idle (waiting for I/O)
> > 2. __copy_tofrom_user
> > 3. radix_tree_delete
> > 4. _spin_lock_irq
> > 5. __find_get_block
> > 
> > So, yes, if the page-cache is used in a DSS workload then one will see
> > the tree-lock.  BTW, this was on a PPC64 machine w/ a fairly small
> > NUMA factor.
> 
> The easiest way to confirm the spin-lock thing is to recompile with 
> CONFIG_SPINLINE, and take a new profile, then diff the two ...

Yep...

Unfortunately, this is broken in PPC64 since 2.6.9-rc2 or something
like that, I never had a chance to track down what the issue was
exactly.  IIRC, there was a lot of churn in the spinlocking code
around that time.

Sonny
