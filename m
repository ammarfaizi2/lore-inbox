Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVJYC0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVJYC0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 22:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVJYC0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 22:26:08 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:55044 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751411AbVJYC0G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 22:26:06 -0400
Date: Mon, 24 Oct 2005 22:18:28 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, blaisorblade@yahoo.it
Subject: Re: [PATCH 2.6.14-rc5-mm1] UML: fix compile part-2
Message-ID: <20051025021828.GA13870@ccure.user-mode-linux.org>
References: <E1EU4jP-0005lz-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EU4jP-0005lz-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 05:59:27PM +0200, Miklos Szeredi wrote:
> This patch fixes the following compile error:
> 
>   LD      .tmp_vmlinux1
> arch/um/kernel/built-in.o(.text+0x577a): In function `do_gettimeofday':
> arch/um/kernel/time.c:128: undefined reference to `clock_was_set'
> collect2: ld returned 1 exit status
> 
> ktimers patch left all clock_was_set() calls in place presumably
> because they will be reused at a later time (?).  So this patch does
> the same.
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> 
> Index: linux/arch/um/kernel/time.c
> ===================================================================
> --- linux.orig/arch/um/kernel/time.c	2005-09-02 11:17:38.000000000 +0200
> +++ linux/arch/um/kernel/time.c	2005-10-24 13:26:20.000000000 +0200
> @@ -114,8 +114,8 @@ void time_init(void)
>  	wall_to_monotonic.tv_nsec = -now.tv_nsec;
>  }
>  
> -/* Declared in linux/time.h, which can't be included here */
> -extern void clock_was_set(void);
> +/* Defined in linux/ktimer.h, which can't be included here */
> +#define clock_was_set()		do { } while (0)
>  
>  void do_gettimeofday(struct timeval *tv)
>  {
> -

Acked-by: Jeff Dike <jdike@addtoit.com>

				Jeff
