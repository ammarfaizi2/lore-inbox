Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbUKAANh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbUKAANh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 19:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUKAANh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 19:13:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:12012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261706AbUKAANf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 19:13:35 -0500
Date: Sun, 31 Oct 2004 16:13:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 504] m68k: smp_lock.h: Avoid recursive include
In-Reply-To: <200410311003.i9VA3d14009637@anakin.of.borg>
Message-ID: <Pine.LNX.4.58.0410311612140.17101@ppc970.osdl.org>
References: <200410311003.i9VA3d14009637@anakin.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one is _totally_ broken. 

Not only is that include not recursive, but it immediately breaks any SMP 
compile because that header file _needs_ the definition of "task_struct".

I applied it without realizing it, but I'll undo it and I hope you fix 
your broken tree so that I don't ever have to see this broken patch 
again..

		Linus

On Sun, 31 Oct 2004, Geert Uytterhoeven wrote:
>
> smp_lock.h: Avoid recursive include
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> --- linux-2.6.10-rc1/include/linux/smp_lock.h	2004-04-28 15:47:31.000000000 +0200
> +++ linux-m68k-2.6.10-rc1/include/linux/smp_lock.h	2004-10-20 22:24:05.000000000 +0200
> @@ -2,7 +2,6 @@
>  #define __LINUX_SMPLOCK_H
>  
>  #include <linux/config.h>
> -#include <linux/sched.h>
>  #include <linux/spinlock.h>
>  
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
