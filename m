Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946024AbWJ0F6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946024AbWJ0F6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 01:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946032AbWJ0F6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 01:58:00 -0400
Received: from styx.suse.cz ([82.119.242.94]:13519 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1946024AbWJ0F57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 01:57:59 -0400
Date: Fri, 27 Oct 2006 07:57:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andi Kleen <ak@muc.de>
Cc: Om Narasimhan <om.turyx@gmail.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, randy.dunlap@oracle.com,
       clemens@ladisch.de, bob.picco@hp.com
Subject: Re: HPET : Legacy Routing Replacement Enable - 3rd try.
Message-ID: <20061027055708.GA20270@suse.cz>
References: <EB12A50964762B4D8111D55B764A8454C9608C@scsmsx413.amr.corp.intel.com> <6b4e42d10610251420x4365b840sa3232010e7bd7f73@mail.gmail.com> <20061027024238.GC58088@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061027024238.GC58088@muc.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 04:42:38AM +0200, Andi Kleen wrote:

> On Wed, Oct 25, 2006 at 02:20:22PM -0700, Om Narasimhan wrote:
> > I tested against five different bioses (some with 8132, some with
> > CK-804 ..etc) and I observed three different patterns.
> > 
> > 1. HW is LRR capable, HPET ACPI it is 1, timer interrupt is on INT2.
> > Before the fix: Linux cannot get timer interrupts on INT0, goes for ACPI 
> > timer.
> 
> What ACPI timer?  I don't think we have any fallback for int 0.
> 
> Not sure what you mean with INT2. Pin2 on ioapic 0 perhaps?
> 
> > After the fix : Works fine. This is according to hpet spec.
> 
> On what exact motherboard was that?
> 
> > 
> > To handle case 3, I removed all references to acpi_hpet_lrr, explained
> > this case in the code and decided to solely rely on the command line
> > parameter for LRR capability. Rational for this approach is ,
> 
> This means the systems which you said fixes this would need the command
> line parameter to work? 
> 
> > 1. At present, there are not many BIOSes which implement LRR (correctly)
> > 2. People would see the bootup message (MP-BIOS bug...) if LRR is
> > enabled and no timer interrupt on INT0. They can pass the hpet_lrr=1
> > to make everything work fine.
> > Is it the right approach?
> 
> Generally we try to work everywhere without command line parameter
> unless something is terminally broken. 

JFYI: The new per-cpu timekeeping code doesn't need the HPET legacy bit,
thus not replacing IRQ0 (PIT) and IRQ13 (RTC). It still can do that, but
will work just as well without it.

-- 
Vojtech Pavlik
Director SuSE Labs
