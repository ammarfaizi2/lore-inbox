Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312325AbSDCSpT>; Wed, 3 Apr 2002 13:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312331AbSDCSpJ>; Wed, 3 Apr 2002 13:45:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:1529 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S312325AbSDCSo5>;
	Wed, 3 Apr 2002 13:44:57 -0500
Message-ID: <3CAB4D7C.29DB808D@mvista.com>
Date: Wed, 03 Apr 2002 10:44:12 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Legoll <vlegoll@apsydev.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        high-res-timers-discourse@lists.sourceforge.net
Subject: Re: Is CLOCK_REALTIME the same as the clock under gettimeofday()
In-Reply-To: <014701c1db2b$d1f537f0$820314ac@fdvlegoll01>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Legoll wrote:
> 
> After reading that message from you on lkml archive, I asked me a question:
> How would you know you have drifted more than one second, if timer expires
> after a very long time ? It'll be too late...

You are right.  I am still trying to figure out a sane way to do this. 
I suppose we could check from time to time to see what the drift is and
redo all the nanosleep abs timers if it ever drifts more than some
value.  We have to redo them when there is a gross clock set anyway, so
we do need to know how to do this.
> 
> Did I misread you ? (my english is not omnipotent)
> ---------------------------------------------------------------------------
> -----
> From: george anzinger (george@mvista.com)
> Date: Wed Mar 27 2002 - 15:50:43 EST
> 
> Another solution to this issue is to program the clock_nanosleep() calls
> to wake up a second or so prior to the requested time and then fine tune
> the wake up to happen as close as possible to the requested time. This
> calculation might take into account the current ntp drift rate.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
