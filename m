Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318060AbSFSXrL>; Wed, 19 Jun 2002 19:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSFSXrK>; Wed, 19 Jun 2002 19:47:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:25335 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318060AbSFSXrK>; Wed, 19 Jun 2002 19:47:10 -0400
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0206200123470.25434-100000@e2>
References: <Pine.LNX.4.44.0206200123470.25434-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 16:47:00 -0700
Message-Id: <1024530423.917.21.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 16:35, Ingo Molnar wrote:

> the scheduler optimisation in 2.5.23-dj1, from James Bottomley, look fine
> to me. I did some modifications:

Nice.

> +static inline unsigned int task_cpu(struct task_struct *p)
> +static inline unsigned int set_task_cpu(struct task_struct *p, unsigned int cpu)

Technically, shouldn't we make these `unsigned long' ?

I know on x86 we store cpu as a `u32' so it does not matter per se, but
in reality it is an unsigned long and other architectures may export it
as such.

Further, we compare and set it against the various CPU bitmaps and they
are all `unsigned long' and we do shifts against 1UL ...

	Robert Love

