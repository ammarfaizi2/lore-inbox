Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSJPIFy>; Wed, 16 Oct 2002 04:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264957AbSJPIFy>; Wed, 16 Oct 2002 04:05:54 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12499 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264956AbSJPIFw>;
	Wed, 16 Oct 2002 04:05:52 -0400
Date: Wed, 16 Oct 2002 10:23:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Martin Wirth <Martin.Wirth@dlr.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] futex-2.5.42-A2
In-Reply-To: <3DAD1C3C.3080001@dlr.de>
Message-ID: <Pine.LNX.4.44.0210161018210.4683-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Oct 2002, Martin Wirth wrote:

>  >	if (__alignof__(int) < sizeof(int)) {
>  > 
> 	extern void __error_small_int_align();

> I suggested to tighten the above test, because if __alignof__(int) <
> sizeof(int) the test leads to sporadic user space errors if the futex
> variable accidentally crosses a page boundary. [...]

i think you misunderstood Rusty's suggestion - what he suggests is to fail
the kernel compile with a linker error if alignof(int) < sizeof(int). This
is a pure compile-time thing, it does not relate to the alignment of the
futex variable in any way.

> Anyway, the test dates back to times when the futex code did atomic
> operations on the user space variable. But this is gone. The present
> code only touches users space by get_user which does its on checks. So
> from the point of keeping the kernel in a sane state we could drop the
> test completely.

actually, i think it's still important to do the alignment check to
enforce userspace to use sane alignment. We dont want one futex variable
out of 1000 potential futex to be misaligned, missed and blamed on the
kernel.

	Ingo

