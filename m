Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280839AbRKLQrB>; Mon, 12 Nov 2001 11:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280840AbRKLQqw>; Mon, 12 Nov 2001 11:46:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23315 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280839AbRKLQqk>; Mon, 12 Nov 2001 11:46:40 -0500
Date: Mon, 12 Nov 2001 08:42:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <dalecki@evision.ag>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.14 mregparm=3 compilation fixes
In-Reply-To: <3BEFB261.700729A4@evision-ventures.com>
Message-ID: <Pine.LNX.4.33.0111120838110.15242-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Nov 2001, Martin Dalecki wrote:
>
> The attached patch is fixing compilation and running
> of the kernel with -mregparm=3 on IA32. The fixes excluding
> the change in arch/i386/Makefile of course apply to the stock kernel
> as well, so Linus please include it in 2.4.15 - it just won't hurt...

I certainly won't enable it in the stock kernel, considering the bad track
record gcc has had with regparm under register pressure, but the
"asmlinkage" parts look like real fixes.

However, it's kind of sad to make some of the more timing-critical stuff
(like schedule_tail) be asmlinkage - it might be worth it to do it the
other way around, and make it FASTCALL() and change the assembly code to
pass arguments in registers. That way, the calling convention is still the
same on both regparm=3 and without, but instead of defaulting to the slow
method we'd default to the fast one..

		Linus

