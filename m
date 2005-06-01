Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVFAUoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVFAUoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 16:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFAUoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 16:44:02 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:17163 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261167AbVFAUNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 16:13:31 -0400
Date: Wed, 1 Jun 2005 13:17:54 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, Thomas Gleixner <tglx@linutronix.de>,
       Karim Yaghmour <karim@opersys.com>, Ingo Molnar <mingo@elte.hu>,
       Paulo Marques <pmarques@grupopie.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <bhuey@lnxw.com>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>, dwalker@mvista.com,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050601201754.GA27795@nietzsche.lynx.com>
References: <20050601192224.GV5413@g5.random> <Pine.OSF.4.05.10506012129460.1707-100000@da410.phys.au.dk> <20050601195905.GX5413@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050601195905.GX5413@g5.random>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2005 at 09:59:05PM +0200, Andrea Arcangeli wrote:
> There's a significant number of local_irq_disable across the kernel, I
> don't see why should we risk a driver update possibly looping a bit too
> logn, to break the RT guarantee. It's not too hard to reach the hundred
> usec range when doing hardware operations in inefficient drivers when
> touchign the mmio/io regions. That would not be a bug in any config but
> preempt-RT. Possibly not nice, but not a bug (keep in mind the usb irq
> in my firewall for whatever reasons keeps irq disabled for >1msec).

Please survey this and see how the patch deals with it. Please also
stop asking FUD enabling questions until you look at the patch.

> Using cli by hand never happens anywhere, while if you grep for
> local_irq_disable that happens in many drivers.

Memory allocators and the like need do to this and this has been dealt
with in the patch. The use of those function isn't SMP safe in drivers,
so any use of those functions and spin-waiting so far has already been
reviewed and dealt with in the patch.

> Using cli in asm is like doing memset() all over the ram... then kernel
> will crash and irq will stop too ;) While local_irq_disable os far was a
> supported API for drivers and generic kernel code (most commmonly used
> before touching per-cpu data structures, so very common in certain part
> of the kernels, including the scheduler).

Some of that stuff has been moved into work queues that are used to
defer processing out-of-line, so that it doesn't effect that path.

Just about all you've been saying has been handled by the patch and I
ask you to stop asking stupid question until you've looked at it..

bill

