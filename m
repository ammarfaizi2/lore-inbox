Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSDCWZa>; Wed, 3 Apr 2002 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312425AbSDCWZV>; Wed, 3 Apr 2002 17:25:21 -0500
Received: from quark.didntduck.org ([216.43.55.190]:59397 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S312418AbSDCWZP>; Wed, 3 Apr 2002 17:25:15 -0500
Message-ID: <3CAB8133.1AAF5338@didntduck.org>
Date: Wed, 03 Apr 2002 17:24:51 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn users about machines with non-working WP bit
In-Reply-To: <20020403215457.GA1050@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> This might be good idea, as those machines are not safe for multiuser
> systems.
> 
> --- clean.2.5/arch/i386/mm/init.c       Sun Mar 10 20:06:31 2002
> +++ linux/arch/i386/mm/init.c   Mon Mar 11 21:49:14 2002
> @@ -383,7 +383,7 @@
>         local_flush_tlb();
> 
>         if (!boot_cpu_data.wp_works_ok) {
> -               printk("No.\n");
> +               printk("No (that's security hole).\n");
>  #ifdef CONFIG_X86_WP_WORKS_OK
>                 panic("This kernel doesn't support CPU's with broken WP. Recompile it for a 386!");
>  #endif
> 
>                                                                         Pavel

The "bug" is really the lack of a feature present on 486+ cpus.  A 386
will allow the kernel to write to a write-protected user page (but not a
write-protected kernel page).  In user mode, write protect works as it
should.  The kernel works around this by doing extra checks when writing
to user pages (check the *_user() functions).  It is not a security
hole, because if the kernel wasn't compiled with the workaround, it
refuses to boot on those cpus.

--

				Brian Gerst
