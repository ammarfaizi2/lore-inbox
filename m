Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbRBZGvk>; Mon, 26 Feb 2001 01:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130182AbRBZGvb>; Mon, 26 Feb 2001 01:51:31 -0500
Received: from outbound.charter.net ([24.216.159.200]:5679 "EHLO
	front001.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S130178AbRBZGvV>; Mon, 26 Feb 2001 01:51:21 -0500
Date: Sun, 25 Feb 2001 22:49:17 -0800
From: "Marc D. Williams" <marcdw@charter.net>
Message-Id: <200102260649.f1Q6nHL02281@Aptiva.digisensei.org>
To: k.hindenburg@gte.net, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: __buggy_fxsr_alignment error 2.4.1 and 2.4.2
In-Reply-To: <fa.f823oav.g0oe3a@ifi.uio.no>
In-Reply-To: <fa.f823oav.g0oe3a@ifi.uio.no>
Reply-To: marcdw@charter.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In fa.linux.kernel, you wrote:
>asm-i386:
>init/main.o(.text.init+0x63): undefined reference to `__buggy_fxsr_alignment'
>
>I don't recall this error in 2.4.0, but it is present in 2.4.1 and was not
>fixed in 2.4.2.
>
>Gnu C                  pgcc-2.95.2.1
>
>Fix: Comment out line 217 in include/asm-i386/bugs.h
>/*    __buggy_fxsr_alignment(); */
>
>It compiles after this change.
>
[I'm not on the mailing list but do read it via usenet, can't post though]

As pointed out by Doug Ledford your kernel will surely oops when you
reboot. I have an Athlon and use AthlonGCC (pgcc-2.95.3 with patches).
I didn't want to go back to regular gcc but I fixed my problem anyway
and so far kernels from 2.4.1 to 2.4.2 run just fine.

The first fix was uncommenting in bugs.h as you did.
Not sure if it was proper but I did the whole section. :-)
I may retry it with just the last part commented out.

    	/* if (offsetof(struct task_struct, thread.i387.fxsave) & 15) {
                extern void __buggy_fxsr_alignment(void);
                __buggy_fxsr_alignment();
        } */
	
The problem is this fxsr thing. I found the following in 
arch/i386/kernel/setup.c (line 150):

static int disable_x86_fxsr __initdata = 0;

I changed the 0 to 1 (to disable x86_fxsr) and so far the kernels
have given me no problems.

Since apparently we're using buggy compilers no doubt this workaround
may be frowned upon. At least for me it works.

-- 
>>ANIME SENSHI<<

Marc D. Williams
marcdw@charter.net
http://www.oldskool.org/~tvdog/ -- DOS Internet & Tandy 1000
http://www.geocities.com/SiliconValley/Platform/8269/ -- Win3.x Makeover
