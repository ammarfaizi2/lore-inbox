Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTK1Qfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTK1Qfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:35:38 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:11676 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262603AbTK1Qfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:35:37 -0500
Date: Fri, 28 Nov 2003 17:34:49 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sisop-iii-l <sisopiii-l@cscience.org>
Subject: Re: [PATCH] fix #endif misplacement
In-Reply-To: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
Message-ID: <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de>
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Nov 2003, Ricardo Nabinger Sanchez wrote:

> This patch fixes an #endif misplacement, which leads to dead code in
> sched_clock() in arch/i386/kernel/timers/timer_tsc.c, due to a return
> outside the ifdef/endif.

No, this is exactly what is intended: don't use the TSC on NUMA, use 
jiffies instead.
Look at the comment just above those lines.

Tim


> --- linux-2.6.0-test11/arch/i386/kernel/timers/timer_tsc.c	2003-11-26 18:44:45.000000000 -0200
> +++ linux-2.6.0-test11-sched_clock/arch/i386/kernel/timers/timer_tsc.c	2003-11-28 12:58:59.000000000 -0200
> @@ -140,8 +140,8 @@
>  	 */
>  #ifndef CONFIG_NUMA
>  	if (!use_tsc)
> -#endif
>  		return (unsigned long long)jiffies * (1000000000 / HZ);
> +#endif
>  
>  	/* Read the Time Stamp Counter */
>  	rdtscll(this_offset);
