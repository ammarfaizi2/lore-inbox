Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTENOAR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTENN76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:59:58 -0400
Received: from us02smtp1.synopsys.com ([198.182.60.75]:13002 "HELO
	vaxjo.synopsys.com") by vger.kernel.org with SMTP id S262306AbTENN6p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:58:45 -0400
Date: Wed, 14 May 2003 16:11:21 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: mikpe@csd.uu.se
Cc: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Message-ID: <20030514141121.GA17036@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
References: <20030514094813.GA14904@Synopsys.COM> <16066.16102.618836.204556@gargle.gargle.HOWL> <20030514134600.GA16533@Synopsys.COM> <16066.19659.609760.316141@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16066.19659.609760.316141@gargle.gargle.HOWL>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mikpe@csd.uu.se, Wed, May 14, 2003 16:03:55 +0200:
> > > Since 2.5.69-bk8 or so, apm.c will invoke restore_processor_state()
> > > at resume-time. This is needed to reinitialise the SYSENTER MSRs
> > > used by 2.5's new system call mechanism.
> > 
> > and it supposed to go oops?
> 
> Of course not. It doesn't oops my Dell Latitude: on that laptop it
> prevents oopses since otherwise user-space processes will oops the kernel
> as soon as they make a system call or return from a system call. But this
> only happens if both the CPU and glibc are capable of using SYSENTER.
> 

I'm not sure if my glibc uses sysenter. But I'd like to have the system
prepared if I eventually get one which does.

>  > >  >  <6>note: kapmd[4] exited with preempt_count 2
>  > > This I don't like. I'm not convinced the resume path is preempt-safe.
>  > > Please try again, either with CONFIG_PREEMPT disabled, or with a
>  > > preempt_disable() / preempt_enable() pair around apm.c's suspend code,
>  > > like in the patch below. (Untested, you may need to stick an #include
>  > > <preempt.h> somewhere in apm.c to make it compile.)
>  > 
>  > It changed things a bit. preempt_count is 3 now.
>  > Oops didn't change.
> 
> Ok so it wasn't preempt.
> Can you identify in which statement the oops occurs?

not really. Somewhere fix_processor_context+0x5f/0x100, that's where EIP
points. But latest bk doesn't have this anymore, so I think I'll try it
first.

> And can you confirm that commenting out the calls in apm.c to
> save_processor_state() and restore_processor_state() eliminates the oops?

after I have tried it.

