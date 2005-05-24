Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbVEXUpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbVEXUpt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 16:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVEXUpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 16:45:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:45528 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262063AbVEXUnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 16:43:13 -0400
Date: Tue, 24 May 2005 13:43:10 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Clifford T. Matthews" <ctm@ardi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: trouble trapping SEGV on 2.6.11.2 & 2.6.12-rc4
Message-ID: <20050524204310.GJ23013@shell0.pdx.osdl.net>
References: <17043.36668.164277.860295@newbie.ardi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17043.36668.164277.860295@newbie.ardi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Clifford T. Matthews (ctm@ardi.com) wrote:
> The included program dies with a SEGV under 2.6.11.2 and 2.6.12-rc4.
> It doesn't die under 2.4.25.  I compiled the kernels myself.  The
> distribution is Fedora Core release 3, with glibc 2.3.5.

2.6 has been fixed...  So your program (which happens to be slightly
buggy) no longer works as you expected.  See below.

> #include <stdio.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include <stdbool.h>
> #include <assert.h>
> #include <setjmp.h>
> #include <signal.h>
> 
> static jmp_buf segv_return;
> 
> static void
> segv_handler (int signum_ignored __attribute__((unused)))
> {
>   longjmp (segv_return, 1);

siglongjmp

> }
> 
> int
> main (void)
> {
>   volatile char *volatile addr;
>   volatile int n_failures;
> 
>   addr = (void *) 0x10000L;
>   n_failures = 0;
> 
>   signal (SIGSEGV, segv_handler);
>   if (setjmp (segv_return) != 0)

sigsetjmp

>     ++n_failures;
>   else
>     *addr;
> 
>   printf ("n_failures = %d\n", n_failures);
> 
>   if (setjmp (segv_return) != 0)

sigsetjmp

>     ++n_failures;
>   else
>     *addr;
> 
>   printf ("n_failures = %d\n", n_failures);
> 
>   return 0;
> }
