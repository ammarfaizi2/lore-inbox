Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267834AbRGRPMz>; Wed, 18 Jul 2001 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267854AbRGRPMp>; Wed, 18 Jul 2001 11:12:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:65289 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267839AbRGRPMi>; Wed, 18 Jul 2001 11:12:38 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Wed, 18 Jul 2001 08:10:22 -0700
Message-Id: <200107181510.f6IFAMW03662@penguin.transmeta.com>
To: ja@himel.com, linux-kernel@vger.kernel.org
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.10.10107181347030.16710-100000@l>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.10.10107181347030.16710-100000@l> you write:
>
>	I don't know whether cpuid_eax (2.4.7pre) should preserve the
>registers changed from cpuid

It should. It has the proper "this instruction assigned values to these
registers" stuff, so gcc should know which ones change.

>			 but I have an oops on boot with 2.4.7pre7 in
>squash_the_stupid_serial_number where cpuid_eax changes ebx and the
>parameter "c" is loaded with "Genu". The following change fixes the
>problem:

Interesting. Can you do the following:

 - tell us your compiler version

 - do a "make arch/i386/kernel/setup.s" both ways, and show what
   squash_the_stupid_serial_number() looks like.

 - fix _all_ the "cpuid*()" functions to have

	:"0" (op)

   instead of their current incorrect

	:"a" (op)

   (we're supposed to explicitly tell the compiler that the first input
   is the same as the first output)

 - see if that makes any difference to the assembler output.

In any case it does sound like a compiler bug, but it would be good to
have a workaround. But it would also be good to have a more complete
dump of the oops in question to see more about what is going on..

		Thanks,
			Linus
