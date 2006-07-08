Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWGHNrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWGHNrR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWGHNrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:47:17 -0400
Received: from relay03.pair.com ([209.68.5.17]:17929 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S964835AbWGHNrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:47:16 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: "trajce nedev" <trajcenedev@hotmail.com>
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Sat, 8 Jul 2006 08:46:49 -0500
User-Agent: KMail/1.9.3
Cc: torvalds@osdl.org, acahalan@gmail.com, linux-kernel@vger.kernel.org,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
References: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
In-Reply-To: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080847.12566.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 01:44, trajce nedev wrote:
> On Sat, 8 Jul 2006, Chase Venters wrote:
> >Perhaps you should have followed this thread closely before composing your
> >assault on Linus. We're not talking about "asm volatile". We're talking
> >about
> >the "volatile" keyword as applied to variables. 'volatile' as applied to
> >inline ASM is of course necessary in many cases -- no one is disputing
> >that.
>
> Ok, let's port a spinlock macro that spins instead of context switches
> instead of using the pthread garbage on IA64 or AMD64:
>
> #if ((defined (_M_IA64) || defined (_M_AMD64)) && !defined(NT_INTEREX))
> #include <windows.h>
> #pragma intrinsic (_InterlockedExchange)
>
> typedef volatile LONG lock_t[1];
>
> #define LockInit(v)	((v)[0] = 0)
> #define LockFree(v)	((v)[0] = 0)
> #define Unlock(v)	((v)[0] = 0)
>
> __forceinline void Lock(volatile LONG *hPtr)
> {
> 	int iValue;
>
> 	for (;;) {
> 		iValue = _InterlockedExchange((LPLONG)hPtr, 1);
> 		if (iValue == 0)
> 			return;
> 		while (*hPtr);
> 	}
> }
>
> Please show me how I can write this to spinlock without using volatile.

Please show me how that lock is safe without a compiler memory barrier! What's 
to stop your compiler from moving loads and stores across your inlined lock 
code?

When you add the missing compiler memory barrier, the "volatile" classifier 
becomes unnecessary.

Actually, please just read the thread. We've been over this already. It's 
starting to get really old.

> 		Trajce Nedev
> 		tnedev@mail.ru

Thanks,
Chase
