Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbWEOVta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbWEOVta (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbWEOVta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:49:30 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:30605 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965259AbWEOVt3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:49:29 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: =?iso-8859-15?q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Subject: Re: rt20 scheduling latency testcase and failure data
Date: Mon, 15 May 2006 14:49:20 -0700
User-Agent: KMail/1.9.1
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
References: <200605121924.53917.dvhltc@us.ibm.com> <200605131106.16864.dvhltc@us.ibm.com> <1147692048.3970.21.camel@frecb000686>
In-Reply-To: <1147692048.3970.21.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605151449.21398.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 May 2006 04:20, Sébastien Dugué wrote:
> On Sat, 2006-05-13 at 11:06 -0700, Darren Hart wrote:
> > These tests are running on a 4 way opteron at 2 GHz with 4 GB RAM.  I
> > have attached the .config and a listing of all the rt tasks running on
> > the system (which addresses the questions regarding priority setup, IRQ
> > handlers, and softirqs - all default).  I am running with the futex
> > priority based wakeup patches from Sebastien Duque, but I don't think
> > this test excercises those paths.
>
>   Which watchdog are you using here? Have you tried without the
> watchdog?

Those are the softlockup watchdog threads (kernel/softlockup.c).  They run 
once a second and reports a bug if the watchdog failed to run in 10 seconds.  
It is difficult to reproduce but at run 126 (1,260,000 iterations) it finally 
failed.  Note that I am only counting runs that completely miss an entire 
period as a failure for the purposes of this test.  I want to knock out the 
10+ms latencies before I concern myself too much with the >100us failures :-)

--------------------
ITERATION 26
--------------------
-------------------------------
Scheduling Latency
-------------------------------

Running 10000 iterations with a period of 5 ms
Expected running time: 50 s

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------


PERIOD MISSED!
     scheduled delta:     4076 us
        actual delta:    14892 us
             latency:    10815 us
---------------------------------------
      previous start: 18365818 us
                 now: 18366739 us
     scheduled start: 18360000 us
next scheduled start is in the past!


Start Latency:  106 us: FAIL
Min Latency:      8 us: PASS
Avg Latency:      4 us: PASS
Max Latency:   10818 us: FAIL
Failed Iterations: 1


It's interesting, this 10ms latency seems to be the most common result.  I'm 
going to take a look at ingo's tracing script now, more info a bit later...

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team

