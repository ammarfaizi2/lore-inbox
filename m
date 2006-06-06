Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932081AbWFFEWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWFFEWN (ORCPT <rfc822;akpm@zip.com.au>);
	Tue, 6 Jun 2006 00:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWFFEWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 00:22:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38305 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932081AbWFFEWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 00:22:12 -0400
Date: Mon, 5 Jun 2006 21:18:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [patch] i386: print NUMA in oops messages
Message-Id: <20060605211855.d92dab53.akpm@osdl.org>
In-Reply-To: <200606052303_MC3-1-C1B2-7E2C@compuserve.com>
References: <200606052303_MC3-1-C1B2-7E2C@compuserve.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 23:01:14 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> +		printk(
>  #ifdef CONFIG_PREEMPT
> -		printk("PREEMPT ");
> +			"PREEMPT "
>  #endif
>  #ifdef CONFIG_SMP
> -		printk("SMP ");
> +			"SMP "
> +#endif
> +#ifdef CONFIG_NUMA
> +			"NUMA "
>  #endif
>  #ifdef CONFIG_DEBUG_PAGEALLOC
> -		printk("DEBUG_PAGEALLOC");
> +			"DEBUG_PAGEALLOC"
>  #endif
> -		printk("\n");
> +			"\n");
> +

This is too cute for my taste.  Keep it simple.

I suppose one could do something like

static const char config_string[] = ""
#ifdef CONFIG_SMP
	" SMP"
#endif
#ifdef CONFIG_NUMA
	" NUMA"
#endif
;

if one really feels so motivated...
