Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265637AbTFXCk0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 22:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTFXCk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 22:40:26 -0400
Received: from [203.94.130.164] ([203.94.130.164]:45773 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S265637AbTFXCkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 22:40:17 -0400
Date: Tue, 24 Jun 2003 12:25:47 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] PCMCIA patches (fwd)
Message-ID: <Pine.LNX.4.44.0306241225050.30736-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


since russell doesn't want to accept my mail,
forwarded here

---------- Forwarded message ----------
Date: Tue, 24 Jun 2003 12:17:00 +1000 (EST)
From: Brett <generica@email.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CFT] PCMCIA patches


Hey,

works for me,
i82365 controller
xirc2ps_cs and 8250_cs

i still get "Trying to free nonexistent resource <000002f8-000002ff>" on 
eject/shutdown, but you can't have everything

thanks,

	/ Brett

On Mon, 23 Jun 2003, Russell King wrote:

> Ok guys,
> 
> Here's another set of PCMCIA patches to keep people occupied for a while.
> Tested sa11xx and yenta here.  Please report successes/failures.
> 
> Note: if you are using modules, you will only be able to remove the
> socket driver when the cards are ejected (by either physically removing
> the card or via cardctl eject.)  Some init scripts may get upset with
> this on shutdown; this will eventually be noted in davej's 2.6 changes
> document.  The script needs to run cardctl eject before rmmoding the
> pcmcia modules.
> 
>  drivers/pcmcia/cs.c           |  103 ++++++++++++++++++++++++------------------
>  drivers/pcmcia/i82092.c       |   46 ++----------------
>  drivers/pcmcia/i82092aa.h     |    1
>  drivers/pcmcia/i82365.c       |   75 +++---------------------------
>  drivers/pcmcia/sa11xx_core.c  |   66 +++++---------------------
>  drivers/pcmcia/sa11xx_core.h  |    3 -
>  drivers/pcmcia/tcic.c         |   48 ++-----------------
>  drivers/pcmcia/yenta_socket.c |   39 +--------------
>  drivers/pcmcia/yenta_socket.h |    5 --
>  include/pcmcia/ss.h           |    3 -
>  10 files changed, 96 insertions(+), 293 deletions(-)
> 
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-1.diff
> 
> 	Move ->owner field from socket operations to pcmcia_socket.
> 	(This change is mainly for the SA11xx drivers, which use
> 	a core driver for the chip, and a separate module for all
> 	the machine specific bits.)
> 
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-2.diff
> 
> 	Get/Put module when we insert and remove a card.  This avoids
> 	a potential deadlock when socket drivers are unloaded, and we
> 	have a cardbus card known to the system.
> 
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-3.diff
> 
> 	Remove original module use accounting in register_callback.
> 
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-4.diff
> 
> 	Add work-around for i82365-based socket drivers to the core
> 	PCMCIA code.  Since insert processing is not a time critical
> 	event, we can afford to delay (by sleeping) these for everyone.
> 
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-5.diff
> 
> 	Remove register_callback methods; allow socket drivers to call
> 	pcmcia_parse_events() directly.
> 
> http://patches.arm.linux.org.uk/pcmcia/pcmcia-event-20030623-6.diff
> 
> 	Remove now obsolete work queues, spinlocks, and code from
> 	socket drivers.
> 
> 
> 


