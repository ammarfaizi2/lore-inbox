Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154322AbQDHX3s>; Sat, 8 Apr 2000 19:29:48 -0400
Received: by vger.rutgers.edu id <S154363AbQDHX32>; Sat, 8 Apr 2000 19:29:28 -0400
Received: from lightning.swansea.uk.linux.org ([194.168.151.1]:4225 "EHLO the-village.bc.nu") by vger.rutgers.edu with ESMTP id <S154600AbQDHX3Q>; Sat, 8 Apr 2000 19:29:16 -0400
Subject: Re: zap_page_range(): TLB flush race
To: kanoj@google.engr.sgi.com (Kanoj Sarcar)
Date: Sun, 9 Apr 2000 00:37:05 +0100 (BST)
Cc: manfreds@colorfullife.com (Manfred Spraul), linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com, davem@redhat.com, alan@lxorguk.ukuu.org.uk
In-Reply-To: <200004082331.QAA78522@google.engr.sgi.com> from "Kanoj Sarcar" at Apr 08, 2000 04:31:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E12e4mo-0003Pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

> > Yes, establish_pte() is broken. We should reverse the calls:
> > 
> > 	set_pte(); /* update the kernel page tables */
> > 	update_mmu(); /* update architecture specific page tables. */
> > 	flush_tlb();  /* and flush the hardware tlb */
> >
> 
> People are aware of this too, it was introduced during the 390 merge. 
> I tried talking to the IBM guy about this, I didn't see a response from
> him ...

Strange since I did and it included you

> I think what we now need is a critical mass, something that will make us
> go "okay, lets just fix these races once and for all".

Basically establish_pte() has to be architecture specific, as some processors
need different orders either to avoid races or to handle cpu specific
limitations.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
