Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWGHGpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWGHGpT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 02:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWGHGpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 02:45:18 -0400
Received: from bay0-omc3-s31.bay0.hotmail.com ([65.54.246.231]:56951 "EHLO
	bay0-omc3-s31.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751302AbWGHGpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 02:45:17 -0400
Message-ID: <BAY110-F352D1029C60425661175C9B8750@phx.gbl>
X-Originating-IP: [198.123.50.95]
X-Originating-Email: [trajcenedev@hotmail.com]
In-Reply-To: <200607080119.52533.chase.venters@clientec.com>
From: "trajce nedev" <trajcenedev@hotmail.com>
To: chase.venters@clientec.com
Cc: torvalds@osdl.org, acahalan@gmail.com, linux-kernel@vger.kernel.org,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Date: Fri, 07 Jul 2006 23:45:15 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 08 Jul 2006 06:45:17.0039 (UTC) FILETIME=[12A7EFF0:01C6A25A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Chase Venters wrote:
>
>Perhaps you should have followed this thread closely before composing your
>assault on Linus. We're not talking about "asm volatile". We're talking 
>about
>the "volatile" keyword as applied to variables. 'volatile' as applied to
>inline ASM is of course necessary in many cases -- no one is disputing 
>that.
>

Ok, let's port a spinlock macro that spins instead of context switches 
instead of using the pthread garbage on IA64 or AMD64:

#if ((defined (_M_IA64) || defined (_M_AMD64)) && !defined(NT_INTEREX))
#include <windows.h>
#pragma intrinsic (_InterlockedExchange)

typedef volatile LONG lock_t[1];

#define LockInit(v)	((v)[0] = 0)
#define LockFree(v)	((v)[0] = 0)
#define Unlock(v)	((v)[0] = 0)

__forceinline void Lock(volatile LONG *hPtr)
{
	int iValue;

	for (;;) {
		iValue = _InterlockedExchange((LPLONG)hPtr, 1);
		if (iValue == 0)
			return;
		while (*hPtr);
	}
}

Please show me how I can write this to spinlock without using volatile.

		Trajce Nedev
		tnedev@mail.ru

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today - it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

