Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSLULK5>; Sat, 21 Dec 2002 06:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266898AbSLULK5>; Sat, 21 Dec 2002 06:10:57 -0500
Received: from mx1.elte.hu ([157.181.1.137]:1170 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S266888AbSLULK4>;
	Sat, 21 Dec 2002 06:10:56 -0500
Date: Sat, 21 Dec 2002 12:24:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>, <davej@suse.de>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212172205590.1233-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212211222580.32244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Dec 2002, Linus Torvalds wrote:

> > How about this patch?  Instead of making a per-cpu trampoline, write to
> > the msr during each context switch.
> 
> I wanted to avoid slowing down the context switch, but I didn't actually
> time how much the MSR write hurts you (it needs to be conditional,
> though, I think).

this is the solution i took in the original vsyscall patches. The syscall
entry cost is at least one factor more important than the context-switch
cost. The MSR write was not all that slow when i measured it (it was on
the range of 20 cycles), and it's definitely something the chip makers
should keep fast.

	Ingo

