Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319256AbSH2RLg>; Thu, 29 Aug 2002 13:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319257AbSH2RLf>; Thu, 29 Aug 2002 13:11:35 -0400
Received: from tolkor.SGI.COM ([192.48.180.13]:24984 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S319256AbSH2RLf>;
	Thu, 29 Aug 2002 13:11:35 -0400
From: Dean Nelson <dcn@sgi.com>
Message-Id: <200208291715.MAA75017@cyan.americas.sgi.com>
Subject: Re: atomic64_t proposal
To: ak@suse.de (Andi Kleen)
Date: Thu, 29 Aug 2002 12:15:47 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p73sn102hvu.fsf@oldwotan.suse.de> from "Andi Kleen" at Aug 27, 2002 09:58:45 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
> 
> Dean Nelson <dcn@sgi.com> writes:
> 
> > I'm proposing the creation of an atomic64_t variable, which is a 64-bit
> > version of atomic_t, and the usage of the __typeof__ keyword in macro versions
> > of the atomic operations to enable them to operate on either type (atomic_t and
> > atomic64_t).
> > 
> > I submitted the following patch to David Mosberger to be considered for
> > inclusion in the IA-64 linux kernel. He suggested that I bring the topic up
> > on this list so that the other 64-bit platform maintainers can commment.
> 
> Wouldn't it be much cleaner to just define atomic64_add/sub/read etc. ?
> That would make the macros much nicer.
> 
> On x86-64 it would be fine this way.
> 
> Is it supposed to only work on 64bit or do you plan to supply it for 32
> bit too? If no, I don't see how drivers etc. should ever use it. linux 
> is supposed to have a common kernel api.
> If yes, the implementation on 32bit could be a problem. e.g. some 
> archs need space in there for spinlocks, so it would be needed to limit
> the usable range.

Your point about a common kernel api (across all architectures) is valid
and leads me to reconsider the use of common macros for the two atomic types.
So I guess I would lean in the direction you suggested of separate macros
(atomic64_add/sub/read etc.) for the atomic64_t type.

But I'm wondering if it would be acceptable to have the atomic64_t implemented
(initially) on only one platform?

My original intent was to get atomic64_t into the IA-64 linux kernel.
Mosberger suggested that the other 64-bit architecture maintainers should
weigh in on this issue and that I send the proposal to lkml.

I have no plans on implementing this for anything but the IA-64 linux kernel.
But its api should be discussed and approved (or disapproved) by this list.
The implementations for the other platforms can come as other people feel
so moved to do them.

Dean
