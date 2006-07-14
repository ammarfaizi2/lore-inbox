Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWGNDbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWGNDbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 23:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWGNDbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 23:31:09 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:17893 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161219AbWGNDbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 23:31:08 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Steven Rostedt <rostedt@goodmis.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: trajce nedev <trajcenedev@hotmail.com>, torvalds@osdl.org,
       acahalan@gmail.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <200607080847.12566.chase.venters@clientec.com>
References: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
	 <200607080847.12566.chase.venters@clientec.com>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 23:30:03 -0400
Message-Id: <1152847803.1883.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 08:46 -0500, Chase Venters wrote:
> On Saturday 08 July 2006 01:44, trajce nedev wrote:
> > On Sat, 8 Jul 2006, Chase Venters wrote:
> > >Perhaps you should have followed this thread closely before composing your
> > >assault on Linus. We're not talking about "asm volatile". We're talking
> > >about
> > >the "volatile" keyword as applied to variables. 'volatile' as applied to
> > >inline ASM is of course necessary in many cases -- no one is disputing
> > >that.
> >
> > Ok, let's port a spinlock macro that spins instead of context switches
> > instead of using the pthread garbage on IA64 or AMD64:
> >
> > #if ((defined (_M_IA64) || defined (_M_AMD64)) && !defined(NT_INTEREX))
> > #include <windows.h>
> > #pragma intrinsic (_InterlockedExchange)
> >
> > typedef volatile LONG lock_t[1];
> >
> > #define LockInit(v)	((v)[0] = 0)
> > #define LockFree(v)	((v)[0] = 0)
> > #define Unlock(v)	((v)[0] = 0)
> >
> > __forceinline void Lock(volatile LONG *hPtr)
> > {
> > 	int iValue;
> >
> > 	for (;;) {
> > 		iValue = _InterlockedExchange((LPLONG)hPtr, 1);
> > 		if (iValue == 0)
> > 			return;
> > 		while (*hPtr);
> > 	}
> > }
> >
> > Please show me how I can write this to spinlock without using volatile.
> 
> Please show me how that lock is safe without a compiler memory barrier! What's 
> to stop your compiler from moving loads and stores across your inlined lock 
> code?
> 
> When you add the missing compiler memory barrier, the "volatile" classifier 
> becomes unnecessary.
> 
> Actually, please just read the thread. We've been over this already. It's 
> starting to get really old.

Actually it was good that he posted.  It just proved Linus's assumption
that those that use volatile usually don't understand exactly what is
going on.  I certainly learned a lot in this thread ;)

[ /me goes off to fix some of my broken "volatile" code ... ]

-- Steve


