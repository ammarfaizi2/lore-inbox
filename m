Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317623AbSGJVGz>; Wed, 10 Jul 2002 17:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSGJVGy>; Wed, 10 Jul 2002 17:06:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8433 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317623AbSGJVGx>;
	Wed, 10 Jul 2002 17:06:53 -0400
Message-ID: <3D2CA278.49BE1ADA@mvista.com>
Date: Wed, 10 Jul 2002 14:09:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> I'd like to see HZ closer to 100 than 1000, for CPU power reasons. Processor
> power states like C3 may take 100 microseconds+ to enter/leave - time when
> both the CPU isn't doing any work, but still drawing power as if it was. We
> pop out of C3 whenever there is an interrupt, so reducing timer interrupts
> is good from a power standpoint by amortizing the transition penalty over a
> longer period of power savings.
> 
> But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> these been quantified? I'd either like to see a HZ that has balanced
> power/performance, or could we perhaps detect we are on a system that cares
> about power (aka a laptop) and tweak its value at runtime?

HZ is used in a LOT of places.  I suspect "tweaking" at run
time would be a bit difficult.  

The high-res-timers patch give high resolution timers with
out changing HZ.  Interrupts are scheculed as needed,
between the 1/HZ ticks, so a quite system will have few (if
any) interrupts between the ticks.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
