Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUKXCxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUKXCxO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbUKXCxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:53:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:61356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261688AbUKXCxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:53:03 -0500
Message-ID: <41A3F6F6.1040903@osdl.org>
Date: Tue, 23 Nov 2004 18:50:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: blaisorblade_spam@yahoo.it
CC: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com
Subject: Re: [patch 1/1] uml: fix some ptrace functions returns values
References: <20041124000715.E3A2FAB24@zion.localdomain>
In-Reply-To: <20041124000715.E3A2FAB24@zion.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade_spam@yahoo.it wrote:
> From: Jeff Dike <jdike@addtoit.com>
> 
> This patch adds ptrace_setfpregs and makes these functions return -errno on
> failure.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
> ---
> 
>  linux-2.6.10-rc-paolo/arch/um/sys-i386/ptrace_user.c |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff -puN arch/um/sys-i386/ptrace_user.c~uml-fix-ptrace-interfaces arch/um/sys-i386/ptrace_user.c
> --- linux-2.6.10-rc/arch/um/sys-i386/ptrace_user.c~uml-fix-ptrace-interfaces	2004-11-24 01:06:35.525806848 +0100
> +++ linux-2.6.10-rc-paolo/arch/um/sys-i386/ptrace_user.c	2004-11-24 01:06:35.528806392 +0100
> @@ -17,17 +17,30 @@
>  
>  int ptrace_getregs(long pid, unsigned long *regs_out)
>  {
> -	return(ptrace(PTRACE_GETREGS, pid, 0, regs_out));
> +	if(ptrace(PTRACE_GETREGS, pid, 0, regs_out) < 0)
> +		return(-errno);
> +	return(0);
>  }
>  
>  int ptrace_setregs(long pid, unsigned long *regs)
>  {
> -	return(ptrace(PTRACE_SETREGS, pid, 0, regs));
> +	if(ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
> +		return(-errno);
> +	return(0);
>  }
>  
>  int ptrace_getfpregs(long pid, unsigned long *regs)
>  {
> -	return(ptrace(PTRACE_GETFPREGS, pid, 0, regs));
> +	if(ptrace(PTRACE_GETFPREGS, pid, 0, regs) < 0)
> +		return(-errno);
> +	return(0);
> +}
> +
> +int ptrace_setfpregs(long pid, unsigned long *regs)
> +{
> +	if(ptrace(PTRACE_SETFPREGS, pid, 0, regs) < 0)
> +		return(-errno);
> +	return(0);
>  }
>  
>  static void write_debugregs(int pid, unsigned long *regs)

Looks OK except that someone's SPACEBAR is broken (missing)
and there are (unneeded/unwanted) parens on the returns.

-- 
~Randy
