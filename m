Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315869AbSEGPP7>; Tue, 7 May 2002 11:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315861AbSEGPPK>; Tue, 7 May 2002 11:15:10 -0400
Received: from holomorphy.com ([66.224.33.161]:51433 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315871AbSEGPOx>;
	Tue, 7 May 2002 11:14:53 -0400
Date: Tue, 7 May 2002 08:13:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: Re: irqbalance+O(1)-sched
Message-ID: <20020507151334.GU32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"J.A. Magallon" <jamagallon@able.es>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20020507150357.GA2142@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 05:03:57PM +0200, J.A. Magallon wrote:
> I am trying to mix the irqbalance patch on top of the O1-scheduler
> to use it on a dual P4 box.
> Everything mix easy but this piece of code in irqbalance:
> int idle_cpu(int cpu)
> {
>    return cpu_curr(cpu) == idle_task(cpu);
> }
> 2.4.18 defines it as 
> sched.c:#define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
> ...
> sched.c:#define idle_task(cpu) (&init_task)
> but O1 kills it.
> Any syggestion on hwo to implement idle_cpu() on top of O1 ?

Another quick one might be

#define idle_task(cpu) (cpu_rq(cpu)->idle)

which leaves idle_cpu() unchanged.

Cheers,
Bill
