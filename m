Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWAEBKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWAEBKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 20:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWAEBKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 20:10:07 -0500
Received: from smtp-out.google.com ([216.239.45.12]:35365 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751087AbWAEBKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 20:10:04 -0500
Message-ID: <43BC716A.5080204@mbligh.org>
Date: Wed, 04 Jan 2006 17:07:54 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Matt Mackall <mpm@selenic.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
References: <200601041959_MC3-1-B550-5EE2@compuserve.com>
In-Reply-To: <200601041959_MC3-1-B550-5EE2@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <20060104042822.GA3356@waste.org>
> 
> On Tue, 3 Jan 2006 at 22:28:23 -0600, Matt Mackall wrote:
> 
> 
>>On Tue, Jan 03, 2006 at 03:40:59PM -0800, Martin J. Bligh wrote:
>>
>>
>>>It seems odd to me that we're doing this by second-hand effect on
>>>code size ... the objective of making the code smaller is to make it
>>>run faster, right? So ... howcome there are no benchmark results
>>>for this?
>>
>>Because it's extremely hard to design a benchmark that will show a
>>significant change one way or the other for single kernel functions
>>that doesn't also make said functions unusually cache-hot. And part of
>>the presumed advantage of uninlining is that it leaves icache room for
>>random other code that you're _not_ benchmarking.
> 
> 
> Moving code out-of-line can have some serious drawbacks, too.  For example,
> if you have a 12 byte function that is called frequently, you are pinning
> an additional 52 bytes of code in the L1 cache.  Unless that code is also
> called often you might waste more space than you gain from un-inlining.
> 
> E.g. a look at arch/i386/kernel/apic.c shows a bunch of functions that are
> only there because of CPU hotplug, to handle errors or deal with
> suspend/resume/shutdown.  Such code should be in its own text section.
> 
> And the only way to get meaningful benchmarks so you can figure out where
> to place the code would be to instrument the kernel and then run real-world
> applications.

What would be nice to do is pack all the frequently used code together 
in close proximity. Would probably have much larger effects with 
userspace code, esp where we touch disk (which is more page-size 
granularity), but is probably worth doing with kernel code too (where 
AFAICS we'd only get cacheline granular).

M.
