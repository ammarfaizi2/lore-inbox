Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262898AbSIPSxO>; Mon, 16 Sep 2002 14:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262899AbSIPSxO>; Mon, 16 Sep 2002 14:53:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43278 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262898AbSIPSxN>; Mon, 16 Sep 2002 14:53:13 -0400
Date: Mon, 16 Sep 2002 12:01:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032202138.969.12.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0209161157300.1352-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Sep 2002, Robert Love wrote:
> 
> The current in_atomic() check fails with kernel preemption enabled since
> we set preempt_count to PREEMPT_ACTIVE in preempt_schedule().
> 
> We need to additionally check whether PREEMPT_ACTIVE is set.

Would it not be a lot better to just mask off PREEMPT_ACTIVE() instead of 
checking for it explicitly.

The in_interrupt() etc stuff already effectively do this by masking off
the HARDIRQ_MASK etc. I would prefer a patch to hardirq.h that just adds a
#define to make preempt_count() not contain PREEMPT_ACTIVE - and make the
PREEMPT_ACTIVE checks be a totally separate check (logic: it's not a
count, so it shouldn't show up in preempt_count())

> There is also still the issue that bugging out is a bit drastic and a
> hindrance to debugging; but I will tackle that later.  For now, please
> apply this so we can at least boot with preemption enabled.

I certainly wouldn't mind the DEBUG/WARNING/FATAL infrastructure discussed 
earlier..

		Linus

