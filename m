Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUDOUTr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 16:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUDOUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 16:19:47 -0400
Received: from fmr01.intel.com ([192.55.52.18]:28054 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262106AbUDOUTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 16:19:44 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: ross@datscreative.com.au
Cc: christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       a.verweij@student.tudelft.nl, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <200404160110.37573.ross@datscreative.com.au>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1082060255.24425.180.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Apr 2004 16:17:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 11:10, Ross Dickson wrote:
> On Wednesday 14 April 2004 11:02, Len Brown wrote:
> > Re: IRQ0 XT-PIC timer issue
> > 
> > Since the hardware is connected to APIC pin0, it is a BIOS bug
> > that an ACPI interrupt source override from pin2 to IRQ0 exists.
> > 
> > With this simple 2.6.5 patch you can specify "acpi_skip_timer_override"
> > to ignore that bogus BIOS directive.  The result is with your
> > ACPI-enabled APIC-enabled kernel, you'll get IRQ0 IO-APIC-edge timer.
> > 
> > Probably there is a more clever way to trigger this workaround
> > automatcially instead of via boot parameter.

> Hi Len, I have updated my nforce2 patches for 2.6.5 to work with your patch.
> I have tested them only on one nforce2 board Epox 8Rga+ but as little has
> changed in core functionality from past releases I think all will be OK....
> Hopefully no clock skew. I saw none on my system but thats no guarantee.

While I don't want to get into the business of maintaining
a dmi_scan entry for every system with this issue, I think
it might be a good idea to add a couple of example entries
for high volume systems for which there is no BIOS fix available.

Got any opinions on which system to use as the example?
I'll need the output from dmidecode for them.
 
> I tried your above patch with the timer_ack on as is default in 2.6.5 and
> nmi_watchdog=1 failed as expected. I still think Maciej's 8259 ack patch 
> is more complete solution to the ack issue but this one gets watchdog going for
> nforce2. I cannot see anyone using your above patch without an integrated
> apic and tsc so I cannot see a problem triggering it off your kern arg.

"acpi_skip_timer_override" is specific to IOAPIC mode,
since that is the only place that the bogus interrupt
source override is used.

I'm not clued-in on the nmi_watchdog and 8259 ack issues.
My focus is primarily the ACPI issues involved in getting
these systems up and running in IOAPIC mode.

> The second patch is the C1halt update I suggested in another posting.
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/1707.html

Clearly this hang issue is more important than the timer issue.
I'm impressed that you built such a sophisticated patch without
any support from the vendors.  But it would be a "really good thing"
if we got some input from the vendors before considering putting
a workaround into the upstream kernel -- for they may have
guidance which would either simplify it, or make it unnecessary.
Perhaps Allen Martin at nVidia can comment?

-Len



