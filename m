Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSGXUKk>; Wed, 24 Jul 2002 16:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSGXUKj>; Wed, 24 Jul 2002 16:10:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20475 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317488AbSGXUKi>;
	Wed, 24 Jul 2002 16:10:38 -0400
Message-ID: <3D3F0A5E.E548C8DA@mvista.com>
Date: Wed, 24 Jul 2002 13:13:18 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nico Schottelius <nicos-mutt@pcsystems.de>
CC: Joshua Uziel <uzi@uzix.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpu speed is 165mhz instead of real 650mhz
References: <20020724110121.GA1925@schottelius.org> <20020724102709.GA17905@uzix.org> <20020724131642.GA479@schottelius.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nico Schottelius wrote:
> 
> Joshua Uziel [Wed, Jul 24, 2002 at 03:27:09AM -0700]:
> > * Nico Schottelius <nicos-mutt@pcsystems.de> [020724 02:03]:
> > > This periodicly appears in my system. The Kernel seems to misdetect the
> > > right cpu speed and then it's running only at 165mhz.
> > > I don't really understand why this happens, there's no acpi enabled, which
> > > caused this failure the last time.
> >
> > Is this a notebook computer?  Is it that you're sometimes booting it up
> > while the system is unplugged (ie. on battery)?
> 
> yes,it is, but slowing down to 500 mhz is the only  available speedstep
> option.
> 
> 165 or similar is not supported (afaik) by the bios/processor.
> 
The cpu speed is detected by comparing the TSC against the
PIT.  The PIT is used to drive the clock.  If it is wrong by
this much you should see time drifting like mad.  If the TSC
is wrong, you should see errors in the sub 1/HZ correction
applied to get_time_of_day().  You could detect this by
looping on a get_time_of_day() call and noticing that time
slides ahead 3/HZ seconds and then back each tick.  What
would be happening is that the interpolation code would be
taking the fast TSC (i.e. 500MHZ when it thought it was 165)
and be pushing time out beyond the next tick value.  Each
tick this would reset and be replayed.  If neither of these
is happening, the reported value is most likely what is
really going on.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
