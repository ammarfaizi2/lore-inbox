Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWEaXaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWEaXaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 19:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965260AbWEaXaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 19:30:13 -0400
Received: from smtp-out.google.com ([216.239.45.12]:33435 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965258AbWEaXaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 19:30:11 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=w48TRfFtyvjZNc3JlOXkMInGU+o9CE+HYvE4fx4wiZEV+8UyZindfJXhV7D3nz7o5
	gVGZNd2JhhnmDoeEzmOLA==
Message-ID: <447E26C5.8030301@google.com>
Date: Wed, 31 May 2006 16:29:09 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org, apw@shadowen.org, ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <20060531230710.GA7484@elte.hu>
In-Reply-To: <20060531230710.GA7484@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Martin, is the box still somewhat operational after such a crash? If yes 
> then we could use my crash-tracer to see the kernel function call 
> history leading up to the crash:
> 
>   http://redhat.com/~mingo/lockdep-patches/latency-tracing-lockdep.patch
> 
> just apply the patch, accept the offered Kconfig defaults and it will be 
> configured to do the trace-crashes thing. Reproduce the crash and save 
> /proc/latency_trace - it contains the execution history leading up to 
> the crash. (on the CPU that crashes) Should work on i386 and x86_64.
> 
> the trace is saved upon the first crash or lockdep assert that occurs on 
> the box. (but you'll have lockdep disabled, so it's the crash that 
> matters)
> 
> if the box dies after a crash then there's a possibility to print the 
> execution history to the serial console - but that takes around 10-15 
> minutes even on 115200 baud. If you want/need to do this then edit 
> kernel/latency.c and change "trace_print_at_crash = 0" to 
> "trace_print_at_crash = 1".
> 
> (btw., the tracer has another neat feature as well: if a kernel crashes 
> or triple faults (and reboots) early during bootup, then the tracer can 
> be configured to print all function calls to the serial console, via 
> early_printk() - right when the function calls happen. I debugged 
> numerous nasty boot-time bugs via this. To set it, change 
> "print_functions = 0" to "print_functions = 1" in kernel/latency.c.)

Looks cool, but we'll have to beg the IBM guys to run it, I don't have
access to that box anymore. Dumping to serial console would be cool,
even if it's slow (the test boxes all have that logged).

M.

