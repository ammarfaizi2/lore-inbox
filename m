Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289598AbSBEPf2>; Tue, 5 Feb 2002 10:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289594AbSBEPfT>; Tue, 5 Feb 2002 10:35:19 -0500
Received: from smtp.tele.fi ([192.89.123.25]:60489 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id <S289598AbSBEPfH>;
	Tue, 5 Feb 2002 10:35:07 -0500
Date: Tue, 5 Feb 2002 17:34:16 +0200 (EET)
From: tchiwam <tchiwam@ees2.oulu.fi>
X-X-Sender: tchiwam@tchiwam2.invers.fi
To: linux-kernel@vger.kernel.org
Subject: Xcompile of Linux kernel from SunSolaris
Message-ID: <Pine.LNX.4.44.0202051721270.13196-100000@tchiwam2.invers.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The compile environment is a sparc-sun-solaris2.8

I have attached the way I built gcc cross compiler and binutils, these
compile without any troubles.

But then comes the Kernel...

make mrproper works
make config works
make menuconfig (don't work , I think because of ncurse version??)
make dep stops at

386/kernel _sfdep_arch/i386/mm _sfdep_arch/i386/lib
_FASTDEP_ALL_SUB_DIRS="kernel drivers mm fs net ipc lib arch/i386/kernel
arch/i386/mm arch/i386/lib"
make[1]: Entering directory `/home/tchiwam/lfs/usr/src/linux'
make -C kernel fastdep
make[2]: Entering directory `/home/tchiwam/lfs/usr/src/linux/kernel'
/bin/sh: test: unknown operator -ot
make[2]: ***
[/home/tchiwam/lfs/usr/src/linux/include/linux/modules/signal.ver] Error 1
make[2]: Leaving directory `/home/tchiwam/lfs/usr/src/linux/kernel'
make[1]: *** [_sfdep_kernel] Error 2
make[1]: Leaving directory `/home/tchiwam/lfs/usr/src/linux'
make: *** [dep-files] Error 2


If I bypass it , it complains about some version and time stamp, that
would make send considering test -ot ...

tchiwam@abc:/linux$ make zImage
i386-linux-gcc -D__KERNEL__ -I/home/tchiwam/lfs/usr/src/linux/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i386   -c -o init/main.o init/main.c
. scripts/mkversion > .tmpversion
i386-linux-gcc -D__KERNEL__ -I/home/tchiwam/lfs/usr/src/linux/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i386  -DUTS_MACHINE='"i386"' -c -o init/version.o init/version.c
In file included from init/version.c:12:
/home/tchiwam/lfs/usr/src/linux/include/linux/compile.h:1: parse error
before `-'
init/version.c:20: `UTS_VERSION' undeclared here (not in a function)
init/version.c:20: initializer element is not constant
init/version.c:20: (near initialization for `system_utsname.version')
init/version.c:26: parse error before `UTS_VERSION'
make: *** [init/version.o] Error 1


This seems to be related to Rules.make line 231

$(MODINCL)/%.ver: %.c
        @if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ];
then \
                echo '$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__
$<'; \
                echo '| $(GENKSYMS) $(genksyms_smp_prefix) -k
$(VERSION).$(PATCHLEVEL).$(SUBLEVEL) >
 $@.tmp'; \
                $(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $< \
                | $(GENKSYMS) $(genksyms_smp_prefix) -k
$(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tm
p; \
                if [ -r $@ ] && cmp -s $@ $@.tmp; then echo $@ is
unchanged; rm -f $@.tmp; \
                else echo mv $@.tmp $@; mv -f $@.tmp $@; fi; \
        fi; touch $(MODINCL)/$*.stamp


Since /bin/sh of sun solaris just don't seem to work I tried to change the
test = [ to a newly compiled one but still gives the same trouble or
wierder trouble. (I guess my skills in scripting aren't good) It would
also help to have some comments of what is this thing doing ?? and how
????

Philippe





