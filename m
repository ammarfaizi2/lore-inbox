Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWBVAwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWBVAwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWBVAwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:52:13 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:27610 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751134AbWBVAwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:52:11 -0500
In-Reply-To: <200602212339.SAA1138491@shell.TheWorld.com>
References: <200602212339.SAA1138491@shell.TheWorld.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A2CF403-20CC-4AE9-B955-9BA2E92A5474@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: fix altivec_unavailable_exception Oopses
Date: Tue, 21 Feb 2006 18:52:16 -0600
To: Alan Curry <pacman@TheWorld.com>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Feb 21, 2006, at 5:39 PM, Alan Curry wrote:

> altivec_unavailable_exception is called without setting r3... it  
> looks like
> the r3 that actually gets passed in as struct pt_regs *regs is the
> undisturbed value of r3 at the time the altivec instruction was  
> encountered.
> The user actually gets to choose the pt_regs printed in the Oops!
>
> After applying the following patch to 2.6.16-rc4, I can no longer  
> cause an
> Oops by executing an altivec instruction with CONFIG_ALTIVEC=n. The  
> same
> change would probably also be good for arch/ppc/kernel/head.S to  
> fix the same
> Oops in 2.6.15.4, though I haven't tested that.
>
> --- arch/powerpc/kernel/head_32.S.orig	2006-02-21  
> 15:58:18.000000000 -0500
> +++ arch/powerpc/kernel/head_32.S	2006-02-21 15:59:23.000000000 -0500
> @@ -714,6 +714,7 @@
>  #ifdef CONFIG_ALTIVEC
>  	bne	load_up_altivec		/* if from user, just load it up */
>  #endif /* CONFIG_ALTIVEC */
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
>  	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
>
>  PerformanceMonitor:

Would you mine providing a patch for arch/ppc/kernel/head.S and  
adding a signed-off-by line.

- k
