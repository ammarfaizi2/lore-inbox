Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267521AbUGWD1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267521AbUGWD1f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 23:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUGWD1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 23:27:35 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:55905 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267521AbUGWD12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 23:27:28 -0400
Message-ID: <4100859C.9060409@yahoo.com.au>
Date: Fri, 23 Jul 2004 13:27:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Dimitri Sivanich <sivanich@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch for isolated scheduler domains
References: <20040722164126.GB13189@sgi.com> <20040722175459.GA30059@elte.hu>
In-Reply-To: <20040722175459.GA30059@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Dimitri Sivanich <sivanich@sgi.com> wrote:
> 
> 
>>I'm interested in implementing something I'll call isolated sched
>>domains for single cpus (to minimize the latencies involved when doing
>>things like load balancing on certain select cpus) on IA64.
>>
>>Below I've included an initial patch to illustrate what I'd like to
>>do.  I know there's been mention of 'platform specific work' in the
>>area of sched domains. This patch only addresses IA64, but could be
>>made generic as well.  The code is derived directly from the current
>>default arch_init_sched_domains code.
> 
> 
> it looks good to me - and i'd suggest to put it into sched.c. Every
> architecture benefits from the ability to define isolated CPUs.
> 

Cool. Have you actually tried running it? With Ingo's correction, it
should work fine but I don't think anyone has tested this.

> One minor nit wrt. this line:
> 
> +               cpu_sd->flags &= ~(SD_BALANCE_NEWIDLE | SD_BALANCE_EXEC |
> + SD_BALANCE_CLONE);  /* Probably redundant */
> 
> i'd suggest to set it to 0. You dont want WAKE_AFFINE nor WAKE_BALANCE
> to move your tasks out of the isolated domain.
> 
> 
>>- Assuming boot time configuration is appropriate ('isolcpus=' in my example),
>>  is allowing boot time configuration of only completely isolated cpus
>>  focusing too narrowly on this one concept, or should a boot time
>>  configuration allow for a broader array of configurations, or would other
>>  types of sched domain configurations be addressed separately?
> 
> 
> i'd prefer to go with this simple solution and wait for actual usage
> patterns to materialize. If it becomes popular we can define a syscall
> to configure the domain hierarchy (maybe even the parameters) runtime.
> 

Seconded.
