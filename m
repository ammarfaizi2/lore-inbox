Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbUDOStI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDOSqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 14:46:15 -0400
Received: from fmr03.intel.com ([143.183.121.5]:12696 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263117AbUDOSnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 14:43:50 -0400
Message-Id: <200404151842.i3FIguF09326@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <raybry@sgi.com>,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: RE: hugetlb demand paging patch part [0/3]
Date: Thu, 15 Apr 2004 11:42:55 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <7A4826DE8867D411BAB8009027AE9EB91DB42C83@scsmsx401.sc.intel.com>
Thread-Index: AcQi6pjtEdGy/DvtQ9m6bS2olrTMVgAIH/rAAAMKAOA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Chen, Kenneth W wrote on Thursday, April 15, 2004 10:08 AM
> >>>> David Gibson wrote on Wednesday, April 14, 2004 11:43 PM
> > >
> > > Some caveats:  I don't have sh and sparc64 hardware to test.  But hugetlb
> > > code in these two arch looked like a triplet twin of x86 code.  So I'm
> > > pretty sure it will work right out of box.  I've monkeyed around with
> > > ppc64 code and after a while I realized it should be left for the experts.
> > > I'm sure there are plenty ppc64 developers out there that can get it done
> > > in no time.
> >
> > To the extent that I understand your patches, it shouldn't be that
> > hard to adapt for ppc64, with one caveat: on ppc64, unlike the other
> > hugepage archs, the format of hugepage PTEs is not identical to the
> > format of normal PTEs.  So to do this for ppc64, the generic parts of
> > your code will need to use a hugepte_t instead of pte_t - it can be
> > typedeffed to pte_t on archs other than ppc64.  Likewise there will
> > need to be hugepte_none() and so forth macros.
>
> I think it would be cleaner if ppc64 change its format instead of changing
> 4 other arch to accommodate ppc64.  By the way, why do you need to special
> typedef hugepte_t? pte for huge page aren't anything special on all other
> arches.

Again, I'm not an expert on ppc64, but this look suspicious to me:

arch/ppc64/mm/hugetlbpage.c
/* HugePTE layout:
 *
 * 31 30 ... 15 14 13 12 10 9  8  7   6    5    4    3    2    1    0
 * PFN>>12..... -  -  -  -  -  -  HASH_IX....   2ND  HASH RW   -    HG=1
 */

#define HUGEPTE_SHIFT   15

17 bits for pfn?  It looks to me that huge page on ppc64 will break on
system with more than 2 Terabyte of physical memory.


