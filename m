Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRADBK0>; Wed, 3 Jan 2001 20:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbRADBKQ>; Wed, 3 Jan 2001 20:10:16 -0500
Received: from fep01.swip.net ([130.244.199.129]:53952 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP
	id <S129436AbRADBKF>; Wed, 3 Jan 2001 20:10:05 -0500
Date: Thu, 4 Jan 2001 02:09:56 +0100 (CET)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, <linux-parport@torque.net>,
        <tim@cyberelk.demon.co.uk>
Subject: Re: Printing to off-line printer in 2.4.0-prerelease
In-Reply-To: <20010104014115.C6256@athlon.random>
Message-ID: <Pine.LNX.4.30.0101040158310.3983-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Andrea Arcangeli wrote:

: I'm worried somebody needed to disable LP_CAREFUL to print, probably
: it's not a big deal to keep it.

I removed it because otherwise I would have had to do twice as many tests
to convince myself that all combinations of flags and printer states
worked correctly. I can reinsert it if you think that's necessary. But
then I don't think the tunelp man page and the comments in the kernel
should say that it is obsolete. I think obsolete means "you should never
ever have to use this stuff".

: However parport_write can still could silenty discard data, but maybe
: it can't notice errors with some handshake.

At least with my printer, it only discards data when it is powered off. If
you power off the printer between the times when lp_wait_ready returns and
parport_write is called, I think it is ok to lose data. After all, if the
power off had occurred a few ms later, the data would already have been in
the printer when it was powered off, and then you would have lost data
anyway.

: I didn't checked the details of the DMA based handshake so Tim needs
: to comment if this can be considered a final/right fix (I hope it's
: not ;).

I don't understand the lowlevel parport details, so I can not comment on
this.

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
