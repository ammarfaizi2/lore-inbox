Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUDPCgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 22:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUDPCgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 22:36:45 -0400
Received: from ozlabs.org ([203.10.76.45]:18069 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261947AbUDPCgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 22:36:41 -0400
Date: Fri, 16 Apr 2004 11:40:45 +1000
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [3/3]
Message-ID: <20040416014045.GE12735@zax>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, 'Andrew Morton' <akpm@osdl.org>
References: <20040415072535.GF25560@zax> <200404151716.i3FHGjF08464@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404151716.i3FHGjF08464@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 10:16:45AM -0700, Chen, Kenneth W wrote:
> >>>>> David Gibson wrote on Thursday, April 15, 2004 12:26 AM
> >
> > > @@ -175,7 +132,6 @@ struct page *follow_huge_addr(struct mm_
> > >  		return NULL;
> > >  	page = pte_page(*ptep);
> > >  	page += ((addr & ~HPAGE_MASK) >> PAGE_SHIFT);
> > > -	get_page(page);
> > >  	return page;
> > >  }
> >
> > As far as I can tell, the removal of these get_page()s is also
> > unrelated to the demand paging per se.  But afaict removing them is
> > correct - the corresponding logic in follow_page() for normal pages
> > doesn't appear to do a get_page(), nor do all archs do a get_page().
> >
> > Does that sound right to you?
> 
> It's a bug in the code that was never exercised with prefaulting.  See
> get_user_pages() that short circuits the rest of faulting code with
> is_vm_hugetlb_page() test.

Erm.. it's not clear to me that it could never be exercise:
get_user_pages() is not the only caller of follow_page().

> > If so, the patch below ought to be safe (and indeed a bugfix) to
> > apply now:
> 
> Yep, that's correct, I already did x86 and ia64 in one of the three
> patches posted. ;-)

Yes, I know, but I'm trying to separate which parts of your patches
are fixes/cleanups for pre-existing problems, and which are genuinely
new for demand paging.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
