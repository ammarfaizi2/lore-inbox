Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUAWNTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUAWNTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:19:34 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:24454 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261575AbUAWNTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:19:32 -0500
Date: Fri, 23 Jan 2004 14:19:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Karol Kozimor <sziwan@hell.org.pl>, "Georg C. F. Greve" <greve@gnu.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <Pine.LNX.4.58.0401221044440.2172@home.osdl.org>
Message-ID: <Pine.LNX.4.55.0401231327020.3223@jurand.ds.pg.gda.pl>
References: <88056F38E9E48644A0F562A38C64FB6082D0B8@scsmsx403.sc.intel.com>
 <16400.6262.97863.651276@alkaid.it.uu.se> <Pine.LNX.4.58.0401221044440.2172@home.osdl.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, Linus Torvalds wrote:

> > To handle both cases the code should do one of those "is intergrated"
> > tests we alreay have several of in apic.c. I can fix that, but not
> > until tomorrow.
> 
> Even then I'd like to hear _why_ it would be a problem to bypass the
> divider on an external LAPIC. The original patch comes with a message
> explicitly saying that it was never even tested on such an external LAPIC, 
> and doing a google newsgroup search doesn't find any replies to that
> post.

 It wasn't tested back then in July 1999, but later it actually was and
proved correct -- see the note in arch/i386/kernel/apic.c (I can dig
through my archive for patches and mails involved).  A few other problems
were resolved as a result as well, e.g. the logical destination mode
turned out not to work with the i82489DX unless the DFR is set to
0xffffffff explicitly as stated in the manuals (we used to set it to 0xf
earlier, based on documentation on the integrated APICs, and yes, the
i82489DX does support a flat 32-bit logical destination selection), a race
when using INIT IPIs to wake up APs, etc.

> I actually have some really old Intel manuals, including one for the
> i82489DX (actually, it's just one part of a "Pentium Processors and
> Related Products" manual). And while I see the register definition (and 
> yes, it documents the CLKIN/TMBASE/DIVIDER usage), I don't see anything 
> that actually says that you shouldn't just use CLKIN.

 There were actually two documents, sort of complementing each other, also
available as discrete hardcopies. ;-)  If there's interest in the
documents I can think on how to make them available.

> Do we have any real reason to care? We calculate the counter value
> dynamically anyway, so the only "bug" might be that on one of those old
> i82489DX machines we might report a frequency value that is off by a
> factor of 16. Which should just make the user really happy ("cool, my APIC
> is running at 256 MHz!").

 Well, I think the systems are rare enough we'd better keep their
configuration as much similar to the more common ones as possible.  This
way chances are any bug that would hit the formers, will trigger for the
latters as well.  And in this case it's just a few bytes of code as Mikael 
has already proposed.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
