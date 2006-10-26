Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422891AbWJZJYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWJZJYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWJZJYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:24:32 -0400
Received: from science.horizon.com ([192.35.100.1]:16461 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1422891AbWJZJYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:24:32 -0400
Date: 26 Oct 2006 05:24:30 -0400
Message-ID: <20061026092430.25816.qmail@science.horizon.com>
From: linux@horizon.com
To: johnstul@us.ibm.com, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: 2.6.19-rc2 and very unstable NTP
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There have been a bunch of changes to timekeeping since 2.6.17, and I've
noticed that, with 2.6.19-rc2 + linuxpps, I'm getting some impressively
unstable oscillations in the local time.  +/- 350 us, when, given a
good quality local PPS source, it should be wiggling +/- a few us.
And the shape of the curves is not "wander" but "overcorrecting wildly".

It's sort of series of exponential decay curves, but each one overshoots
by 100%, and then before it fully flattens out, starts surging in the
other direction.   (Actually, the overshoot amplitudes fluctuate
erratically, too.)  As best I can render it in ASCII art:


*                      *                      *
                    *                      *
                  *                      *
                 *                      *
 *              *       *              *

               *                      *
  *                      *
--------------*----------------------*-----------
   *                      *

    *        *             *        *
     *                      *
      *                      *
        *                      *
           *                      *

600-700 us p-p, with 2200-2400 s per full cycle.

It looks like ajtimex() isn't doing what NTP is expecting,
leading to loop instability.


I'm going to git bisect this, although it's a bit time-consuming
waiting to see if things will settle own cleanly after each reboot.
And some of the patches have been anything but one-liners, so
that's not necessarily a direct pointer to the problem.

I know there have been a number of reports of ntp timekeeping
problems with 2.6.18.  Has there been any progress already?

(Local system: AMD64 uniprocessor, 2.6.19-rc2+linuxpps kernel,
NTP 4.2.2, Acutime 2000 GPS clock + PPS input.)
