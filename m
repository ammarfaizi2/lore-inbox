Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312526AbSDXS5k>; Wed, 24 Apr 2002 14:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312529AbSDXS5j>; Wed, 24 Apr 2002 14:57:39 -0400
Received: from pool-151-204-74-250.delv.east.verizon.net ([151.204.74.250]:40200
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S312526AbSDXS5i>; Wed, 24 Apr 2002 14:57:38 -0400
Date: Wed, 24 Apr 2002 14:58:25 -0400
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre7 MIPS compile errors.
Message-ID: <20020424145825.A21701@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





The MIPS box (an SGI Indy) has been having problems compiling kernels
since I first put Linux on it I've never had a kernel complete the
basic image compile (make vmlinux)  between 2.4.16-2.4.18 there were
problems compiling one of the keyboard drivers, 2.4.19-pre5 had the two
problems I'm about to describe, as does 2.4.19-pre7.  2.4.19-pre6
wouldn't even attempt to compile.

It's an R5000/150Mhz, 128M RAM, Newport graphics, Debian Woody, gcc
2.95.4, binutils 2.12.90.0.1 20020307.

First problem seems to be in the ARCs Console support subsystem of the
kernel.

gcc -I /usr/src/linux-2.4.19-pre7/include/asm/gcc -D__KERNEL__
-I/usr/src/linux-2.4.19-pre7/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
-Wa,--trap -pipe   -nostdinc -I
/usr/lib/gcc-lib/mips-linux/2.95.4/include -DKBUILD_BASENAME=identify
-c -o identify.o identify.c
identify.c: In function `prom_identify_arch':
identify.c:76: warning: `iname' might be used uninitialized in this
function
gcc -I /usr/src/linux-2.4.19-pre7/include/asm/gcc -D__KERNEL__
-I/usr/src/linux-2.4.19-pre7/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
-Wa,--trap -pipe   -nostdinc -I
/usr/lib/gcc-lib/mips-linux/2.95.4/include -DKBUILD_BASENAME=arc_con
-c -o arc_con.o arc_con.c
arc_con.c:53: warning: initialization from incompatible pointer type
arc_con.c:55: warning: initialization makes integer from pointer
without a cast
arc_con.c:55: initializer element is not computable at load time
arc_con.c:55: (near initialization for `arc_cons.flags')
arc_con.c:60: warning: excess elements in struct initializer
arc_con.c:60: warning: (near initialization for `arc_cons')
make[2]: *** [arc_con.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.19-pre7/arch/mips/arc'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.19-pre7/arch/mips/arc'
make: *** [_dir_arch/mips/arc] Error 2

The second error, I run into when I disable ARC console support, and
attempt to compile again. Not as sure about what causes this one,
though.

gcc -I /usr/src/linux-2.4.19-pre7/include/asm/gcc -D__KERNEL__
-I/usr/src/linux-2.4.19-pre7/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r5000 -mips2
-Wa,--trap -pipe   -nostdinc -I
/usr/lib/gcc-lib/mips-linux/2.95.4/include -DKBUILD_BASENAME=signal  -c
-o signal.o signal.c
signal.c: In function `do_signal':
signal.c:573: `PER_LINUX' undeclared (first use in this function)
signal.c:573: (Each undeclared identifier is reported only once
signal.c:573: for each function it appears in.)
make[1]: *** [signal.o] Error 1
make[1]: Leaving directory
`/usr/src/linux-2.4.19-pre7/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2

Anyway... I'm hoping that this information is useful, if y'all need any
more, please just ask.
--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net:8008/~magamo/index.htm
