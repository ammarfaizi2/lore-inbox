Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbRAaWZT>; Wed, 31 Jan 2001 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129386AbRAaWZC>; Wed, 31 Jan 2001 17:25:02 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:63249 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129351AbRAaWY5>; Wed, 31 Jan 2001 17:24:57 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE61D@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: RE: ACPI fix + comments
Date: Wed, 31 Jan 2001 14:23:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem the diff below fixes is a BIOS issue - the _STA control method
should always be returning a value, but in this case it doesn't. The
approach we're taking is "get everything working and THEN worry about broken
ACPI implementations" and hopefully in the meantime, people will release
fixed BIOSs ;-).

> And working around error in running sta makes it actually
> usefull. This is ugly workaround, should not be applied to official
> tree.
[snip]

> And now questions: Why are numbers reported in hexadecimal? Reporting
> voltage in hexadecimal is nice nonsense to me...

This is a temporary interface, just to see if we're returning values
properly. Your points below are well taken. People really care about
minutes/percentage remaining. In your opinion should we just report that
through /proc or should we keep the data low-level like it is now, and have
a user app do the math, or what?

> I believe that we should keep description: value format, and switch to
> decimal. Plus, units are nonsensical in some cases:
> 
> Remaining Capacity: 59a
> 		    ~~~ should be in mAh, probably

[snip]

> PS: What should be difference between _info and _status? Both contain
> fields that change with time...

*info corresponds with the _BIF control method, and *status with _BST. I
thought _BIF stuff is static - is it not?

Regards -- Andy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
