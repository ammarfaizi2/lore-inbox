Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWCHTnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWCHTnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWCHTnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:43:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:63172 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932169AbWCHTnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:43:51 -0500
Date: Wed, 8 Mar 2006 17:18:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
Message-ID: <20060308161829.GC3669@elf.ucw.cz>
References: <31492.1141753245@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +There are some more advanced barriering functions:
> +
> + (*) set_mb(var, value)
> + (*) set_wmb(var, value)
> +
> +     These assign the value to the variable and then insert at least a write
> +     barrier after it, depending on the function.
> +

I... don't understand what these do. Better explanation would
help.. .what is function?

Does it try to say that set_mb(var, value) is equivalent to var =
value; mb(); but here mb() affects that one variable, only?


> +In all cases there are variants on a LOCK operation and an UNLOCK operation.
> +
> + (*) LOCK operation implication:
> +
> +     Memory accesses issued after the LOCK will be completed after the LOCK
> +     accesses have completed.

"LOCK access"? Does it try to say that ...will be completed after any
access inside lock region is completed?

("LOCK" looks very much like well-known i386 prefix. Calling it
*_lock() or something would avoid that confusion. Fortunately there's
no UNLOCK instruction :-)

> + (*) UNLOCK operation implication:
> +
> +     Memory accesses issued before the UNLOCK will be completed before the
> +     UNLOCK accesses have completed.
> +
> +     Memory accesses issued after the UNLOCK may be completed before the UNLOCK
> +     accesses have completed.
> +
> + (*) LOCK vs UNLOCK implication:
> +
> +     The LOCK accesses will be completed before the unlock accesses.
                                                       ~~~~~~
							 capital? Or
						lower it everywhere?


> +==============================
> +I386 AND X86_64 SPECIFIC NOTES
> +==============================
> +
> +Earlier i386 CPUs (pre-Pentium-III) are fully ordered - the operations on the
> +bus appear in program order - and so there's no requirement for any sort of
> +explicit memory barriers.
> +
> +From the Pentium-III onwards were three new memory barrier instructions:
> +LFENCE, SFENCE and MFENCE which correspond to the kernel memory barrier
> +functions rmb(), wmb() and mb(). However, there are additional implicit memory
> +barriers in the CPU implementation:
> +
> + (*) Normal writes imply a semi-rmb(): reads before a write may not complete
> +     after that write, but reads after a write may complete before the write
> +     (ie: reads may go _ahead_ of writes).

This makes it sound like pentium-III+ is incompatible with previous
CPUs. Is it really the case?
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
