Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbTCLSkL>; Wed, 12 Mar 2003 13:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbTCLSkL>; Wed, 12 Mar 2003 13:40:11 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:64468 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261872AbTCLSkJ> convert rfc822-to-8bit; Wed, 12 Mar 2003 13:40:09 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre5-ac3 DRM build problem
Date: Wed, 12 Mar 2003 19:50:50 +0100
User-Agent: KMail/1.4.3
References: <200303121358.h2CDwmB06606@devserv.devel.redhat.com>
In-Reply-To: <200303121358.h2CDwmB06606@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303121950.50620.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

compiling your current snapshot, I'm running into this problem:

make[3]: Wechsel in das Verzeichnis 
»/usr/src/linux-2.4.21-pre5-ac3-nb/drivers/char«
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5-ac3-nb/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon -nostdinc -iwithprefix 
include -DKBUILD_BASENAME=tty_io  -DEXPORT_SYMTAB -c tty_io.c
tty_io.c:1845:1: directives may not be used inside a macro argument
tty_io.c:1844:1: unterminated argument list invoking macro "put_user"
tty_io.c: In function `tty_ioctl':
tty_io.c:1848: `put_user' undeclared (first use in this function)
tty_io.c:1848: (Each undeclared identifier is reported only once
tty_io.c:1848: for each function it appears in.)
tty_io.c:1848: parse error before "struct"
tty_io.c:1855: warning: `return' with no value, in function returning non-void
tty_io.c: In function `do_SAK':
tty_io.c:1898: `__do_SAK' undeclared (first use in this function)
tty_io.c: In function `tty_ioctl':
tty_io.c:2080: section attribute cannot be specified for local variables
tty_io.c:2080: section attribute cannot be specified for local variables
tty_io.c:2081: section attribute cannot be specified for local variables
tty_io.c:2081: section attribute cannot be specified for local variables
tty_io.c:2416: parse error at end of input
tty_io.c:2081: warning: unused variable `__ksymtab_tty_unregister_devfs'
tty_io.c:2080: warning: unused variable `__ksymtab_tty_register_devfs'
tty_io.c:136: warning: `initialize_tty_struct' used but never defined
tty_io.c:1652: warning: `send_break' defined but not used

Looks like TTY_SOFT_SAK macro isn't defined anywhere, at least a grep -r 
doesn't reveal one...

Relevant .config:
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD_8151=y
# CONFIG_AGP_SIS is not set
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
CONFIG_DRM_OLD=y
# CONFIG_DRM40_TDFX is not set
# CONFIG_DRM40_GAMMA is not set
# CONFIG_DRM40_R128 is not set
# CONFIG_DRM40_RADEON is not set
# CONFIG_DRM40_I810 is not set
CONFIG_DRM40_MGA=m
# CONFIG_MWAVE is not set

Reading specs from /usr/lib/gcc-lib/i486-suse-linux/3.2/specs
Configured with: ../configure --enable-threads=posix --prefix=/usr 
--with-local-prefix=/usr/local --infodir=/usr/share/info 
--mandir=/usr/share/man --libdir=/usr/lib 
--enable-languages=c,c++,f77,objc,java,ada --enable-libgcj 
--with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib 
--with-system-zlib --enable-shared --enable-__cxa_atexit i486-suse-linux
Thread model: posix
gcc version 3.2

Let me know, if I can provide some more infos, testing, whatever.

Thanks,
Pete
