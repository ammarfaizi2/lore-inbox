Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130469AbQKREke>; Fri, 17 Nov 2000 23:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131094AbQKREkY>; Fri, 17 Nov 2000 23:40:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130516AbQKREkL>; Fri, 17 Nov 2000 23:40:11 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Freeze on FPU exception with Athlon
Date: 17 Nov 2000 20:10:01 -0800
Organization: Transmeta Corporation
Message-ID: <8v4vep$15d$1@penguin.transmeta.com>
In-Reply-To: <20001118014019.18006.qmail@web3404.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001118014019.18006.qmail@web3404.mail.yahoo.com>,
=?iso-8859-1?q?Markus=20Schoder?=  <markus_schoder@yahoo.de> wrote:
>The following small program (linked against glibc 2.1.3) reliably
>freezes my system (Athlon Thunderbird CPU) with at least kernels
>2.4.0-test10 and 2.4.0-test11-pre5.  Even the SysRq keys do not work
>after the freeze.
>
>Older kernels (e.g. 2.3.40) seem to work.  Any Ideas?

It certainly doesn't happen for me on any of the machines I work with,
but it wouldn't compile as-is for me, so I exchanged the FPU setting
with a simpler

	asm("fldcw %0": :"m" (0));

which should do the equivalent (ie unmask divide by zero errors). Does
that make a difference for you?

Can you try to figure out where it started happening? Ie try test9 and
back too, to figure out what might be bringing it on... 

I sure as hell hope this isn't an Athlon issue.  Can other people try
the test-program and see if we have a pattern (ie "it happens only on
Athlons", or "Linus is on drugs and it happens for everybody else").

Thanks,

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
