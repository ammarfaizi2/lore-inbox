Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSF1SC3>; Fri, 28 Jun 2002 14:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317474AbSF1SC2>; Fri, 28 Jun 2002 14:02:28 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40185 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317473AbSF1SC1>;
	Fri, 28 Jun 2002 14:02:27 -0400
Message-ID: <3D1CA51C.5D854BE2@mvista.com>
Date: Fri, 28 Jun 2002 11:04:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Frank van de Pol <fvdpol@home.nl>,
       "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <Pine.LNX.3.95.1020625073649.18426A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
<snip> 
> I ran my program all night on another machine and it's still running.
> Neither of these machines are trying to sync with NIST. Machines that
> are running timing daemons that attempt to sync their clocks could, of
> course, have problems with time-jumps.
> 

Me thinks it is time to fix this NIST/NTP issue.  The
problem is that we are adjusting the wall clock every 1/HZ
tick instead of adjusting the 1/HZ tick AND the
interpolation constant.  What happens is (in the X86) is
that we assume that the conversion of TSC to usec is fixed
and exact as computed at boot time.  The time sync protocols
have a more "correct" story to tell.  We need to incorporate
this information into the TSC to usec conversion so that the
wall clock correction for times between 1/HZ ticks agrees
with what is done at the tick time.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
