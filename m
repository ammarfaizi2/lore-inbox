Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277258AbRKHR4F>; Thu, 8 Nov 2001 12:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKHRzv>; Thu, 8 Nov 2001 12:55:51 -0500
Received: from [208.129.208.52] ([208.129.208.52]:17158 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277068AbRKHRzb>;
	Thu, 8 Nov 2001 12:55:31 -0500
Date: Thu, 8 Nov 2001 10:03:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.33.0111081909050.18050-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0111080954350.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Ingo Molnar wrote:

>
> Davide,
>
> On Thu, 8 Nov 2001, Davide Libenzi wrote:
>
> > Maybe you missed this :
> >
> > http://www.xmailserver.org/linux-patches/mss.html
> >
> > where the patch that does this is here :
> >
> > http://www.xmailserver.org/linux-patches/lnxsched.html#CPUHist
>
> i'm not sure what the patch is trying to achieve, but this part of
> mcsched-2.4.13-0.4.diff looks incorrect:
>
> +               prev->cpu_jtime += (jiffies - prev->sched_jtime) + jiffies;
>
> (this is "2*jiffies - prev->sched_jtime" which doesnt appear to make much
> sense - does it?)

The optimization is not good ( i left it in that way to make it more clear
what that operation is meant ) but the mean of the code is ok.
It sets the time ( in jiffies ) at which the process won't have any more
scheduling advantage.


> and your patch adds a scheduling advantage to processes with more cache
> footprint, which is the completely opposite of what we want.

It is exactly what we want indeed :
<quote>
it's a fix for a UP and SMP scheduler problem Alan described to me
recently, the 'CPU intensive process scheduling' problem. The essence of
the problem: if there are multiple, CPU-intensive processes running,
intermixed with other scheduling activities such as interactive work or
network-intensive applications, then the Linux scheduler does a poor job
of affinizing processes to processor caches. Such scheduler workload is
common for a large percentage of important application workloads: database
server workloads, webserver workloads and math-intensive clustered jobs,
and other applications.
</quote>

and if you take a look at the LatSched sampling it is achived very well.


> but in any case, changing the goodness() function was not a goal of my
> patch, i change the granularity of how processes lose their 'effective
> priority'.

I'll test the patch asap with the LatSched sampler and i'll let you know.




- Davide



