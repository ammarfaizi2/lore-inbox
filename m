Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274468AbRJFCYG>; Fri, 5 Oct 2001 22:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274875AbRJFCX4>; Fri, 5 Oct 2001 22:23:56 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:44548 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S274468AbRJFCXr>;
	Fri, 5 Oct 2001 22:23:47 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200110060224.f962O53104349@saturn.cs.uml.edu>
Subject: Re: Context switch times
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 5 Oct 2001 22:24:05 -0400 (EDT)
Cc: bcrl@redhat.com (Benjamin LaHaise),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <E15pWfR-0006g5-00@the-village.bc.nu> from "Alan Cox" at Oct 05, 2001 04:13:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [somebody]

>> I don't quite agree with you that it doesn't matter.  A lot of tests
>> (volanomark, other silly things) show that the current scheduler jumps
>> processes from CPU to CPU on SMP boxes far too easily

Be careful that your viewer doesn't disturb the system.
Please don't even consider using "top" for this.

> #4	On x86 we are horribly cache pessimal. All the task structs are
> 	on the same cache colour. Multiple tasks waiting for the same event
> 	put their variables (like the wait queue) on the same cache line.

If cache problems are bad enough, maybe this pays for itself:

/* old */
current = stack_ptr & ~0x1fff;

/* new */
hash = (stack_ptr>>8)^(stack_ptr>>12)^(stack_ptr>>16)^(stack_ptr>>20);
current = (stack_ptr & ~0x1fff) | (hash & 0x1e0);

> The classic example is two steady cpu loads and an occasionally waking
> client (like an editor)

Like "top"!
