Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263313AbSK0QMN>; Wed, 27 Nov 2002 11:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSK0QMN>; Wed, 27 Nov 2002 11:12:13 -0500
Received: from tirwhan.org ([217.160.128.80]:57477 "EHLO tirwhan.org")
	by vger.kernel.org with ESMTP id <S263313AbSK0QMM>;
	Wed, 27 Nov 2002 11:12:12 -0500
Message-ID: <3DE4F143.4050106@tirwhan.org>
Date: Wed, 27 Nov 2002 16:22:27 +0000
From: Marc <kernelmarc@tirwhan.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modversions problem with 2.5.48 + .49
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I cannot successfully make dep on either 2.5.48 or 2.5.49 . My steps are:

cd ~/kernel/
tar xvzf linux-2.5.49.tar.gz
cd linux-2.5.49
make mrproper
make config - (output below), choosing all default options except for 
processor type
make dep     - which fails with following output:

   Generating include/linux/version.h (updated)
   Making asm->asm-i386 symlink
   SPLIT  include/linux/autoconf.h -> include/config/*  
   Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
  make[1]: Nothing to be done for `include/linux/modversions.h'.

'make config' produced the following output:

   rm -f scripts/built-in.o; ar rcs scripts/built-in.o
   gcc -Wp,-MD,scripts/.fixdep.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/fixdep scripts/fixdep.c
   gcc -Wp,-MD,scripts/.split-include.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/split-include scripts/split-include.c
   gcc -Wp,-MD,scripts/.docproc.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/docproc scripts/docproc.c
   gcc -Wp,-MD,scripts/.conmakehash.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -o scripts/conmakehash scripts/conmakehash.c
   cat scripts/kconfig/zconf.tab.h_shipped > scripts/kconfig/zconf.tab.h
   gcc -Wp,-MD,scripts/kconfig/.conf.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -c -o scripts/kconfig/conf.o scripts/kconfig/conf.c
  sed < scripts/kconfig/lkc_proto.h > scripts/kconfig/lkc_defs.h 
's/P(\([^,]*\),.*/#define \1 (\*\1_p)/'
   gcc -Wp,-MD,scripts/kconfig/.kconfig_load.o.d -Wall 
-Wstrict-prototypes -O2 -fomit-frame-pointer   -c -o 
scripts/kconfig/kconfig_load.o scripts/kconfig/kconfig_load.c
   gcc -Wp,-MD,scripts/kconfig/.mconf.o.d -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer   -c -o scripts/kconfig/mconf.o 
scripts/kconfig/mconf.c
   cat scripts/kconfig/zconf.tab.c_shipped > scripts/kconfig/zconf.tab.c
   cat scripts/kconfig/lex.zconf.c_shipped > scripts/kconfig/lex.zconf.c
   gcc -Wp,-MD,scripts/kconfig/.zconf.tab.o.d -fPIC -Wall 
-Wstrict-prototypes -O2 -fomit-frame-pointer  -Iscripts/kconfig -c -o 
scripts/kconfig/zconf.tab.o scripts/kconfig/zconf.tab.c
   gcc  -shared -o scripts/kconfig/libkconfig.so 
scripts/kconfig/zconf.tab.o  gcc  -o scripts/kconfig/conf 
scripts/kconfig/conf.o scripts/kconfig/libkconfig.so 
./scripts/kconfig/conf arch/i386/Kconfig
  #
  # using defaults found in arch/i386/defconfig
  #
  arch/i386/defconfig:27: trying to assign nonexistent symbol MODVERSIONS
  arch/i386/defconfig:282: trying to assign nonexistent symbol 
SD_EXTRA_DEVS
  arch/i386/defconfig:287: trying to assign nonexistent symbol 
SR_EXTRA_DEVS
  arch/i386/defconfig:1015: trying to assign nonexistent symbol 
USB_UHCI_HCD_ALT
  *
  * Linux Kernel Configuration
  ...etc

So the problem seems to be that the MODVERSIONS option isn't picked up 
by Kconfig but 'make dep' looks for modversions.h anyway and falls over 
when it doesn't find it. I've tried fiddling with the configuration 
options (added modversions in manually, changed the module options etc.) 
but never get anywhere. This wasn't a problem up to 2.5.47, but the last 
two kernels both behave the same way. And I've tried it on two different 
machines with exactly the same result. What's even more puzzling to me 
is that nobody else seems to be having this problem since I can't find 
any reference on here or anywhere else on the net. So I must be making 
some weirdly stupid mistake. Could somebody please tell me what it is?

Thanks a bunch,

Marc

