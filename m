Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273997AbRIYVYp>; Tue, 25 Sep 2001 17:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273995AbRIYVY0>; Tue, 25 Sep 2001 17:24:26 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:21188 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S273990AbRIYVYR>; Tue, 25 Sep 2001 17:24:17 -0400
Message-ID: <8FB7D6BCE8A2D511B88C00508B68C2081971BD@orsmsx102.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@ucw.cz>
Cc: "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ACPI sleep, proc error checking, and proc info patches
Date: Tue, 25 Sep 2001 14:24:34 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

I like the proc info and the error-checking patches. (although I think you
meant to check against proc, not proc_entry, in a few places).

I don't like the sleep problem workaround. One, because it uses DMI
information. The ACPI tables contain machine name and table version, and we
want to use that, instead of DMI information that will not necessarily be
updated when the BIOS is fixed. Two, I am extremely loathe to take
workarounds for broken BIOSes. I know we don't have a blacklist at this
point but I think having one would be cleaner - if *anything* is wrong, we
shouldn't enable ACPI.

I admit, we *do* have one workaround in the code, for the PIIX4 C3 issue.
That was a chipset problem, not an ACPI BIOS problem, and affected a huge
number of machines.

ACPI BIOS problems usually are obviously wrong code, and I have had some
success in getting vendors to fix them. If we do workarounds, vendors will
never fix it. If we politely but insistently contact them and ask nicely,
maybe they will, and if they don't, we can blacklist that table version for
that machine.

So if you implement an ACPI bios blacklist I'd probably take that.

Regards -- Andy
	
