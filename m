Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755098AbWKLNQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbWKLNQd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbWKLNQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:16:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49863 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755096AbWKLNQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:16:32 -0500
Subject: Re: [Bugme-new] [Bug 7495] New: Kernel periodically hangs.
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>,
       linux-kernel@vger.kernel.org, alex@hausnet.ru, mingo@redhat.com
In-Reply-To: <20061112125357.GH25057@stusta.de>
References: <200611111129.kABBTWgp014081@fire-2.osdl.org>
	 <20061111100038.6277efd4.akpm@osdl.org>
	 <1163268603.3293.45.camel@laptopd505.fenrus.org>
	 <20061111101942.5f3f2537.akpm@osdl.org>
	 <1163332237.3293.100.camel@laptopd505.fenrus.org>
	 <20061112125357.GH25057@stusta.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 12 Nov 2006 14:16:16 +0100
Message-Id: <1163337376.3293.120.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Some APIC-related bugs in the kernel Bugzilla that have been reported or 
> confirmed during the last 12 months (I only looked at "apic" in the 
> subject, there might be more related bugs in the Bugzilla):
> 
> #5038 Fast running system clock with IO-APIC enabled

This is a UP machine. NotInteresting(tm) wrt APIC.

> #5303 AMD64 Erratum: Should not enable C2 when using APIC

This is clearly not a linux issue but a hardware bug, as the title says

> #5565 Guess of i386 APIC PTE area scribble
this is only on one machine and a "special case"; not ruling out
anything fundamental but..

> #6404 APIC error on CPU0: 40(40)

This bug is a mess though; many different people seeing a symptom of an
apic error, and all jumping in assuming they see the same problem...
Also it's afaik only a message and not (yet) fatal in any way.
Sometimes apics do this a few times a day, esp when things are getting
hot in the box. Afaik there is then just a resend of the message and
nothing is lost.

> #6748 Clock drifts by 30% for SMP kernel w/APIC

this looks like a totally weird hardware case that probably just wants
to be blacklisted.

> #6859 Linux kernel won't work without "nolapic" passed
weird one, probably a bios issue but it's the opposite of "noapic", and
also this is about local apic not about ioapic. Although they share 4
letters they're entirely different animals.

> #6890 Kernel boot freezes when APIC is enabled & SATA is used

seems to be UP as well but asked for confirmation in the bug (lack of
lots of information here!). 

If this isn't UP this could be the first real case of "noapic" in your
entire list...... which isn't too useful. 
Maybe we need to get more/any people who see "need noapic on SMP" to
file a bug (and provide a reasonable amount of info)

> > 
> > 1) Only care about SMP machines. APIC on true UP (no
> > Hyperthreading/Dualcore) is a thing no hardware vendor tests (Microsoft
> > doesn't use it) and is just too likely to trip up SMM and other bad BIOS
> > stuff. 
> >  * exception is probably people who don't WANT to use apic but where it
> > somehow gets used anyway; if that happens we probably have the magic
> > bullet that causes the regression :)
> 
> On i386, it's a kernel configuration option.

yes but it's generally a bad idea to set it; it only works on some
machines. (and it can't be fixed)
> 
> On x86_64, the APIC is currently always enabled even when configuring a 
> UP kernel.

I think that's a mistake. But oh well, I suspect in practice ACPI/BIOS
cause it to be turned off automatic most of the time.

> 
> > 2) Only care about ACPI using kernels. Non-ACPI uses MPS tables for
> > this, but most vendors hardly maintain those anymore at all and they are
> > generally just /dev/random nowadays
> 
> What about non-ACPI SMP?

if the machine is new enough to run ACPI I don't care about the non-ACPI
case; just enable it. Really. On newish machines (and that is 7 years
old or newer) MPS tables are NOT getting much if any attention by the
bios guys. So Linux should use ACPI, and if you deliberately disable
ACPI and THEN hit a problem to a large degree you asked for the problem
in the first place.

Older machines, different story.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

