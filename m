Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVCVVH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVCVVH3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVCVVH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:07:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:61371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261307AbVCVVHW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:07:22 -0500
Date: Tue, 22 Mar 2005 13:06:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?UGF3ZV9f?= Sikora <pluto@pld-linux.org>
Cc: linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
       Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH][alpha] "pm_power_off"
 [drivers/char/ipmi/ipmi_poweroff.ko] undefined!
Message-Id: <20050322130657.7502418d.akpm@osdl.org>
In-Reply-To: <200503152335.48995.pluto@pld-linux.org>
References: <200503152335.48995.pluto@pld-linux.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawe__ Sikora <pluto@pld-linux.org> wrote:
>
> Fix for modpost warning:
>  "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!
> 
>  --- linux-2.6.11.3/arch/alpha/kernel/alpha_ksyms.c.orig	2005-03-13 07:44:05.000000000 +0100
>  +++ linux-2.6.11.3/arch/alpha/kernel/alpha_ksyms.c	2005-03-15 23:20:00.405832368 +0100
>  @@ -67,6 +67,9 @@
>   EXPORT_SYMBOL(alpha_using_srm);
>   #endif /* CONFIG_ALPHA_GENERIC */
>   
>  +#include <linux/pm.h>
>  +EXPORT_SYMBOL(pm_power_off);
>  +
>   /* platform dependent support */
>   EXPORT_SYMBOL(strcat);
>   EXPORT_SYMBOL(strcmp);
>  --- linux-2.6.11.3/arch/alpha/kernel/process.c.orig	2005-03-13 07:44:40.000000000 +0100
>  +++ linux-2.6.11.3/arch/alpha/kernel/process.c	2005-03-15 23:28:15.687538104 +0100
>  @@ -183,6 +183,8 @@
>   
>   EXPORT_SYMBOL(machine_power_off);
>   
>  +void (*pm_power_off)(void) = machine_power_off;
>  +
>   /* Used by sysrq-p, among others.  I don't believe r9-r15 are ever
>      saved in the context it's used.  */

There doesn't seem to be a lot of point in defining it and not using it.

Perhaps IPMI is making untoward assumptions about the architecture's power
management?  Should we instead be disabling CONFIG_IPMI_POWEROFF on alpha
(and others?)

