Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbQLUKka>; Thu, 21 Dec 2000 05:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131041AbQLUKkK>; Thu, 21 Dec 2000 05:40:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57611 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130315AbQLUKkA>;
	Thu, 21 Dec 2000 05:40:00 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012211007.eBLA7ad25114@flint.arm.linux.org.uk>
Subject: Re: set_rtc_mmss: can't update from 0 to 59
To: p_gortmaker@yahoo.com (Paul Gortmaker)
Date: Thu, 21 Dec 2000 10:07:36 +0000 (GMT)
Cc: mdharm-kernel@one-eyed-alien.net (Matthew Dharm), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <3A41CD4F.1259FB08@yahoo.com> from "Paul Gortmaker" at Dec 21, 2000 04:28:47 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker writes:
> It smells like policy in the kernel to me.  What if a user wants to run NTP
> but wants the CMOS RTC time as an independent clock to do something else
> (possibly with the option of having a meaningful /etc/adjtime too) ?

NTP and adjtime are synomonous - NTP uses the adjtimex call to adjust the
local clock.  Therefore, when running NTP, leave adjtime well alone
(unless you want to break NTP).  You either use NTP or adjtime, not both.

> Can't the people who want the current behaviour simply have a crontab
> that runs (hw)clock -[u]w from util-linux at whatever interval they want?

And how do you handle the situation where NTP hasn't synchronised, and
therefore the local hardware clock should not be updated?  Sometimes
the hardware clock is higher precision than the kernels idea of time
(ok, not in cheap PCs).
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
