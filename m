Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbTCHPAS>; Sat, 8 Mar 2003 10:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbTCHPAS>; Sat, 8 Mar 2003 10:00:18 -0500
Received: from AMarseille-201-1-6-96.abo.wanadoo.fr ([80.11.137.96]:13351 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S262035AbTCHPAR>;
	Sat, 8 Mar 2003 10:00:17 -0500
Subject: Re: [patch] oprofile for ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org,
       Segher Boessenkool <segher@koffie.nl>, o.oppitz@web.de,
       afleming@motorola.com, linux-kernel@vger.kernel.org
In-Reply-To: <1047061862.1900.67.camel@cube>
References: <200303070929.h279TGTu031828@saturn.cs.uml.edu>
	 <1047032003.12206.5.camel@zion.wanadoo.fr>  <1047061862.1900.67.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047136206.12202.85.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Mar 2003 16:10:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 19:31, Albert Cahalan wrote:

> This is just the first part of the code. Please merge it
> into any tree you have, unless it's obviously broken.
> It is useful for long-running processes that don't do
> much that is tied to the clock tick. (number crunching,
> maybe X, web browsers without animations, /tmp cleaner...)
> 
> The i386 port is already using 1000 Hz in the kernel,
> and has 100 Hz as a non-default option. I'd really like
> to have this on my Mac; lots of things would improve.
> 
> I intend to allow sampling based on the performance counter
> interrupt/trap/exception and the external interrupt signal.

Ok. I'll ask paulus about merging this.

Beware though that some G4s have a nasty bug that prevents
using the performance counter interrupt (and the thermal interrupt
as well). The problem is that if any of those fall at the same
time as the DEC interrupt, the CPU messes up it's internal
state and you lose SRR0/SRR1, which means you can't recover
from the exception.

Note also that it should be relatively easy to have the DEC timer
run faster than HZ. The code in timer.c can deal with spurrious DEC
interrupts, so you may improve your results by just making it fire
at 1Khz or higher.

Ben.
