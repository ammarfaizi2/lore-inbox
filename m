Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbVADU0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbVADU0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVADUXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:23:50 -0500
Received: from colin2.muc.de ([193.149.48.15]:34821 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262107AbVADUVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:21:05 -0500
Date: 4 Jan 2005 21:21:04 +0100
Date: Tue, 4 Jan 2005 21:21:04 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V14 [5/7]: x86_64 atomic pte operations
Message-ID: <20050104202104.GA28454@muc.de>
References: <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0412011545060.5721@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041129030.805@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0501041137410.805@schroedinger.engr.sgi.com> <m1652ddljp.fsf@muc.de> <Pine.LNX.4.58.0501041154560.1083@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501041154560.1083@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 11:58:13AM -0800, Christoph Lameter wrote:
> On Tue, 4 Jan 2005, Andi Kleen wrote:
> 
> > Christoph Lameter <clameter@sgi.com> writes:
> >
> > I bet this has been never tested.
> 
> I tested this back in October and it worked fine. Would you be able to
> test your proposed modifications and send me a patch?

Hmm, I don't think it could have worked this way, except
if you only tested page faults < 4GB. 

> 
> > > +#define pmd_test_and_populate(mm, pmd, pte) \
> > > +		(cmpxchg((int *)pmd, PMD_NONE, _PAGE_TABLE | __pa(pte)) == PMD_NONE)
> > > +#define pud_test_and_populate(mm, pud, pmd) \
> > > +		(cmpxchg((int *)pgd, PUD_NONE, _PAGE_TABLE | __pa(pmd)) == PUD_NONE)
> > > +#define pgd_test_and_populate(mm, pgd, pud) \
> > > +		(cmpxchg((int *)pgd, PGD_NONE, _PAGE_TABLE | __pa(pud)) == PGD_NONE)
> > > +
> >
> > Shouldn't this all be (long *)pmd ? page table entries on x86-64 are 64bit.
> > Also why do you cast at all? i think the macro should handle an arbitary
> > pointer.
> 
> The macro checks for the size of the pointer and then generates the
> appropriate cmpxchg instruction. pgd_t is a struct which may be
> problematic for the cmpxchg macros.

It just checks sizeof, that should be fine.

-Andi

