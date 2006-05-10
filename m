Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWEJHJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWEJHJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWEJHJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:09:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40077 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751405AbWEJHJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:09:42 -0400
Date: Wed, 10 May 2006 09:09:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Define __raw_get_cpu_var and use it
Message-ID: <20060510070929.GA23414@elte.hu>
References: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17505.24133.491523.358882@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Mackerras <paulus@samba.org> wrote:

> There are several instances of per_cpu(foo, raw_smp_processor_id()), 
> which is semantically equivalent to __get_cpu_var(foo) but without the 
> warning that smp_processor_id() can give if CONFIG_DEBUG_PREEMPT is 
> enabled.  For those architectures with optimized per-cpu 
> implementations, namely ia64, powerpc, s390, sparc64 and x86_64, 
> per_cpu() turns into more and slower code than __get_cpu_var(), so it 
> would be preferable to use __get_cpu_var on those platforms.
> 
> This defines a __raw_get_cpu_var(x) macro which turns into per_cpu(x, 
> raw_smp_processor_id()) on architectures that use the generic per-cpu 
> implementation, and turns into __get_cpu_var(x) on the architectures 
> that have an optimized per-cpu implementation.
>     
> Signed-off-by: Paul Mackerras <paulus@samba.org>

i made the original raw_smp_processor_id() changes and i never liked the 
per_cpu() open-coding it introduced. Your patch solves this problem 
nicely.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
