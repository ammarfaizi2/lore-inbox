Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUDPDEc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 23:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDPDEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 23:04:32 -0400
Received: from fmr03.intel.com ([143.183.121.5]:29578 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261603AbUDPDE2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 23:04:28 -0400
Message-Id: <200404160301.i3G31tF13237@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [0/3]
Date: Thu, 15 Apr 2004 20:01:55 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQjW6s78FC/52c1RWOi/7c+GKqpLgAAx8DQ
In-Reply-To: <20040416013033.GC12735@zax>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, April 15, 2004 6:31 PM
> On Thu, Apr 15, 2004 at 10:08:22AM -0700, Chen, Kenneth W wrote:
> > >>>> David Gibson wrote on Wednesday, April 14, 2004 11:43 PM
> > > >
> > > > Some caveats:  I don't have sh and sparc64 hardware to test.  But hugetlb
> > > > code in these two arch looked like a triplet twin of x86 code.  So I'm
> > > > pretty sure it will work right out of box.  I've monkeyed around with
> > > > ppc64 code and after a while I realized it should be left for the experts.
> > > > I'm sure there are plenty ppc64 developers out there that can get it done
> > > > in no time.
> > >
> > > To the extent that I understand your patches, it shouldn't be that
> > > hard to adapt for ppc64, with one caveat: on ppc64, unlike the other
> > > hugepage archs, the format of hugepage PTEs is not identical to the
> > > format of normal PTEs.  So to do this for ppc64, the generic parts of
> > > your code will need to use a hugepte_t instead of pte_t - it can be
> > > typedeffed to pte_t on archs other than ppc64.  Likewise there will
> > > need to be hugepte_none() and so forth macros.
> >
> > I think it would be cleaner if ppc64 change its format instead of changing
> > 4 other arch to accommodate ppc64.  By the way, why do you need to special
> > typedef hugepte_t? pte for huge page aren't anything special on all other
> > arches.
>
> The hugepte entries go in the same slots as pmd entries, which means
> they must be compatible with the layout of pmd entries.  That's not
> compatible with making them identical to normal PTE entries.  For one
> thing, normal PTE entries are 64 bits wide, whereas PMD entries are
> only 32 bits wide.


It smells like handle_hugetlb_mm_fault() need to be replicated in each arch
(or at least replicated in ppc64).

- Ken


