Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVDZWQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVDZWQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVDZWQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:16:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:40402 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261812AbVDZWPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:15:53 -0400
Date: Wed, 27 Apr 2005 00:19:11 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: ak@suse.de, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.31-pre1] x86_64 breakage on UP_IOAPIC
In-Reply-To: <17006.40286.664503.252615@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.62.0504270017210.2071@dragon.hyggekrogen.localhost>
References: <17006.40286.664503.252615@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tiny, trivial, pedantic whitespace nit : 

On Tue, 26 Apr 2005, Mikael Pettersson wrote:

> The
> 
>   o x86_64: Resend lost APIC IRQs on Uniprocessor too
> 
> change in 2.4.31-pre1 causes linkage errors: on UP_IOAPIC systems it
> creates references to send_IPI_self() which is only defined on SMP.
> 
> The patch below reverts this change.
> 
> Alternatively, x86_64 could implement a send_IPI_self() fallback for !SMP,
> just like i386 does.
> 
> /Mikael
> 
> --- linux-2.4.31-pre1/include/asm-x86_64/hw_irq.h.~1~	2005-04-26 20:57:43.000000000 +0200
> +++ linux-2.4.31-pre1/include/asm-x86_64/hw_irq.h	2005-04-26 21:09:31.000000000 +0200
> @@ -156,7 +156,7 @@ static inline void x86_do_profile (unsig
>  	atomic_inc((atomic_t *)&prof_buffer[eip]);
>  }
>  
> -#ifdef CONFIG_X86_IO_APIC
> +#ifdef CONFIG_SMP /*more of this file should probably be ifdefed SMP */
                     ^^^
                      Space here?


-- 
Jesper

