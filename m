Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbRGVACl>; Sat, 21 Jul 2001 20:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbRGVACb>; Sat, 21 Jul 2001 20:02:31 -0400
Received: from [64.81.246.98] ([64.81.246.98]:33674 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267857AbRGVACY>;
	Sat, 21 Jul 2001 20:02:24 -0400
Date: Sat, 21 Jul 2001 17:00:18 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
        Julian Anastasov <ja@ssi.bg>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
Message-ID: <20010721170018.C3676@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org,
	Julian Anastasov <ja@ssi.bg>
In-Reply-To: <Pine.LNX.4.33.0107181014590.883-100000@penguin.transmeta.com> <Pine.LNX.4.33.0107182239050.1298-100000@vaio> <200107182204.f6IM4K001282@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200107182204.f6IM4K001282@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jul 18, 2001 at 03:04:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 18, 2001 at 03:04:20PM -0700, Linus Torvalds wrote:
> Can you verify with this alternate patch instead?

I take it you've found something that happens to work with egcs 1.1?

At a glance the bug appears to be the one that caused
gcc/testsuite/gcc.dg/clobbers.c to be written.  That one
is a fundamental flaw in reload that caused it to be 
largely rewritten for gcc 2.95.

In other words, you may not be able to find a workaround
for egcs 1.1 that works for all cases.  Using an alternative
that writes all of eax/ebx/ecx/edx to memory is probably
safer if none of the uses of cpuid are performance-critical.


r~
