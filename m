Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290185AbSALAdo>; Fri, 11 Jan 2002 19:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290188AbSALAdf>; Fri, 11 Jan 2002 19:33:35 -0500
Received: from ns.suse.de ([213.95.15.193]:63503 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290185AbSALAd3>;
	Fri, 11 Jan 2002 19:33:29 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Jan 2002 01:33:24 +0100
In-Reply-To: Andrew Morton's message of "11 Jan 2002 21:59:44 +0100"
Message-ID: <p73r8ow4dd7.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> So in this case, the behaviour I would prefer is MCL_FUTURE for
> all vma's *except* the stack.   Stack pages should be locked
> only when they are faulted in.   Hard call.

There is just one problem: linuxthread stacks are just ordinary mappings
and they are in no way special to the kernel; they aren't VM_GROWSDOWN. 
You would need to add a way to the kernel first to tag the linux thread 
stacks in a way that is recognizable to mlockall and then do that 
from linuxthreads. 

I think for the normal stack - real VM_GROWSDOWN segments - mlockall
already does the right thing.

-Andi
