Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S.rD889161028>; Fri, 14 May 1999 18:24:11 -0400
Received: by vger.rutgers.edu id <S.rD1ov413859>; Fri, 14 May 1999 11:11:55 -0400
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:46114 "EHLO rrzs2.rz.uni-regensburg.de") by vger.rutgers.edu with ESMTP id <S.rCvP2185134>; Fri, 14 May 1999 01:38:12 -0400
From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: linux-kernel@vger.rutgers.edu
Date: Fri, 14 May 1999 08:22:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: for review: PPS API implementation (2.2.7)
X-mailer: Pegasus Mail for Windows (v3.01d)
Message-ID: <1339160249FA@rkdvmks1.ngate.uni-regensburg.de>
Sender: owner-linux-kernel@vger.rutgers.edu
X-UIDL: 926720645.427649.27459

Hello,

I have put PPSkit-0.7-pre3.diff.gz, a patch against Linux 2.2.7, on 
linux.kernel.org/pub/linux/daemons/ntp/PPS.

The patch implements (as most of you know already) nanosecond time 
resolution, updated NTP algorithms,AND an implementation of the  
Internet draft for a PPS API.

The PPS API is a portable interface to event timing. Specifically you 
can get rising and falling edges of some signal with high accuracy 
(getting a struct timespec). I have implemented it for the serial 
port's carrier detect input.

I have also implemented the time_pps_wait() function. As it is my 
first try to do scheduling, wait_queue and interrupt stuff, I'd 
kindly ask some guru to have a look at the code. For me it just seems 
to work.

In addition I have an other issue: The routines to fetch the 
timestamp disable interrupts to ensure that the timestamp is 
consistent. Now if you busily poll for events, interrupts are 
disabled frequently (for a short while). This will reduce the 
accuracy of the time stamps. Now I wonder if I can or should use 
spinlocks instead. IMHO they could smooth things a bit. But is it 
safe for an interrupt service routine?

For those who prefer had numbers:
My Pentium-100 can resolve time up to roughly 2us. With a GPS 
reference with a nominal accuracy of 250ns ntpd-4.0.92h says after 
some time "estimated error 0 us". If fact the peak estimate was 17ns, 
but more realistic is 800ns, and 5us is easy to get. (Now you can 
compare with your numbers)

In addition three new POSIX.4 functions (clock_gettime, 
clock_settime, clock_getres) are ready to be made available to 
applications. They are used already internally.

With version 0.7 of PPSkit I have fulfilled all the plans for this 
year.  A remaining issue is precision timing for SMP, but I don't 
have the hardware nor experience.

Those maintainers of non-i386 architectures are kindly requested to 
try the patch and (preferredly) submit patches, fixes, contributions, 
...

I think the stuff is very close to be integrated into the mainstream 
kernel.

Regards,
Ulrich
P.S. Please CC: replies as I'm not subscribed to this list


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
