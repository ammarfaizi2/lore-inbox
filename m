Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbUAXWlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 17:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUAXWlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 17:41:46 -0500
Received: from gamma.utc.fr ([195.83.155.32]:34016 "EHLO gamma.utc.fr")
	by vger.kernel.org with ESMTP id S262745AbUAXWln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 17:41:43 -0500
Message-ID: <1074983859.4012f3b32e87a@mailetu.utc.fr>
Date: Sat, 24 Jan 2004 23:37:39 +0100
From: eric.piel@tremplin-utc.net
To: Andrew Morton <akpm@osdl.org>
Cc: eric.piel@tremplin-utc.net, minyard@acm.org, george@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Incorrect value for SIGRTMAX
References: <1074979873.4012e421714b1@mailetu.utc.fr> <20040124143037.5116ccc9.akpm@osdl.org>
In-Reply-To: <20040124143037.5116ccc9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Spam-Checked-By: gamma.utc.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@osdl.org>:


> b) it's casting the result of (foo > N) to unsigned which is nonsensical.
> 
> Your patch doesn't address b).
> 
> I don't thik there's a case in which sigev_signo can be negative anyway. 
> But if there is, the cast should be done like the below, yes?
God! I hadn't catch this one :-) Actually, the cast is needed because
sigev_signo is an int, this catches the (all fobidden) negative values.

Your patch is the right one :-)
Eric
 
> 
>  kernel/posix-timers.c |    3 +--
>  1 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff -puN kernel/posix-timers.c~SIGRTMAX-fix kernel/posix-timers.c
> --- 25/kernel/posix-timers.c~SIGRTMAX-fix	2004-01-24 14:27:13.000000000
> -0800
> +++ 25-akpm/kernel/posix-timers.c	2004-01-24 14:28:21.000000000 -0800
> @@ -344,8 +344,7 @@ static inline struct task_struct * good_
>  		return NULL;
>  
>  	if ((event->sigev_notify & ~SIGEV_NONE & MIPS_SIGEV) &&
> -			event->sigev_signo &&
> -			((unsigned) (event->sigev_signo > SIGRTMAX)))
> +	    (((unsigned)event->sigev_signo > SIGRTMAX) || !event->sigev_signo))
>  		return NULL;
>  
>  	return rtn;
> 

