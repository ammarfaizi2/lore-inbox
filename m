Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVGUEnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVGUEnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 00:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVGUEnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 00:43:05 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:8049 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261612AbVGUEnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 00:43:03 -0400
Date: Wed, 20 Jul 2005 21:42:39 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Mark Whittington <markc@liquidev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12] printk: add sysctl to control printk_time
Message-Id: <20050720214239.71dc4e05.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.63.0507201551310.727@beigebox.liquidev.com>
References: <Pine.LNX.4.63.0507201551310.727@beigebox.liquidev.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2005 16:08:35 -0400 (EDT) Mark Whittington wrote:

> Added a sysctl (KERN_PRINTK_TIME) and by proxy an entry in 
> /proc/sys/kernel to enable and disable printk interval information when 
> CONFIG_PRINTK_TIME is compiled in.

1/  That explains "what."  How about "why?"

2/  The patch does not apply cleanly.  It looks like some tabs
are messed up, but I'm not sure about it.

rddunlap@midway:linux-2612> patch -p1 -b --dry-run < ~/fixes/printk_time.patch
patching file Documentation/sysctl/kernel.txt
Hunk #1 FAILED at 39.
Hunk #2 FAILED at 261.
2 out of 2 hunks FAILED -- saving rejects to file Documentation/sysctl/kernel.txt.rej
patching file include/linux/sysctl.h
Hunk #1 FAILED at 136.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/sysctl.h.rej
patching file kernel/printk.c
Hunk #1 FAILED at 473.
1 out of 1 hunk FAILED -- saving rejects to file kernel/printk.c.rej
patching file kernel/sysctl.c
Hunk #1 FAILED at 63.
Hunk #2 FAILED at 590.
2 out of 2 hunks FAILED -- saving rejects to file kernel/sysctl.c.rej
patching file lib/Kconfig.debug
Hunk #1 FAILED at 6.
1 out of 1 hunk FAILED -- saving rejects to file lib/Kconfig.debug.rej

3/  The patch should be made against a more recent kernel version,
like 2.6.13-rc3 or 2.6.13-rc3-git4.


> Signed-off-by: Mark Whittington <markc@liquidev.com>
> 
> diff -ruN linux-2.6.12/kernel/printk.c linux-2.6.12-work/kernel/printk.c
> --- linux-2.6.12/kernel/printk.c	2005-06-17 15:48:29.000000000 -0400
> +++ linux-2.6.12-work/kernel/printk.c	2005-07-20 15:32:03.000000000 -0400
> @@ -473,7 +473,8 @@
>   }
> 
>   #if defined(CONFIG_PRINTK_TIME)
> -static int printk_time = 1;
> +int printk_time = 1;
> +EXPORT_SYMBOL(printk_time);

I wouldn't think that the EXPORT_SYMBOL() is needed.  That just
makes it visible to modules.  Not being 'static' should be enough
to make it visible to other built-in-kernel files...
so, did you try it without the EXPORT_SYMBOL()?

>   #else
>   static int printk_time = 0;
>   #endif
> diff -ruN linux-2.6.12/lib/Kconfig.debug linux-2.6.12-work/lib/Kconfig.debug
> --- linux-2.6.12/lib/Kconfig.debug	2005-06-17 15:48:29.000000000 -0400
> +++ linux-2.6.12-work/lib/Kconfig.debug	2005-07-20 15:09:07.000000000 -0400
> @@ -6,7 +6,9 @@
>   	  included in printk output.  This allows you to measure
>   	  the interval between kernel operations, including bootup
>   	  operations.  This is useful for identifying long delays
> -	  in kernel startup.
> +	  in kernel startup.  If this option is enabled, you can turn
> +          off and on the timing information by echoing a 1 or 0 to
> +          /proc/kernel/sys/printk_time.

Those last 2 lines should line up with the lines above them.
However, the last 2 lines use only spaces and not tab(s),
which is incorrect.

Basically, fix your email client and justify the patch.

---
~Randy
