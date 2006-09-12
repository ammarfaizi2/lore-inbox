Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWILSRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWILSRP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWILSRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:17:15 -0400
Received: from alnrmhc11.comcast.net ([206.18.177.51]:49365 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030312AbWILSRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:17:13 -0400
Subject: Re: ACPI: Idle Processor PM Improvements
From: Jim Gettys <jg@laptop.org>
Reply-To: jg@laptop.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jordan Crouse <jordan.crouse@amd.com>, "Brown, Len" <len.brown@intel.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       ACPI ML <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>, devel@laptop.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
In-Reply-To: <20060912092100.GC19482@elf.ucw.cz>
References: <EB12A50964762B4D8111D55B764A845484D316@scsmsx413.amr.corp.intel.com>
	 <20060830194317.GA9116@srcf.ucam.org>
	 <200608311713.21618.bjorn.helgaas@hp.com>
	 <1157070616.7974.232.camel@localhost.localdomain>
	 <20060904130933.GC6279@ucw.cz>
	 <1157466710.6011.262.camel@localhost.localdomain>
	 <20060906103725.GA4987@atrey.karlin.mff.cuni.cz>
	 <20060906145849.GE2623@cosmic.amd.com>  <20060912092100.GC19482@elf.ucw.cz>
Content-Type: text/plain
Organization: OLPC
Date: Tue, 12 Sep 2006 14:14:30 -0400
Message-Id: <1158084871.28991.489.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 11:21 +0200, Pavel Machek wrote:

> Ok, so what is needed is message to X "we are suspending", and X needs
> to respond "okay, I'm ready, no need for console switch".

This presumes an external agent to X controlling the fast
suspend/resume, with messages having to flow to and from X, and to and
from the kernel, with the kernel in the middle.

Another simpler option is X itself just telling the kernel to suspend
without console switch, as the handoff of the display to the DCON chip
has to be done with X and with an interrupt signaling completion of the
handoff.  This would be triggered by an inactivity timeout in the X
server.

I'm not sure which is best right now: generality vs. simplicity.  We
just got samples of hardware to do some prototyping on in the last two
weeks. (see wiki.laptop.org for photographs of our screen and the DCON
in action).

> 
> Alternatively, hack kernel to take control from X without actually
> switching consoles. That should be possible even with current
> interface.

This would require saving/restoring all graphics state in the kernel
(and X already has that state internally).  Feasible, but seems like
duplication of effort.  I haven't checked if there are any write-only
registers in the Geode (though, thankfully, this kind of brain damage is
rarer than it once was).  This then begs interesting kernel/X
synchronization issues, of course.
                                     - Jim


> 								Pavel
-- 
Jim Gettys
One Laptop Per Child


