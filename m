Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUAVTGu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266346AbUAVTGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:06:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:10120 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264916AbUAVTGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:06:47 -0500
Date: Thu, 22 Jan 2004 11:05:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Karol Kozimor <sziwan@hell.org.pl>, "Georg C. F. Greve" <greve@gnu.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: RE: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
In-Reply-To: <16400.6262.97863.651276@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.58.0401221044440.2172@home.osdl.org>
References: <88056F38E9E48644A0F562A38C64FB6082D0B8@scsmsx403.sc.intel.com>
 <16400.6262.97863.651276@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jan 2004, Mikael Pettersson wrote:
> 
> To handle both cases the code should do one of those "is intergrated"
> tests we alreay have several of in apic.c. I can fix that, but not
> until tomorrow.

Even then I'd like to hear _why_ it would be a problem to bypass the
divider on an external LAPIC. The original patch comes with a message
explicitly saying that it was never even tested on such an external LAPIC, 
and doing a google newsgroup search doesn't find any replies to that
post.

So it's entirely possible that the code was bogus to begin with, and just 
never mattered..

I actually have some really old Intel manuals, including one for the
i82489DX (actually, it's just one part of a "Pentium Processors and
Related Products" manual). And while I see the register definition (and 
yes, it documents the CLKIN/TMBASE/DIVIDER usage), I don't see anything 
that actually says that you shouldn't just use CLKIN.

Do we have any real reason to care? We calculate the counter value
dynamically anyway, so the only "bug" might be that on one of those old
i82489DX machines we might report a frequency value that is off by a
factor of 16. Which should just make the user really happy ("cool, my APIC
is running at 256 MHz!").

Hmm?

			Linus
