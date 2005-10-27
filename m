Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbVJ0ASc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVJ0ASc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 20:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVJ0ASb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 20:18:31 -0400
Received: from fmr23.intel.com ([143.183.121.15]:35985 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751523AbVJ0ASb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 20:18:31 -0400
Message-Id: <200510270016.j9R0Gdg26347@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: "Adam Litke" <agl@us.ibm.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>, <hugh@veritas.com>,
       "William Irwin" <wli@holomorphy.com>
Subject: RE: RFC: Cleanup / small fixes to hugetlb fault handling
Date: Wed, 26 Oct 2005 17:16:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXaivgVzxa+vJM0S/mWNH6Evo/HbwAAGhZg
In-Reply-To: <20051027000504.GC14742@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Wednesday, October 26, 2005 5:05 PM
> On Wed, Oct 26, 2005 at 11:44:52AM -0700, Chen, Kenneth W wrote:
> > David Gibson wrote on Tuesday, October 25, 2005 7:49 PM
> > > +int hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> > > +		  unsigned long address, int write_access)
> > > +{
> > > +	pte_t *ptep;
> > > +	pte_t entry;
> > > +
> > > +	ptep = huge_pte_alloc(mm, address);
> > > +	if (! ptep)
> > > +		/* OOM */
> > > +		return VM_FAULT_SIGBUS;
> > > +
> > > +	entry = *ptep;
> > > +
> > > +	if (pte_none(entry))
> > > +		return hugetlb_no_page(mm, vma, address, ptep);
> > > +
> > > +	/* we could get here if another thread instantiated the pte
> > > +	 * before the test above */
> > > +
> > > +	return VM_FAULT_SIGBUS;
> > >  }
> > 
> > Are you sure about the last return?  Looks like a typo to me, if *ptep
> > is present, it should return VM_FAULT_MINOR.
> 
> Oops, yes, thinko.  Corrected patch shortly.

While you at it, I think it would be preferable that the first return be
VM_FAULT_OOM, your thoughts?

- Ken

