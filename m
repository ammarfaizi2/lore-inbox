Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUIBVF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUIBVF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUIBVDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:03:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62205 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268846AbUIBU6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:58:32 -0400
Message-ID: <4137896E.5080802@mvista.com>
Date: Thu, 02 Sep 2004 13:58:22 -0700
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
References: <87smcf5zx7.fsf@devron.myhome.or.jp>	<20040816124136.27646d14.akpm@osdl.org>	<Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>	<412285A5.9080003@mvista.com>	<1092782243.2429.254.camel@cog.beaverton.ibm.com>	<Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>	<1092787863.2429.311.camel@cog.beaverton.ibm.com>	<1092781172.2301.1654.camel@cube>	<1092791363.2429.319.camel@cog.beaverton.ibm.com>	<Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>	<20040819191537.GA24060@elektroni.ee.tut.fi>	<20040826040436.360f05f7.akpm@osdl.org>	<Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>	<Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>	<1093916047.14662.144.camel@cog.beaverton.ibm.com>	<Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de> <87fz61yf75.fsf@devron.myhome.or.jp>
In-Reply-To: <87fz61yf75.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Tim Schmielau <tim@physik3.uni-rostock.de> writes:
> 
> 
>>However, the actual reason were just missing wall_to_monotonic 
>>initializations:
>>
>>  http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.2/1330.html
> 
> 
> Sorry for may not be related question in this thread.
> 
> 
>          xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);
> 
> #include <stdio.h>
> 
> #define HZ 1000
> #define NSEC_PER_SEC (1000000000L)
> #define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))
> 
> int main()
> {
> 	printf("%ld\n", (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ));
> 	return 0;
> }
> 
> hirofumi@devron (a)[1006]$ ./c
> 296000000
> 
> xtime.tv_nsec was not 0. Is this bug?

Well, my machine says the result should be 996000000, so something is wrong with 
your or my math.  As to if the initial jiffie value should be a multiple of HZ, 
I don't see why.  I think it is several counts off of this value when the system 
wall clock is set in any case.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

