Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWHMRXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWHMRXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 13:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHMRXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 13:23:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751342AbWHMRXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 13:23:36 -0400
Date: Sun, 13 Aug 2006 10:23:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel@vger.kernel.org, toyoa@mvista.com
Subject: Re: [patch] fix posix timer errors
Message-Id: <20060813102327.b02cfffe.akpm@osdl.org>
In-Reply-To: <20060813143200.GA2779@slug>
References: <20060813012454.f1d52189.akpm@osdl.org>
	<20060813143200.GA2779@slug>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 16:32:00 +0200
Frederik Deweerdt <deweerdt@free.fr> wrote:

> On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> > 
> Hi,
> 
> posix-timers-fix-clock_nanosleep-doesnt-return-the-remaining-time-in-compatibility-mode.patch
> declares two functions with the wrong return type.
> 
> Also, posix-timers-fix-the-flags-handling-in-posix_cpu_nsleep.patch uses
> '=' instead of '=='.
> 
> The attached patch fix both issues.
> 

Thanks.

> 
> diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
> index 1fc1ea2..479b16b 100644
> --- a/kernel/posix-cpu-timers.c
> +++ b/kernel/posix-cpu-timers.c
> @@ -1477,7 +1477,7 @@ int posix_cpu_nsleep(const clockid_t whi
>  
>  	error = do_cpu_nanosleep(which_clock, flags, rqtp, &it);
>  
> -	if (error = -ERESTART_RESTARTBLOCK) {
> +	if (error == -ERESTART_RESTARTBLOCK) {
>  
>  	       	if (flags & TIMER_ABSTIME)
>  			return -ERESTARTNOHAND;
> @@ -1511,7 +1511,7 @@ long posix_cpu_nsleep_restart(struct res
>  	restart_block->fn = do_no_restart_syscall;
>  	error = do_cpu_nanosleep(which_clock, TIMER_ABSTIME, &t, &it);
>  
> -	if (error = -ERESTART_RESTARTBLOCK) {
> +	if (error == -ERESTART_RESTARTBLOCK) {

This is the sort of thing which should have been caught in testing, but it
wasn't, which raises questions about how well-tested the rest of it is?

Plus it will have generated compiler warnings.
