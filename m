Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVJNO4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVJNO4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 10:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVJNO4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 10:56:10 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:32612 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750730AbVJNO4I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 10:56:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=myfbko9BCEXS1qsvaoAt45WDgtuy/A65e1o1k57QVwsy7GHN37jdaHBSVFBz4Sv3E1fFXotN/W09E30dhqqsx8ux/MfvZStNmdGPH2ZN7GzwnwAgbeM+wlMgjTpzVxvWKowtHli3ugc5ARoY/9f0aKiqSfTKVR6d8dAUJwtEXWY=
Message-ID: <5bdc1c8b0510140756u1b006de9td552539421666bec@mail.gmail.com>
Date: Fri, 14 Oct 2005 07:56:05 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc4-rt1 - enable IRQ-off tracing causes kernel to fault at boot
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051014035230.GB6513@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com>
	 <20051013073029.GA12801@elte.hu>
	 <5bdc1c8b0510130526k6064c640pecded9ccb0ef7dde@mail.gmail.com>
	 <Pine.LNX.4.58.0510130844070.13098@localhost.localdomain>
	 <5bdc1c8b0510131210i64f7f289q557368b056e59e18@mail.gmail.com>
	 <20051014035230.GB6513@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Mark Knecht <markknecht@gmail.com> wrote:
>
> > Ingo & Steve,
> >    Thank you for your great instructions that even a guitar player
> > could basically follow. After about an hour of messing around I did
> > manage to capture the crash. The console file is attached.
> >
> > NOTE: The first time I booted the kernel it got to the crash point and
> > the machine rebooted. The second time it booted I got the trace. Both
> > boots are in the capture file.
>
> thanks, this log is much more informative. No smoking gun though, but it
> seems something fundamental (probably lowlevel x64 code) has been broken
> by -rt1.
>
> Do the crashes go away if you take the -rc3-rt13 version of
> arch/x86_64/kernel/entry.S and copy it over into the -rc4-rt1 tree?
> [this undoes a particular set of CONFIG_CRITICAL_IRQSOFF_TIMING fixes
> from the x64 code, which i did during -rc3-rt13 => -rc4-rt1]

Indeed it is fixed by doing this. Options are on but the modified
kernel does boot:

*****************************************************************************
*                                                                           *
*  REMINDER, the following debugging options are turned on in your .config: *
*                                                                           *
*        CONFIG_DEBUG_PREEMPT                                               *
*        CONFIG_CRITICAL_PREEMPT_TIMING                                     *
*        CONFIG_CRITICAL_IRQSOFF_TIMING                                     *
*                                                                           *
*  they may increase runtime overhead and latencies.                        *
*                                                                           *
*****************************************************************************

mark@lightning ~ $ uname -a
Linux lightning 2.6.14-rc4-rt1 #8 PREEMPT Fri Oct 14 07:46:29 PDT 2005
x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
mark@lightning ~ $


>
> (Note that doing this will re-introduce tracing bugs, which can result
> in false-positive latency readings - but it should fix any related
> lowlevel bug in the assembly code.)
>
> if this indeed solves the crash then i'd suggest to restore the -rt1
> version of entry.S, and i'd suggest to disable CRITICAL_IRQSOFF_TIMING
> until i fix it. You should be able to get pretty good latency tracing
> info even without CRITICAL_IRQSOFF_TIMING.
>
>         Ingo
>

Will got back to the original entry.S file with the IRQoff option
turned off. Let me know when you have a fix to test, or if you need
more data.

Thanks,
Mark
