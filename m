Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVBDWEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVBDWEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266428AbVBDVsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 16:48:06 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:15334 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266203AbVBDV1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 16:27:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=go5g2RtLSjspl8fd5ufocy7yipTFdJmqCrYBDcNik8Rj73/YYTJYRWyDa5R6tBqTcagAzXjgxPuLp4BbH7DgNhq0ZgjrN1Vy1UwztF/jD7lldQ37/YJ3aWKEWS3y/TGjmiKB/4B3DLskLLlpXO6/BqOpy9qnKQT1Jf4Isy0HEFc=
Message-ID: <40f323d0050204132737396647@mail.gmail.com>
Date: Fri, 4 Feb 2005 22:27:09 +0100
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Patch 1/6 introduce sysctl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050127101201.GB9760@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050127101117.GA9760@infradead.org>
	 <20050127101201.GB9760@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 10:12:01 +0000, Arjan van de Ven
<arjan@infradead.org> wrote:
> 
> This first patch of the series introduces a sysctl (default off) that
> enables/disables the randomisation feature globally. Since randomisation may
> make it harder to debug really tricky situations (reproducability goes
> down), the sysadmin needs a way to disable it globally.
> 
> Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> 
> diff -purN linux-2.6.11-rc2-bk4/include/linux/kernel.h linux-step-1/include/linux/kernel.h
> --- linux-2.6.11-rc2-bk4/include/linux/kernel.h 2005-01-26 18:24:39.000000000 +0100
> +++ linux-step-1/include/linux/kernel.h 2005-01-26 19:04:58.016540168 +0100
> @@ -278,6 +278,9 @@ struct sysinfo {
>  extern void BUILD_BUG(void);
>  #define BUILD_BUG_ON(condition) do { if (condition) BUILD_BUG(); } while(0)
> 
> +
> +extern int randomize_va_space;
> +
>  /* Trap pasters of __FUNCTION__ at compile-time */
>  #if __GNUC__ > 2 || __GNUC_MINOR__ >= 95
>  #define __FUNCTION__ (__func__)
> [snip]
>
> diff -purN linux-2.6.11-rc2-bk4/kernel/sysctl.c linux-step-1/kernel/sysctl.c
> --- linux-2.6.11-rc2-bk4/kernel/sysctl.c        2005-01-26 18:24:39.000000000 +0100
> +++ linux-step-1/kernel/sysctl.c        2005-01-26 19:03:44.000000000 +0100
> @@ -122,6 +122,8 @@ extern int sysctl_hz_timer;
>  extern int acct_parm[];
>  #endif
> 
> +int randomize_va_space = 0;
> +
>  static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
>                        ctl_table *, void **);
>  static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
>
> [snip]

This breaks the compilation with allnoconfig (since CONFIG_SYSCTL is
not defined):

arch/i386/kernel/built-in.o(.text+0xf92): In function `arch_align_stack':
: undefined reference to `randomize_va_space'

maybe randomize_va_space should be defined as extern in sysctl.c and
put elsewhere.

regards,

Benoit
