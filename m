Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289218AbSA1QGM>; Mon, 28 Jan 2002 11:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289220AbSA1QFw>; Mon, 28 Jan 2002 11:05:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10446 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289218AbSA1QFo>;
	Mon, 28 Jan 2002 11:05:44 -0500
Date: Mon, 28 Jan 2002 19:03:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] load-balancer improvements, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.33.0201281620210.1120-100000@bellatrix.tat.physik.uni-tuebingen.de>
Message-ID: <Pine.LNX.4.33.0201281902270.11975-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Richard Guenther wrote:

> > +	cache_decay_ticks = (long)cacheflush_time/cpu_khz * HZ / 1000;
> > +
> >  	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
> >  		(long)cacheflush_time/(cpu_khz/1000),
> >  		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
> > +	printk("task migration cache decay timeout: %ld msecs.\n",
> > +		(cache_decay_ticks + 1) * 1000 / HZ);

> Isnt it better for such randomly(?) choosen numbers like 1000 and 100
> which you use to divide / modulo to choose them as a near power of
> two? Like 1024 for / 1000 and 128 for the */% 100 above? For
> correctness just change cpu_khz to be 1024*hz, not 1000*hz.

it's not randomly chosen numbers. From cacheflush_time i'm calculating the
time it takes the cache to flush, in timer ticks.

	Ingo

