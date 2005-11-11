Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbVKKWP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbVKKWP5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVKKWP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:15:57 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:51701 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751275AbVKKWP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:15:56 -0500
Message-ID: <4375181B.7060104@mvista.com>
Date: Fri, 11 Nov 2005 14:15:55 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Perches <joe@perches.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Timespec normalize off by one errors
References: <43750A1A.4010102@mvista.com> <1131744325.9957.20.camel@localhost>
In-Reply-To: <1131744325.9957.20.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches wrote:
> On Fri, 2005-11-11 at 13:16 -0800, George Anzinger wrote:
> 
>>@@ -1209,13 +1209,9 @@ static int do_posix_clock_monotonic_get(
>> 
>> 	do_posix_clock_monotonic_gettime_parts(tp, &wall_to_mono);
>> 
>>-	tp->tv_sec += wall_to_mono.tv_sec;
>>-	tp->tv_nsec += wall_to_mono.tv_nsec;
>>+	set_normalized_timespec(tp, tp->tv_sec += wall_to_mono.tv_sec,
>>+				tv_nsec += wall_to_mono.tv_nsec);
>> 
>>-	if ((tp->tv_nsec - NSEC_PER_SEC) > 0) {
>>-		tp->tv_nsec -= NSEC_PER_SEC;
>>-		tp->tv_sec++;
>>-	}
>> 	return 0;
>> }
> 
> 
> This is extremely ugly.
> 
> tp->tv_sec += wall_to_mono.tv_sec;
> tp->tv_nsec += wall_to_mono.tv_nsec;
> set_normalized_timespec(tp, tv->sec, tv_nsec);
> 
> is much more intelligible.
> 
> Besides, I think you forgot the "tp->" indirection in the
> last argument of the set_normalized_timespec.

Oh SHIT.  That is wrong.  Think I will compile the next version...  Stand by.
> 
> cheers,  Joe
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
