Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317361AbSGOGx0>; Mon, 15 Jul 2002 02:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSGOGxZ>; Mon, 15 Jul 2002 02:53:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:3332 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317361AbSGOGxZ>;
	Mon, 15 Jul 2002 02:53:25 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207150656.g6F6uFx178288@saturn.cs.uml.edu>
Subject: Re: HZ, preferably as small as possible
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 15 Jul 2002 02:56:14 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <agtlq6$iht$1@penguin.transmeta.com> from "Linus Torvalds" at Jul 15, 2002 05:15:50 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> The fact that libproc believes that HZ can change is _their_ problem.
> I've told people over and over that user-level HZ is a constant (and, on
> x86, that constant is 100), and that won't change.

Was HZ supposed to be 1024 or 1200 on alpha?
How about arm... 64, 128, or 1000?

Not even counting user-mode-linux at 20 HZ, there were
about _five_ archs in your official kernel source that
indirectly made HZ a config option.

> So in current 2.5.x times() still counts at 100Hz, and /proc files that
> export clock_t still show the same 100Hz rate.

Good. That works for the 2.5 kernel and above, assuming you
did something about alpha, arm, ia64, s390, and mips.

Unfortunately, the hack must remain for another 4 years or so.
Maybe that's not so bad though. I prefer it over this:

#ifdef __386__
#define HZ 100
#endif
#ifdef __IA64__
#define HZ 1024
#endif
#ifdef __ARM__
#define HZ 128  // if they settle on this
#endif
#ifdef __S390__
#define HZ 10
#endif
...
