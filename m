Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbQKRTIN>; Sat, 18 Nov 2000 14:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130893AbQKRTID>; Sat, 18 Nov 2000 14:08:03 -0500
Received: from jalon.able.es ([212.97.163.2]:64419 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130751AbQKRTHm>;
	Sat, 18 Nov 2000 14:07:42 -0500
Date: Sat, 18 Nov 2000 19:37:28 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Errors in aa2
Message-ID: <20001118193728.A4607@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <20001118033609.C4381@werewolf.able.es> <20001118181937.I2512@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20001118181937.I2512@athlon.random>; from andrea@suse.de on Sat, Nov 18, 2000 at 18:19:37 +0100
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Nov 2000 18:19:37 Andrea Arcangeli wrote:
> On Sat, Nov 18, 2000 at 03:36:09AM +0100, J . A . Magallon wrote:
> > /usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall
> -Wstrict-prototypes
> > -O4 -fomit-frame-pointer -fno-strict-aliasing -D__SMP__ -pipe
> > -fno-strength-reduce -march=i686 -malign-loops=2 -malign-jumps=2
> > -malign-functions=2 -DCPU=686   -c -o time.o time.c
> > time.c: In function `do_gettimeofday':
> > time.c:727: fixed or forbidden register 0 (ax) was spilled for class AREG.
> > This may be due to a compiler bug or to impossible asm
> > statements or clauses.
> 
> That's compiler bug obviously.
> 
> Anyways I guess you're triggering compiler bugs because of the weird
> optimizations (-O4). Note also that everything over -O2 is _wrongly_ used to
> inline everything and that will trash away all your icache (I remeber
> also Linus complained about that bad behaviour of >-O2 in the past and
> it's also trivial to fix [shouldn't be more than a one liner], but nobody on
> the gcc side seems to care to fix it since it's still impling the
> inline-functions in gcc CVS of a few weeks ago).
> 

Thanks. I tried to do "by hand" the inlining (just cut and paste, the proc
seemed
not to be used anywhere but time.c), but the result was the same. So looked at
the
gcc info and saw that the function was being inlined from opt level 3.
Also realized that the 'O4' level does not exist in gcc ( I think i 'ported' it
from
use of IRIX cc), so just O2 is right.

Anyway, you can compile somehing with -O9751, and gcc says nothing. If max opt
level
is 3, any higher level should trig a warning at least...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
