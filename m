Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVKMCe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVKMCe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 21:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVKMCe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 21:34:57 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:42431 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750858AbVKMCe4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 21:34:56 -0500
Subject: Re: [PATCH 0/13] Time: Generic Timeofday Subsystem (v B10)
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <p73lkzt49wr.fsf@verdi.suse.de>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
	 <p73lkzt49wr.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Sat, 12 Nov 2005 18:34:55 -0800
Message-Id: <1131849296.2607.30.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-13 at 02:24 +0100, Andi Kleen wrote:
> john stultz <johnstul@us.ibm.com> writes:
> 
> > All,
> > 	I had hoped to submit this to -mm today, but since Ingo pointed
> > out an issue in the __delay code, I'm going to wait a week so the new fix
> > can be better tested.
> 
> At least on x86-64 there is currently so much other timer related
> development going on (per CPU TSC timers, no idle tick, 64bit HPET
> etc.)  that I don't want any x86-64 bits of that merged for the next
> time. The other stuff needs to settle first.

Oh yes, I should have been more clear. I'm not planning on submitting
the x86-64 bits yet, just the i386. The x86-64 parts are there as an
example that this is useful outside of just i386, and ensures the
framework can support more complex features, like vsyscall for example
(Also just to give some scope, I have code for ppc that I run at home
and code that builds for ppc64, s390, arm, sparc, alpha and ia64, but
all of those will need much more work).  

> I haven't read the patchset in full detail, but from a quick look
> it's also not obvious too me in which way it is easier and cleaner
> than the old setup. While the old code was quirky in parts the
> new one seems to fall more in the overmodularization/too many
> indirect callbacks trap.

I appreciate your time in looking at the code. I've added some
documentation in Documentation/timekeeping.txt, so let me know if
anything there needs further clarification.

However I don't feel it is overmodulation. The close linking between
timer interrupts and timekeeping is really problematic because any
change in one affects the other.  Further, examples like the list above
(for per-cpu TSC management and 64bit HPET timkeeping) show that the
code could use some modulation so these features can be developed beside
the already working implementations without serious conflicts.

> It is also totally unclear how it will interact with vsyscall.

vsyscall is probably adds the most complexity to the infrastructure, but
I feel I've addressed it in a pretty clean way. And it is working fine
for x86-64 and I have an additional patch that enables it for i386.

Take a look at the arch_update_vsyscall() function in the x86-64 code
and look at the vread() function in the x86-64 tsc clocksource. These
bits could use some cleaning up (I haven't removed the legacy time
variables that are exported), but the foundation is there. Please let me
know if you have any comments or suggestions for further simplifying
that code.

If you need more explanation, I can send the i386 code out on Monday,
which might show a more clear example.

Again, I really appreciate your feedback, and once I move my attention
off of getting the i386 code to Andrew, the x86-64 is the next arch I'll
be focusing on. So suggest away and I'll try to get the code to your
liking.

thanks
-john

