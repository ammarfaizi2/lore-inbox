Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269781AbRHMD3y>; Sun, 12 Aug 2001 23:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269783AbRHMD3o>; Sun, 12 Aug 2001 23:29:44 -0400
Received: from lanm-pc.com ([64.81.97.118]:12282 "EHLO golux.thyrsus.com")
	by vger.kernel.org with ESMTP id <S269781AbRHMD3g>;
	Sun, 12 Aug 2001 23:29:36 -0400
Date: Sun, 12 Aug 2001 23:26:57 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: SB Live! driver controversy, some thoughts from the trenches
Message-ID: <20010812232657.A10677@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there seems to be some controversy about whether the emu10k1 driver
should have been replaced in a stable tree, let me make a few observations
from the point of view of someone who has just spent the better part of
three days chasing (and solving!) problems related to this card.

(The system configuration now seems to be in a good state.  We have been
simultaneously doing X builds, playing our Jimi Hendrix test CD and sshing
in over the LAN for some hours now without inducing a hang.)

It now appears to me that Gary Sandine and I were victimized by two distinct
problems.  One was at the driver level; that one was solved by the 2.4.8
driver update.  From the symptoms, we think it had something to do with PCI
bus timing issues.  This problem went away when the driver was unloaded.

The other problem was specific to the S2464 board or BIOS -- it was sharing
IRQs between on-board devices and the SB Live! in a way that caused 
conflicts and lockups.  This one could (and did) manifest if the card
was plugged in but the emu10k1 module had never loaded.

We have *not*, in three days of intensive testing, seen good evidence that
the new driver was producing any problems specific to SMP machines.  Early
on we thought uniprocessor kernels were immune, but that was the first
hypothesis we had to discard.

>From our point of view as people trying to get the card to actually
work on a bleeding-edge dual-processor system, the change to the 2.4.8
driver was an unequivocally good thing.  It solved our first problem,
and it unmasked the second one.

>From this particular experience and in general, I think Linus is quite
correct in preferring an unstable driver with a maintainer to an
unstable driver without one.  The advantage of a live maintainer is
sufficient that I think he would have been right to make that call
even if the new driver were *known* to be a bit flakier than the old
one -- and that wasn't the case here.

Once again, thanks to all of you who helped.  You made the critical
difference.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The danger (where there is any) from armed citizens, is only to the
*government*, not to *society*; and as long as they have nothing to
revenge in the government (which they cannot have while it is in their
own hands) there are many advantages in their being accustomed to the 
use of arms, and no possible disadvantage.
        -- Joel Barlow, "Advice to the Privileged Orders", 1792-93
