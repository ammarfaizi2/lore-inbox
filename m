Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLSVoq>; Tue, 19 Dec 2000 16:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLSVof>; Tue, 19 Dec 2000 16:44:35 -0500
Received: from waste.org ([209.173.204.2]:60256 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S129352AbQLSVoZ>;
	Tue, 19 Dec 2000 16:44:25 -0500
Date: Tue, 19 Dec 2000 15:13:03 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: set_rtc_mmss: can't update from 0 to 59
In-Reply-To: <200012180846.eBI8kNY20521@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.30.0012191510570.18938-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Russell King wrote:

> Matthew Dharm writes:
> > Ahh... I think I see.  While the math says "if the diference between the
> > real time and the cmos time is less than 30 min", it doesn't recognize that
> > the time difference between 2:59 and 3:00 is only 1 min.
>
> Which is intentional.
>
> > True enough...  but, the question is, how do we fix this?
>
> Why do you think it needs fixing?
>
> Think about what happens when the current time according to the CMOS is
> 2:59:00 and Linux thinks its 3:01:20.  We only write the minutes and
> seconds, so if we did write, the CMOS clock then becomes 2:01:20.
> Oops, we just lost an hour.  Next time you reboot, you'll find the
> time out by an hour or more depending on how many corrections of this
> type have been done.
>
> So, why don't we update the hours and be done with it?  We would have to
> play the same game with the days of the month vs hours.  Also, we don't
> know if the CMOS clock is programmed for UTC time or not (the kernel's
> idea of time is UTC.  Your CMOS may be programmed for EST for instance).

Sounds like its still broken then - there are time zones which are not
even multiples of 60 minutes.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
