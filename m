Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129357AbRBOTN0>; Thu, 15 Feb 2001 14:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129881AbRBOTNQ>; Thu, 15 Feb 2001 14:13:16 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14671 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129793AbRBOTNH>; Thu, 15 Feb 2001 14:13:07 -0500
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200102151905.LAA62688@google.engr.sgi.com>
Subject: Re: x86 ptep_get_and_clear question
To: manfred@colorfullife.com (Manfred Spraul)
Date: Thu, 15 Feb 2001 11:05:00 -0800 (PST)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier), bcrl@redhat.com (Ben LaHaise),
        linux-mm@kvack.org, mingo@redhat.com, alan@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A8C254F.17334682@colorfullife.com> from "Manfred Spraul" at Feb 15, 2001 07:51:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Kanoj Sarcar wrote:
> > 
> > Okay, I will quote from Intel Architecture Software Developer's Manual
> > Volume 3: System Programming Guide (1997 print), section 3.7, page 3-27:
> > 
> > "Bus cycles to the page directory and page tables in memory are performed
> > only when the TLBs do not contain the translation information for a
> > requested page."
> > 
> > And on the same page:
> > 
> > "Whenever a page directory or page table entry is changed (including when
> > the present flag is set to zero), the operating system must immediately
> > invalidate the corresponding entry in the TLB so that it can be updated
> > the next time the entry is referenced."
> >
> 
> But there is another paragraph that mentions that an OS may use lazy tlb
> shootdowns.
> [search for shootdown]
> 
> You check the far too obvious chapters, remember that Intel wrote the
> documentation ;-)

:-) :-)

The good part is, there are a lot of Intel folks now active on Linux,
I can go off and ask one of them, if we are sufficiently confused. I
am trying to see whether we are.

> I searched for 'dirty' though Vol 3 and found
> 
> Chapter 7.1.2.1 Automatic locking.
> 
> .. the processor uses locked cycles to set the accessed and dirty flag
> in the page-directory and page-table entries.
> 
> But that obviously doesn't answer your question.
> 
> Is the sequence
> << lock;
> read pte
> pte |= dirty
> write pte
> >> end lock;
> or
> << lock;
> read pte
> if (!present(pte))
> 	do_page_fault();
> pte |= dirty
> write pte.
> >> end lock;

No, it is a little more complicated. You also have to include in the
tlb state into this algorithm. Since that is what we are talking about.
Specifically, what does the processor do when it has a tlb entry allowing
RW, the processor has only done reads using the translation, and the 
in-memory pte is clear?

Kanoj

> 
> --
> 	Manfred
> 

