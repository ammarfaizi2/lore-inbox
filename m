Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTADBBu>; Fri, 3 Jan 2003 20:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267760AbTADBBu>; Fri, 3 Jan 2003 20:01:50 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:773 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S264944AbTADBBt>;
	Fri, 3 Jan 2003 20:01:49 -0500
To: linux-kernel@vger.kernel.org
Subject: build failure 2.5.54+
From: "James H. Cloos Jr." <cloos@jhcloos.com>
Date: 03 Jan 2003 20:10:08 -0500
Message-ID: <m3bs2xu3db.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometime between the csets

    rddunlap@osdl.org|ChangeSet|20021218224440|38837

and

    sfr@canb.auug.org.au|ChangeSet|20030103190613|05701

compilation of ixj.ko broke.

(That is OTOO 520 csets of difference; I didn't try a compile during
the 2.5.53 timeframe.)

It looks isapnp related:

make -f scripts/Makefile.build obj=drivers/telephony
   rm -f drivers/telephony/built-in.o; ar rcs drivers/telephony/built-in.o
  gcc -Wp,-MD,drivers/telephony/.phonedev.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=phonedev -DKBUILD_MODNAME=phonedev -DEXPORT_SYMTAB  -c -o drivers/telephony/phonedev.o drivers/telephony/phonedev.c
  ld -m elf_i386  -r -o drivers/telephony/phonedev.ko drivers/telephony/phonedev.o
  gcc -Wp,-MD,drivers/telephony/.ixj.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=ixj -DKBUILD_MODNAME=ixj -DEXPORT_SYMTAB  -c -o drivers/telephony/ixj.o drivers/telephony/ixj.c
drivers/telephony/ixj.c: In function `cleanup':
drivers/telephony/ixj.c:7581: structure has no member named `deactivate'
drivers/telephony/ixj.c:7582: structure has no member named `deactivate'
drivers/telephony/ixj.c: In function `ixj_probe_isapnp':
drivers/telephony/ixj.c:7715: warning: implicit declaration of function `isapnp_find_dev'
drivers/telephony/ixj.c:7716: warning: assignment makes pointer from integer without a cast
drivers/telephony/ixj.c:7719: structure has no member named `prepare'
drivers/telephony/ixj.c:7731: structure has no member named `activate'
drivers/telephony/ixj.c:7762: structure has no member named `serial'
drivers/telephony/ixj.c:7712: warning: `result' might be used uninitialized in this function
make[2]: *** [drivers/telephony/ixj.o] Error 1
make[1]: *** [drivers/telephony] Error 2
make: *** [drivers] Error 2

(I'd try w/o ISAPNP, but the last time I did, I ended up w/o a working
kb or mouse....)

-JimC

