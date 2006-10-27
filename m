Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWJ0O7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWJ0O7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 10:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbWJ0O7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 10:59:15 -0400
Received: from colin.muc.de ([193.149.48.1]:25864 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751057AbWJ0O7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 10:59:14 -0400
Date: 27 Oct 2006 16:59:11 +0200
Date: Fri, 27 Oct 2006 16:59:11 +0200
From: Andi Kleen <ak@muc.de>
To: Om Narasimhan <om.turyx@gmail.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, vojtech@suse.cz, bob.picco@hp.com
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Message-ID: <20061027145911.GB37582@muc.de>
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com> <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com> <20061027024238.GC58088@muc.de> <4541A325.6030102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4541A325.6030102@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 11:11:49PM -0700, Om Narasimhan wrote:
> Andi Kleen wrote:
> >>1. HW is LRR capable, HPET ACPI it is 1, timer interrupt is on INT2.
> >>Before the fix: Linux cannot get timer interrupts on INT0, goes for ACPI 
> >>timer.
> >
> >What ACPI timer?  I don't think we have any fallback for int 0.
> Sorry, Mea Culpa, I should have written APIC timer.
> >
> >Not sure what you mean with INT2. Pin2 on ioapic 0 perhaps?
> Yes. PIN2 on IOAPIC #0.
> >
> >>After the fix : Works fine. This is according to hpet spec.
> >
> >On what exact motherboard was that?
> SunFire X4600
> >
> >>To handle case 3, I removed all references to acpi_hpet_lrr, explained
> >>this case in the code and decided to solely rely on the command line
> >>parameter for LRR capability. Rational for this approach is ,
> >
> >This means the systems which you said fixes this would need the command
> >line parameter to work? 
> I feel I do not make things clear enough.
> The command line parameter can be avoided entirely if majority of the 
> BIOSes implement LRR routing correctly. I would rewrite the patch to avoid 
> cmdline parameter and according to Andrew Morton's suggestions.

But on SunFire X4600 it would need to be set to work, correct? 
I guess that would make the users of that machine unhappy because
users usually don't want to set weird parameters to make their
system boot.

Actually in theory the HPET driver should ignore the HPET if legacy
replacement is not supported and fall back to PIT.  Or are you saying
that PIT doesn't work on that system either?

Anyways I think we need some heuristics to do this all automatically
without user involvement.

-Andi


> 
> Thanks,
> Om.
