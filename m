Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318391AbSGYJ6l>; Thu, 25 Jul 2002 05:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318396AbSGYJ6l>; Thu, 25 Jul 2002 05:58:41 -0400
Received: from spirit.qbfox.com ([212.67.200.51]:4881 "EHLO spirit.qbfox.com")
	by vger.kernel.org with ESMTP id <S318391AbSGYJ6d>;
	Thu, 25 Jul 2002 05:58:33 -0400
Message-Id: <200207251001.LAA04512@spirit.qbfox.com>
From: Per Gregers Bilse <bilse@qbfox.com>
Date: Thu, 25 Jul 2002 11:01:43 +0100
In-Reply-To: <3D3EF711.19FAB352@mvista.com>
Organization: qbfox
X-Mailer: Mail User's Shell (7.2.2 4/12/91)
To: george anzinger <george@mvista.com>
Subject: Re: 2.4.18 clock warps 4294 seconds
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 24, 11:50am, george anzinger <george@mvista.com> wrote:
> missed 2.68 (or so) seconds worth of ticks.  At the warp
> back, it would NOT make them up, however the ntp code should
> notice and start a correction sequence.  To confirm this you
> might look at the ntp logs, AND/OR you could modify the test

This is indeed happening.  I've been puzzled by both machines
suffering from repeated loss of NTP synch, here's from the logs:

/var/log/messages.4:Jun 24 06:52:14 wraith ntpd[24927]: synchronisation lost
/var/log/messages.4:Jun 25 04:13:44 wraith ntpd[24927]: synchronisation lost
/var/log/messages.4:Jun 25 07:19:06 wraith ntpd[24927]: synchronisation lost
/var/log/messages.4:Jun 25 12:35:14 wraith ntpd[24927]: synchronisation lost
/var/log/messages.4:Jun 25 12:38:42 wraith ntpd[24927]: synchronisation lost
/var/log/messages.4:Jun 26 14:24:30 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jun 30 21:02:45 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  1 14:18:47 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  1 14:24:12 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  1 20:13:25 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  2 22:45:52 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  3 01:12:24 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  3 12:23:15 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  3 16:46:18 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  3 18:19:17 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  3 23:51:23 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  4 04:08:52 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  4 19:38:39 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  5 10:04:17 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  6 06:08:25 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  6 20:07:39 wraith ntpd[24927]: synchronisation lost
/var/log/messages.3:Jul  7 00:44:08 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul  7 12:26:35 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul  8 01:21:44 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul  8 12:49:24 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul  8 12:58:11 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul  8 16:16:52 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul  8 23:19:42 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul 10 03:22:27 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul 10 03:40:45 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul 10 05:12:57 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul 10 11:20:37 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul 10 11:24:05 wraith ntpd[24927]: synchronisation lost
/var/log/messages.2:Jul 13 10:09:24 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 17:09:57 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 17:31:27 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 19:14:15 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 19:43:14 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 20:26:19 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 20:37:12 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 17 21:04:03 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 19 13:02:30 wraith ntpd[24927]: synchronisation lost
/var/log/messages.1:Jul 19 19:29:56 wraith ntpd[24927]: synchronisation lost
/var/log/messages:Jul 23 05:24:06 wraith ntpd[24927]: synchronisation lost
/var/log/messages:Jul 23 19:28:54 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 24 01:18:13 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 24 06:39:41 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 24 14:47:58 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 24 14:52:34 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 24 16:28:00 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 24 22:10:54 wraith ntpd[690]: synchronisation lost
/var/log/messages:Jul 25 00:17:05 wraith ntpd[690]: synchronisation lost

I don't think I'm really losing genuine NTP synch:

     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
 LOCAL(0)        .LCL.            0 l    3   64  377    0.000    0.000   0.015
-bow.qbfox.com   Time4.Stupi.SE   2 u 1005 1024  377    0.015   73.062  17.196
-spur.qbfox.com  chronos.EU.net   2 u  218 1024  377    0.015   45.572  26.202
-chronos.EU.net  .GPS.            1 u  38m  68m  377   24.867   30.629  72.573
*Time1.Stupi.SE  .PPS.            1 u  58m  68m  377  116.053   43.776  20.203
-Time2.Stupi.SE  .PPS.            1 u 2035  68m  377  109.794   76.732  83.159
+Time3.Stupi.SE  Time2.Stupi.SE   2 u  58m  68m  377  112.871   40.217  35.787
+Time4.Stupi.SE  .PPS.            1 u  58m  68m  377  109.851   40.490  28.328
-veracity.mcc.ac swisstime.ee.et  2 u  59m  68m  337   24.609  -36.300  12.049
#ice.mcc.ac.uk   swisstime.ee.et  2 u  38m  68m  237    9.838   34.553  79.622
 ntp0.teletext.n 71.80.83.0       2 u  38m  68m  377    9.917   25.972 5780.24
#fnbhs.com       ntp0.mcs.anl.go  2 u  38m  68m  377  204.931  -27.539 126.563
#triangle.kansas navobs1.wustl.e  2 u  36m  68m  377  142.747   33.596  73.565
#cisco1-mhk.kans navobs1.wustl.e  2 u  38m  68m  377  139.877   34.206  72.558
#lovenun.maineco prowlingtabby.m  2 u  38m  68m  377  369.278  -60.517  18.498
#ns1.usg.edu     navobs1.gatech.  2 u  38m  68m  377   98.843   35.825  78.009
#tock.CS.unlv.ed usno.pa-x.dec.c  2 u  38m  68m  377  379.879  -71.831  22.986
#thor.capfed1.si rdu163-37-160.n  3 u  68m  68m  377  239.856  -51.136   3.906
#augean.eleceng. murgon.cs.mu.OZ  2 u  38m  68m  377  349.874   31.117  80.168
#WWW.UREGINA.CA  CLOCK.UREGINA.C  2 u  38m  68m  377  321.107  -43.573   0.314
#ns.keso.fi      ntp-cup.externa  2 u  36m  68m  377   89.870   44.390  65.048
#ns2.keso.fi     swisstime.ee.et  2 u  65m  68m  337   80.688  -41.038   5.025
-zen.via.ecp.fr  horlogegps.rese  2 u  38m  68m  377   31.053   34.715   2.282
-fartein.ifi.uio swisstime.ee.et  2 u  59m  68m  377   55.164  -41.223  11.385
#alpha.prao.psn. ntp0-rz.rrze.un  2 u 2042  68m  377  101.028   39.420  83.563
#maverick.mcc.ac ntp1.ja.net      2 u  38m  68m  377   18.858   59.411 176.100

(I turned into a bit of an NTP aficionado after having ported NTPv4 while
working at Cisco a couple of years ago.-)  I'm on a leased line into
the MAE-East equivalent in London, so I don't think it will be network
issues causing NTP synch loss.  Also notice nearly all NTP peers having
full reachability -- "reach" is in octal, it's 8 bits shifting left
indicating whether or not a reply was received at each "poll" interval.

I've added some debug to arch/i386/kernel/time.c:

[root@vulpes kernel]# diff -c time.c.orig time.c
*** time.c.orig	Thu Jul 25 10:36:41 2002
--- time.c	Thu Jul 25 10:39:10 2002
***************
*** 83,88 ****
--- 83,90 ----
  
  spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
  
+ static unsigned long glob_eax;
+ 
  static inline unsigned long do_fast_gettimeoffset(void)
  {
  	register unsigned long eax, edx;
***************
*** 94,99 ****
--- 96,107 ----
  	/* .. relative to previous jiffy (32 bits is enough) */
  	eax -= last_tsc_low;	/* tsc_low delta */
  
+ 	if ( eax > 5000000 ) {
+ 		glob_eax = eax;
+ 		return delay_at_last_interrupt;
+ 	}
+ 
+ 
  	/*
           * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
           *             = (tsc_low delta) * (usecs_per_clock)
***************
*** 286,291 ****
--- 294,304 ----
  
  	tv->tv_sec = sec;
  	tv->tv_usec = usec;
+ 
+ 	if ( glob_eax != 0 ) {
+ 		printk("do_gettimeofday eax %lu\n",glob_eax);
+ 		glob_eax = 0;
+ 	}
  }
  
  void do_settimeofday(struct timeval *tv)
[root@vulpes kernel]# 


Ie, set flag/value in do_fast_gettimeoffset(), check/print in
do_gettimeofday().  I figure that should catch it if it happens
again, and safely so.

Thanks for your note.

  -- Per

