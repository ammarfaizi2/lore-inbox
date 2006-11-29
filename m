Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967463AbWK2QYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967463AbWK2QYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 11:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967464AbWK2QYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 11:24:47 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:26125 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S967463AbWK2QYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 11:24:46 -0500
Date: Wed, 29 Nov 2006 08:24:34 -0800 (PST)
From: Daniel Walker <dwalker@mvista.com>
X-X-Sender: dwalker@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc6-rt8: alsa xruns
In-Reply-To: <20061129072100.GA1983@elte.hu>
Message-ID: <Pine.LNX.4.64.0611290801260.11628@localhost.localdomain>
References: <1164743931.15887.34.camel@cmn3.stanford.edu>
 <1164744757.1701.58.camel@mindpipe> <20061128201444.GB26934@elte.hu>
 <1164751282.7543.25.camel@localhost.localdomain> <20061129072100.GA1983@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006, Ingo Molnar wrote:
>
> please talk to John and Thomas about GTOD interfaces. Right now the
> solution used by the latency tracer is working out pretty OK - but if
> something better comes along i can use that too. It's not a burning
> issue though, unless you know of some bug. (i'm not sure what you mean
> by it becoming constrictive)

It doesn't appear to handle clock switching, so for instance, if generic 
time switches from the tsc, to the acpi_pm would the latency tracer 
tolerate it ? Also a combination of HRT enabled, and a faulty acpi_pm 
would cause the tracer to use the PIT .. The PIT takes spinlocks during 
it's read so I'd imgaine the system would crash, or something else not so 
good.

Also with HRT enabled, you would end up using the acpi_pm even if the TSC 
is stable which is slower ..

That's what I mean when I say constrictive .

I've been working with John and Thomas to make the clocksource more 
usable (and lots of cleanups),

ftp://source.mvista.com/pub/dwalker/clocksource/clocksource-v8/

Daniel
