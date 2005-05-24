Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVEXVQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVEXVQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVEXVQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:16:23 -0400
Received: from alog0666.analogic.com ([208.224.223.203]:17105 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262189AbVEXVP1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:15:27 -0400
Date: Tue, 24 May 2005 17:14:50 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Clifford T. Matthews" <ctm@ardi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: trouble trapping SEGV on 2.6.11.2 & 2.6.12-rc4
In-Reply-To: <17043.36668.164277.860295@newbie.ardi.com>
Message-ID: <Pine.LNX.4.61.0505241712570.4930@chaos.analogic.com>
References: <17043.36668.164277.860295@newbie.ardi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To jump out of signal handlers, you now need sigsetjmp() and
siglongjmp().


On Tue, 24 May 2005, Clifford T. Matthews wrote:

> The included program dies with a SEGV under 2.6.11.2 and 2.6.12-rc4.
> It doesn't die under 2.4.25.  I compiled the kernels myself.  The
> distribution is Fedora Core release 3, with glibc 2.3.5.
>
> I don't have any earlier 2.6 kernels to test it on, so I have no idea
> when this bug first appeared.
>
> I only skim LKML through fa.linux.kernel, so please CC me on any reply
> that I should see.
>
> --Cliff Matthews <ctm@ardi.com>
> +1 505 363 5754 Cell
>
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
>  longjmp (segv_return, 1);
> }
>
> int
> main (void)
> {
>  volatile char *volatile addr;
>  volatile int n_failures;
>
>  addr = (void *) 0x10000L;
>  n_failures = 0;
>
>  signal (SIGSEGV, segv_handler);
>  if (setjmp (segv_return) != 0)
>    ++n_failures;
>  else
>    *addr;
>
>  printf ("n_failures = %d\n", n_failures);
>
>  if (setjmp (segv_return) != 0)
>    ++n_failures;
>  else
>    *addr;
>
>  printf ("n_failures = %d\n", n_failures);
>
>  return 0;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
