Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbSLREG1>; Tue, 17 Dec 2002 23:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267047AbSLREG1>; Tue, 17 Dec 2002 23:06:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23566 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266994AbSLREG0>; Tue, 17 Dec 2002 23:06:26 -0500
Date: Tue, 17 Dec 2002 20:15:05 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF8668.9080209@redhat.com>
Message-ID: <Pine.LNX.4.44.0212171621410.1578-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Dec 2002, Ulrich Drepper wrote:

> > -		0x55,			/* push %ebp */
> > +		0x55,			/* push %ebp */
> > +		0x5d,			/* pop %ebp */
> > -		0x5d,			/* pop %ebp */
>
> Instead of duplicating the push/pop %ebp just use the first one by using

No, it's not duplicating it. Look closer. It's just _moving_ it, so that
the old %ebp value will naturally be pointed to by %esp, which is what we
want.

Anyway, I reverted the %ebp games from my kernel, because they are
fundamentally not restartable and thus not really a good idea. Besides, it
might be wrong to try to optimize the fast system calls to handle six
arguments too, if that makes the (much more common case) the other system
calls slower. So the six-argument case might as well just continue to use
"int 0x80".

		Linus


