Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130373AbQLKAuv>; Sun, 10 Dec 2000 19:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130511AbQLKAul>; Sun, 10 Dec 2000 19:50:41 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:36368 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S130373AbQLKAuZ>; Sun, 10 Dec 2000 19:50:25 -0500
Date: Sun, 10 Dec 2000 16:19:55 -0800
From: Richard Henderson <rth@twiddle.net>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
Message-ID: <20001210161955.A31596@twiddle.net>
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org> <20001209161013.A30555@twiddle.net> <3A334F7C.3205A3DF@alsa-project.org> <20001210104413.A31257@twiddle.net> <3A33D3A7.FCD55F4@alsa-project.org> <20001210124918.A31383@twiddle.net> <3A33F448.258A731@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A33F448.258A731@alsa-project.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2000 at 10:23:20PM +0100, Abramo Bagnara wrote:
> asm/io.h uses out of line function only when CONFIG_ALPHA_GENERIC is
> defined, otherwise it uses (take writel as an example) __raw_writel that
> IMHO need to be defined in core_t2.h.

Perhaps you should _show_ an actual failure rather than just guessing.

You are wildly incorrect asserting that out of line functions are used
only with CONFIG_ALPHA_GENERIC.  You should examine

#ifndef __raw_writel
# define __raw_writel(v,a)  ___raw_writel((v),(unsigned long)(a))
#endif

and suchlike definitions.

> core_t2.h is the only core_*.h file that does not define it and this is
> why I've proposed that patch.

FOR THE NTH TIME, NO IT IS NOT!

How often do I have to point you at the other files that do not
define (all of) these macros before you will believe me?

Jesus H Christ!  Look at some preprocessor output why don't you?
Better yet, compile the kernel with CONFIG_ALPHA_T2.  Notice how
it does not fail with undefined symbol errors.  Notice how there
are non-trivial bit fiddling insns implementing the functions in
alpha/lib/io.o.  That's the quickest way to see that I'm right
and you aren't.

End of discussion.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
