Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbRGVE2i>; Sun, 22 Jul 2001 00:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267901AbRGVE22>; Sun, 22 Jul 2001 00:28:28 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267899AbRGVE2Q>; Sun, 22 Jul 2001 00:28:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
Date: 21 Jul 2001 21:27:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9jdko9$900$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0107181014590.883-100000@penguin.transmeta.com> <Pine.LNX.4.33.0107182239050.1298-100000@vaio> <200107182204.f6IM4K001282@penguin.transmeta.com> <20010721170018.C3676@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Followup to:  <20010721170018.C3676@twiddle.net>
By author:    Richard Henderson <rth@twiddle.net>
In newsgroup: linux.dev.kernel
>
> On Wed, Jul 18, 2001 at 03:04:20PM -0700, Linus Torvalds wrote:
> > Can you verify with this alternate patch instead?
> 
> I take it you've found something that happens to work with egcs 1.1?
> 
> At a glance the bug appears to be the one that caused
> gcc/testsuite/gcc.dg/clobbers.c to be written.  That one
> is a fundamental flaw in reload that caused it to be 
> largely rewritten for gcc 2.95.
> 
> In other words, you may not be able to find a workaround
> for egcs 1.1 that works for all cases.  Using an alternative
> that writes all of eax/ebx/ecx/edx to memory is probably
> safer if none of the uses of cpuid are performance-critical.
> 

Either making the asms "volatile" seems to work, as does leaving the
unused arguments as clobbers rather than output operands.  If either
doesn't work with later versions, then later versions would have their
own bugs.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
