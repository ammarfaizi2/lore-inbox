Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUEKRbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUEKRbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUEKRbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:31:05 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:3199 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264885AbUEKR2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:28:45 -0400
Subject: Re: [patch] really-ptrace-single-step
From: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
To: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Message-Id: <1084296680.2912.8.camel@slack.domain.invalid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 May 2004 14:31:20 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still not getting the desired result.
Which kernel is the patch based on?

On Tue, 2004-05-11 at 14:12, Davide Libenzi wrote:
> This patch lets a ptrace process on x86 to "see" the instruction 
> following the INT #80h op.
> 
> 
> 
> - Davide
> 
> 
> arch/i386/kernel/entry.S       |    2 +-
> include/asm-i386/thread_info.h |    2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> 
> 
> Index: arch/i386/kernel/entry.S
> ===================================================================
> RCS file: /usr/src/bkcvs/linux-2.5/arch/i386/kernel/entry.S,v
> retrieving revision 1.83
> diff -u -r1.83 entry.S
> --- arch/i386/kernel/entry.S	12 Apr 2004 20:29:12 -0000	1.83
> +++ arch/i386/kernel/entry.S	11 May 2004 06:35:29 -0000
> @@ -354,7 +354,7 @@
>  	# perform syscall exit tracing
>  	ALIGN
>  syscall_exit_work:
> -	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT), %cl
> +	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
>  	jz work_pending
>  	sti				# could let do_syscall_trace() call
>  					# schedule() instead
> Index: include/asm-i386/thread_info.h
> ===================================================================
> RCS file: /usr/src/bkcvs/linux-2.5/include/asm-i386/thread_info.h,v
> retrieving revision 1.19
> diff -u -r1.19 thread_info.h
> --- include/asm-i386/thread_info.h	12 Apr 2004 20:29:12 -0000	1.19
> +++ include/asm-i386/thread_info.h	11 May 2004 06:34:47 -0000
> @@ -165,7 +165,7 @@
>  
>  /* work to do on interrupt/exception return */
>  #define _TIF_WORK_MASK \
> -  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT))
> +  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP))
>  #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
>  
>  /*
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

