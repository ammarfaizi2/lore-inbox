Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVEOLiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVEOLiF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 07:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbVEOLiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 07:38:05 -0400
Received: from one.firstfloor.org ([213.235.205.2]:5505 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261610AbVEOLiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 07:38:02 -0400
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: tickle nmi watchdog whilst doing serial writes.
References: <20050513184806.GA24166@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: Sun, 15 May 2005 13:38:02 +0200
In-Reply-To: <20050513184806.GA24166@redhat.com> (Dave Jones's message of
 "Fri, 13 May 2005 14:48:06 -0400")
Message-ID: <m1u0l4afdx.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:
>  
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -2099,8 +2100,10 @@ static inline void wait_for_xmitr(struct
>  	if (up->port.flags & UPF_CONS_FLOW) {
>  		tmout = 1000000;
>  		while (--tmout &&
> -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
>  			udelay(1);
> +			touch_nmi_watchdog();

Note that touch_nmi_watchdog is not exported on i386 - Linus vetoed
that some time ago. The real fix of course is to use schedule_timeout(),
but that might break printk() with interrupts off :/

-Andi
