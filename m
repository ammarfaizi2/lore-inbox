Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTGOFXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 01:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbTGOFXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 01:23:15 -0400
Received: from air-2.osdl.org ([65.172.181.6]:989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262439AbTGOFXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 01:23:14 -0400
Date: Mon, 14 Jul 2003 22:38:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernardo Innocenti <bernie@develer.com>
Cc: george@mvista.com, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       rmk@arm.linux.org.uk, torvalds@osdl.org
Subject: Re: do_div64 generic
Message-Id: <20030714223805.4e5bee3f.akpm@osdl.org>
In-Reply-To: <200307150717.54981.bernie@develer.com>
References: <3F1360F4.2040602@mvista.com>
	<200307150717.54981.bernie@develer.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernardo Innocenti <bernie@develer.com> wrote:
>
> I see. do_div() which updates the dividend in-place did not quite apply
>  to the usage pattern of the new timer code.

This is getting silly.  The timer stuff has been an ongoing bug factory and
now it is colluding with the do_div() saga.

Can we just get the things working, without mangling every architecture
again?

>  > The using code tests for the existance of div_long_long_rem and uses
>  > the longer do_div() if it does not exist.
>  >
>  > Could you consider adding this to the generic code?
>  >
>  > /*
>  >   * (long)X = ((long long)divs) / (long)div
>  >   * (long)rem = ((long long)divs) % (long)div
>  >   *
>  >   * Warning, this will do an exception if X overflows.
>  >   */
>  > #define div_long_long_rem(a,b,c) div_ll_X_l_rem(a,b,c)
>  >
>  > extern inline long
>  > div_ll_X_l_rem(long long divs, long div, long *rem)
>  > {
>  > 	long dum2;
>  >        __asm__("divl %2":"=a"(dum2), "=d"(*rem)
>  >
>  >        :	"rm"(div), "A"(divs));
>  >
>  > 	return dum2;
>  >
>  > }
> 
>  Here's a patch that takes care of all architectures.

AFAICT, we can just rework posix-timers.c to use the standard do_div() and
be done with it, can we not?  ie: no div_long_long_rem(), no
div_ll_X_l_rem().  Just do_div().

Please use `static inline', not `extern inline', btw.


