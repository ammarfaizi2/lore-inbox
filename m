Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWHPVxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWHPVxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWHPVxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:53:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932268AbWHPVxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:53:00 -0400
Date: Wed, 16 Aug 2006 14:52:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Message-Id: <20060816145242.32faa669.akpm@osdl.org>
In-Reply-To: <200608162305.34038.rjw@sisk.pl>
References: <200608162259.00941.rjw@sisk.pl>
	<200608162305.34038.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 23:05:33 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> by people who know exactly what they are doing, from kernel/power/Kconfig .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  kernel/power/Kconfig |   18 ------------------
>  1 files changed, 18 deletions(-)
> 
> Index: linux-2.6.18-rc4-mm1/kernel/power/Kconfig
> ===================================================================
> --- linux-2.6.18-rc4-mm1.orig/kernel/power/Kconfig
> +++ linux-2.6.18-rc4-mm1/kernel/power/Kconfig
> @@ -47,24 +47,6 @@ config PM_DISABLE_CONSOLE_SUSPEND
>  	suspend/resume routines, but may itself lead to problems, for example
>  	if netconsole is used.
>  
> -config PM_TRACE
> -	bool "Suspend/resume event tracing"
> -	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
> -	default n
> -	---help---
> -	This enables some cheesy code to save the last PM event point in the
> -	RTC across reboots, so that you can debug a machine that just hangs
> -	during suspend (or more commonly, during resume).
> -
> -	To use this debugging feature you should attempt to suspend the machine,
> -	then reboot it, then run
> -
> -		dmesg -s 1000000 | grep 'hash matches'
> -
> -	CAUTION: this option will cause your machine's real-time clock to be
> -	set to an invalid time after a resume.
> -
> -
>  config SOFTWARE_SUSPEND
>  	bool "Software Suspend"
>  	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)

So...  how are people supposed to turn it on again?  By patching the
kernel?  That's a bit painful if they're using (say) fedora-of-the-day.

How about we add a kernel boot parameter to enable it at runtime?
