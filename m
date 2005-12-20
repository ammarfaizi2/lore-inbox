Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVLTTUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVLTTUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 14:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVLTTUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 14:20:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26378 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750829AbVLTTUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 14:20:44 -0500
Date: Tue, 20 Dec 2005 19:20:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051220192018.GB24199@flint.arm.linux.org.uk>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
	David Woodhouse <dwmw2@infradead.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
References: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au> <Pine.LNX.4.64.0512200927450.26663@localhost.localdomain> <43A81DD4.30906@yahoo.com.au> <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512201049310.26663@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 11:35:22AM -0500, Nicolas Pitre wrote:
> So 14 instructions total with preemption disabling, and that's with the 
> best implementation possible by open coding everything instead of 
> relying on generic functions/macros.

I agree with your analysis Nicolas.

However, don't forget to compare this with our existing semaphore
implementation which is 9 instructions, or 8 for the SMP version.

In total, this means that mutexes will be _FAR MORE EXPENSIVE_ on ARM
than our semaphores.

Forcing architectures down the "lets make everything generic" path
does not always hack it.  It can't do by its very nature.  Generic
implementations are *always* sub-optimal and it is pretty clear
that any gain that mutexes _may_ give is completely wasted on ARM
by the overhead of having a generic framework imposed upon us.

So, to sum up, if this path is persued, mutexes will be a bloody
disaster on ARM.  We'd be far better off sticking to semaphores
and ignoring this mutex stuff.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
