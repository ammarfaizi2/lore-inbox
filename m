Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289213AbSA1PXT>; Mon, 28 Jan 2002 10:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289214AbSA1PXI>; Mon, 28 Jan 2002 10:23:08 -0500
Received: from mx01.uni-tuebingen.de ([134.2.3.11]:20239 "EHLO
	mx01.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S289213AbSA1PW5>; Mon, 28 Jan 2002 10:22:57 -0500
Date: Mon, 28 Jan 2002 16:22:56 +0100 (CET)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] [sched] load-balancer improvements, 2.5.3-pre5
In-Reply-To: <Pine.LNX.4.33.0201281754050.10067-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201281620210.1120-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  static void smp_tune_scheduling (void)
>  {
> @@ -957,9 +959,13 @@
>  		cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
>  	}
>
> +	cache_decay_ticks = (long)cacheflush_time/cpu_khz * HZ / 1000;
> +
>  	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
>  		(long)cacheflush_time/(cpu_khz/1000),
>  		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
> +	printk("task migration cache decay timeout: %ld msecs.\n",
> +		(cache_decay_ticks + 1) * 1000 / HZ);
>  }

Isnt it better for such randomly(?) choosen numbers like 1000 and 100
which you use to divide / modulo to choose them as a near power of two?
Like 1024 for / 1000 and 128 for the */% 100 above? For correctness just
change cpu_khz to be 1024*hz, not 1000*hz.

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

