Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318934AbSH1Toe>; Wed, 28 Aug 2002 15:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318936AbSH1Toe>; Wed, 28 Aug 2002 15:44:34 -0400
Received: from kim.it.uu.se ([130.238.12.178]:8098 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S318934AbSH1Toc>;
	Wed, 28 Aug 2002 15:44:32 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.10526.800183.413898@kim.it.uu.se>
Date: Wed, 28 Aug 2002 21:48:46 +0200
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
In-Reply-To: <1030551390.1489.63.camel@ldb>
References: <1030506106.1489.27.camel@ldb>
	<15724.61927.221405.274843@kim.it.uu.se>
	<1030551390.1489.63.camel@ldb>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Barbieri writes:
 > > I've tried this sort of thing before (unsynchronised cross-modifying code),
 > > but I had to abandon it due to Pentium III Erratum E49 and similar errata
 > > for all Intel P6 CPUs. Have you verified that you're not hitting this erratum?
 > It is indeed completely hitting it.
 > However, we can work around this by simply stopping all other CPUs in
 > interrupt context with an IPI (while this may sound horrible, it
 > shouldn't significantly impact performance unless the response time is
 > excessively long).

That was my thought too. IPI to bring the others to a barrier, do the
modification, release the barrier.

In my case (patching CALL instructions to call the correct targets
after HW detection) I was fortunately able to fix up the code before
it was seen by other CPUs, but this relied on the fact that I knew
the locations of all CALL sites needing fix up.

 > I'll write some code to this. However I don't have the hardware to test
 > it, so it might require multiple iterations to get it right.
 > 
 > As for the "all Intel P6 CPUs" are really _all_ Intel P6 CPU broken? 

Yes, last time I checked the erratum existed for all members of
Intel's P6 family.

 > Do you know of any other CPU that would need the workaround?

No. The P5 is ok, and I believe the P4 is also. The K7s didn't have
this listed as an erratum last time I checked.

/Mikael
