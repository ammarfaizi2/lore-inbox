Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318958AbSHFBWa>; Mon, 5 Aug 2002 21:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318963AbSHFBW3>; Mon, 5 Aug 2002 21:22:29 -0400
Received: from h-64-105-137-168.SNVACAID.covad.net ([64.105.137.168]:18835
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318958AbSHFBW2>; Mon, 5 Aug 2002 21:22:28 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 5 Aug 2002 18:25:50 -0700
Message-Id: <200208060125.SAA03296@baldur.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.30/arch/arm/mach-iop310/iq80310-pci.c BUG_ON(cond1 || cond2) separation
Cc: linux-kernel@vger.kernel.org, mporter@mvista.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Mon, Aug 05, 2002 at 01:17:40PM -0700, Adam J. Richter wrote:
>> 	I want to replace all statements in the kernel of the form
>> BUG_ON(condition1 || condition2) with:
>> 
>> 			BUG_ON(condition1);
>> 			BUG_ON(condition2);

>Why?  In the case below, its one logical error (value out of range).
>The register dump tells you more information.  In fact, I don't care
>which side of less than 1 or greater than 4 pin actually is.  It's
>indicating a bug in the PCI subsystem either way, and the analysis
>is the same in either case.

	Because knowing which way the failure occurred may give you
a clue about what *caused* it.

>> 	I was recently bitten by a very sporadic BUG_ON(cond1 || cond2)
>> statement and was quite annoyed at the greatly reduced opportunity to
>> debug the problem.  Make these changes and someone who experiences
>> the problem may be able to provide slightly more useful information.

>This would make sense of the two conditions were unrelated to each
>other.

	Even when two conditions are related, knowing which one failed
gives you more information, and can make it easier to track down the bug,
even when the two parts of the condition seem very simple, especially
considering that some bugs can be sporadic and tracking down bugs
often involves pearing down an exponential tree of possibilities.

	That was pretty much the case with the BUG_ON for two
related conditions that I tripped.  The lack of information about
the problem was basically enough to tip the scales so that other
things were a better use of my time than trying to track it down
further, although I may come back to it later.

	That will probably never happen with "pin < 1 || pin > 4", 
because, like most BUG_ON statements, it will probably never be
tripped.  Nevertheless, if one of those BUG_ON statements is tripped,
it will probably save someone some valuable developer time, and
reduce the interactions necessary with some user who might not be
that interested in becoming an ARM kernel developer.

	All of the other patches that I have submitted to
eliminate BUG_ON(x || y) statements have been accepted by
their maintainers.  If you accept the patch for your two BUG_ON
statements, the practice should be completely eliminated from
the kernel once the other maintainers propagate their next
releases to Linus.

	Even if you think this case is trivial, you will at least be
leading by example about accomodating quality requests, at least when
somone submits a patch.

	Anyhow, please let me know what you want to do or what you
want me to do.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
