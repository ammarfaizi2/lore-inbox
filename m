Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTKKJoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 04:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTKKJoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 04:44:23 -0500
Received: from coffee.creativecontingencies.com ([210.8.121.66]:37345 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S263463AbTKKJoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 04:44:20 -0500
Message-Id: <6.0.0.22.2.20031111202757.01af5f50@caffeine.cc.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Tue, 11 Nov 2003 20:43:49 +1100
To: Linus Torvalds <torvalds@osdl.org>
From: Peter Lieverdink <cafuego@cafuego.net>
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ? 
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <200311110250.hAB2orA8004592@turing-police.cc.vt.edu>
References: <1067411342.1574.11.camel@localhost>
 <20031109131018.GA18342@deneb.enyo.de>
 <bop47i$7eg$1@gatekeeper.tmr.com>
 <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
 <200311110250.hAB2orA8004592@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Tue, 11 Nov 2003 10:27:16 +1100, Peter Lieverdink 
><linux@cafuego.net>  said:
>
> > I agree that something is very broken, though. Mind you, I can only
> > replicate this problem on one of my machines - the other one I've tried it
> > on seems to work fine. Odder still, when I compile a kernel on the machine
> > which is fine and ruin said kernel on the machine which is not fine, I
> > don't experience the crash.
>
>At 11:15 11/11/2003, you wrote:
>That _really_ sounds like your "broken machine" is nothing more than a
>broken compiler (or possibly binutils, but compilers tend to be more
>fragile by far, so it's more likely the compiler).
>
>What compiler versions do you have installed on the broken vs good
>machines?
>
>At 13:50 11/11/2003, you wrote:
>Could we see a 'gcc -V' from *both* machines, please? (and an 'as -v'
>and 'ld -v' as well, just to be thorough?)

They're the same. Both boxes use Debian Sid with gcc-3.3.2. I made sure 
they were both running the same versions of gcc/binutils when I tested it. 
When I use gcc-2.95.4 (gcc version 2.95.4 20011002 Debian prerelease) on 
the "broken" machine I get a crash at the same point, but with different 
output. (not captured, due to got annoyed and gave up) I can probably spend 
an hour or so recompiling and capturing said crash if you want me to.

As for software versions (kahlua is "bad", shiraz is "good")

root@kahlua:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.2/specs
Configured with: ../src/configure -v 
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info 
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared 
--with-system-zlib --enable-nls --without-included-gettext 
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug 
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.2 (Debian)

root@kahlua:~$ as -v
GNU assembler version 2.14.90.0.7 (i386-linux) using BFD version 
2.14.90.0.7 20031029 Debian GNU/Linux

root@kahlua:~$ ld -v
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux

root@shiraz:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i486-linux/3.3.2/specs
Configured with: ../src/configure -v 
--enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr 
--mandir=/usr/share/man --infodir=/usr/share/info 
--with-gxx-include-dir=/usr/include/c++/3.3 --enable-shared 
--with-system-zlib --enable-nls --without-included-gettext 
--enable-__cxa_atexit --enable-clocale=gnu --enable-debug 
--enable-java-gc=boehm --enable-java-awt=xlib --enable-objc-gc i486-linux
Thread model: posix
gcc version 3.3.2 (Debian)

root@shiraz:~$ as -v
GNU assembler version 2.14.90.0.7 (i386-linux) using BFD version 
2.14.90.0.7 20031029 Debian GNU/Linux

root@shiraz:~$ ld -v
GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux

As you see, versions are identical on both machines - this is what had me 
baffled. Every single other thing works fine on the "bad" machine, so I 
tend to not suspect a hardware problem.

- Peter. 

