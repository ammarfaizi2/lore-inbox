Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312982AbSDBXAQ>; Tue, 2 Apr 2002 18:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSDBXAG>; Tue, 2 Apr 2002 18:00:06 -0500
Received: from are.twiddle.net ([64.81.246.98]:35992 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S312982AbSDBW77>;
	Tue, 2 Apr 2002 17:59:59 -0500
Date: Tue, 2 Apr 2002 14:59:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: Michal Moskal <malekith@pld.org.pl>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-3.1 ffs problem, kernel 2.4.18
Message-ID: <20020402145955.A12932@twiddle.net>
Mail-Followup-To: Michal Moskal <malekith@pld.org.pl>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020320174238.GA13533@ep09.kernel.pl> <20020328211025.A30037@twiddle.net> <20020329115731.GA3227@ep09.kernel.pl> <20020329144232.A495@twiddle.net> <20020402114848.GA9004@ep09.kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2002 at 01:48:48PM +0200, Michal Moskal wrote:
> Could you please check if it compiles for you?

Ah, I see the bug.  I was looking at ffz (which is correct),
not ffs (which isn't).

> 	__asm__("bsfl %1,%0\n\t"
> 		"jnz 1f\n\t"
> 		"movl $-1,%0\n"
> 		"1:" : "=r" (r) : "g" (x));

The problem is                    ^^^

That sez any of register, memory, or immediate is ok.
It should be "r" instead, just like in ffz.

That said, we should probably be using __builtin_ffs
instead.  The compiler knows how to do bsfl plus the
adjustment.  Plus, it knows how to evaluate it at
compile-time for constants.


r~
