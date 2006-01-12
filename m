Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWALIWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWALIWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWALIWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:22:38 -0500
Received: from rrzmta2.rz.uni-regensburg.de ([132.199.1.17]:45222 "EHLO
	rrzmta2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S1751165AbWALIWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:22:37 -0500
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 12 Jan 2006 09:22:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 6/10] NTP: add time_adjust to tick_nsec
Cc: George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Message-ID: <43C61FCA.12735.FA541A8@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1137033983.2890.111.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.61.0512220024290.30918@scrub.home>
X-mailer: Pegasus Mail for Windows (4.30 public beta 1)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-P=3.98.0+V=3.98+U=2.07.112+R=03 October 2005+T=114253@20060112.081749Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think that's wrong: On the long term it doesn't make any difference, but while 
adjusting time, the increase of time changes slope every second (i.e. time will 
advance at different speed) when only adjusting the clock at the end of a second. 
A frequency error should be corrected every time the clock is read. So you can 
either do a correction frequently whenever it's needed ("tick interpolation"), or 
you do it pro-active, even when it's not needed (That's what the 
update_wall_time_one_tick() code does). In my solution I even tried to apply the 
correction between ticks, using a combination of both methods.

What you are proposing is even what we had before, and much worse what can be 
done. The old question: Do you want a fast clock, or an exact clock?

And who said that adjtime() isn't used by ntpd? "disable kernel" does exacltly 
that I think.

As always I may be wrong...

Regards,
Ulrich

On 11 Jan 2006 at 18:46, john stultz wrote:

> On Thu, 2005-12-22 at 00:25 +0100, Roman Zippel wrote:
> > This removes time_adjust from update_wall_time_one_tick() and moves it
> > to second_overflow() and adds it to tick_nsec_curr instead.
> > This slightly changes the adjtime() behaviour, instead of applying it to
> > the next tick, it's applied to the next second. As this interface isn't
> > used by ntp, there shouldn't be much users left.
> > 
> 
> This sounds reasonable to me. 
> Although CC'ing Ulrich and George for more review.
> 
> 
> Acked-by: John Stultz <johnstul@us.ibm.com>
> 
> thanks
> -john
> 
> 


