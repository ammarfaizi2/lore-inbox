Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272449AbTHJH0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272459AbTHJH0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:26:50 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:36360 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S272449AbTHJH0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:26:49 -0400
Date: Sun, 10 Aug 2003 02:26:47 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Subject: PCI parallel card causes erratic timekeeping? (2.4.21)
Message-ID: <20030810072647.GU6464@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a strange one for the kernel time gurus out there!

We have a file server with a Intel PR440FX dual PPro mainboard (2x200Mhz
PPro CPU).  The PR440FX has 3 PCI slots and 1 PCI/ISA shared slot, in
addition to onboard PIIX3 IDE, AIC-7880 SCSI, and Intel 82557 ethernet.

In the 3 PCI slots, we have an old Matrox video card, a AHA-2940UW, and
a Promise PDC20262 ATA-66 controller card.

In the ISA slot, up until recently, we had a dual parallel port card
that was attached to the network printers.  However, the printers and
the card were fried in a storm recently; luckily, the server survived.
We replaced the card with a dual PCI parallel port card (Netmos
NM9715CV) and the printers are now working fine.

However, a new problem emerged.  The software clock of the system is
crazy!  Sometimes it is very fast, other times very slow.  NTP
constantly loses synchronization, and since this machine is also a
Kerberos KDC, Kerberos tickets are flakey. :(  This problem exists
independently of whether a driver is loaded for the card or not; if it
is in the system at all, the clock runs screwy.  If I remove the card,
the clock is back to normal as far as I can tell.

What do you all think could be causing this problem, and what other
information would I need to provide to find a solution?  The only
strange thing about that slot is that it is the only PCI slot that is
not master capable in the PR440FX.  The card received its own IRQ (19,
from the IO-APIC).

I have heard about strange problems with timekeeping on SMP machines,
but there's no problem with this box except when that card is inserted.
I checked out messing with the kernel ticks (using tickadj), but it
seems that would only help with a clock that is consistently skewed one
way or the other, not one that is as erratic as this one.

Can simply inserting a card generally make a system clock act screwy
like this?  Should I try to find a different card?

Thanks,

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
