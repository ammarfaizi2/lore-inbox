Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbSKFWKA>; Wed, 6 Nov 2002 17:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266162AbSKFWKA>; Wed, 6 Nov 2002 17:10:00 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:9124 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S266161AbSKFWJ6>; Wed, 6 Nov 2002 17:09:58 -0500
From: jordan.breeding@attbi.com
To: Cliff White <cliffw@osdl.org>
Cc: Yury Umanets <umka@namesys.com>, Cliff White <cliffw@osdl.org>,
       reiserfs-dev@namesys.com, Linux-Kernel@vger.kernel.org, cliffw@osdl.org
Subject: Re: [reiserfs-dev] build failure: reiser4progs-0.1.0 
Date: Wed, 06 Nov 2002 22:15:42 +0000
X-Mailer: AT&T Message Center Version 1 (Aug 12 2002)
Message-Id: <20021106221551.BZKL13074.rwcrmhc51.attbi.com@rwcrwbc55>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try the following:

do a search for -lreadline in ./configure, add -lncurses 
to any line in ./configure which is a) setting an 
environment variable and b) does not yet contain -
lncurses but _does_ contain -lreadline

then do ./configure --enable-Werror=no; make

works for me

Jordan
> ./configure --without-readline --enable-Weror=no 
> builds successfully
> ----------------------------
> ./configure --without-readline
> -------------------------------
> 0.lo -MD -MP -MF .deps/alloc40.TPlo  -fPIC -DPIC -o .libs/alloc40.lo
> cc1: warnings being treated as errors
> alloc40.c: In function `callback_fetch_bitmap':
> alloc40.c:50: warning: signed and unsigned type in conditional expression
> alloc40.c: In function `callback_flush_bitmap':
> alloc40.c:209: warning: signed and unsigned type in conditional expression
> alloc40.c: In function `callback_check_bitmap':
> alloc40.c:376: warning: signed and unsigned type in conditional expression
> make[3]: *** [alloc40.lo] Error 1
> make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin/all
> oc40'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/plugin'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
> make: *** [all] Error 2
> ---------------------------------
> ./configure  --enable-Werror=no
> ------------------------------------
> st -f mkfs.c || echo './'`mkfs.c
> /bin/sh ../../libtool --mode=link gcc  -g -O2 -D_REENTRANT 
> -D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused -DPLUGIN_DIR=\"/usr/local/lib/re
> iser4\"   -o mkfs.reiser4  mkfs.o ../../libreiser4/libreiser4.la 
> ../../progs/libmisc/libmisc.la -lreadline  -luuid
> mkdir .libs
> gcc -g -O2 -D_REENTRANT -D_FILE_OFFSET_BITS=64 -g -W -Wall -Wno-unused 
> -DPLUGIN_DIR=\"/usr/local/lib/reiser4\" -o .libs/mkfs.reiser4 mkfs.o  
> ../../libreiser4/.libs/libreiser4.so ../../progs/libmisc/.libs/libmisc.al 
> /root/cgl/kern/reiser/reiser4progs-0.1.0/libaal/.libs/libaal.so -lreadline 
> -luuid -Wl,--rpath -Wl,/usr/local/lib
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `tgetnum'
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `tgoto'/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadlin
> e.so: undefined reference to `tgetflag'
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `BC'
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `tputs'/usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadlin
> e.so: undefined reference to `PC'
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `tgetent'
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `UP'
> /usr/lib/gcc-lib/i386-redhat-linux/2.96/../../../libreadline.so: undefined 
> reference to `tgetstr'
> collect2: ld returned 1 exit status
> make[3]: *** [mkfs.reiser4] Error 1
> make[3]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/progs/mkfs
> '
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0/progs'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/cgl/kern/reiser/reiser4progs-0.1.0'
> make: *** [all] Error 2
> ----------------------------------------
> 
