Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWBMCqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWBMCqs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWBMCqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:46:48 -0500
Received: from thorn.pobox.com ([208.210.124.75]:18640 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751161AbWBMCqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:46:48 -0500
Date: Sun, 12 Feb 2006 20:46:40 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] Fix CPU hotplug with new time infrastructure
Message-ID: <20060213024640.GC3293@localhost.localdomain>
References: <Pine.LNX.4.64.0602121351400.1579@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602121351400.1579@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> tsc_disable was marked __initdata so we were accessing random data (which 
> happened to have a set bit) so upon warm cpu online we would disable the 
> TSC, resulting in the following. Nathan does this fix your triple fault?

Doesn't apply to latest -linus, which is where I've been seeing that.
I found tsc_disable in arch/i386/kernel/timers/timer_tsc.c, but it's
marked __devinitdata.

So my problem would appear to be something different; I'll try to get
more information, thanks.


> root@arusha cpu1 {0:0} echo 1 > online
> Booting processor 1/1 eip 3000
> Disabling TSC...
> Calibrating delay using timer specific routine.. 797.62 BogoMIPS 
> (lpj=3988115)
> CPU1: Intel Pentium II (Deschutes) stepping 02
> migration_cost=2595
> root@arusha cpu1 {0:0} ps
>   PID TTY          TIME CMD
>  2432 ttyS0    00:00:00 tcsh
>  2490 ttyS0    00:00:00 ps
> root@arusha cpu1 {0:0} ps
> Segmentation fault
> root@arusha cpu1 {0:139}
> 
> <signed-off-by> Zwane Mwaikambo <zwane@arm.linux.org.uk>
> 
> Index: linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c
> ===================================================================
> RCS file: /home/cvsroot/linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c,v
> retrieving revision 1.1.1.1
> diff -u -p -B -r1.1.1.1 tsc.c
> --- linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c	11 Feb 2006 16:55:15 -0000	1.1.1.1
> +++ linux-2.6.16-rc2-mm1/arch/i386/kernel/tsc.c	12 Feb 2006 22:00:12 -0000
> @@ -25,7 +25,7 @@
>   */
>  unsigned int tsc_khz;
>  
> -int tsc_disable __initdata = 0;
> +int tsc_disable __cpuinitdata = 0;
>  
>  #ifdef CONFIG_X86_TSC
>  static int __init tsc_setup(char *str)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
