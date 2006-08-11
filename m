Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWHKOMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWHKOMk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 10:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHKOMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 10:12:40 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:43475 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751141AbWHKOMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 10:12:39 -0400
Subject: Re: mingo@elte.hu, tglx@linutronix.de, linuxppc-dev@ozlabs.org,
	tsutomu.owa@toshiba.co.jp
From: Daniel Walker <dwalker@mvista.com>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yyilkpwhvwh.wl@forest.swc.toshiba.co.jp>
References: <yyilkpwhvwh.wl@forest.swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 07:12:35 -0700
Message-Id: <1155305556.16579.49.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 11:02 +0900, Tsutomu OWA wrote:

> +
> +#if defined(CONFIG_PREEMPT_TRACE) || defined(CONFIG_LATENCY_TRACE)
> +        print_traces(current);
> +#endif /* CONFIG_PREEMPT_TRACE || CONFIG_LATENCY_TRACE */

You shouldn't need the ifdef's here.

> +#ifdef CONFIG_DEBUG_MUTEXES
> +	show_held_locks(current);
> +#endif /* CONFIG_DEBUG_MUTEXES */
> +
>  }
>  EXPORT_SYMBOL(dump_stack);
>  
> diff -rup -x CVS 2.6.16-rt17/arch/powerpc/kernel/prom.c rt-powerpc/arch/powerpc/kernel/prom.c

Your on an ancient version of the -rt patch. I see that your using CVS
which explains that. If you want to keep better pace you should consider
not using CVS. 


> diff -rup -x CVS 2.6.16-rt17/lib/string.c rt-powerpc/lib/string.c
> --- 2.6.16-rt17/lib/string.c	2006-03-20 14:53:29.000000000 +0900
> +++ rt-powerpc/lib/string.c	2006-06-16 13:08:07.000000000 +0900
> @@ -67,7 +67,7 @@ EXPORT_SYMBOL(strnicmp);
>   * @src: Where to copy the string from
>   */
>  #undef strcpy
> -char *strcpy(char *dest, const char *src)
> +char * notrace strcpy(char *dest, const char *src)
>  {
>  	char *tmp = dest;

Why are these notrace ?


Daniel


