Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262755AbTCJJB7>; Mon, 10 Mar 2003 04:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbTCJJB7>; Mon, 10 Mar 2003 04:01:59 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:62362 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262755AbTCJJB6>;
	Mon, 10 Mar 2003 04:01:58 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Date: Mon, 10 Mar 2003 20:12:32 +1100
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@digeo.com>
References: <5.2.0.9.2.20030310075720.00c832f8@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030310075720.00c832f8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303102012.32465.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 18:05, Mike Galbraith wrote:
> At 01:29 PM 3/10/2003 +1100, you wrote:
> >Tried running contest on 2.5.64-mm2 and mm4 and had the same thing happen.
> > It will hang reliably during process_load. I tried not running
> > process_load but it would still get stuck in one of the other loads
> > (either a tar load or list load). I can simply stop contest at that stage
> > but then the machine wont work well hanging at the console after a minute
> > or so. This started at mm2 (doesn't happen with mm1).
> >
> >Here is the sysrq-p and sysrq-t output during process_load (which hangs
> > every time):
>
> hmm, the below looks interesting to me...
>
> >ksoftirqd/0   R C129A000     2      1             3       (L-TLB)
> >Call Trace:
> >  [<c0118f3e>] ksoftirqd+0x5e/0x9c
> >  [<c0118ee0>] ksoftirqd+0x0/0x9c
> >  [<c0106f1d>] kernel_thread_helper+0x5/0xc
>
> I see that too with irman.  You could try renicing the shell you start
> contest from to >= +12.  With irman, what appears to be cpu starvation
> ceases to be a problem at exactly +12.  I also see kapmd constantly wanting
> to run but not being serviced.

Contest uses a modified process load from irman so it exhibits similar 
behaviour. Not sure what +12 actually tells me though :-( 

My simplistic understanding is that the pipe task in process_load gets 
constantly elevated as "interactive" by the new scheduler, and nothing else 
ever happens.

Con
