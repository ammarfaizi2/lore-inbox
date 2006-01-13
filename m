Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbWAMItV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbWAMItV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030325AbWAMItV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:49:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030323AbWAMItU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:49:20 -0500
Date: Fri, 13 Jan 2006 00:48:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       dhowells@redhat.com
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Message-Id: <20060113004842.4c419174.akpm@osdl.org>
In-Reply-To: <1137140937.2675.4.camel@localhost.localdomain>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924357.3435.107.camel@localhost.localdomain>
	<20060112195950.60188acf.akpm@osdl.org>
	<1137126606.3085.44.camel@localhost.localdomain>
	<20060112205451.392c0c5c.akpm@osdl.org>
	<20060112221037.5dbc3dd9.akpm@osdl.org>
	<1137133408.3621.6.camel@pmac.infradead.org>
	<1137140937.2675.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2006-01-13 at 06:23 +0000, David Woodhouse wrote:
> > I suspect it might be the sigset size. 
> 
> I bet this is it, although I haven't yet confirmed the theory....
> 
> Sorry, I should have tested this for myself on i386 before forwarding
> the patch. Stupid bloody legacy architecture :)
> 
> --- linux-2.6.15.ppc/kernel/compat.c~	2006-01-13 04:39:54.000000000 +0000
> +++ linux-2.6.15.ppc/kernel/compat.c	2006-01-13 08:23:24.000000000 +0000
> @@ -873,7 +873,7 @@ asmlinkage long compat_sys_stime(compat_
>  #endif /* __ARCH_WANT_COMPAT_SYS_TIME */
>  
>  #ifdef __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
> -long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
> +asmlinkage long compat_sys_rt_sigsuspend(compat_sigset_t __user *unewset, compat_size_t sigsetsize)
>  {
>  	sigset_t newset;
>  	compat_sigset_t newset32;
> --- linux-2.6.15.ppc/kernel/signal.c~	2006-01-13 04:39:54.000000000 +0000
> +++ linux-2.6.15.ppc/kernel/signal.c	2006-01-13 08:23:29.000000000 +0000
> @@ -2761,7 +2761,7 @@ sys_pause(void)
>  #endif
>  
>  #ifdef __ARCH_WANT_SYS_RT_SIGSUSPEND
> -long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
> +asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
>  {
>  	sigset_t newset;

I gues we want that, but x86 doesn't compile kernel/compat.c
