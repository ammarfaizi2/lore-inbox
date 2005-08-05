Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262857AbVHENRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbVHENRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 09:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbVHENRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 09:17:23 -0400
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:32453 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262857AbVHENRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 09:17:22 -0400
From: Con Kolivas <kernel@kolivas.org>
To: vatsa@in.ibm.com
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Fri, 5 Aug 2005 23:08:43 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
References: <200508031559.24704.kernel@kolivas.org> <20050805123754.GA1262@in.ibm.com>
In-Reply-To: <20050805123754.GA1262@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508052308.44313.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005 22:37, Srivatsa Vaddagiri wrote:
> On Wed, Aug 03, 2005 at 06:05:28AM +0000, Con Kolivas wrote:
> > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> > Patch for 2.6.13-rc5
> >
> > There were a couple of things that I wanted to change so here is an
> > updated version. This code should have stabilised enough for general
> > testing now.
>
> Con,
> 	I have been looking at some of the requirement of tickless idle CPUs in
> core kernel areas like scheduler and RCU. Basically, both power management
> and virtualization benefit if idle CPUs can cut off useless timer ticks.
> Especially from a virtualization standpoint, I think it makes sense that we
> enable this feature on a per-CPU basis i.e let individual CPUs cut off
> their ticks as and when they become idle. The benefit of this is more
> visible in platforms that host lot of (SMP) VMs on the same machine. Most
> of the time, these VMs may be partially idle (some CPUs in it are idle,
> some not) and it is good that we quiesce the timer ticks on the partial set
> of idle CPUs. Both S390 and Xen ports of Linux kernel have this ability
> today (S390 has it in mainline already and Xen has it out of tree).

Hi Srivatsa.

Thanks very much for your comments. The actual codebase for dynticks I've 
never staked any claim to as it isn't mine. The demand for such a feature in 
the kernel on multiple architectures appears to have reached critical mass 
with mainline now considering another Hz change. This is why I decided to 
champion this patch at this time by polishing and tweaking it (in purely 
cosmetic ways). I mostly agree with your comments about limitations of this 
patch and would like to see changes like those you describe done in an 
arch-neutral fashion as well. I have not the hardware resources to develop 
such code and would be more than happy if have generated enough interest in 
dynticks for you to develop it further via whatever means. Knowing arm and 
S390 already have dynticks makes it more important that cross-arch code is 
consolidated sooner rather than later.

Cheers,
Con
