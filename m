Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVEPXgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVEPXgc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVEPXgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:36:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:20459 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261306AbVEPXga (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:36:30 -0400
Date: Mon, 16 May 2005 16:37:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: YhLu@tyan.com, linux-tiny@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: serial console
Message-Id: <20050516163712.66a1a058.akpm@osdl.org>
In-Reply-To: <20050516231508.GD5914@waste.org>
References: <3174569B9743D511922F00A0C943142309F80D9F@TYANWEB>
	<20050516205731.GA5914@waste.org>
	<20050516231508.GD5914@waste.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> Fix compile bug with serial console and printk disabled.
> 
> Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Index: l-p/kernel/printk.c
> ===================================================================
> --- l-p.orig/kernel/printk.c	2005-05-16 15:13:51.000000000 -0700
> +++ l-p/kernel/printk.c	2005-05-16 15:29:56.000000000 -0700
> @@ -665,6 +665,11 @@ asmlinkage long sys_syslog(int type, cha
>  	return 0;
>  }
>  
> +int __init add_preferred_console(char *name, int idx, char *options)
> +{
> +	return 0;
> +}
> +

It would be nicer if this was a static inline, so all the function call
code at the callsites is removed by the compiler.

Yes, it's presumably __init code anyway, but that's no excuse ;)
