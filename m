Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129550AbRBRU54>; Sun, 18 Feb 2001 15:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129586AbRBRU5q>; Sun, 18 Feb 2001 15:57:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22022 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129550AbRBRU5k>;
	Sun, 18 Feb 2001 15:57:40 -0500
Date: Sun, 18 Feb 2001 21:57:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Andries.Brouwer@cwi.nl
Cc: chief@bandits.org, johnsom@orst.edu, linux-kernel@vger.kernel.org
Subject: Re: Changes to ide-cd for 2.4.1 are broken?
Message-ID: <20010218215727.D6593@suse.de>
In-Reply-To: <UTC200102182032.VAA132602.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200102182032.VAA132602.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Feb 18, 2001 at 09:32:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18 2001, Andries.Brouwer@cwi.nl wrote:
>     > +               /*
>     > +                * If not using Mt Fuji extended media tray reports,
>     > +                * just return TRAY_OPEN since ATAPI doesn't provide
>     > +                * any other way to detect this...
>     > +                */
>     >                 if (sense.sense_key == NOT_READY) {
>     > -                       /* ATAPI doesn't have anything that can help
>     > -                          us decide whether the drive is really
>     > -                          emtpy or the tray is just open. irk. */
>     > -                       return CDS_TRAY_OPEN;
>     > +                       if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
>     > +                               return CDS_NO_DISC;
>     > +                       else
>     > +                               return CDS_TRAY_OPEN;
>     >                 }
>     > 
>     > My tray is open as I type, and it is misreported as CDS_NO_DISC. In
>     > 2.4.0 it worked fine.
> 
>     Your drive is broken, the only other valid combination is 0x3a/0x02
>     which means no media and tray open. You could try and dump the asc
>     and ascq to see what your drive reports for the different states.
> 
> Ha Jens - must we disagree twice on one evening?

:-)

> You know all about this stuff, so probably I am mistaken.
> However, my copy of SFF8020-r2.6 everywhere has
> "Sense 02 ASC 3A: Medium not present" without giving
> subcodes to distinguish Tray Open from No Disc.
> So, it seems to me that drives built to this spec will not have
> nonzero ASCQ.

Right, old ATAPI has 3a/02 as the only possible condition, so we
can't really tell between no disc and tray open. I guess the safest
is to just keep the old behaviour for !ascq and report open.

-- 
Jens Axboe

