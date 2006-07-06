Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWGFEjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWGFEjF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 00:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWGFEjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 00:39:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20128 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965174AbWGFEjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 00:39:04 -0400
Date: Wed, 5 Jul 2006 21:39:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Thomas Tuttle" <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Create new LED trigger for CPU activity (ledtrig-cpu)
 (UPDATED)
Message-Id: <20060705213901.4c903e4b.akpm@osdl.org>
In-Reply-To: <e4cb19870607051948t7e6d208m729a572a65f2da5e@mail.gmail.com>
References: <e4cb19870607051948t7e6d208m729a572a65f2da5e@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 22:48:17 -0400
"Thomas Tuttle" <thinkinginbinary@gmail.com> wrote:

> Here is a new version of the patch, incorporating code style tips from
> Randy Dunlap <rdunlap@xenotime.net>, and based on 2.6.17-git25, rather
> than 2.6.17.1.
> 
> I noticed that there's a Heartbeat LED trigger in the git version.  I
> hope this isn't too similar.
> 

> --- linux-2.6.17-git25/drivers/leds/Kconfig	2006-07-05 22:11:45.000000000 -0400
> +++ linux-2.6.17-git25-mine/drivers/leds/Kconfig	2006-07-05 22:42:58.000000000 -0400
> @@ -93,6 +93,41 @@
>  	  This allows LEDs to be controlled by IDE disk activity.
>  	  If unsure, say Y.
>  
> +config LEDS_TRIGGER_CPU
> +	tristate "LED CPU Trigger"
> +	depends LEDS_TRIGGERS
> +	help
> +	  This allows LEDs to be controlled by CPU activity.
> +	  If unsure, say Y.
> +
> +config LEDS_TRIGGER_CPU_INCLUDE_USER
> +	bool "Include user time in CPU trigger"
> +	depends LEDS_TRIGGER_CPU
> +	default y
> +	help
> +	  This option makes user CPU time cause the CPU trigger to activate.
> +
> +config LEDS_TRIGGER_CPU_INCLUDE_NICE
> +	bool "Include nice time in CPU trigger"
> +	depends LEDS_TRIGGER_CPU
> +	default n
> +	help
> +	  This option makes nice CPU time cause the CPU trigger to activate.
> +
> +config LEDS_TRIGGER_CPU_INCLUDE_SYSTEM
> +	bool "Include system time in CPU trigger"
> +	depends LEDS_TRIGGER_CPU
> +	default y
> +	help
> +	  This option makes system CPU time cause the CPU trigger to activate.
> +
> +config LEDS_TRIGGER_CPU_INCLUDE_IOWAIT
> +	bool "Include iowait time in CPU trigger"
> +	depends LEDS_TRIGGER_CPU
> +	default n
> +	help
> +	  This option makes iowait CPU time cause the CPU trigger to activate.

waaaaaaaaaaay too many config options.  Make up your mind, man ;)

> +cputime64_t last_cputime;

static.

> +static void __exit ledtrig_cpu_exit(void)
> +{
> +	del_timer(&ledtrig_cpu_timer);

del_timer_sync().


