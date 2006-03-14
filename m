Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752340AbWCNSHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbWCNSHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 13:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbWCNSHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 13:07:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:13757 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1752340AbWCNSHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 13:07:48 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: does swsusp suck after resume for you? [was Re: Faster resuming of suspend technology.]
Date: Tue, 14 Mar 2006 19:06:48 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       ck@vds.kolivas.org, Jun OKAJIMA <okajima@digitalinfra.co.jp>,
       linux-kernel@vger.kernel.org
References: <200603101704.AA00798@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <20060313113631.GA1736@elf.ucw.cz> <200603132303.18758.kernel@kolivas.org>
In-Reply-To: <200603132303.18758.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603141906.49183.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 13:03, Con Kolivas wrote:
> On Monday 13 March 2006 22:36, Pavel Machek wrote:
> > 4) Congratulations, you are right person to help. Could you test if
> > Con's patches help?
> 
> Ok this patch is only compile tested only but is reasonably straight forward.
> (I have no hardware to test it on atm). It relies on the previous 4 patches I
> sent out that update swap prefetch. To make it easier here is a single rolled
> up patch that goes on top of 2.6.16-rc6-mm1:
> 
> http://ck.kolivas.org/patches/swap-prefetch/2.6.16-rc6-mm1-swap_prefetch_suspend_test.patch
> 
> Otherwise the incremental patch is below.
> 
> Usual blowing up warnings apply with this sort of patch. If it works well then
> /proc/meminfo should show a very large SwapCached value after resume.
> 
}-- snip --{
> Index: linux-2.6.16-rc6-mm1/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.16-rc6-mm1.orig/kernel/power/swsusp.c	2006-03-13 10:05:05.000000000 +1100
> +++ linux-2.6.16-rc6-mm1/kernel/power/swsusp.c	2006-03-13 22:42:52.000000000 +1100
> @@ -49,6 +49,7 @@
>  #include <linux/bootmem.h>
>  #include <linux/syscalls.h>
>  #include <linux/highmem.h>
> +#include <linux/swap-prefetch.h>
>  
>  #include "power.h"
>  
> @@ -269,5 +270,6 @@ int swsusp_resume(void)
>  	touch_softlockup_watchdog();
>  	device_power_up();
>  	local_irq_enable();
> +	post_resume_swap_prefetch();
>  	return error;
>  }

Hm, this code is only executed if there's an error during resume.  You should
have placed the post_resume_swap_prefetch() call in swsusp_suspend(). :-)

Greetings,
Rafael
