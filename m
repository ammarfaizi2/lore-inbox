Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315860AbSEGPKo>; Tue, 7 May 2002 11:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315858AbSEGPJr>; Tue, 7 May 2002 11:09:47 -0400
Received: from holomorphy.com ([66.224.33.161]:49385 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315860AbSEGPJ0>;
	Tue, 7 May 2002 11:09:26 -0400
Date: Tue, 7 May 2002 08:08:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>
Subject: Re: irqbalance+O(1)-sched
Message-ID: <20020507150809.GT32767@holomorphy.com>
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

int idle_cpu(int cpu)
{
	return cpu_curr(cpu) == cpu_rq(cpu)->idle;
}

Cheers,
Bill
