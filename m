Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVLARPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVLARPI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVLARPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:15:08 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:38610 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932341AbVLARPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:15:06 -0500
Subject: Re: Better pagecache statistics ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-mm <linux-mm@kvack.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051201170850.GA16235@dmt.cnet>
References: <1133377029.27824.90.camel@localhost.localdomain>
	 <20051201152029.GA14499@dmt.cnet>
	 <1133452790.27824.117.camel@localhost.localdomain>
	 <1133453411.2853.67.camel@laptopd505.fenrus.org>
	 <20051201170850.GA16235@dmt.cnet>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 09:15:15 -0800
Message-Id: <1133457315.21429.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 15:08 -0200, Marcelo Tosatti wrote:
> On Thu, Dec 01, 2005 at 05:10:11PM +0100, Arjan van de Ven wrote:
> > > Out of "Cached" value - to get details like
> > > 
> > > 	<mmap> - xxx KB
> > > 	<shared mem> - xxx KB
> > > 	<text, data, bss, malloc, heap, stacks> - xxx KB
> > > 	<filecache pages total> -- xxx KB
> > > 		(filename1 or <dev>, <ino>) -- #of pages
> > > 		(filename2 or <dev>, <ino>) -- #of pages
> > > 		
> > > This would be really powerful on understanding system better.
> > 
> > to some extend it might be useful.
> > I have a few concerns though
> > 1) If we make these stats into an ABI then it becomes harder to change
> > the architecture of the VM radically since such concepts may not even
> > exist in the new architecture. As long as this is some sort of advisory,
> > humans-only file I think this isn't too much of a big deal though. 
> > 
> > 2) not all the concepts you mention really exist as far as the kernel is
> > concerned. I mean.. a mmap file is file cache is .. etc.
> > malloc/heap/stacks are also not differentiated too much and are mostly
> > userspace policy (especially thread stacks). 
> > 
> > A split in
> > * non-file backed
> >   - mapped once
> >   - mapped more than once
> > * file backed
> >   - mapped at least once
> >   - not mapped
> > I can see as being meaningful. Assigning meaning to it beyond this is
> > dangerous; that is more an interpretation of the policy userspace
> > happens to use for things and I think coding that into the kernel is a
> > mistake.
> > 
> > Knowing which files are in memory how much is, as debug feature,
> > potentially quite useful for VM hackers to see how well the various VM
> > algorithms work. I'm concerned about the performance impact (eg you can
> > do it only once a day or so, not every 10 seconds) and about how to get
> > this data out in a consistent way (after all, spewing this amount of
> > debug info will in itself impact the vm balances)
> 
> Most of the issues you mention are null if you move the stats
> maintenance burden to userspace. 
> 
> The performance impact is also minimized since the hooks 
> (read: overhead) can be loaded on-demand as needed.
> 

The overhead is - going through each mapping/inode in the system
and dumping out "nrpages" - to get per-file statistics. This is
going to be expensive, need locking and there is no single list 
we can traverse to get it. I am not sure how to do this.

Thanks,
Badari 

