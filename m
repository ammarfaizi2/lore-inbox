Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315982AbSETNey>; Mon, 20 May 2002 09:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315983AbSETNex>; Mon, 20 May 2002 09:34:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:48063 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315982AbSETNex>;
	Mon, 20 May 2002 09:34:53 -0400
Date: Mon, 20 May 2002 23:31:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Miller <davem@redhat.com>
Subject: Re: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020520133105.GC14488@krispykreme>
In-Reply-To: <20020516185448.A8069@in.ibm.com> <20020520085500.GB14488@krispykreme> <20020520155958.F6270@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dipankar,
 
> The tasklet code also needs fixing. It is a miracle that the kernel
> booted when I tested that code. Here is a fixed diff.

:) I was surprised it worked with the missing spin_unlock too. Im
testing the fixed diff now, so far it looks good.

> I am curious about performance of smptimers. It seems that
> webserver benchmark performance worsens with smptimers (Ingo version)
> contrary to our expectations. Do you see this ? If so, could this
> happen because -
> 
> 1) Bouncing around of global_bh_lock cacheline by more cpus compared
> to earlier timer implemenation ?
> 2) All per-cpu timers invoked from timer_bh running in one cpu ?
> 
> Do you see any other side-effects of smptimers ?

We used to see bad behaviour. It turned out to be the per cpu
timer interrupt firing at exactly the same time on all cpus. One
cpu would successfully spin_trylock and the others would fail
and postpone the work.

We now evenly space the per cpu interrupts. Does intel do the same?

> Also, did my PPC changes for smptimers work or you had to fix it ?

I tested ppc64 and it worked fine.

Anton
