Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbQKRRuK>; Sat, 18 Nov 2000 12:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129955AbQKRRuB>; Sat, 18 Nov 2000 12:50:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:5409 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129835AbQKRRto>; Sat, 18 Nov 2000 12:49:44 -0500
Date: Sat, 18 Nov 2000 18:19:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Errors in aa2
Message-ID: <20001118181937.I2512@athlon.random>
In-Reply-To: <20001118033609.C4381@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001118033609.C4381@werewolf.able.es>; from jamagallon@able.es on Sat, Nov 18, 2000 at 03:36:09AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 03:36:09AM +0100, J . A . Magallon wrote:
> Hi everyone.
> 
> When compiling Andreas aa2 patch I got:
> 
> /usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
> -O4 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe
> -fno-strength-reduce -march=i686 -malign-loops=2 -malign-jumps=2
> -malign-functions=2 -DCPU=686   -c -o time.o time.c
> time.c: In function `do_gettimeofday':
> time.c:727: fixed or forbidden register 0 (ax) was spilled for class AREG.
> This may be due to a compiler bug or to impossible asm
> statements or clauses.

That's compiler bug obviously.

Anyways I guess you're triggering compiler bugs because of the weird
optimizations (-O4). Note also that everything over -O2 is _wrongly_ used to
inline everything and that will trash away all your icache (I remeber
also Linus complained about that bad behaviour of >-O2 in the past and
it's also trivial to fix [shouldn't be more than a one liner], but nobody on
the gcc side seems to care to fix it since it's still impling the
inline-functions in gcc CVS of a few weeks ago).

I triggered various compiler bugs both in 2.7.2.3 and egcs in the past but
they're should be sorted out in 18pre21aa2 patchkit. If you can still trigger
compiler bugs with the _default_ compiler options please let me know and I'll
work around them. 2.95.2 compiles it fine for me.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
