Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUDSR5N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUDSR5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:57:13 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:46348 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S261668AbUDSR5B convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:57:01 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: build system broken in 2.6.6rc1 for external modules?
Date: Mon, 19 Apr 2004 19:56:52 +0200
User-Agent: KMail/1.6.1
Cc: zippel@linux-m68k.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404191956.53184.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "maja.beep.pl", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	postmaster@localhost for details.
	Content preview:  On 2.6.5 this works fine (/usr/src/linux is read only
	and make mrproper'ed): ln -sf %{_kernelsrcdir}/config-up .config
	install -d include/{linux,config} ln -sf
	%{_kernelsrcdir}/include/linux/autoconf-up.h include/linux/autoconf.h
	ln -sf %{_kernelsrcdir}/include/asm-%{_arch} include/asm touch
	include/config/MARKER %{__make} -C %{_kernelsrcdir} scripts modules \
	SUBDIRS=$PWD \ O=$PWD \ V=1 [...] 
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.6.5 this works fine (/usr/src/linux is read only and make mrproper'ed):

ln -sf %{_kernelsrcdir}/config-up .config
install -d include/{linux,config}
ln -sf %{_kernelsrcdir}/include/linux/autoconf-up.h include/linux/autoconf.h
ln -sf %{_kernelsrcdir}/include/asm-%{_arch} include/asm
touch include/config/MARKER
%{__make} -C %{_kernelsrcdir} scripts modules \
        SUBDIRS=$PWD \
        O=$PWD \
        V=1

I'm getting:
+ umask 022
+ cd /home/users/misiek/rpm/BUILD
+ cd slmodem-2.9.6
+ cp -r drivers drivers-smp
+ cd drivers
+ ln -sf /usr/src/linux/config-up .config
+ install -d include/linux include/config
+ ln -sf /usr/src/linux/include/linux/autoconf-up.h include/linux/autoconf.h
+ ln -sf /usr/src/linux/include/asm-i386 include/asm
+ touch include/config/MARKER
+ /usr/bin/make -C /usr/src/linux modules SUBDIRS=/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers O=/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers V=1
make: Wej¶cie do katalogu `/usr/src/linux-2.6.5'
/usr/bin/make -C /home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers             \
KBUILD_SRC=/usr/src/linux-2.6.5 KBUILD_VERBOSE=1        \
KBUILD_CHECK= -f /usr/src/linux-2.6.5/Makefile modules
  Using /usr/src/linux-2.6.5 as source for kernel
if [ -h /usr/src/linux-2.6.5/include/asm -o -f /usr/src/linux-2.6.5/.config ]; then \
        echo "  /usr/src/linux-2.6.5 is not clean, please run 'make mrproper'";\
        echo "  in the '/usr/src/linux-2.6.5' directory.";\
        /bin/false; \
fi;
if [ ! -d include2 ]; then mkdir -p include2; fi;
ln -fsn /usr/src/linux-2.6.5/include/asm-i386 include2/asm
*** Warning: Overriding SUBDIRS on the command line can cause
***          inconsistencies
mkdir -p .tmp_versions
/usr/bin/make -f /usr/src/linux-2.6.5/scripts/Makefile.build obj=scripts/basic
  gcc -Wp,-MD,scripts/basic/.fixdep.d -Iscripts/basic                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/basic/fixdep /usr/src/linux-2.6.5/scripts/basic/fixdep.c
  gcc -Wp,-MD,scripts/basic/.split-include.d -Iscripts/basic                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/basic/split-include /usr/src/linux-2.6.5/scripts/basic/split-include.c
  gcc -Wp,-MD,scripts/basic/.docproc.d -Iscripts/basic                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/basic/docproc /usr/src/linux-2.6.5/scripts/basic/docproc.c
/usr/bin/make -f /usr/src/linux-2.6.5/scripts/Makefile.build obj=scripts
  gcc -Wp,-MD,scripts/.conmakehash.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/conmakehash /usr/src/linux-2.6.5/scripts/conmakehash.c
  gcc -Wp,-MD,scripts/.kallsyms.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/kallsyms /usr/src/linux-2.6.5/scripts/kallsyms.c
  gcc -Wp,-MD,scripts/.empty.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/usr/src/linux-2.6.5/include -I/usr/src/linux-2.6.5/scripts -Iscripts -D__KERNEL__ -I/usr/src/linux-2.6.5/include -Iinclude -I/usr/src/linux-2.6.5/include2 -Iinclude2  -I/usr/src/linux-2.6.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -mregparm=3 -I/usr/src/linux-2.6.5/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default -O2  -DKBUILD_BASENAME=empty -DKBUILD_MODNAME=empty -c -o scripts/empty.o /usr/src/linux-2.6.5/scripts/empty.c
  gcc -Wp,-MD,scripts/.mk_elfconfig.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/mk_elfconfig /usr/src/linux-2.6.5/scripts/mk_elfconfig.c
  scripts/mk_elfconfig i386 < scripts/empty.o > scripts/elfconfig.h
  gcc -Wp,-MD,scripts/.file2alias.o.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o scripts/file2alias.o /usr/src/linux-2.6.5/scripts/file2alias.c
  gcc -Wp,-MD,scripts/.modpost.o.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o scripts/modpost.o /usr/src/linux-2.6.5/scripts/modpost.c
 gcc -Wp,-MD,scripts/.sumversion.o.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o scripts/sumversion.o /usr/src/linux-2.6.5/scripts/sumversion.c
  gcc  -o scripts/modpost scripts/modpost.o scripts/file2alias.o scripts/sumversion.o
  gcc -Wp,-MD,scripts/.pnmtologo.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/pnmtologo /usr/src/linux-2.6.5/scripts/pnmtologo.c
  gcc -Wp,-MD,scripts/.bin2c.d -Iscripts                 -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer  -o scripts/bin2c /usr/src/linux-2.6.5/scripts/bin2c.c
/usr/bin/make -f /usr/src/linux-2.6.5/scripts/Makefile.build obj=arch/i386/kernel arch/i386/kernel/asm-offsets.s
  gcc -Wp,-MD,arch/i386/kernel/.asm-offsets.s.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/usr/src/linux-2.6.5/include -I/usr/src/linux-2.6.5/arch/i386/kernel -Iarch/i386/kernel -D__KERNEL__ -I/usr/src/linux-2.6.5/include -Iinclude -I/usr/src/linux-2.6.5/include2 -Iinclude2  -I/usr/src/linux-2.6.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -mregparm=3 -I/usr/src/linux-2.6.5/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default -O2  -DKBUILD_BASENAME=asm_offsets -DKBUILD_MODNAME=asm_offsets -S -o arch/i386/kernel/asm-offsets.s /usr/src/linux-2.6.5/arch/i386/kernel/asm-offsets.c
  CHK     include/asm-i386/asm_offsets.h
  UPD     include/asm-i386/asm_offsets.h
/usr/bin/make -f /usr/src/linux-2.6.5/scripts/Makefile.build obj=/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers
  gcc -Wp,-MD,/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers/.amrmo_init.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/usr/src/linux-2.6.5/include  -I/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers -D__KERNEL__ -I/usr/src/linux-2.6.5/include -Iinclude -I/usr/src/linux-2.6.5/include2 -Iinclude2  -I/usr/src/linux-2.6.5/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -mregparm=3 -I/usr/src/linux-2.6.5/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default -O2  -I/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers  -I/home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers/../modem -DMODULE -DKBUILD_BASENAME=amrmo_init -DKBUILD_MODNAME=slamr -c -o /home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.o /home/users/misiek/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.c
and so one

but on 2.6.6rc1
+ cd slmodem-2.9.6
+ cp -r drivers drivers-smp
+ cd drivers
+ ln -sf /usr/src/linux/config-up .config
+ install -d include/linux include/config
+ ln -sf /usr/src/linux/include/linux/autoconf-up.h include/linux/autoconf.h
+ ln -sf /usr/src/linux/include/asm-i386 include/asm
+ touch include/config/MARKER
+ /usr/bin/make -C /usr/src/linux modules SUBDIRS=/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers O=/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers V=1
make: Entering directory `/usr/src/linux-2.6.6'
/usr/bin/make -C /home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers              \
KBUILD_SRC=/usr/src/linux-2.6.6      KBUILD_VERBOSE=1   \
KBUILD_CHECK= KBUILD_EXTMOD=/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers     \
        -f /usr/src/linux-2.6.6/Makefile modules
mkdir -p /home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/.tmp_versions
/usr/bin/make -f /usr/src/linux-2.6.6/scripts/Makefile.build obj=/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers
  gcc -Wp,-MD,/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/.amrmo_init.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/usr/src/linux-2.6.6/include  -I/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon -I/usr/src/linux-2.6.6/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default -O2  -I/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers  -I/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/../modem -DMODULE -DKBUILD_BASENAME=amrmo_init -DKBUILD_MODNAME=slamr -c -o /home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.o /home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.c
/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.c:48:27: linux/version.h: No such file or directory
/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.c:58:40: missing binary operator before token "("
make[2]: *** [/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers/amrmo_init.o] Error 1
make[1]: *** [/home/users/arekm/rpm/BUILD/slmodem-2.9.6/drivers] Error 2
make: *** [modules] Error 2
make: Leaving directory `/usr/src/linux-2.6.6'

So what's new way of building external modules when sources are read only?

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
