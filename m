Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265395AbSJaWEy>; Thu, 31 Oct 2002 17:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265388AbSJaWE1>; Thu, 31 Oct 2002 17:04:27 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:29382 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265395AbSJaWC5>;
	Thu, 31 Oct 2002 17:02:57 -0500
Subject: Re: [PATCH] (3/3) stack overflow checking for x86
From: "David C. Hansen" <haveblue@us.ibm.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.COM>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031213032.GA25685@suse.de>
References: <1036091906.4272.87.camel@nighthawk>
	<1036092052.4272.96.camel@nighthawk>  <20021031213032.GA25685@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 14:08:34 -0800
Message-Id: <1036102114.4155.272.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 13:30, Dave Jones wrote:
> On Thu, Oct 31, 2002 at 11:20:52AM -0800, David C. Hansen wrote:
>  > * stack checking (3/3)
>  >    - use gcc's profiling features to check for stack overflows upon
>  >      entry to functions.
>  >    - Warn if the task goes over 4k.
>  >    - Panic if the stack gets within 512 bytes of overflowing.
>  >    - use kksymoops information, if available
>  > 
>  > This won't apply cleanly without the irqstack patch, but the conflict is
>  > easy to resolve.  It requires the thread_info cleanup.
> 
> I'm wondering about interaction between this patch and the
> already merged CONFIG_DEBUG_STACKOVERFLOW ?

The currently merged one is very, very simple, but relatively worthless.
There are no guarantees about catching an overflow, especially if it
happens in a long call chain _after_ do_IRQ with interrupts disabled.  
Ben's version checks on entrance to every function, making it _much_
more likely to be caught, even during an interrupt.  But, the currently
merged one doesn't have any strange compiler requirements, like adding
the -p option.

The irq stack patch would make the current check pretty worthless
because the check happens just after the switch to a fresh irqstack
would have happened.

But, if they both get in, it can be cleaned up later because even if
both are turned on, nothing will blow up.  
-- 
Dave Hansen
haveblue@us.ibm.com

