Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRKHR3p>; Thu, 8 Nov 2001 12:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276914AbRKHR3e>; Thu, 8 Nov 2001 12:29:34 -0500
Received: from posta2.elte.hu ([157.181.151.9]:51688 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S276743AbRKHR3V>;
	Thu, 8 Nov 2001 12:29:21 -0500
Date: Thu, 8 Nov 2001 19:27:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.40.0111080913560.1501-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0111081909050.18050-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Davide,

On Thu, 8 Nov 2001, Davide Libenzi wrote:

> Maybe you missed this :
>
> http://www.xmailserver.org/linux-patches/mss.html
>
> where the patch that does this is here :
>
> http://www.xmailserver.org/linux-patches/lnxsched.html#CPUHist

i'm not sure what the patch is trying to achieve, but this part of
mcsched-2.4.13-0.4.diff looks incorrect:

+               prev->cpu_jtime += (jiffies - prev->sched_jtime) + jiffies;

(this is "2*jiffies - prev->sched_jtime" which doesnt appear to make much
sense - does it?)

and your patch adds a scheduling advantage to processes with more cache
footprint, which is the completely opposite of what we want.

but in any case, changing the goodness() function was not a goal of my
patch, i change the granularity of how processes lose their 'effective
priority'.

	Ingo

