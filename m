Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154789AbQDKS3r>; Tue, 11 Apr 2000 14:29:47 -0400
Received: by vger.rutgers.edu id <S154833AbQDKSYO>; Tue, 11 Apr 2000 14:24:14 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30467 "EHLO pneumatic-tube.sgi.com") by vger.rutgers.edu with ESMTP id <S154776AbQDKSOk>; Tue, 11 Apr 2000 14:14:40 -0400
From: kanoj@google.engr.sgi.com (Kanoj Sarcar)
Message-Id: <200004111814.LAA74654@google.engr.sgi.com>
Subject: Re: zap_page_range(): TLB flush race
To: manfreds@colorfullife.com (Manfred Spraul)
Date: Tue, 11 Apr 2000 11:14:11 -0700 (PDT)
Cc: andrea@suse.de (Andrea Arcangeli), sct@redhat.com (Stephen C. Tweedie), davem@redhat.com (David S. Miller), alan@lxorguk.ukuu.org.uk, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
In-Reply-To: <38F364B3.5A4A45D9@colorfullife.com> from "Manfred Spraul" at Apr 11, 2000 07:45:23 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> 
> Yes. 
> Can we ignore the munmap+access case?
> I'd say that if 2 threads race with munmap+access, then the behaviour is
> undefined.
> Tlb flushes are expensive, I'd like to avoid the second tlb flush as in
> Kanoj's patch.
> 

To handle clones on SMP systems properly, you have to stop at least other
threads from writing to the page during unmap time, and possibly loading
the old translation during translation-changing time. Probably the only
generic way to do this is to twiddle the ptes and flush the tlb's, unless
you start making big chunks of code architecture dependent. Note that in
my patch, in most cases, the tlb flush position has changed, not the 
number of flushes ....

Kanoj

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
