Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265289AbUFOFG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUFOFG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUFOFG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:06:27 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:15631 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id S265289AbUFOFGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:06:24 -0400
Date: Tue, 15 Jun 2004 16:35:08 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gcc3.3.2, kernel-2.6.6, and Mandrake 10.0 compiling problem.
Message-ID: <Pine.LNX.4.21.0406151623590.9232-100000@brick.flying-brick.vpn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got a small problem, folks.  I've got a Mandrake 10.0 system (upgraded in 
bits and bobs, but that's not really relevant), with gcc-3.3.2, binutils-2.14.90.0.7
and a plain (linux.org) kernel tree patched from 2.6.0 to 2.6.6. No -mm, no
-ac, nothing except base.

The system's a K6-2 @533 MHz, 192Mb memory (and 308 Mb swap). Plenty of hard
disk space available.

I was trying to compile the tree (make V=1) and got the following output.
----- start output -----
... other make lines omitted ...
make -f scripts/Makefile.build obj=fs/nls
  gcc -Wp,-MD,fs/nls/.tmp_nls_base.o.d -nostdinc -iwithprefix include
  -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
  -fno-unit-at-a-time -march=k6 -Iinclude/asm-i386/mach-default -O2
  -DKBUILD_BASENAME=nls_base -KBUILD_MODNAME=nls_base -c 
  -o fs/nls/.tmp_nls_base.o  fs/nls/nls_base.c
fs/nls/nls_base.c: In function `char2uni':
fs/nls/nls_base.c:465: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:https://qa.mandrakesoft.com/> for instructions.

----- end output -----

Fine, I said. I eliminated all the obvious aspects, such as CPU overheating,
bad memory, etc. This particular item happened consistently, and happened no
matter what the load on the machine, nor what time of the day. Other programs
seem to compile fine on it (i.e. ne2k-pci-diag.c, once I turned all the
multi-line strings into one single string with embedded newlines).

I tried running each section, from preprocessing (.c -> .i,  .i -> .S) and
found it failed in the cc1 section of compilation. The output of gcc --verbose
+plus_all_other_args runs like this:

----- start output -----

gcc -Wp,-MD,fs/nls/.nls_base.o.d -nostdinc -iwithprefix include -D__KERNEL__
  -Iinclude  -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
  -fnon -pipe -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=k6 
  -Iinclude/asm-i386/mach-default -O2 -DKBUILD_BASENAME=nls_base 
  -DKBUILD_MODNAME=nls_base -S -o fs/nls/.tmp_nls_base.S 
  fs/nls/.tmp_nls_base.i --verbose
Reading specs from /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.3.2/specs
Configured with: ../configure --prefix=/usr --libdir=/usr/lib --with-slibdir=/lib 
  --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared 
  --enable-threads=posix --disable-checking --enable-long-long 
  --enable-__cxa_atexit --enable-clocale=gnu
  --enable-languages=c,c++,ada,f77,objc,java,pascal 
  --host=i586-mandrake-linux-gnu --with-system-zlib
Thread model: posix
gcc version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk)
  /usr/lib/gcc-lib/i586-mandrake-linux-gnu/3.3.2/cc1 -fpreprocessed 
  fs/nls/.tmp_nls_base.i -quiet -dumpbase .tmp_nls_base.i 
  -mpreferred-stack-boundary=2 -march=k6 -auxbase-strip fs/nls/.tmp_nls_base.S
-O2 -Wall -Wstrict-prototypes -Wno-trigraphs -version -fno-strict-aliasing
-fno-common -fno-unit-at-a-time -o fs/nls/.tmp_nls_base.S
GNU C version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk) (i586-mandrake-linux-gnu)
compiled by GNU C version 3.3.2 (Mandrake Linux 10.0 3.3.2-6mdk).
GGC heuristics: --param ggc-min-expand=42 --param ggc-min-heapsize=22885
fs/nls/nls_base.c: In function `char2uni':
fs/nls/nls_base.c:465: internal compiler error: Segmentation fault
Please submit a full bug report,
with preprocessed source if appropriate.
See <URL:https://qa.mandrakesoft.com/> for instructions.

----- end output -----

As you can see, it doesn't really give me any other info that I didn't have.
Now, where should I go from here?  I'm not really willing to try gcc-3.3.3 or
3.4.0, due to not having them available without upgrading to cooker...yeeesh.
However, given the simplicity of the function, I don't think this should
be happening. I really DON'T think it's an "internal compiler error" -
still, I have been known to be wrong before.

I looked through the newsgroups for other likely affected people, but nobody
particularly seems to spring to mind.

I will try with the 2.96 compiler too, but I don't expect to get too far
with that, as people have been having trouble compiling 2.6.x kernels
using the 2.9x compilers.


-- 
 /|   _,.:*^*:.,   |\  Cheers from the Viking family, including Pippin, our cat
| |_/'  viking@ `\_| |
|    flying-brick    | $FunnyMail   : What do you mean, I've lost the plot?
 \_.caverock.net.nz_/     5.40      : I planted them carrots right here!!

