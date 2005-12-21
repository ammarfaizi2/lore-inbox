Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVLUKpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVLUKpE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 05:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLUKpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 05:45:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbVLUKpB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 05:45:01 -0500
Date: Wed, 21 Dec 2005 02:41:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, uclinux-v850@lsi.nec.co.j
Subject: Re: [RFC: 2.6 patch] include/linux/irq.h: #include <linux/smp.h>
Message-Id: <20051221024133.93b75576.akpm@osdl.org>
In-Reply-To: <20051221012750.GD5359@stusta.de>
References: <20051221012750.GD5359@stusta.de>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> The #include <asm/smp.h> in irq.h was intruduced in 2.6.15-rc.
> 
> Since include/linux/irq.h needs code from asm/smp.h only in the 
> CONFIG_SMP=y case and linux/smp.h #include's asm/smp.h only in the
> CONFIG_SMP=y case, I'm suggesting this patch to #include <linux/smp.h>
> in irq.h.
> 
> I've tested the compilation with both CONFIG_SMP=y and CONFIG_SMP=n
> on i386.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.15-rc6/include/linux/irq.h.old	2005-12-20 21:45:57.000000000 +0100
> +++ linux-2.6.15-rc6/include/linux/irq.h	2005-12-20 21:46:08.000000000 +0100
> @@ -10,7 +10,7 @@
>   */
>  
>  #include <linux/config.h>
> -#include <asm/smp.h>		/* cpu_online_map */
> +#include <linux/smp.h>
>  
>  #if !defined(CONFIG_ARCH_S390)

Yes, it's basically always wrong to include asm/foo.h when linux/foo.h
exists. 
