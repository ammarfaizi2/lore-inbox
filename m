Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284254AbRLGRdA>; Fri, 7 Dec 2001 12:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282916AbRLGRci>; Fri, 7 Dec 2001 12:32:38 -0500
Received: from air-1.osdl.org ([65.201.151.5]:37517 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S284204AbRLGRcY>;
	Fri, 7 Dec 2001 12:32:24 -0500
Date: Fri, 7 Dec 2001 09:35:20 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Cory Bell <cory.bell@usa.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: IRQ Routing Problem on ALi Chipset Laptop (HP Pavilion N5425)
In-Reply-To: <1007688442.6675.8.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112070925280.851-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey there.

On 6 Dec 2001, Cory Bell wrote:

> On Thu, 2001-12-06 at 17:03, Randy.Dunlap wrote:
> > Hi-
> >
> > Did your search for "$PIR" or "RIP$" ?
> > It is suppsed to be the latter (little-endian).
>
> Tried both. The flash BIOS update might be reading system specific stuff
> and then appending it to the new update, though. Maybe they have
> separate "code" and data areas, and the the data part never gets
> overwritten.
>
> Would you happen to have any thoughts or advice WRT the problem we have
> and the proper method of addressing it? Absent a BIOS fix, of course,
> which I imagine would be the ultimate solution.

How new is this system?

If it's new (3-6 months) PCI IRQ information is probably encoded in ACPI
AML methods. OEMs are gradually changing from the old way (PIRQ and MP
tables, APM) to new Grand Unified Way(tm) (ACPI).

For a while now, BIOSes have shipped with both old tables and ACPI tables,
and in a lot of cases, one or the other lies. So, you're almost lucky in a
sense. Unfortunately, it doesn't solve your problem.

For some reason, the people that wrote the spec encoded PCI IRQ
information in AML (ACPI Machine Language), instead of putting them in a
flat table. Which means you need the interpretor up and running and you
need to execute those methods (don't ask, just nod and smile).

The Intel ACPI guys kinda have this working. They are able to extract and
execute the methods. But, they still have yet to make devices request and
use that information. Maybe Andy Grover can comment on this..

BTW, The latest ACPI patch is at: http://sourceforge.net/projects/acpi/.

	-pat

