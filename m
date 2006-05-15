Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964885AbWEOLLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWEOLLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWEOLLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:11:31 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17288 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964885AbWEOLLa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:11:30 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, mista.tapas@gmx.net,
       efault@gmx.de, rostedt@goodmis.org, rlrevell@joe-job.com
In-Reply-To: <200605121924.53917.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
Date: Mon, 15 May 2006 13:15:46 +0200
Message-Id: <1147691746.3970.16.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/05/2006 13:14:28,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/05/2006 13:14:31,
	Serialize complete at 15/05/2006 13:14:31
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-05-12 at 19:24 -0700, Darren Hart wrote:
> I have been noticing unexpected intermittant large latencies.  I wrote the 
> attached test case to try and capture some information on them.  The librt.h 
> file contains convenience functions I use for writing other tests as well, so 
> much of it is irrelevant, but the test case itself is pretty clear I believe.
> 
> The test case emulates a periodic thread that wakes up on time%PERIOD=0, so 
> rather than sleeping the same amount of time each round, it checks now 
> against the start of its next period and sleeps for that length of time.  
> Every so often it will miss it's period, I've captured that data and included 
> a few of the interesting bits below.  The results are from a run with a 
> period of 5ms, although I have seen them with periods as high as 17ms.  The 
> system was under heavy network load for some of the time, but not all.
> 

  Hi Darren,

  FWIW:

  I've been running you test program on my box under a stress-kernel
load and did not observe any failure as you describe, not even a max
latency overshooting the 100 us limit (max latencies in the 60~70 us).

  I even went to decrease PERIOD to 1 ms and still no failure. 

  I'm running rt20 with the futex priority based wakeup patch on
a dual 2.8 GHz HT Xeon box. All hardirq and softirq threads are at their
default priority.

  How do you generate the network load you mention? Maybe I could try at
least with the same load you're using.

  Sébastien.

