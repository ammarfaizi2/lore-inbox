Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbTHUJZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbTHUJZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:25:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:6135 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262604AbTHUJZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:25:25 -0400
Message-ID: <3F449001.5030905@mvista.com>
Date: Thu, 21 Aug 2003 02:25:21 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@linuxtestproject.org>
CC: lkml <linux-kernel@vger.kernel.org>,
       ltp-results <ltp-results@lists.sourceforge.net>, linstab@osdl.org
Subject: Re: LTP nightly regression results for	2.6.0-test3-bk2,bk3,bk5,bk6,bk7,mm3,mjb1
References: <1061415052.3909.1733.camel@plars>
In-Reply-To: <1061415052.3909.1733.camel@plars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> 
> Here's the latest batch of LTP test results for the latest 2.6 bk
> snapshots and mm/mjb trees.  These results and previous results are
> archived at: http://developer.osdl.org/dev/ltp/results/

The failure in alarm03, which by the way is only some times, is caused 
by the need to add a jiffie to the alarm time to cover the fact that 
the current time is not on a jiffie boundry.  If this was not done, 
the timer would expire early about 50% of the time.  Given this 
correction the timer will expire some where between the requested time 
and the requested time + one jiffie.  alarm(2), dealing with seconds, 
is bumping the return value by one when ever the return is not an even 
second, thus the 1 second longer than requested result.

In short, the test should allow the return value to be one higher than 
requested.
-g
> 
> Thanks,
> Paul Larson
> 
> 2.6.0-test3-bk1-vs-2.6.0-test3-bk2
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk1-vs-2.6.0-test3-bk2/
> Test Name      2.6.0-test3-bk1    2.6.0-test3-bk2     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> nanosleep02    FAIL               FAIL                    N            N
> setegid01      FAIL               PASS                    N            Y
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> 
> 2.6.0-test3-bk2-vs-2.6.0-test3-bk3
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk2-vs-2.6.0-test3-bk3/
> Test Name      2.6.0-test3-bk2    2.6.0-test3-bk3     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> gettimeofday   PASS               FAIL                    Y            N
> nanosleep02    FAIL               FAIL                    N            N
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> syslog04       PASS               FAIL                    Y            N
> 
> *** bk4 failed to compile, but the failure was quickly fixed in bk5 ***
> 
> 2.6.0-test3-bk3-vs-2.6.0-test3-bk5
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk3-vs-2.6.0-test3-bk5/
> Test Name      2.6.0-test3-bk3    2.6.0-test3-bk5     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> gettimeofday   FAIL               PASS                    N            Y
> nanosleep02    FAIL               FAIL                    N            N
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> syslog04       FAIL               FAIL                    N            N
> 
> 2.6.0-test3-bk5-vs-2.6.0-test3-bk6
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk5-vs-2.6.0-test3-bk6/
> Test Name      2.6.0-test3-bk5    2.6.0-test3-bk6     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> nanosleep02    FAIL               FAIL                    N            N
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> syslog04       FAIL               PASS                    N            Y
> 
> 2.6.0-test3-bk6-vs-2.6.0-test3-bk7
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-bk6-vs-2.6.0-test3-bk7/
> Test Name      2.6.0-test3-bk6    2.6.0-test3-bk7     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> gettimeofday   PASS               FAIL                    Y            N
> nanosleep02    FAIL               FAIL                    N            N
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> syslog04       PASS               FAIL                    Y            N
> 
> 2.6.0-test3-mm2-vs-2.6.0-test3-mm3
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-mm2-vs-2.6.0-test3-mm3/
> Test Name      2.6.0-test3-mm2    2.6.0-test3-mm3     Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> nanosleep02    FAIL               FAIL                    N            N
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> 
> 2.6.0-test3-vs-2.6.0-test3-mjb1
> http://developer.osdl.org/dev/ltp/results/2.6.0-test3-vs-2.6.0-test3-mjb1/
> Test Name      2.6.0-test3        2.6.0-test3-mjb1    Regression  Improvement
> -----------------------------------------------------------------------------
> alarm03        FAIL               FAIL                    N            N
> getgroups03    FAIL               FAIL                    N            N
> nanosleep02    FAIL               FAIL                    N            N
> setegid01      FAIL               PASS                    N            Y
> swapoff01      FAIL               FAIL                    N            N
> swapoff02      FAIL               FAIL                    N            N
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

