Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316910AbSFDWZ0>; Tue, 4 Jun 2002 18:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSFDWZZ>; Tue, 4 Jun 2002 18:25:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7931 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316901AbSFDWZX>;
	Tue, 4 Jun 2002 18:25:23 -0400
Message-ID: <3CFD3E39.6FB262A2@mvista.com>
Date: Tue, 04 Jun 2002 15:24:57 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hossein Mobahi <hmobahi@yahoo.com>
CC: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Race: SignalHandler() & sleep()
In-Reply-To: <20020604144804.33629.qmail@web12706.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hossein Mobahi wrote:
> 
> Hello
> 
> main()
> {
>     ....
>     signal (SIGIO, signalhandler() ) ;
>     ....
>     sleep (65535) ;
>     ....
> }
> 
> signalhandler() { ... }
> 
> Assume the frequency of IO events is faster than one
> event per 65535 seconds. Therefore, let's consider
> 65535 as infinity (sleeping foreveR).
> If a SIGIO arrives, main will get out of sleep and
> continue running, but signalhandler will be invoked
> too. I wanted to know if there is any order/priority
> for sleep() in main, and signalhandler() to be called
> first, or one of them is invoked first randomly (race
> condition) ?
> 
> I myself ran the program many times and everytime
> observed signalhandler responding first. But maybe it
> is not a rule, and it was just my chance ?
> 
In linux (and most (all) unices) pending signals are checked
for on exit from the kernel so the order of operation is:

wake up (end of sleep) still in kernel
on exit from kernel, find signal, and deliver it, i.e. call
handler if there is one
on return from the handler, continue with the exit from the
system.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
