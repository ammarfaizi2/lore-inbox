Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVA3SGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVA3SGD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVA3SGC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:06:02 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38929 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261754AbVA3SFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:05:33 -0500
Date: Sun, 30 Jan 2005 19:05:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050130180527.GQ3185@stusta.de>
References: <20050130180016.GA12987@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050130180016.GA12987@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2005 at 06:00:17PM +0000, Arjan van de Ven wrote:
> Hi,
> 
> intermodule is deprecated for quite some time now, and MTD is the sole last
> user in the tree. To shrink the kernel for the people who don't use MTD, and
> to prevent accidental return of more users of this, make the compiling of
> this function conditional on MTD.
> 
> 
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> --- linux/kernel/Makefile	2005-01-30 18:57:11.000000000 +0100
> +++ linux/kernel/Makefile	2005-01-30 18:57:11.000000000 +0100
> @@ -6,7 +6,7 @@
>  	    exit.o itimer.o time.o softirq.o resource.o \
>  	    sysctl.o capability.o ptrace.o timer.o user.o \
>  	    signal.o sys.o kmod.o workqueue.o pid.o \
> -	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
> +	    rcupdate.o extable.o params.o posix-timers.o \
>  	    kthread.o wait.o kfifo.o sys_ni.o
>  
>  obj-$(CONFIG_FUTEX) += futex.o
> @@ -27,6 +27,10 @@
>  obj-$(CONFIG_SYSFS) += ksysfs.o
>  obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
>  
> +inter-$(CONFIG_MTD)	+= intermodule.o
> +obj-y	+= $(inter-y)
> +obj-y  += $(inter=m)
>...

This should be inter-m .

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

