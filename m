Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271712AbRHUOxg>; Tue, 21 Aug 2001 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271713AbRHUOx0>; Tue, 21 Aug 2001 10:53:26 -0400
Received: from ultra.sonic.net ([208.201.224.22]:26209 "EHLO ultra.sonic.net")
	by vger.kernel.org with ESMTP id <S271712AbRHUOxN>;
	Tue, 21 Aug 2001 10:53:13 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Tue, 21 Aug 2001 07:53:26 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.9 build fails on Mandrake 8.0 ( make modules_install 'isdn')
Message-ID: <20010821075326.A8844@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0108200019320.23800-100000@vaio>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 12:19:49AM +0200, Kai Germaschewski wrote:
> On Sun, 19 Aug 2001, Chris Oxenreider wrote:
> 
> > depmod: *** Unresolved symbols in
> > /lib/modules/2.4.9/kernel/drivers/isdn/eicon/eicon.o
> > depmod: 	vsnprintf
> 
> This patch should fix it:

Hmmm... with that patch, I get the following errors:

make[2]: Entering directory `/usr/src/linux/linux-2.4.9/kernel'
gcc -D__KERNEL__ -I/usr/src/linux/linux-2.4.9/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i586    -DEXPORT_SYMTAB -c ksyms.c
ksyms.c:461: `snprintf' undeclared here (not in a function)
ksyms.c:461: initializer element is not constant
ksyms.c:461: (near initialization for `__ksymtab_snprintf.value')
ksyms.c:462: `vsnprintf' undeclared here (not in a function)
ksyms.c:462: initializer element is not constant
ksyms.c:462: (near initialization for `__ksymtab_vsnprintf.value')
make[2]: *** [ksyms.o] Error 1
make[2]: Leaving directory `/usr/src/linux/linux-2.4.9/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/linux-2.4.9/kernel'
make: *** [_dir_kernel] Error 2

Do I have an out of date tool?
mrc


> 
> diff -u linux-2.4.9/kernel/ksyms.c linux-2.4.9.work/kernel/ksyms.c
> --- linux-2.4.9/kernel/ksyms.c	Fri Aug 17 09:57:12 2001
> +++ linux-2.4.9.work/kernel/ksyms.c	Mon Aug 20 00:16:58 2001
> @@ -458,6 +458,8 @@
>  EXPORT_SYMBOL(printk);
>  EXPORT_SYMBOL(sprintf);
>  EXPORT_SYMBOL(vsprintf);
> +EXPORT_SYMBOL(snprintf);
> +EXPORT_SYMBOL(vsnprintf);
>  EXPORT_SYMBOL(kdevname);
>  EXPORT_SYMBOL(bdevname);
>  EXPORT_SYMBOL(cdevname);

-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
