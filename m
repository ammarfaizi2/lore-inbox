Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131690AbQLRKec>; Mon, 18 Dec 2000 05:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130490AbQLRKeW>; Mon, 18 Dec 2000 05:34:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61710 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131753AbQLRKeG>;
	Mon, 18 Dec 2000 05:34:06 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012180846.eBI8kNY20521@flint.arm.linux.org.uk>
Subject: Re: set_rtc_mmss: can't update from 0 to 59
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Mon, 18 Dec 2000 08:46:23 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <20001217194737.C11947@one-eyed-alien.net> from "Matthew Dharm" at Dec 17, 2000 07:47:37 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dharm writes:
> Ahh... I think I see.  While the math says "if the diference between the
> real time and the cmos time is less than 30 min", it doesn't recognize that
> the time difference between 2:59 and 3:00 is only 1 min.

Which is intentional.

> True enough...  but, the question is, how do we fix this?

Why do you think it needs fixing?

Think about what happens when the current time according to the CMOS is
2:59:00 and Linux thinks its 3:01:20.  We only write the minutes and
seconds, so if we did write, the CMOS clock then becomes 2:01:20.
Oops, we just lost an hour.  Next time you reboot, you'll find the
time out by an hour or more depending on how many corrections of this
type have been done.

So, why don't we update the hours and be done with it?  We would have to
play the same game with the days of the month vs hours.  Also, we don't
know if the CMOS clock is programmed for UTC time or not (the kernel's
idea of time is UTC.  Your CMOS may be programmed for EST for instance).
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
