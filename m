Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268444AbTBYWo3>; Tue, 25 Feb 2003 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268449AbTBYWo3>; Tue, 25 Feb 2003 17:44:29 -0500
Received: from fmr01.intel.com ([192.55.52.18]:28382 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S268444AbTBYWnh> convert rfc822-to-8bit;
	Tue, 25 Feb 2003 17:43:37 -0500
content-class: urn:content-classes:message
Subject: RE: Scheduling with Hyperthreading
Date: Tue, 25 Feb 2003 13:21:31 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1901048557@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Scheduling with Hyperthreading
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcLdEaCdxTzJ20kDEde/HgBQi2jWFgAAL+gw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Mike Sullivan" <mike.sullivan@alltec.com>,
       "Mark Hahn" <hahn@physics.mcmaster.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 25 Feb 2003 21:21:32.0537 (UTC) FILETIME=[DE698690:01C2DD13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is the nature of this jobs that you are running?
1) Just the continuous computations from the user land
2) computations mixed with some system calls, i/o or some other of sleep
wakeups.

My guess at this moment is that it is the former one. With that kind of
a load, one can easily get stuck in this "bad" situation with 2 jobs
running on the same package. And as these processes doesn't sleep or get
scheduled out, they continue to run on the same CPUs, mostly trying to
use any cache affinity in those CPUs.

2.4.20 has code in place to take care of load as in 2 above. When trying
to find the best CPU to schedule in a process (while waking up from
sleep), it actually looks at idle package v/s idle logical processor.


Thanks,
-Venkatesh

> -----Original Message-----
> From: Mike Sullivan [mailto:mike.sullivan@alltec.com] 
> Sent: Tuesday, February 25, 2003 1:01 PM
> To: Mark Hahn; linux-kernel
> Subject: Re: Scheduling with Hyperthreading
> 
> 
>   Mark
> 
> I would to a quick snap with top, and when I saw 99.9% I 
> assumed the the 
> process had
> been there during the time top was starting up.
> 
> Looking at /proc/(pid)/cpu, shows that with two jobs running they are 
> sticking to cpu 0 and 1
> which are siblings
> 
> 
>                                                               
>           
>                                                               
>           
> Regards
>                                                               
>           
>                                                               
>           Mike
> 
> Mark Hahn wrote:
> 
> >>that if I run two compute intensive jobs on a Dual Xeon, 
> the processes 
> >>run on separate
> >>physical cpus and can spend a significant amount of time 
> with both on a 
> >>single
> >>cpu.
> >>    
> >>
> >
> >how did you determine this?  running another program, such as top,
> >will naturally disturb the scheduler and corrupt any observations.
> >the only means I can think of is to look in /proc/<pid>/cpu near
> >very infrequently (ideally, just before the processes exit.)
> >or is this what you've done?
> >  
> >
> 
> -- 
> ----------------------------------------------------------------------
> Mike Sullivan                           Director Performance Computing
> @lliance Technologies,                  Voice: (416) 385-3255, 
> 18 Wynford Dr, Suite 407                Fax:   (416) 385-1774
> Toronto, ON, Canada, M3C-3S2            Toll Free:1-877-216-3199
> http://www.alltec.com
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
