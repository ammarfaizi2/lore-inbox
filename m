Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUHQUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUHQUxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268426AbUHQUxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:53:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:28413 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266721AbUHQUxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:53:03 -0400
Message-ID: <41227018.8090008@mvista.com>
Date: Tue, 17 Aug 2004 13:52:40 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Courtier-Dutton <James@superbug.demon.co.uk>
CC: Albert Cahalan <albert@users.sourceforge.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       johnstul@us.ibm.com, david+powerix@blue-labs.org
Subject: Re: boot time, process start time, and NOW time
References: <1087948634.9831.1154.camel@cube>	 <87smcf5zx7.fsf@devron.myhome.or.jp>	 <20040816124136.27646d14.akpm@osdl.org>	 <Pine.LNX.4.53.0408170055180.14122@gockel.physik3.uni-rostock.de>	 <412151CA.4060902@mvista.com> <1092695544.2301.1227.camel@cube>	 <41215EDA.3070802@mvista.com> <1092697717.2301.1233.camel@cube> <41216566.8040206@superbug.demon.co.uk>
In-Reply-To: <41216566.8040206@superbug.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> Albert Cahalan wrote:
> 
>>>>
>>>>
>>>> That's userspace, which works fine on a 2.4.xx kernel.
>>>> If userspace were to change, it wouldn't work OK for
>>>> a 2.4.xx kernel anymore. So consider that cast in stone.
>>>>
>>>> "now" is the time() function. Using gettimeofday()
>>>> would only make sense if I decided to pay the cost
>>>> of asking for the time every time I look at a task.
>>>>
> 
> While on the subject of time, is it possible to get a monotonic timer 
> with 1ms or better resolution?
> We need this for linux multimedia applications, and it is used to sync 
> audio and video. Currently we use gettimeofday(). If a movie is playing, 
> and the user goes and changes the time, or changes the timezone, we do 
> not want that to effect the movie playing. I have not been able to find 
> a monotonic 1ms accurate timer in the linux kernel, that is available to 
> applications, and has little overhead. Some efficient ioctl or function 
> call for uptime to 1ms accuracy would do perfectly.

If all you want is the time try
clock_gettime(CLOCK_MONOTONIC, struct time_spec *tv)

Should work fine on 2.6.x kernels.  This is good to what ever the fine structure 
is on the box, e.g. TCP cycles on most x86 or pm_timer cycles on some, in any 
case it is good to better than a micro second.
> 
   If you want a timer, look into the posix clocks & timers which were added at 
2.6.
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

