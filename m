Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264646AbSLGSWG>; Sat, 7 Dec 2002 13:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264653AbSLGSWG>; Sat, 7 Dec 2002 13:22:06 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:55953 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S264646AbSLGSWD> convert rfc822-to-8bit; Sat, 7 Dec 2002 13:22:03 -0500
Message-ID: <3DF23E0F.6BA703B8@attbi.com>
Date: Sat, 07 Dec 2002 13:29:35 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
CC: linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] The alternate Posix timers patch7
References: <200212071713.gB7HDdv09557@linux.local> <3DF231E8.60703@kolumbus.fi>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Penttilä wrote:
> 
> Just out of curiosity, how does the "sharing the local APIC timer" work
> with the SMP local APIC timer scheme. Hopefully not disable periodic
> timer tick on that cpu totally...?
> 
> --Mika

Hi Mike,

Here is how I wire into the timer interrupt:

   inline void smp_local_timer_interrupt(struct pt_regs * regs)
   {
        int cpu = smp_processor_id();
 
	if (!run_posix_timers((void *)regs))
                return;
        ... the original code continues.

I keep an in kernel Posix style timer queued for each cpu at
HZ frequency.  If this timer has expired run_posix_timers returns
true and the normal local timer processing is done.

The code is not perfect yet.  I don't honour changes in the 
profiling multiplier.

Jim Houston - Concurrent Computer Corp.
