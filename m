Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269316AbUICHfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269316AbUICHfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUICHfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:35:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28410 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S269316AbUICHb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:31:29 -0400
Message-ID: <41381DC6.8050001@mvista.com>
Date: Fri, 03 Sep 2004 00:31:18 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
References: <87smcf5zx7.fsf@devron.myhome.or.jp>	<Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>	<412285A5.9080003@mvista.com>	<1092782243.2429.254.camel@cog.beaverton.ibm.com>	<Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>	<1092787863.2429.311.camel@cog.beaverton.ibm.com>	<1092781172.2301.1654.camel@cube>	<1092791363.2429.319.camel@cog.beaverton.ibm.com>	<Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>	<20040819191537.GA24060@elektroni.ee.tut.fi>	<20040826040436.360f05f7.akpm@osdl.org>	<Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>	<Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>	<1093916047.14662.144.camel@cog.beaverton.ibm.com>	<Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>	<87fz61yf75.fsf@devron.myhome.or.jp> <4137896E.5080802@mvista.com>	<87u0uggxme.fsf@devron.myhome.or.jp> <4137C1FA.7070000@mvista.com> <87wtzct47h.fsf@ibmpc.myhome.or.jp>
In-Reply-To: <87wtzct47h.fsf@ibmpc.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> George Anzinger <george@mvista.com> writes:
> 
> 
>>>The cause of this is
>>>     INITIAL_JIFFIES % HZ (4294667296 % 1000)
>>>because INITIAL_JIFFIES is unsigned long.
>>>So, I guessed this is not intention.
>>>Looks like this should be (-300*1000) % 1000.
>>
>>What "should be"?
> 
> 
> in time_init(), and hpet_time_init(),
>         xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> should be
>         xtime.tv_nsec = ((long)INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> 
> because
> 	(INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ)		== 296000000
> and
> 	((long)INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ)	== 0

It is possible that I am missing something here, but I just don't see that it 
matters.  If the wall clock is set jiffies is not changed so there is no implied 
or actual alignment between these two.

Is there a calculation in the system that would differ if this were changed?

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

