Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131802AbRACPZB>; Wed, 3 Jan 2001 10:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131195AbRACPYw>; Wed, 3 Jan 2001 10:24:52 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:12166 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S130172AbRACPYi>; Wed, 3 Jan 2001 10:24:38 -0500
Date: Wed, 03 Jan 2001 06:57:23 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Prerelease kernel will not hotplug a USB host-controller when it
 isinserted into a Cardbus slot.
To: Miles Lane <miles@megapathdsl.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Message-id: <032e01c07595$7be8b8c0$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <3A53187B.9030601@megapathdsl.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am writing to let you know that in all test12-pre6+ kernels,
> I get a "Bad PCI invocation" error when hotplug attempts to
> handle the insertion of a USB host-controller into a Cardbus
> slot.

That's new info ... you'd previously thought that it wasn't even
invoking /sbin/hotplug!

The scripts I know about will produce that message when they're
invoked without PCI_CLASS set.  That's a sanity check which was
needed for the intial PCI hotplug support, which wouldn't pass
that info -- needed to hotplug devices using class drivers, such
as USB host controllers.

But they'll also dump all the arguments and environment of
hotplug before they get that far, if you set DEBUG=yes; please
enable that and let us know the whole environment that's getting
passed !

- Dave

p.s. Re that patch Andrew mentioned, it shouldn't have made
    a difference unless "PCI_CLASS=%04X" truncated the top
    eight bits of the class (it's 24 bits, not 16:  8 bits
    each of class, subclass, prog-if.)  That would have had a
    different failure mode:  only class 0 devices (pci.ids
    says is "unclassified" devices) would PCI hotplug.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
