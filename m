Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbRAWHhu>; Tue, 23 Jan 2001 02:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAWHhl>; Tue, 23 Jan 2001 02:37:41 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:51985 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S135304AbRAWHhc>; Tue, 23 Jan 2001 02:37:32 -0500
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Date: Tue, 23 Jan 2001 08:37:30 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: patch: 2.4.0/2.5.0: nanoseconds time resolution
CC: linux-kernel@vger.kernel.org
Message-ID: <3A6D42BD.17942.244B3D@localhost>
In-Reply-To: <200101230355.f0N3tQU24971@saturn.cs.uml.edu>
In-Reply-To: <3A6BF8F9.26580.FB55D37@localhost> from "Ulrich Windl" at Jan 22, 2001 09:10:29 AM
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2001, at 22:55, Albert D. Cahalan wrote:

> > Therefore I put together a simple "hacking document" (see attachment) 
> > to guide you when trying to port the code.  More text can be found in 
> > Documentation/kernel-time.txt after the patch, or in the distribution 
> > for Linux 2.2 (PPSkit-1.0.2.tar*) So please spend an hour or two to 
> > help me out there. I hope I'm not forced to drop the project.
> 
> URL for the patch? BTW, this is something for the 2.5.xx series.

The URL for the patch is on top of the hacking document, thinking that 
those who don't read it won't need the URL.

Yes the patch is intended for 2.5 if you all want it. However it 
applies to 2.4.0 for those who need it right now. As stated it requires 
some extra work that can't be done by myself alone.

> 
> > * time is kept in nanoseconds.
> 
> Nice, I'd imagine. Would that be 64-bit nanoseconds since 1970?

Compatibility: Just using timespec instead of timeval at the user-level.
Seconds are still 32bit on 32 bit machines.

> 
> > `do_fast_gettimeoffset()' is replaced
> >   with `do_exact_nanotime()' that returns nanoseconds passed since
> >   occurrence of the last timer interrupt. `do_slow_gettimeoffset()' is
> >   replaced with `do_poor_nanotime()' accordingly.
> 
> Ugh. Those names are awful. Why would anyone use do_poor_nanotime()
> when they could have something better?

That's exactly the point: For a i486 you must use the timer's counter 
register to interpolate between interrupts, but for the Pentium you can 
use the cycle counter of the CPU. When making a kernel for a 
distribution, you can't know whether the system will have a Pentium, so 
the decision is made during boot. (Just as it was before)

The old naming put stress on speed of the routines (I guess), while I 
put stress on the accuracy. So "poor" means "poor accuracy".

> 
> > * Updating the RTC is controlled by new variables: `rtc_update_slave',
> >   when non-zero, controls after how many seconds the RTC has to be
> >   updated. Internally `last_rtc_update' keeps the time of the last
> >   update.  Upon update the `rtc_update_slave' is cleared on success.
> 
> What about leap seconds on network and non-UNIX filesystems?  >:-)

You mean to say that a leap second is an implicit time update? I can 
Implement it without any trouble, if you all can agree that the idea is 
acceptable. BTW: Same applies for RTCs using local time, and we switch 
from/to DST: The kernel doesn't have the tables, so you (or cron) must 
update the /proc/sys/kernel/time/timezone.

I'd be glad if these were the only problems you had. ;-)

Regards,
Ulrich

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
