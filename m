Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263505AbUJ2UAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263505AbUJ2UAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUJ2T7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:59:54 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37616 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S263484AbUJ2Txw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:53:52 -0400
Date: Fri, 29 Oct 2004 12:53:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, amitkale@linsyssoft.com
Subject: Re: [patch 1/8] A different KGDB stub for -mm
Message-ID: <20041029195345.GA15699@smtp.west.cox.net>
References: <1.29102004.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1.29102004.trini@kernel.crashing.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -puN kernel/sched.c~core-lite kernel/sched.c
> --- linux-2.6.10-rc1/kernel/sched.c~core-lite	2004-10-29 11:26:42.888818087 -0700
> +++ linux-2.6.10-rc1-trini/kernel/sched.c	2004-10-29 11:26:42.904814331 -0700
[snip]
> @@ -4567,6 +4568,12 @@ void __might_sleep(char *file, int line)
>  #if defined(in_atomic)
>  	static unsigned long prev_jiffy;	/* ratelimiting */
>  
> +	if (atomic_read(&debugger_active))
> +		return;
> +
> +	if (atomic_read(&debugger_active))
> +		return;
> +
>  	if ((in_atomic() || irqs_disabled()) &&
>  	    system_state == SYSTEM_RUNNING) {
>  		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)

Olaf Hering pointed this out to me privately.  Obvious patch follows.

(And, er, I fogot this on all of the other patches too, as I said, not a
good start to the day...)

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff -u linux-2.6.10-rc1/kernel/sched.c linux-2.6.10-rc1/kernel/sched.c
--- linux-2.6.10-rc1/kernel/sched.c
+++ linux-2.6.10-rc1/kernel/sched.c
@@ -4571,9 +4571,6 @@
 	if (atomic_read(&debugger_active))
 		return;
 
-	if (atomic_read(&debugger_active))
-		return;
-
 	if ((in_atomic() || irqs_disabled()) &&
 	    system_state == SYSTEM_RUNNING) {
 		if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)

-- 
Tom Rini
http://gate.crashing.org/~trini/
