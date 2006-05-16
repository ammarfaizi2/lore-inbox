Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWEPHSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWEPHSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 03:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWEPHSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 03:18:40 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:36500 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751559AbWEPHSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 03:18:40 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <200605151830.23544.dvhltc@us.ibm.com>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <200605131601.31880.dvhltc@us.ibm.com> <20060515081341.GB24523@elte.hu>
	 <200605151830.23544.dvhltc@us.ibm.com>
Date: Tue, 16 May 2006 09:22:55 +0200
Message-Id: <1147764175.3970.33.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/05/2006 09:21:38,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 16/05/2006 09:21:44,
	Serialize complete at 16/05/2006 09:21:44
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-15 at 18:30 -0700, Darren Hart wrote:
> Following Ingo's example I have included the modified test case (please see 
> the original mail for librt.h) that starts the trace before each sleep and 
> disables it after we wake up.  If we have missed a period, we print the 
> trace.
> 
 <snip>
>   The very first run 
> failed, (I've noticed that the first iteration seems to always hit PERIOD 
> MISSED! while the second usually passes fine).

  I've noticed also that, on some occasions, the first run would fail,
but subsequent runs would be fine. Strange!

  I finally managed to hit a missed period under heavy heavy load:

Running 100000 iterations with a period of 5 ms
Expected running time: 500 s

ITERATION DELAY(US) MAX_DELAY(US) FAILURES
--------- --------- ------------- --------
      211        70            97        0

PERIOD MISSED!
     scheduled delta:     3128 us
        actual delta:     3191 us
             latency:       62 us
---------------------------------------
      previous start:  1055070 us
                 now:  1060172 us
     scheduled start:  1060000 us
next scheduled start is in the past!


Start Latency:  198 us: FAIL
Min Latency:      6 us: PASS
Avg Latency:      0 us: PASS
Max Latency:     97 us: PASS
Failed Iterations: 0


  I'll try to trace it now.

>   It's still running a 1M 
> iteration run with no more failures so far (100K so far).
> 
> The latency tracer is a very interesting tool.  I have a few 
> questions/assumptions I'd like to run by you to make sure I understand the 
> output of the latency trace:
> 
> o ! in the delay column means there is a long latency here?

  ! means latency > 100 us

> o + in the delay column means there is a > 1us latency here?

  + means latency > 1 us

> o > means entering the kernel from a sys_call?

  yep

> o < means returning from the sys_call?

  or from interrupt

> o : is not < or >

  yep


  Sébastien.

