Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970795-12281>; Mon, 4 May 1998 14:41:44 -0400
Received: from ppp-116-2.villette.club-internet.fr ([194.158.116.2]:1105 "EHLO localhost.localdomain" ident: "groudier") by vger.rutgers.edu with ESMTP id <971062-12281>; Mon, 4 May 1998 14:33:47 -0400
Date: Mon, 4 May 1998 20:23:21 +0200 (MET DST)
From: Gerard Roudier <groudier@club-internet.fr>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Rik van Riel <H.H.vanRiel@phys.uu.nl>, MOLNAR Ingo <mingo@chiara.csoma.elte.hu>, linux-kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: New pre-patch (Re: [PATCH] kswapd fully sysctl tunable)
In-Reply-To: <Pine.LNX.3.95.980503175650.632Z-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.980504200048.547A-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


On Sun, 3 May 1998, Linus Torvalds wrote:

> Note that the apic code really isn't SMP-specific at all, and is valid on
> its own. It does have a strong link to SMP mainly because the MP table
> contains the PCI routing information, but even that really isn't a SMP
> issue. 
> 
> So if somebody feels interested, it might be a good idea to split up the
> _real_ SMP code from the code that should be merely "CONFIG_APIC". That
> would give it more wider testing - and the newer APIC makes sense even on
> UP if for no other reason than the fact that is is much lower latency. 

Interesting, indeed.

Just an idea:
Very low interrupt latency can make interrupt go ahead posted memory 
write. I would suggest to check if all PCI device drivers do read an IO
register from the device in order to flush posted write just before
looking at the data.

A correct construct should look like the following:

read STATUS register
If interrupt condition
     clear interrupt condition
  -> READ a device IO register in order to force posted write flush.
     look at the data written to memory by the PCI device.

Note that if the interrupt condition is cleared by an IO register read, 
the additional READ is not needed, otherwise it should be IMHO.


Gerard.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
