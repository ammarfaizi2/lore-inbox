Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271150AbTHLVOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTHLVOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:14:48 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2435 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S271150AbTHLVOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:14:37 -0400
Subject: Re: PCI parallel card causes erratic timekeeping? (2.4.21)
From: john stultz <johnstul@us.ibm.com>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030810072647.GU6464@dbz.icequake.net>
References: <20030810072647.GU6464@dbz.icequake.net>
Content-Type: text/plain
Organization: 
Message-Id: <1060722814.10732.1416.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Aug 2003 14:13:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-08-10 at 00:26, Ryan Underwood wrote:
> In the ISA slot, up until recently, we had a dual parallel port card
> that was attached to the network printers.  However, the printers and
> the card were fried in a storm recently; luckily, the server survived.
> We replaced the card with a dual PCI parallel port card (Netmos
> NM9715CV) and the printers are now working fine.
> 
> However, a new problem emerged.  The software clock of the system is
> crazy!  Sometimes it is very fast, other times very slow.  NTP
> constantly loses synchronization, and since this machine is also a
> Kerberos KDC, Kerberos tickets are flakey. :(  This problem exists
> independently of whether a driver is loaded for the card or not; if it
> is in the system at all, the clock runs screwy.  If I remove the card,
> the clock is back to normal as far as I can tell.

[snip]

> Can simply inserting a card generally make a system clock act screwy
> like this?  Should I try to find a different card?

Sounds like the card is blocking the timer interrupt from being handled.
This would cause a loss in time as well as time inconsistencies. I'm a
bit curious about time running too fast, though. It could be NTP trying
to compensate for the slowness and then overcompensates if the card
stops misbehaving. Its also possible calibrate_tsc is being confused by
the card's funkyness. It would be interesting to see what Bogomips is
being reported as the system acts up.

Sounds like a bad card to me. 

thanks
-john




