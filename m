Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSGOSvv>; Mon, 15 Jul 2002 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317601AbSGOSvu>; Mon, 15 Jul 2002 14:51:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18961 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317597AbSGOSvr>; Mon, 15 Jul 2002 14:51:47 -0400
Date: Mon, 15 Jul 2002 11:50:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <200207151607.g6FG7In203512@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0207151148080.19586-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 15 Jul 2002, Albert D. Cahalan wrote:
>
> It's not a different value in libproc. There's autodetection.
> I can't just support "the majority of ARM", and people keep
> giving me shit about HZ supposedly being a per-arch constant.
> (not that there's a sane way to get a per-arch constant from
> user code anyway)

But that's just _wrong_.

There _is_ a sane way to get the per-arch constant, and there has been for 
a long long time.

The kernel exports it with the AT_CLKTCK ELF auxiliary note to every ELF
binary ever loaded, and I think glibc in turn exports that value through
the regular sysconf(_SC_CLK_TCK) thing. (Yeah, I disagree with some of the
glibc sysconf implementation, but it sure should be there, and it's
documented).

If that doesn't work, then it's a glibc bug (well, in theory there could
be a kernel bug too, but since it's a one-liner in the kernel I really
doubt it).

		Linus

