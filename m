Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRACVfm>; Wed, 3 Jan 2001 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbRACVfd>; Wed, 3 Jan 2001 16:35:33 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:38736 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129348AbRACVfV>; Wed, 3 Jan 2001 16:35:21 -0500
Date: Wed, 3 Jan 2001 22:35:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Cc: linux-kernel@vger.kernel.org, linux-parport@torque.net,
        tim@cyberelk.demon.co.uk
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
Message-ID: <20010103223504.L32185@athlon.random>
In-Reply-To: <m2k88czda4.fsf@ppro.localdomain> <20010103201344.A3203@athlon.random> <m2hf3gz6yc.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2hf3gz6yc.fsf@ppro.localdomain>; from peter.osterlund@mailbox.swipnet.se on Wed, Jan 03, 2001 at 10:00:59PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2001 at 10:00:59PM +0100, Peter Osterlund wrote:
> off.  Apparently the printer tells the computer it is OK to send data
> to it when it is off.

So then parport_write is probably buggy because it's losing data silenty while
the printer is off. So the below is probably a band aid. Really some printer
acts in a different way (see the LP_CAREFUL hack in 2.2.x) so it maybe that
parport_write is ok on some printer and it would need something like a
LP_CAREFUL option to work also on some other printer. Or maybe some parport
handshake is badly designed in hardware and it cannot report errors (or maybe
there's the hardware compatibility mode that cannot know about LP_CAREFUL to
workaround some printer behaviour). In such case your patch is probably the
only way to go (but almost certainly for the software compatibility mode it
should be possible to report errors via parport_write as we do in 2.2.x).

> I also only get one DMA write timeout when putting the printer in
> offline mode during sending, instead of repeated timeouts as I got
> with the previous patch.

I see, it makes sense to try to parport_write only when errors goes away, but I
think it's nicer to have lp_error or lp_check_status that loops internally in
interruptible mode if LP_ABORT isn't set via lptune. probably the code should
be restructured a bit.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
