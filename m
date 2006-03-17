Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752502AbWCQCNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbWCQCNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbWCQCNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:13:25 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:48576 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751419AbWCQCNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:13:24 -0500
Date: Thu, 16 Mar 2006 20:13:04 -0600
From: Robin Holt <holt@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       cotte@de.ibm.com, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
Message-ID: <20060317021304.GA11166@lnx-holt.americas.sgi.com>
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <20060316163728.06f49c00.akpm@osdl.org> <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 05:04:14PM -0800, Linus Torvalds wrote:
> 
> 
> On Thu, 16 Mar 2006, Andrew Morton wrote:
> > 
> > hm.  Is that a superset of ->nopage?  Should we be looking at
> > migrating over to ->nopfn, retire ->nopage?
> > 
> > <looks at the ghastly stuff in do_no_page>
> > 
> > Maybe not...
> 
> Yeah, absolutely _not_.
> 
> If we wouldn't pass the "struct page" around, we wouldn't have anything to 
> synchronize with, and each nopage() function would have to do rmap stuff.
> 
> That's actually how nopage() worked a long time ago (not rmap, but it was 
> up the the low-level function to do all the page table logic etc). 
> Switching to returning a structured return value and letting the generic 
> VM code handle all the locking and the races was a _huge_ improvement.
> 
> So yes, the modern "->nopage()" interface is less flexible, but it's less 
> flexible for a very good reason. 
> 
> Quite frankly, I don't think nopfn() is a good interface. It's only usable 
> for one single thing, so trying to claim that it's a generic VM op is 
> really not valid. If (and that's a big if) we need this interface, we 
> should just do it inside mm/memory.c instead of playing games as if it was 
> generic.

My understanding was Carsten Otte was also interested in a do_no_pfn() for
execute-in-place.

Casten, is that still your intention?

Thanks,
Robin
