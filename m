Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263037AbSJBKfk>; Wed, 2 Oct 2002 06:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbSJBKfk>; Wed, 2 Oct 2002 06:35:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36106 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263037AbSJBKfB>; Wed, 2 Oct 2002 06:35:01 -0400
Date: Wed, 2 Oct 2002 11:40:28 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: kernel makefiles broken?
Message-ID: <20021002114028.C24770@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've noticed on two machines now that the kernel makefiles seem to have
changed their behaviour.  One x86 RH-based, and one parisc debian based.

make seems to ignores errors from gcc, and only stops when trying to link.
On a PARISC box, I've seen the build get all the way though to successfully
linking vmlinux, even with compilation failures.  Obviously not ideal,
since vmlinux may not reflect reality.

  arm-linux-gcc -Wp,-MD,./.sl82c105.o.d -D__KERNEL__ -I/home/rmk/v2.5/linux-ebsa285/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -mapcs -mapcs-32 -D__LINUX_ARM_ARCH__=4 -march=armv4 -mtune=strongarm110 -mshort-load-bytes -msoft-float -Wa,-mno-fpu -nostdinc -iwithprefix include
-I../  -DKBUILD_BASENAME=sl82c105   -c -o sl82c105.o sl82c105.c
drivers/ide/pci/sl82c105.c: In function `sl82c105_init_one':
drivers/ide/pci/sl82c105.c:287: `slc82c105_chipsets' undeclared (first use in this function)
drivers/ide/pci/sl82c105.c:287: (Each undeclared identifier is reported only once
drivers/ide/pci/sl82c105.c:287: for each function it appears in.)
/home/rmk/v2.5/linux-ebsa285/include/asm/dma.h: At top level:
drivers/ide/pci/sl82c105.h:12: warning: `sl82c105_chipsets' defined but not used
  arm-linux-gcc -Wp,-MD,./.generic.o.d -D__KERNEL__ -I/home/rmk/v2.5/linux-ebsa285/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -mapcs -mapcs-32 -D__LINUX_ARM_ARCH__=4 -march=armv4 -mtune=strongarm110 -mshort-load-bytes -msoft-float -Wa,-mno-fpu -nostdinc -iwithprefix include  -I../  -DKBUILD_BASENAME=generic   -c -o generic.o generic.c
drivers/ide/pci/generic.h:148: warning: `unknown_chipset' defined but not used
drivers/ide/pci/generic.c:84: warning: `init_setup_unknown' defined but not used
   arm-linux-ld   -r -o built-in.o cy82c693.o pdc202xx_old.o sl82c105.o generic.o
arm-linux-ld: cannot open sl82c105.o: No such file or directory
make[3]: *** [built-in.o] Error 1
make[3]: Leaving directory `/home/rmk/v2.5/linux-ebsa285/drivers/ide/pci'
make[2]: *** [pci] Error 2
make[2]: Leaving directory `/home/rmk/v2.5/linux-ebsa285/drivers/ide'
make[1]: *** [ide] Error 2
make[1]: Leaving directory `/home/rmk/v2.5/linux-ebsa285/drivers'
make: *** [drivers] Error 2


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

