Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281558AbRKPVnC>; Fri, 16 Nov 2001 16:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281559AbRKPVmx>; Fri, 16 Nov 2001 16:42:53 -0500
Received: from air-1.osdl.org ([65.201.151.5]:26374 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S281558AbRKPVmj>;
	Fri, 16 Nov 2001 16:42:39 -0500
Message-ID: <3BF587F8.84607648@osdl.org>
Date: Fri, 16 Nov 2001 13:41:12 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111162219170.22827-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave-
A couple of minor comments below.

~Randy

Dave Jones wrote:
> 
> Note, this code will not stop you from continuing to use unsupported
> configurations, but will..
> a. Print a boot time warning.
> b. Taint any oopses so that SMP problem oopses can be isolated easily.
> 
> I repeat, there is *no* loss of functionality.
> 
> Patch against 2.4.15pre5 follows.
> 
> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/arch/i386/kernel/smpboot.c linux-2.4.15-pre5-dj/arch/i386/kernel/smpboot.c
> --- linux-2.4.15-pre5/arch/i386/kernel/smpboot.c        Fri Oct  5 01:42:54 2001
> +++ linux-2.4.15-pre5-dj/arch/i386/kernel/smpboot.c     Fri Nov 16 21:09:33 2001
> +               printk (KERN_INFO "WARNING: This combination of AMD processors is not suitable for SMP.\n");
> +               tainted |= (1<<2);

Some bit #defines for <tainted> would be nice (instead of magic
numbers).


> diff -urN --exclude-from=/home/davej/.exclude linux-2.4.15-pre5/kernel/panic.c linux-2.4.15-pre5-dj/kernel/panic.c
> --- linux-2.4.15-pre5/kernel/panic.c    Sun Sep 30 19:26:08 2001
> +++ linux-2.4.15-pre5-dj/kernel/panic.c Fri Nov 16 20:46:17 2001
> @@ -103,6 +103,10 @@
>  /**
>   *     print_tainted - return a string to represent the kernel taint state.
>   *
> + *  'P' - Proprietory module has been loaded.
> + *  'F' - Module has been forcibly loaded.
> + *  'S' - SMP with CPUs not designed for SMP.
> + *
>   *     The string is overwritten by the next call to print_taint().
>   */
> 
> @@ -112,7 +116,8 @@
>         if (tainted) {
>                 snprintf(buf, sizeof(buf), "Tainted: %c%c",
>>>>>>>>>>>>>>>>>>                                     %c%c%c <<<<<<<<<<<<<

>                         tainted & 1 ? 'P' : 'G',
> -                       tainted & 2 ? 'F' : ' ');
> +                       tainted & 2 ? 'F' : ' ',
> +                       tainted & 4 ? 'S' : ' ');
>         }
>         else
>                 snprintf(buf, sizeof(buf), "Not tainted");
