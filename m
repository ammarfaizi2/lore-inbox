Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVIQKBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVIQKBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIQKBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:01:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59789 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751020AbVIQKBW (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:01:22 -0400
Date: Sat, 17 Sep 2005 12:01:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: nickpiggin@yahoo.com.au, rmk+lkml@arm.linux.org.uk,
       Linux-Kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
In-Reply-To: <20050916233628.0fd948f0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509171150350.3743@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
 <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au>
 <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk>
 <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk>
 <4328D39C.2040500@yahoo.com.au> <Pine.LNX.4.61.0509170300030.3743@scrub.home>
 <20050916233628.0fd948f0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 16 Sep 2005, Andrew Morton wrote:

> Nope.  On uniprocessor systems, atomic_foo() doesn't actually do the
> buslocked atomic thing.
> 
> #ifdef CONFIG_SMP
> #define LOCK "lock ; "
> #else
> #define LOCK ""
> #endif
> 
> On x86, at least.  Other architectures can do the same thing if they have
> an atomic-wrt-IRQs add and sub.

That's true on x86, but if these functions have to be emulated using 
spinlocks, they always have to disable interrupts, whether the caller 
needs it or not. Also x86 has the lock attribute, which helps a lot, but 
on other archs a cmpxchg instruction can be quite expensive, so it could 
be cheaper by just using {disable,enable}_preempt.

bye, Roman
