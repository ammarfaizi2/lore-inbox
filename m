Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269262AbUIIGns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269262AbUIIGns (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 02:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269362AbUIIGns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 02:43:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10174 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269262AbUIIGn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 02:43:29 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Wed, 8 Sep 2004 23:43:21 -0700
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0409082058140.28678@schroedinger.engr.sgi.com> <20040908210537.585120c1.akpm@osdl.org> <Pine.LNX.4.58.0409082210230.29080@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409082210230.29080@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409082343.21330.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending to lkml just for fun]

On Wednesday, September 8, 2004 8:59 pm, Christoph Lameter wrote:
> SGI has been using this driver under Linux since 2001 in the software
> that they distributed (ProPacks) but it wasnever included in the upstream
> kernel. SuSE did include the patch for mmtimerin SLES 9. The driver has
> been widely used for applications on the Altix platform.
>
> The timer hardware was designed around the multimedia timer specification
> by Intel but to my knowledge only SGI has implemented that standard. The
> driver was written by Jesse Barnes.
>
> Changelog:
>  * Add driver for Altix SHub system clock
> --- linux-2.6.9-rc1.orig/drivers/char/Makefile 2004-09-08
> 20:40:28.000000000 -0700 +++
> linux-2.6.9-rc1/drivers/char/Makefile 2004-09-08 20:40:39.000000000 -0700
> @@ -45,6 +45,7 @@
>  obj-$(CONFIG_HVC_CONSOLE) += hvc_console.o hvsi.o
>  obj-$(CONFIG_RAW_DRIVER) += raw.o
>  obj-$(CONFIG_SGI_SNSC)  += snsc.o
> +obj-$(CONFIG_MMTIMER)         += mmtimer.o
>  obj-$(CONFIG_VIOCONS) += viocons.o
>  obj-$(CONFIG_VIOTAPE)  += viotape.o
>  obj-$(CONFIG_HVCS)  += hvcs.o

Maybe it's just my mailer, but is the indentation in this file all messed up?

> +#ifdef MMTIMER_INTERRUPT_SUPPORT
> +static mmtimer_t timers[] = { { SPIN_LOCK_UNLOCKED, 0, 0,
> +    (unsigned long *)RTC_COMPARE_A_ADDR, 0 },
> +         { SPIN_LOCK_UNLOCKED, 0, 0,
> +    (unsigned long *)RTC_COMPARE_B_ADDR, 0 } };
> +#endif

We may as well kill anything under MMTIMER_INTERRUPT_SUPPORT.  IIRC, people 
use SHub timer interrupts, but not via this driver.  If you want to fix it, 
that's ok too, but you can kill the #ifdef in that case also.

Thanks,
Jesse
