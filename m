Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262254AbRETWUP>; Sun, 20 May 2001 18:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbRETWUG>; Sun, 20 May 2001 18:20:06 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:46721 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S262254AbRETWTv>; Sun, 20 May 2001 18:19:51 -0400
Date: Mon, 21 May 2001 00:19:49 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
Message-ID: <20010521001949.R754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.05.10105202210370.1667-100000@callisto.of.borg> <3B083878.1785C27D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3B083878.1785C27D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, May 20, 2001 at 05:34:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 05:34:48PM -0400, Jeff Garzik wrote:
> This might be a very valid point...
> 
> (let me know if the following test is flawed)
 
It is imho.

> > [jgarzik@rum tmp]$ cat > sectest.c
> > #include <linux/module.h>
> > #include <linux/init.h>
> > static const char version[] __initdata = "foo";
    static char version2[] __initdata = "bar";
> > [jgarzik@rum tmp]$ gcc -D__KERNEL__ -I/spare/cvs/linux_2_4/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o sectest.o sectest.c
> > [jgarzik@rum tmp]$ 
> 
> No section type conflict appears.

Now it SHOULD conflict on these binutils, but doesn't on mine (2.9.5) ;-)

It is decided to put it into .data.init as expected.

AFAIK "const" is only a promise to the compiler, that we write
this data ONCE and read only after this initial write. So the
decision on the section is implementation defined.

What I don't understand is, why GCC overrides our explicit
override (done by setting the "section attribute" explicitly).

I would consider this a BUG in GCC. I don't understand, why we
support this BUG...

Maybe some GCC people can enlighten me, why GCC ignores such
overrides, that are for the cases where we DO KNOW BETTER than
GCC, what section is correct.


Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
