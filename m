Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129404AbRBRUdE>; Sun, 18 Feb 2001 15:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129485AbRBRUcy>; Sun, 18 Feb 2001 15:32:54 -0500
Received: from hera.cwi.nl ([192.16.191.8]:46054 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129404AbRBRUcp>;
	Sun, 18 Feb 2001 15:32:45 -0500
Date: Sun, 18 Feb 2001 21:32:32 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102182032.VAA132602.aeb@vlet.cwi.nl>
To: axboe@suse.de, chief@bandits.org
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
Cc: johnsom@orst.edu, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Jens Axboe <axboe@suse.de>

    On Sat, Feb 17 2001, John Fremlin wrote:
    > Specifically, this part:
    > 
    > @@ -2324,11 +2309,17 @@
    >                     sense.ascq == 0x04)
    >                         return CDS_DISC_OK;
    >  
    > +
    > +               /*
    > +                * If not using Mt Fuji extended media tray reports,
    > +                * just return TRAY_OPEN since ATAPI doesn't provide
    > +                * any other way to detect this...
    > +                */
    >                 if (sense.sense_key == NOT_READY) {
    > -                       /* ATAPI doesn't have anything that can help
    > -                          us decide whether the drive is really
    > -                          emtpy or the tray is just open. irk. */
    > -                       return CDS_TRAY_OPEN;
    > +                       if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
    > +                               return CDS_NO_DISC;
    > +                       else
    > +                               return CDS_TRAY_OPEN;
    >                 }
    > 
    > My tray is open as I type, and it is misreported as CDS_NO_DISC. In
    > 2.4.0 it worked fine.

    Your drive is broken, the only other valid combination is 0x3a/0x02
    which means no media and tray open. You could try and dump the asc
    and ascq to see what your drive reports for the different states.

Ha Jens - must we disagree twice on one evening?
You know all about this stuff, so probably I am mistaken.
However, my copy of SFF8020-r2.6 everywhere has
"Sense 02 ASC 3A: Medium not present" without giving
subcodes to distinguish Tray Open from No Disc.
So, it seems to me that drives built to this spec will not have
nonzero ASCQ.

Andries
