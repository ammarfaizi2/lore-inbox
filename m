Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWFZPku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFZPku (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWFZPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:40:49 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:13283 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750704AbWFZPkt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:40:49 -0400
Date: Mon, 26 Jun 2006 19:40:46 +0400
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Subject: NFS warning messages: .exit section funcs referenced in .init
Message-Id: <20060626194046.c88e8e82.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here's what I get when compiling full NFSv3 support into kernel (I guess that it's also a result of some janitorial actions):

  LD      .tmp_vmlinux1
arm_v5t_le-ld: `nfs_destroy_writepagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_readpagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `.exit.text' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_nfspagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
arm_v5t_le-ld: `nfs_destroy_writepagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_readpagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `.exit.text' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_nfspagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
arm_v5t_le-ld: `nfs_destroy_writepagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_readpagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `.exit.text' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_nfspagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/arm/boot/Image
  Kernel: arch/arm/boot/Image is ready
  GZIP    arch/arm/boot/compressed/piggy.gz
  AS      arch/arm/boot/compressed/piggy.o
  LD      arch/arm/boot/compressed/vmlinux
  OBJCOPY arch/arm/boot/zImage
  Kernel: arch/arm/boot/zImage is ready
vital@laja:~/work/opensource/linux-2.6.git$ make O=../build ARCH=arm CROSS_COMPILE=arm_v5t_le- zImage && cp ../build/arch/arm/boot/zImage /tftpboot/zzz
  CHK     include/linux/version.h
make[2]: `include/asm-arm/mach-types.h' is up to date.
  Using /home/vital/work/opensource/linux-2.6.git as source for kernel
  GEN     /home/vital/work/opensource/build/Makefile
  CHK     include/linux/compile.h
  CC      drivers/char/watchdog/pnx4008_wdt.o
  LD      drivers/char/watchdog/built-in.o
  LD      drivers/char/built-in.o
  LD      drivers/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arm_v5t_le-ld: `nfs_destroy_writepagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_readpagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `.exit.text' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_nfspagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

  KSYM    .tmp_kallsyms1.S
  AS      .tmp_kallsyms1.o
  LD      .tmp_vmlinux2
arm_v5t_le-ld: `nfs_destroy_writepagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_readpagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `.exit.text' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_nfspagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

  KSYM    .tmp_kallsyms2.S
  AS      .tmp_kallsyms2.o
  LD      vmlinux
arm_v5t_le-ld: `nfs_destroy_writepagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_readpagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `.exit.text' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

arm_v5t_le-ld: `nfs_destroy_nfspagecache' referenced in section `.init.text' of fs/built-in.o: defined in discarded section `.exit.text' of fs/built-in.o

Vitaly
