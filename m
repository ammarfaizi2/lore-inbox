Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293182AbSCLWsm>; Tue, 12 Mar 2002 17:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSCLWsd>; Tue, 12 Mar 2002 17:48:33 -0500
Received: from jubjub.wizard.com ([209.170.216.9]:61453 "EHLO
	jubjub.wizard.com") by vger.kernel.org with ESMTP
	id <S293182AbSCLWs1>; Tue, 12 Mar 2002 17:48:27 -0500
Date: Tue, 12 Mar 2002 14:47:54 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.6: make xconfig croaks in with sound/core/Config.in
Message-ID: <20020312224754.GA32687@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux/2.5.5 (i686)
X-uptime: 2:44pm  up 8 days,  9:41,  2 users,  load average: 0.08, 0.04, 0.03
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Short, but sweet:

root@bellicha:/usr/src/linux# head -10 Makefile
VERSION = 2
PATCHLEVEL = 5
SUBLEVEL = 6
EXTRAVERSION =

KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e 
s/arm.*/arm/ -e s/sa110/arm/)
KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//")

root@bellicha:/usr/src/linux# make xconfig &
[2] 32520
root@bellicha:/usr/src/linux# rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.5.5/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
tkparse.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
sound/core/Config.in: 4: can't handle dep_bool/dep_mbool/dep_tristate condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.5/scripts'
make: *** [xconfig] Error 2

[2]+  Exit 2                  make xconfig

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

