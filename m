Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUKLTXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUKLTXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbUKLTVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:21:39 -0500
Received: from mx1.elte.hu ([157.181.1.137]:57764 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262211AbUKLTUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:20:25 -0500
Date: Fri, 12 Nov 2004 21:22:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: 4/4GB:
Message-ID: <20041112202229.GB15256@elte.hu>
References: <41939163.5020305@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41939163.5020305@sw.ru>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kirill Korotaev <dev@sw.ru> wrote:

>  #define __RESTORE_REGS	\
>  	__RESTORE_INT_REGS; \
> +	popl %ds;	\
> +	popl %es;
> +
> +#define __RESTORE_REGS_USER \
> +	__RESTORE_INT_REGS; \
>  111:	popl %ds;	\
>  222:	popl %es;	\
> -.section .fixup,"ax";	\
> +	jmp 666f;	\
>  444:	movl $0,(%esp);	\
>  	jmp 111b;	\
>  555:	movl $0,(%esp);	\
>  	jmp 222b;	\
> -.previous;		\
> +666:			\
>  .section __ex_table,"a";\
>  	.align 4;	\
>  	.long 111b,444b;\
> @@ -220,6 +225,13 @@ int80_ret_end_marker:					\
>  
>  #define __RESTORE_ALL	\
>  	__RESTORE_REGS	\
> +	__RESTORE_IRET
> +
> +#define __RESTORE_ALL_USER \
> +	__RESTORE_REGS_USER \
> +	__RESTORE_IRET
> +
> +#define __RESTORE_IRET	\
>  	addl $4, %esp;	\
>  333:	iret;		\
>  .section .fixup,"ax";   \

looks fine and necessary. Fundamental bugs in this area tend to show up
as instant reboots, so i'm sure if you broke this code you'll quickly
notice it ...

	Ingo
