Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWGKT4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWGKT4r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWGKT4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:56:47 -0400
Received: from [212.33.164.213] ([212.33.164.213]:59666 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932119AbWGKT4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:56:46 -0400
From: Al Boldi <a1426z@gawab.com>
To: Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Tue, 11 Jul 2006 22:57:22 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607112257.22069.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:
>
> Do not randomize stack location unless current->personality permits it.
>
> Signed-off-by: Frank van Maarseveen <frankvm@frankvm.com>
> ---
>
> The problem seems also present in
>
>         arch/um/kernel/process_kern.c
>         arch/x86_64/kernel/process.c
>
>  arch/i386/kernel/process.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
>
> diff -rup a/arch/i386/kernel/process.c b/arch/i386/kernel/process.c
> --- a/arch/i386/kernel/process.c        2006-06-23 16:08:13.000000000
> +0200 +++ b/arch/i386/kernel/process.c        2006-07-11
> 14:39:20.000000000 +0200 @@ -38,6 +38,7 @@
>  #include <linux/kallsyms.h>
>  #include <linux/ptrace.h>
>  #include <linux/random.h>
> +#include <linux/personality.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/pgtable.h>
> @@ -898,7 +899,7 @@ asmlinkage int sys_get_thread_area(struc
>
>  unsigned long arch_align_stack(unsigned long sp)
>  {
> -       if (randomize_va_space)
> +       if (!(current->personality & ADDR_NO_RANDOMIZE) &&
> randomize_va_space) sp -= get_random_int() % 8192;
>         return sp & ~0xf;
>  }

It still blips on my system.

echo 0 > /proc/sys/kernel/randomize_va_space makes the blips go away.

???

Thanks!

--
Al

