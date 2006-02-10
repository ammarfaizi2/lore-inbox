Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWBJVOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWBJVOq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWBJVOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:14:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750948AbWBJVOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:14:45 -0500
Date: Fri, 10 Feb 2006 13:14:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix s390 build failure.
In-Reply-To: <20060210200425.GA11913@redhat.com>
Message-ID: <Pine.LNX.4.64.0602101314082.19172@g5.osdl.org>
References: <20060210200425.GA11913@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Dave Jones wrote:
>
> arch/s390/kernel/compat_signal.c:199: error: conflicting types for 'do_sigaction'
> include/linux/sched.h:1115: error: previous declaration of 'do_sigaction' was here
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c~	2006-02-10 12:47:57.000000000 -0500
> +++ linux-2.6.15.noarch/arch/s390/kernel/compat_signal.c	2006-02-10 12:48:05.000000000 -0500
> @@ -196,7 +196,7 @@ sys32_sigaction(int sig, const struct ol
>  }
>  
>  int
> -do_sigaction(int sig, const struct k_sigaction *act, struct k_sigaction *oact);
> +do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact);

Umm. Shouldn't we just _remove_ the incorrect and unnecessary 
extra declaration?

		Linus
