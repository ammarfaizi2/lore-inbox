Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVHQTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVHQTBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 15:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVHQTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 15:01:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1217 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751204AbVHQTBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 15:01:32 -0400
Date: Wed, 17 Aug 2005 12:00:20 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Glass, Kathleen K (Kathy)" <kkglass@avaya.com>,
       "Rhodes, James E (James)" <jrhodes@avaya.com>,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 2.6.12.5] NPTL signal delivery deadlock fix
Message-ID: <20050817190020.GO7991@shell0.pdx.osdl.net>
References: <1124303193.11458.16.camel@cof110earth.dr.avaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124303193.11458.16.camel@cof110earth.dr.avaya.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bhavesh P. Davda (bhavesh@avaya.com) wrote:
> This bug is quite subtle and only happens in a very interesting
> situation where a real-time threaded process is in the middle of a
> coredump when someone whacks it with a SIGKILL. However, this deadlock
> leaves the system pretty hosed and you have to reboot to recover.
> 
> Not good for real-time priority-preemption applications like our
> telephony application, with 90+ real-time (SCHED_FIFO and SCHED_RR)
> processes, many of them multi-threaded, interacting with each other for
> high volume call processing.

Nice catch, also looks like something for -stable series.  Roland, any
issue with this patch?

thanks,
-chris

> diff -Naur linux-2.6.12.5/kernel/signal.c linux-2.6.12.5-sigfix/kernel/signal.c
> --- linux-2.6.12.5/kernel/signal.c	2005-08-14 18:20:18.000000000 -0600
> +++ linux-2.6.12.5-sigfix/kernel/signal.c	2005-08-17 11:36:20.547600092 -0600
> @@ -686,7 +686,7 @@
>  {
>  	struct task_struct *t;
>  
> -	if (p->flags & SIGNAL_GROUP_EXIT)
> +	if (p->signal->flags & SIGNAL_GROUP_EXIT)
>  		/*
>  		 * The process is in the middle of dying already.
>  		 */
