Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbRBDIdA>; Sun, 4 Feb 2001 03:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129049AbRBDIcv>; Sun, 4 Feb 2001 03:32:51 -0500
Received: from dnvrdslgw14poolB96.dnvr.uswest.net ([63.228.85.96]:63859 "EHLO
	q.dyndns.org") by vger.kernel.org with ESMTP id <S129043AbRBDIci>;
	Sun, 4 Feb 2001 03:32:38 -0500
Date: Sun, 4 Feb 2001 01:32:40 -0700 (MST)
From: Benson Chow <blc@q.dyndns.org>
To: <linux-kernel@vger.kernel.org>
Subject: ACPI weirdness in 2.4.1 ? (!!)
Message-ID: <Pine.LNX.4.31.0102040100300.2478-100000@q.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is odd:

System:
AMD AthlonThunderbird 850, Chaintech 7AIA MB

Seems 2.4.0 isn't affected (dmesg related to ACPI:)

ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enabled
ACPI: System firmware supports: C2
ACPI: System firmware supports: S0 S1 S4 S5

Seems 2.4.1 wasn't affected the first time I tried it, but each subsequent
time it has (dmesg related to ACPI:)

ACPI: Core Subsystem version [20010125]
ACPI: Subsystem enabled
ACPI: System firmware supports: C2 C3                    <- NEW!!!?!
ACPI: System firmware supports: S0 S1 S4 S5

(seems acpi changed in 2.4.0-2.4.1.  and suddenly my hardware supports
C3 whereas in 2.4.0 it doesn't???)

Basically, the 2.4.1 kernel boots pretty quickly just like 2.4.0 - until
it gets to initialize ACPI at the end of kernel init.  Then things run
VERY slowly.  I mean, 10 minutes to boot to text login, as if I were
running a 386.  Worse than that, maybe - keyboard presses take a second
to echo.  It seems when I then start running a task that takes 100% CPU
time, it becomes quite a bit more responsive.  Once I kill that process,
it becomes really slow once more.  Of course wasting the cycles on that
process probably isn't the correct solution...

The strange thing is that the first time I booted 2.4.1, I could have
sworn it booted fine.  Then I tried running acpid (acpid-071100.tar.gz)
and tried the power button and by golly it worked very nicely.  Then the
subsequent boots just took forever.  I tried 2.4.0 again, and that runs
fine, and even acpid works fine too.  Very strange... could some ACPI
register not gotten cleared out or something?  Or set improperly?  Thus
I'm reverting to 2.4.0.

I compiled 2.4.1 with RH7's gcc-2.96-69 and kgcc egcs-2.91.66 (same
results with either compiler), 2.4.0 with RH7's gcc-2.96-54 (ok, bad, but
it actually works ok ... weird.)

I might be barking up the wrong tree on this, because since I was mucking
with acpi, this was the first thing to come to mind as the culprit...

Thanks for any insights.

-bc



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
