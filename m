Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261581AbSJPWN1>; Wed, 16 Oct 2002 18:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261580AbSJPWN1>; Wed, 16 Oct 2002 18:13:27 -0400
Received: from [207.34.103.174] ([207.34.103.174]:46838 "EHLO cdlsystems.com")
	by vger.kernel.org with ESMTP id <S261579AbSJPWNX>;
	Wed, 16 Oct 2002 18:13:23 -0400
Message-ID: <0d9501c27562$64609050$2c0e10ac@frinkiac7>
From: "Mark Cuss" <mcuss@cdlsystems.com>
To: <linux-kernel-owner+mcuss=40cdlsystems.com@vger.kernel.org>
Cc: <jamesclv@us.ibm.com>, <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1021016135105.150A-100000@chaos.analogic.com> <200210161228.58897.jamesclv@us.ibm.com> <0d3901c2754c$7bf17060$2c0e10ac@frinkiac7> <3DADD064.8010707@rackable.com>
Subject: Re: Kernel reports 4 CPUS instead of 2...
Date: Wed, 16 Oct 2002 16:21:37 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Return-Path: mcuss@cdlsystems.com
Reply-To: mcuss@cdlsystems.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that some part of Red Hat 8 was at fault.

I installed Red Hat 7.3 and compiled a custom 2.4.19 kernel.

Speaking of the previous compile test:  The dual PIII 1 Gig box took 9.2s to
compile my test block of code...  The new Dual Xeon 2.2 now takes 4.26 s
(with hyperthreading.  Its about 1/2 a second slower without) - thats better
than double.  I'm not sure if its just the kernel that was running slower on
Red Hat 8, or maybe gcc 3.2 is just a lot slower than 2.96...



Thanks to everyone for your help

Mark

----- Original Message -----
From: "Samuel Flory" <sflory@rackable.com>
To: <mcuss@cdlsystems.com>
Cc: <jamesclv@us.ibm.com>; <root@chaos.analogic.com>;
<linux-kernel@vger.kernel.org>
Sent: Wednesday, October 16, 2002 2:47 PM
Subject: Re: Kernel reports 4 CPUS instead of 2...


> Mark Cuss wrote:
>
> >Speaking of performance.... :)
> >
> >Has anyone done any testing on a dual CPU configuration like this?  I've
> >been testing this box with both the RedHat 8 Stock Kernel
(2.4.18.something)
> >and 2.4.19 from kernel.org.  Currently, I can't make the thing perform
> >anywhere near as fast as my Dual PIII 1 Ghz box (running 2.4.7 for the
last
> >325 days...) .  I've been compiling the same block of code on both the
> >machines and comparing the times.  The PIII box is around 7 s, while the
new
> >Xeon Box is 13 or 14s...
> >
> >My thinking was that since the CPUs are much faster, and the FSB is
faster,
> >and the disk controller is faster, that the computer would be faster.
> >
> >The hardware is obviously faster, I'm sure its just something I've done
> >wrong in the kernel configuration...  If anyone has any advice or words
of
> >wisdom, I'd really appreciate them...
> >
> >
>
>    Try shutting off hyperthreading in the bios.  Keep in mind
> hyperthreading is net loss if you are running a single nonthreaded app.
>  Also you might want to check if there aren't io speed issues.
>
>   A good way to see the effects positive effects of hyperthreading is a
> kernel compile.  A "make -j 4 bzImage" should be much much faster on the
> Xeon system with hyperthreading than a P3.
>
> >
> >Mark
> >
> >----- Original Message -----
> >From: "James Cleverdon" <jamesclv@us.ibm.com>
> >To: <root@chaos.analogic.com>; "Samuel Flory" <sflory@rackable.com>
> >Cc: "Mark Cuss" <mcuss@cdlsystems.com>; <linux-kernel@vger.kernel.org>
> >Sent: Wednesday, October 16, 2002 1:28 PM
> >Subject: Re: Kernel reports 4 CPUS instead of 2...
> >
> >
> >
> >
> >>On Wednesday 16 October 2002 10:54 am, Richard B. Johnson wrote:
> >>
> >>
> >>>On Wed, 16 Oct 2002, Samuel Flory wrote:
> >>>
> >>>
> >>>>>On Wed, 16 Oct 2002, Mark Cuss wrote:
> >>>>>
> >>>>>This is the correct behavior. If you don't like this, you can
> >>>>>swap motherboards with me ;) Otherwise, grin and bear it!
> >>>>>
> >>>>>
> >>>>  Wouldn't it be easier just to turn off the hypertreading or jackson
> >>>>tech option in the bios ;-)
> >>>>
> >>>>
> >>>Why would you ever want to turn it off?  You paid for a CPU with
> >>>two execution units and you want to disable one?  This makes
> >>>no sense unless you are using Windows/2000/Professional, which
> >>>will trash your disks and all their files if you have two
> >>>or more CPUs (true).
> >>>
> >>>
> >>No, you're thinking of IBM's Power4 chip, which really does have two CPU
> >>
> >>
> >cores
> >
> >
> >>on one chip, sharing only the L2 cache.
> >>
> >>The P4 hyperthreading shares just about all CPU resources between the
two
> >>threads of execution.  There are only separate registers, local APIC,
and
> >>some other minor logic for each "CPU" to call its own.  All execution
> >>
> >>
> >units
> >
> >
> >>are demand shared between them.  (The new "pause" opcode, rep nop,
allows
> >>
> >>
> >one
> >
> >
> >>half to yield resources to the other half.)
> >>
> >>That's why typical job mixes only get around 20% improvement.  Even
> >>
> >>
> >optimized
> >
> >
> >>benchmarks, which run only integer code on one side and floating point
on
> >>
> >>
> >the
> >
> >
> >>other only get around a 40% boost.  The P4 just doesn't have all that
many
> >>execution units to go around.  Future chips will probably do better.
> >>
> >>
> >>
> >>>Cheers,
> >>>Dick Johnson
> >>>Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> >>>The US military has given us many words, FUBAR, SNAFU, now ENRON.
> >>>Yes, top management were graduates of West Point and Annapolis.
> >>>
> >>>
> >>--
> >>James Cleverdon
> >>IBM xSeries Linux Solutions
> >>{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
> >>
> >>-
> >>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>Please read the FAQ at  http://www.tux.org/lkml/
> >>
> >>
> >>
> >
> >
> >
> >
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

