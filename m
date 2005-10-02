Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbVJBUrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVJBUrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 16:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVJBUrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 16:47:23 -0400
Received: from free.hands.com ([83.142.228.128]:42178 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1750885AbVJBUrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 16:47:23 -0400
Date: Sun, 2 Oct 2005 21:47:03 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: what's next for the linux kernel?
Message-ID: <20051002204703.GG6290@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

as i love to put my oar in where it's unlikely that people
will listen, and as i have little to gain or lose by doing
so, i figured you can decide for yourselves whether to be
selectively deaf or not:

here's my take on where i believe the linux kernel needs to go,
in order to keep up.

what prompted me to send this message now was a recent report
where linus' no1 patcher is believed to be close to overload,
and in that report, i think it was andrew morton, it was
said that he believed the linux kernel development rate to be
slowing down, because it is nearing completion.

i think it safe to say that a project only nears completion
when it fulfils its requirements and, given that i believe that
there is going to be a critical shift in the requirements, it
logically follows that the linux kernel should not be believed
to be nearing completion.

with me so far? :)

okay, so what's the bit that's missing that mr really irritating,
oh-so-right and oh-so-killfile-ignorable luke kenneth casson
kipper lozenge has spotted that nobody else has, and what's
the fuss about?

well... to answer that, i need to outline a bit about processor
manufacturing: if you are familiar with processor design please
forgive me, this is for the benefit of those who might not be.

the basic premise: 90 nanometres is basically... well...
price/performance-wise, it's hit a brick wall at about 2.5Ghz, and
both intel and amd know it: they just haven't told anyone.

anyone (big) else has a _really_ hard time getting above 2Ghz,
because the amount of pipelining required is just... insane
(see recent ibm powerpc5 see slashdot - what speed does it do?
surprise: 2.1Ghz when everyone was hoping it would be 2.4-2.5ghz).

a _small_ chip design company (not an IBM, intel or amd)
will be lucky to see this side of 1Ghz, at 90nm.

also, the cost of mask charges for 90nm is insane: somewhere
around $2million and that's never going to go away.

the costs for 65nm are going to be far far greater than that,
and 45nm i don't even want to imagine what they're going to be.

plus, there's a problem of quantum mechanics, heat dissipation
and current drain that makes, with current manufacturing
techniques, the production of 65nm and 45nm chips really
problematic.

with present manufacturing techniques, the current drain and heat
dissipation associated with 45nm means that you have to cut the number
of gates down to ONE MILLION, otherwise the chip destroys itself.

(brighter readers might now have an inkling of where i'm going
with this - bear with me :)

compare that one million gates with the present number of gates in an
AMD or x86 chip - some oh, what, 20 million?

now you get it?

for the present insane uniprocessor architectures at least
(and certainly for the x86 design), 90nm is _it_ - and yet,
people demand ever more faster and faster amounts of processing,
and no amount of trying on the part of engineers can get round
the laws of physics.

so, what's the solution?

well.... it's to back to parallel processing techniques, of course.

and, surprise surprise, what do we have intel pushing?

apart from, of course, the performance per watt metric (which,
if you read a few paragraphs back, you realise why they have to
trick both their customers and their engineers into believing
that performance/watt is suddenly important, it's because they
have to carve a path for a while getting the current usage down
in order for the 65nm chips to become palatable - assuming they
can be made at all in a realistic yield - read price bracket)

well - intel is pushing "hyperthreading".

and surprise, surprise, what is amd pushing?  dual-core chips.

and what is in the X-Box 360?  a PowerPC _triple_ core, _dual_
hyper-threaded processor!!

i believe that the X-Box 360 processor is the way things
are going to be moving - quad-core quad-threaded processors;
16 and 32 core ultra-RISC processors: medium to massive parallel
processors, but this time single-chip unlike the past decade(s) where
multi-core was hip and cool and... expensive.

i believe the future to contain stacks of single-chip multiprocessing
designs in several forms - including intel's fun-and-games VLIW stuff.

remember: intel recently bought the company that has spent
15 years working on that DEC/Alpha just-in-time x86-to-alpha
assembly converter product (remember DEC/Alphas running NT 3.51,
anyone, and still being able to run x86 programs?)

and, what is the linux kernel?

it's a daft, monolithic design that is suitable and faster on
single-processor systems, and that design is going to look _really_
outdated, really soon.

fortunately, there is a research project that has already
done a significant amount of work in breaking away from the
monolithic design: the l4linux project.

last time i checked, a few months ago, they were keeping thoroughly
up-to-date and had either 2.6.11 or 2.6.12 ported, can't recall which.

the l4linux project puts the linux kernel on top of L4-compliant
microkernels (yes, just like the gnu hurd :) and there are several such
L4-compliant microkernels - named after nuts.  pistachio, etc.

one of those l4-compliant microkernels is a parallel processor
based one - it's SMP compliant, it even has support for virtual
machining, whoopee, ain't that fun.

i remember now.  university of south australia, and university
of karlsruhe.  i probably spelled that wrong.


in short, basically, if you follow and agree with the logic, the
linux kernel - as maintained by linus - is far from complete.

i therefore invite you to consider the following strategy:

1) that the linux kernel should merge with the oskit project or that the
linux kernel should split into two projects - a) 30-40k lines of code
comprising the code in kernel/* and headers and ports and headers
b) device drivers i.e duh the oskit project.

2) that the linux kernel should merge and maintain the efforts
of the l4linux project as mainlined not sidelined.

3) that serious efforts be diverted into the l4 microkernels to make it
portable, work on parallel processor systems, hyperthreaded, SMP and
other (such as ACPI which has had to be #ifdef'd out even in XEN).

4) other.

yes, i know this flies in the face of linus' distaste for
message-based kernels, and it's because message-passing slows
things down... but they slow things down _only_ on uniprocessor
kernel designs, and uniprocessors are going to be blowing
goats / bubbles / insert-as-appropriate in the not-too-distant
future.  there have _already_ been high-profile parallel
processor designs announced, released, and put into service
(e.g. dual-core AMD64, triple-core dual-hyperthreaded PowerPC in
the X-Box 360).

yes, i may have got things wrong.

yes, it is up to _you_ to point them out.

yes, it is up to _you_ to decide what to do, not me.

good luck.

l.

p.s. XEN is even getting lovely encouraging noises from intel
to support hyperthreading, isn't that nice boys and girls?

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
