Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269067AbRHLK4h>; Sun, 12 Aug 2001 06:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269076AbRHLK41>; Sun, 12 Aug 2001 06:56:27 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:11858 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S269067AbRHLK4U>; Sun, 12 Aug 2001 06:56:20 -0400
Date: Sun, 12 Aug 2001 11:44:16 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: linux-kernel@vger.kernel.org
Subject: Re: alloc_area_pte: page already exists
In-Reply-To: <Pine.LNX.3.96.1010809234824.9949A-100000@medusa.sparta.lu.se>
Message-ID: <Pine.LNX.3.96.1010812113845.1163A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Bjorn Wesen wrote:
> > vfree as usual walks the pgd/pmd to reach the pte. It knows the
> > pgd/pmd/pte cannot go away and it serlializes against vmalloc with the
> > vmlist_lock, it sounds ok.
> 
> So what happens when the kernel accesses the non-existant pte's or when
> the vmalloc space runs out ?

Just for the record, let me answer myself:

When the delayed vmalloc pagetable copying activates during such a
pagefault, the individual PTE's are not copied, but just the pointer to
the PTE container page is inserted into the pgd (or pmd, for 3-level). 

So any pointers from the pgd in non-init processes are simply to the
corresponding pmd and pte container in the init_mm, thus vfree can
remove the PTE's, flush the tlb and bob's your uncle. Too bad there are
not any comments at all in the code to mention design issues like this.

Back to another theory on why my vmalloc pgtables screw up :)

/Bjorn


