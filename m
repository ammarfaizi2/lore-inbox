Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVGJFmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVGJFmn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 01:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVGJFmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 01:42:32 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:50486 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261857AbVGJFmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 01:42:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mD2hf0XzBhFspAe1zKYoQTFOv83QcAfkCgF2KgGRg6xvKoKT/qeUK99+yA2VJrElbA6BWc1CY8RTi+qU2wq2RtyQ5bE1cfw2uWA8nBiNBfeoP4TL2/dJjD+uO4aNskdrviDc13/IkorlPGAWnBD63a+y6Bvby33ABZp/Ilk9fJU=
Message-ID: <d73ab4d0050709224225b2e528@mail.gmail.com>
Date: Sun, 10 Jul 2005 13:42:20 +0800
From: guorke <gourke@gmail.com>
Reply-To: guorke <gourke@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: I confused about diff(simple question)
In-Reply-To: <d73ab4d005070922413fb0dbba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d73ab4d005070922413fb0dbba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/05, guorke <gourke@gmail.com> wrote:
> like:
> 
>  /*
> @@ -220,9 +232,8(HERE: why not -220,9 +220,8) @@ fastcall notrace void
> do_page_fault(stru
>       struct vm_area_struct * vma;
>       unsigned long address;
>       unsigned long page;
> -       int write;
> -       siginfo_t info;
> -
> +       int write, si_code;
> +
>       /* get the address */
>       __asm__("movl %%cr2,%0":"=r" (address));
>       trace_special(regs->eip, error_code, address);
> @@ -236,7 +247,7 (HERE: why not -236,7,+236,7) @@ fastcall notrace
> void do_page_fault(stru
> 
>       tsk = current;
> 
> -       info.si_code = SEGV_MAPERR;
> +       si_code = SEGV_MAPERR;
> 
>       /*
>        * We fault-in kernel-space virtual memory on-demand. The
> @@ -316,7 +327,7 (HERE -316,7, +316,7) @@ fastcall notrace void
> do_page_fault(stru
>  * we can handle it..
>  */
>  good_area:
> -       info.si_code = SEGV_ACCERR;
> +       si_code = SEGV_ACCERR;
>       write = 0;
>       switch (error_code & 3) {
>               default:        /* 3: write, present */
> @@ -390,11 +401,7 (HERE:why not -390,11,+390,11) @@ bad_area_nosemaphore:
>               /* Kernel addresses are always protection faults */
>               tsk->thread.error_code = error_code | (address >= TASK_SIZE);
>               tsk->thread.trap_no = 14;
> -               info.si_signo = SIGSEGV;
> -               info.si_errno = 0;
> -               /* info.si_code has been set above */
> -               info.si_addr = (void __user *)address;
> -               force_sig_info(SIGSEGV, &info, tsk);
> +               force_sig_info_fault(SIGSEGV, si_code, address, tsk);
>               return;
>       }
> 
> @@ -500,11 +507,7(HERE: why not -500,11,+500,7) @@ do_sigbus:
>       tsk->thread.cr2 = address;
>       tsk->thread.error_code = error_code;
>       tsk->thread.trap_no = 14;
> -       info.si_signo = SIGBUS;
> -       info.si_errno = 0;
> -       info.si_code = BUS_ADRERR;
> -       info.si_addr = (void __user *)address;
> -       force_sig_info(SIGBUS, &info, tsk);
> +       force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
>       return;
> 
> ...
> 
> in :-220,9 +232,8
>  I think the old file from the line 220,and have 9 lines,then the
> newfile have 8 lines
> so must delete one line. but why +232,it from the line 232 ?
> like this..
> 
> maybe it's very very simple.but i really confused it.wishes helps,
> 
> Thanks
> 
> --------
> guorke
>
