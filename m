Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130190AbRAKIlx>; Thu, 11 Jan 2001 03:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129735AbRAKIln>; Thu, 11 Jan 2001 03:41:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130167AbRAKIlc>; Thu, 11 Jan 2001 03:41:32 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Date: 11 Jan 2001 00:41:12 -0800
Organization: Transmeta Corporation
Message-ID: <93jrj8$1jc$1@penguin.transmeta.com>
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De>,
Udo A. Steinberg <sorisor@Hell.WH8.TU-Dresden.De> wrote:
>
>Next backed out the entire XMM and FXSR related stuff and now everything
>is fine again. The CPU in question is an AMD Thunderbird (see cpuinfo
>below). A friend with a similar setup but a Pentium-3 CPU doesn't seem
>to see the problem (couldn't verify myself).

Mind trying it with the "HAVE_FXSR" and "HAVE_XMM" macros in 

	linux/include/asm-i386/processor.h

fixed? They _should_ be just

	#define HAVE_FXSR	(cpu_has_fxsr)
	#define HAVE_XMM	(cpu_has_xmm)

instead of testing random bits in CR4 that have different meaning on
different CPU's. 

I'm surprised actually - the same CR4 tests are in newer 2.2.x kernels,
I think. (And in 2.2.x kernels, the above "cpu_has_xxx" do _not_ work
unless FP exception testing etc has been fixed in the 2.2.x tree)

Andrea?

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
