Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268779AbRGaD6w>; Mon, 30 Jul 2001 23:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269170AbRGaD6n>; Mon, 30 Jul 2001 23:58:43 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:5729 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S268779AbRGaD6d>; Mon, 30 Jul 2001 23:58:33 -0400
Date: Tue, 31 Jul 2001 05:58:44 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel diff_small_2.4.8pre2_2.4.8pre3
Message-ID: <20010731055844.A25719@athlon.random>
In-Reply-To: <200107301808.f6UI8DL29566@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107301808.f6UI8DL29566@athlon.random>; from andrea@athlon.random on Mon, Jul 30, 2001 at 08:08:13PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 08:08:13PM +0200, Andrea Arcangeli wrote:
> diff -urN 2.4.8pre2/include/asm-i386/softirq.h 2.4.8pre3/include/asm-i386/softirq.h
> --- 2.4.8pre2/include/asm-i386/softirq.h	Sun Jul 29 06:02:41 2001
> +++ 2.4.8pre3/include/asm-i386/softirq.h	Mon Jul 30 20:07:54 2001
> @@ -28,8 +28,6 @@
>  	unsigned long flags;						\
>  									\
>  	__save_flags(flags);						\
> -	if (!(flags & (1 << 9)))					\
> -		BUG();							\
>  	barrier();							\
>  	if (!--*ptr)							\
>  		__asm__ __volatile__ (					\

if you drop the bugcheck you should drop the __save_flags and flags too.

What was the problem with it? I seen a report from Chris but that sounds
like a bug in a caller of the the smp-call function (smp-call must be
run with irq enabled as it's written explicitly in the comment on top of
it).

Andrea
