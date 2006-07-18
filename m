Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWGRXz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWGRXz5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 19:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWGRXz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 19:55:57 -0400
Received: from student.uhasselt.be ([193.190.2.1]:23059 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932422AbWGRXz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 19:55:57 -0400
Date: Wed, 19 Jul 2006 01:55:54 +0200
To: linux-kernel@vger.kernel.org
Subject: allyesconfig building problem
Message-ID: <20060718235554.GA30193@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to build Linux 2.6.18-rc2 (82d6897fefca6206bca7153805b4c5359ce97fc4)
with the allyesconfig configuration gives me the following error
message:
[...]
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `hdlcdev_open':/usr/local/src/linux-2.6/drivers/char/synclink.c:7847: undefined reference to `hdlc_set_carrier'
drivers/built-in.o: In function `mgsl_isr_io_pin':/usr/local/src/linux-2.6/drivers/char/synclink.c:1348: undefined reference to `hdlc_set_carrier'
drivers/built-in.o: In function `isr_io_pin':/usr/local/src/linux-2.6/drivers/char/synclinkmp.c:2526: undefined reference to `hdlc_set_carrier'
drivers/built-in.o: In function `hdlcdev_open':/usr/local/src/linux-2.6/drivers/char/synclinkmp.c:1755: undefined reference to `hdlc_set_carrier'
drivers/built-in.o: In function `dcd_change':/usr/local/src/linux-2.6/drivers/char/synclink_gt.c:2001: undefined reference to `hdlc_set_carrier'
drivers/built-in.o:/usr/local/src/linux-2.6/drivers/char/synclink_gt.c:1500: more undefined references to `hdlc_set_carrier' follow
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [_all] Error 2

I'm using GCC 4.0.3 on a x86 based Ubuntu 6.06 distro.

Okay, I just noticed that similar problems have been reported before, 
but I'm sending this anyway in case it might be useful as a
confirmation of the problem.

With friendly regards,
Takis


takis@poseidon:/usr/local/src/linux-2.6$ gcc -v
Using built-in specs.
Target: i486-linux-gnu
Configured with: ../src/configure -v
--enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr
--enable-shared --with-system-zlib --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --enable-nls
--program-suffix=-4.0 --enable-__cxa_atexit --enable-clocale=gnu
--enable-libstdcxx-debug --enable-java-awt=gtk-default
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre
--enable-mpfr --disable-werror --with-tune=pentium4
--enable-checking=release i486-linux-gnu
Thread model: posix
gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)

takis@poseidon:/usr/local/src/linux-2.6$ ld -v
GNU ld version 2.16.91 20060118 Debian GNU/Linux

takis@poseidon:/usr/local/src/linux-2.6$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2
cpu MHz         : 2010.499
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 2012.55

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 35
model name      : AMD Athlon(tm) 64 X2 Dual Core Processor 3800+
stepping        : 2
cpu MHz         : 2010.499
cache size      : 512 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 2012.55


-- 
OpenPGP key: http://lumumba.uhasselt.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
