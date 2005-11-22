Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVKVJbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKVJbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 04:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKVJbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 04:31:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:23452 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750785AbVKVJbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 04:31:47 -0500
Date: Tue, 22 Nov 2005 15:07:54 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: david singleton <dsingleton@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, "David F.Carlson" <dave@chronolytics.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051122093754.GA4824@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com> <20051118132715.GA3314@elte.hu> <8311ADE9-5855-11DA-BBAB-000A959BB91E@mvista.com> <20051118174454.GA2793@elte.hu> <43822480.6080301@mvista.com> <20051121212653.GA6143@elte.hu> <8D664A17-5B07-11DA-A840-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8D664A17-5B07-11DA-A840-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 07:24:55PM -0800, david singleton wrote:
> 
> 
> Dinakar,
> 	can you try the attached patch?  I believe it has the fix you 
> 	require. It has the
> correct locking fix I just sent, the patch-2.6.4-rt13-rf2, and has the 
> correct
> lock order in the exit path that was causing the circular deadlock in 
> Dave Carlson's
> application.

David,

This fixes the problem that I was noticing !!
Thank you and Ingo for fixing this

	-Dinakar

> 
> On Nov 21, 2005, at 1:26 PM, Ingo Molnar wrote:
> >* David Singleton <dsingleton@mvista.com> wrote:
> >
> >>Ingo,
> >>   here is a patch that provides the correct locking for the rt_mutex
> >>backing the robust pthread_mutex.   The patch also unifies the locking
> >>for all the robust functions and adds support for pthread_mutexes on
> >>the heap.
> >
> >thanks. Could you split up the patch into a fix and a 'heap' patch (at 
> >a
> >minimum)?
> >
> >it's this portion of the 'heap' patch that looks problematic:
> >
> >>--- base/linux-2.6.14/include/linux/mm.h	2005-11-18 
> >>20:36:53.000000000 -0800
> >>+++ wip/linux-2.6.14/include/linux/mm.h	2005-11-21 
> >>10:51:19.000000000 -0800
> >>@@ -109,6 +109,11 @@
> >> #ifdef CONFIG_NUMA
> >> 	struct mempolicy *vm_policy;	/* NUeMA policy for the VMA */
> >> #endif
> >>+#ifdef CONFIG_FUTEX
> >>+	int robust_init;		/* robust initialized? */
> >>+	struct list_head robust_list;	/* list of robust futexes in this 
> >>vma */
> >>+	struct semaphore robust_sem;	/* semaphore to protect the list */
> >>+#endif
> >> };
> >
> >why is there per-vma info needed?
> >
> >Also, what testing did this patch have - should it solve Dinakar's
> >problem(s)?
> >
> >	Ingo

