Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312562AbSDENHD>; Fri, 5 Apr 2002 08:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312573AbSDENGy>; Fri, 5 Apr 2002 08:06:54 -0500
Received: from sebula.traumatized.org ([193.121.72.130]:7041 "EHLO
	sparkie.is.traumatized.org") by vger.kernel.org with ESMTP
	id <S312562AbSDENGl>; Fri, 5 Apr 2002 08:06:41 -0500
Date: Fri, 5 Apr 2002 15:02:24 +0200
From: Jurgen Philippaerts <jurgen@pophost.eunet.be>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre6 doesn't compile on Alpha and sparc64
Message-ID: <20020405130224.GF22422@sparkie.is.traumatized.org>
In-Reply-To: <20020405105409.GA29804@alpha.of.nowhere> <Pine.GSO.4.21.0204050636100.25849-100000@weyl.math.psu.edu> <20020405124616.GE22422@sparkie.is.traumatized.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-unexpected: Noone expects the unexpected header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 03:00:11PM +0200, Jurgen Philippaerts wrote:
> On Fri, Apr 05, 2002 at 02:00:14PM +0200, Alexander Viro wrote:
> > 
> > > init/do_mounts.c:45: parse error before `mount_initrd'
> > [snip]
> > 
> > Looks like a missing init.h - sorry, this sucker didn't get caught (on
> > x86 slab.h ends up pulling it in, on alpha it doesn't).
> > 
> > Fix: add #include <linux/init.h> in init/do_mounts.c
> 
> same on sparc64.
> adding the extra #include fixes it.

but then it goes wrong with `make modules`

ps: pre5 did work.

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux2419pre6/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
-fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7
-Wno-sign-compare -Wa,--undeclared-regs -DMODULE  -nostdinc -I
/usr/lib/gcc-lib/sparc64-slackware-linux/egcs-2.92.11/include
-DKBUILD_BASENAME=nfsctl  -c -o nfsctl.o nfsctl.c
nfsctl.c:316: parse error before `nfsd_init'
nfsctl.c:317: warning: return-type defaults to `int'
nfsctl.c:334: parse error before `nfsd_exit'
nfsctl.c:335: warning: return-type defaults to `int'
nfsctl.c: In function `nfsd_exit':
nfsctl.c:345: warning: control reaches end of non-void function
nfsctl.c: At top level:
nfsctl.c:347: warning: type defaults to `int' in declaration of
`module_init'
nfsctl.c:347: warning: parameter names (without types) in function
declaration
nfsctl.c:347: warning: data definition has no type or storage class
nfsctl.c:348: warning: type defaults to `int' in declaration of
`module_exit'
nfsctl.c:348: warning: parameter names (without types) in function
declaration
nfsctl.c:348: warning: data definition has no type or storage class
make[2]: *** [nfsctl.o] Error 1
make[2]: Leaving directory `/usr/src/linux2419pre6/fs/nfsd'
make[1]: *** [_modsubdir_nfsd] Error 2
make[1]: Leaving directory `/usr/src/linux2419pre6/fs'
make: *** [_mod_fs] Error 2


Jurgen.
-- 
http://www.tuxedo.org/~esr/faqs/smart-questions.html

Linux sparkie 2.4.19-pre5 #1 Thu Apr 4 19:14:41 CEST 2002 sparc64 unknown
  2:55pm  up 19:08,  8 users,  load average: 0.01, 0.26, 0.45
