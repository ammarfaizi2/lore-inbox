Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290200AbSALBKX>; Fri, 11 Jan 2002 20:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290201AbSALBKN>; Fri, 11 Jan 2002 20:10:13 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22537 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290200AbSALBKH>; Fri, 11 Jan 2002 20:10:07 -0500
Message-ID: <3C3F8BA5.8B793441@zip.com.au>
Date: Fri, 11 Jan 2002 17:04:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel>,
		Andrew Morton's message of "11 Jan 2002 21:59:44 +0100" <p73r8ow4dd7.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> Andrew Morton <akpm@zip.com.au> writes:
> 
> > So in this case, the behaviour I would prefer is MCL_FUTURE for
> > all vma's *except* the stack.   Stack pages should be locked
> > only when they are faulted in.   Hard call.
> 
> There is just one problem: linuxthread stacks are just ordinary mappings
> and they are in no way special to the kernel; they aren't VM_GROWSDOWN.
> You would need to add a way to the kernel first to tag the linux thread
> stacks in a way that is recognizable to mlockall and then do that
> from linuxthreads.
> 
> I think for the normal stack - real VM_GROWSDOWN segments - mlockall
> already does the right thing.

hmm.. So I wonder what changed between 2.4.7 and 2.4.15 which unbroke
MCL_FUTURE.

I suspect we can fix the problem by running mlockall(MCL_FUTURE)
and then an explicit munlock() of the stack area.

-
