Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRBOTU0>; Thu, 15 Feb 2001 14:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRBOTUQ>; Thu, 15 Feb 2001 14:20:16 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:15898 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129884AbRBOTT6>; Thu, 15 Feb 2001 14:19:58 -0500
From: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Message-Id: <200102151919.LAA74131@google.engr.sgi.com>
Subject: Re: x86 ptep_get_and_clear question
To: bcrl@redhat.com (Ben LaHaise)
Date: Thu, 15 Feb 2001 11:19:52 -0800 (PST)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier), linux-mm@kvack.org,
        mingo@redhat.com, alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0102151402460.15843-100000@today.toronto.redhat.com> from "Ben LaHaise" at Feb 15, 2001 02:06:30 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Thu, 15 Feb 2001, Kanoj Sarcar wrote:
> 
> > No. All architectures do not have this problem. For example, if the
> > Linux "dirty" (not the pte dirty) bit is managed by software, a fault
> > will actually be taken when processor 2 tries to do the write. The fault
> > is solely to make sure that the Linux "dirty" bit can be tracked. As long
> > as the fault handler grabs the right locks before updating the Linux "dirty"
> > bit, things should be okay. This is the case with mips, for example.
> >
> > The problem with x86 is that we depend on automatic x86 dirty bit
> > update to manage the Linux "dirty" bit (they are the same!). So appropriate
> > locks are not grabbed.
> 
> Will you please go off and prove that this "problem" exists on some x86
> processor before continuing this rant?  None of the PII, PIII, Athlon,

And will you please stop behaving like this is not an issue? 

> K6-2 or 486s I checked exhibited the worrisome behaviour you're

And I maintain that this kind of race condition can not be tickled
deterministically. There might be some piece of logic (or absence of it),
that can show that your finding of a thousand runs is not relevant.

> speculating about, plus it is logically consistent with the statements the
> manual does make about updating ptes; otherwise how could an smp os

Don't say this anymore, specially if you can not point me to the specs.

> perform a reliable shootdown by doing an atomic bit clear on the present
> bit of a pte?

OS clears present bit, processors can keep using their TLBs and access 
the page, no problems at all. That is why after clearing the present bit, 
the processor must flush all tlbs before it can assume no one is using
the page. Hardware updated access bit could also be a problem, but an
error there does not destroy data, it just leads the os to choosing the
wrong page to evict during memory pressure.

Kanoj

> 
> 		-ben
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux.eu.org/Linux-MM/
> 

