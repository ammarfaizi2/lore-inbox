Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265775AbUBJIsg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 03:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265776AbUBJIsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 03:48:36 -0500
Received: from pool-64-222-172-33.man.east.verizon.net ([64.222.172.33]:53700
	"EHLO samoyed.wuff.dhs.org") by vger.kernel.org with ESMTP
	id S265775AbUBJIsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 03:48:33 -0500
Subject: Re: HT CPU handling - 2.6.2
From: Hod McWuff <hod@wuff.dhs.org>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1076397803.4105.900.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8B98@hdsmsx402.hd.intel.com>
	 <1076391435.4103.730.camel@dhcppc4>
	 <1076395641.2246.5.camel@siberian.wuff.dhs.org>
	 <1076397803.4105.900.camel@dhcppc4>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1076402910.2577.3.camel@siberian.wuff.dhs.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 03:48:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK then the heck with the flag... am I to understand that there is in
fact a partial CPU on the die? (LAPIC but no other logic?) Or is the
second CPU instance there and real but administratively disabled?

You've been very helpful Mr. Brown but I fear you might be under orders
to tell me the party line. I want to know, regardless of disabled flags
and burnt wires, what if any vestige of a second CPU exists on that
particular piece of silicon in my other room.

On Tue, 2004-02-10 at 02:23, Len Brown wrote:
> no.  the disabled flag is a reflection of wires inside the processor. 
> You could pop the cap and ion-beam edit the die, or buy an HT-enabled
> processor.  The later would be somewhat more cost effective;-)
> 
> cheers,
> -Len
> 
> On Tue, 2004-02-10 at 01:47, Hod McWuff wrote:
> > OK, the BIOS setting is disabled and cannot be changed, so the message
> > won't get cleaned up that way. I could of course disable SMP in my
> > kernel, but that really doesn't address anything.
> > 
> > What I'm wondering is, if the second "CPU" appears to exist but is
> > merely marked disabled, who cares about the BIOS flag? Why couldn't the
> > disable flag be cleared or ignored?
> > 
> > Couldn't the ACPI/APIC/SMP code just cope with the odd LAPIC ID somehow?
> > 
> > On Tue, 2004-02-10 at 00:37, Len Brown wrote:
> > > Your BIOS is reporting the 2nd CPU as disabled, and telling us that it
> > > has LAPIC id 0x81 = 129.  The ACPI table code prints this out and
> > > registers the processor anyway, but that chokes because the LAPIC ID is
> > > way out of bounds.
> > > 
> > > I'm thinking that ACPI should not register a processor that the BIOS
> > > marked as disabled...
> > > 
> > > What should you do?  Apparently you've got an HT-enabled platform, BIOS,
> > > and OS, but do not have an HT-enabled processor.  Your choices are to
> > > disable HT in the BIOS SETUP to clean up this message, or plug in an
> > > HT-enabled processor.
> > > 
> > > cheers,
> > > -Len
> > > 
> > > On Mon, 2004-02-09 at 15:44, Hod McWuff wrote:
> > > > I've got a 2.0A GHz P4, advertised as non-hyperthread, that seems to
> > > > be
> > > > reporting the presence of a second CPU. It also seems to be disabled
> > > > by
> > > > setting bit 7 of its ID. I've tried compiling with support for 130
> > > > CPU's
> > > > and nothing changed. What would have to be done to get this disabled
> > > > CPU half back online?
> > > > 
> > > > Feb  9 04:45:03 pug ACPI: Local APIC address 0xfee00000
> > > > Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> > > > Feb  9 04:45:03 pug Processor #0 15:2 APIC version 20
> > > > Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81]
> > > > disabled)
> > > > Feb  9 04:45:03 pug Processor #129 invalid (max 16)
> > > > Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> > > > Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe
> > > > linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > > 
> > > 
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
