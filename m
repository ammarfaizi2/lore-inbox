Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJTREU>; Sat, 20 Oct 2001 13:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRJTREK>; Sat, 20 Oct 2001 13:04:10 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:27280 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S273783AbRJTREA>;
	Sat, 20 Oct 2001 13:04:00 -0400
Date: Sat, 20 Oct 2001 10:03:17 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC:  New Driver Model for 2.5
To: Patrick Mochel <mochelp@infinity.powertie.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <0f2f01c15989$1de93960$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <Pine.LNX.4.21.0110180754060.16868-100000@marty.infinity.powertie.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a lot of agreement that having some
explicit representation of the device tree will help do the
power management better.  That's something USB has
so far not done; there's no current hook from the host
controller drivers (HCDs) to power manage devices.
(But then, there's no HCD layer yet either.  Each HCD
duplicates a lot of code, though there's work afoot to
change that.)

It might be appropriate to have, for example, the USB
portions of the device tree handle hub parent/child style
relationships.  Hubs can't be resumed after their children,
and so on.  Likewise it's no good telling devices they
should attempt remote wakeups unless all the hubs they
are connected to can wake up their parent devices, too;
no bus-powered hubs can be in that part of the tree.

And better standards for device naming and identification
are IMO good ... that'll improve diagnostics, and with a
bit of care we can finally have reasonably "stable" names.
Again, with USB the hub parent/child relationships are
more stable than the bus addresses that get assigned;
they can be used to distinguish the numerous devices
that don't have serial numbers (or for which the serial
numbers aren't really unique).

- Dave


