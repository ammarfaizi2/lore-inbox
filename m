Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313865AbSDFDo4>; Fri, 5 Apr 2002 22:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313938AbSDFDoq>; Fri, 5 Apr 2002 22:44:46 -0500
Received: from ECE.CMU.EDU ([128.2.136.200]:53954 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S313865AbSDFDoe>;
	Fri, 5 Apr 2002 22:44:34 -0500
Date: Fri, 5 Apr 2002 22:44:30 -0500 (EST)
From: Nilmoni Deb <ndeb@ece.cmu.edu>
Reply-To: Nilmoni Deb <ndeb@ece.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: Andre Pang <ozone@algorithm.com.au>
Subject: COMPILE error with 2.4.18: need help
In-Reply-To: <1017970316.478570.13925.nullmailer@bozar.algorithm.com.au>
Message-ID: <Pine.LNX.3.96L.1020405221555.9204D-100000@d-alg.ece.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	I need to fix the severe video corruption problem on my KM133
chipset by the patch described in
the post http://www.uwsg.iu.edu/hypermail/linux/kernel/0204.0/0002.html .

I am using the stock gcc-2.96-0.76mdk of mandrake-8.2 to compile
kernel 2.4.18-6mdk. But before applying the patch in the above post
I ran a test to see if I could compile the default kernel source tree
from /usr/src/linux with the mandrake supplied default .config file. 

I ran these commands:

make dep
make clean
make bzImage
make modules

The first 3 commands worked fine. But in "make modules" I got the error:

make -C affs modules
make[2]: Entering directory `/home/ndeb/usr/src/linux-2.4.18-6mdk/fs/affs'
gcc -D__KERNEL__ -I/home/ndeb/usr/src/linux-2.4.18-6mdk/include  -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586
-DMODULE -DMODVERSIONS -include
/home/ndeb/usr/src/linux-2.4.18-6mdk/include/linux/modversions.h
-DKBUILD_BASENAME=super  -c -o super.o super.c
gcc -D__KERNEL__ -I/home/ndeb/usr/src/linux-2.4.18-6mdk/include  -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i586
-DMODULE -DMODVERSIONS -include
/home/ndeb/usr/src/linux-2.4.18-6mdk/include/linux/modversions.h
-DKBUILD_BASENAME=namei  -c -o namei.o namei.c
In file included from namei.c:11:
/home/ndeb/usr/src/linux-2.4.18-6mdk/include/linux/sched.h:6: nondigits in
number and not hexadecimal
/home/ndeb/usr/src/linux-2.4.18-6mdk/include/linux/sched.h:6: nondigits in
number and not hexadecimal
/home/ndeb/usr/src/linux-2.4.18-6mdk/include/linux/sched.h:6: parse error
before `7b16c344'
/home/ndeb/usr/src/linux-2.4.18-6mdk/include/linux/sched.h:6: warning:
function declaration isn't a prototype
make[2]: *** [namei.o] Error 1
make[2]: Leaving directory `/home/ndeb/usr/src/linux-2.4.18-6mdk/fs/affs'
make[1]: *** [_modsubdir_affs] Error 2
make[1]: Leaving directory `/home/ndeb/usr/src/linux-2.4.18-6mdk/fs'
make: *** [_mod_fs] Error 2



Line 6 of linux-2.4.18-6mdk/include/linux/sched.h  is ->

extern unsigned long event;

I have even tried egcs to compile and got the same error.

If I comment out line 6 of linux-2.4.18-6mdk/include/linux/sched.h
then the compilation continues beyond this point but fails later.

The irony is that dmesg shows this ->

Linux version 2.4.18-6mdk (quintela@bi.mandrakesoft.com) (gcc version 2.96
20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Mar 15 02:59:08 CET 2002

which means that the same kernel was compiled by the same compiler version
which I am working with and is currently running on my machine!!
I don't get it. How was this kernel compiled in the first place if it
doesn't compile now ?

Any help is welcome.

thanks
- Nil

