Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTARTht>; Sat, 18 Jan 2003 14:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTARTht>; Sat, 18 Jan 2003 14:37:49 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6272 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S264984AbTARThs>;
	Sat, 18 Jan 2003 14:37:48 -0500
Date: Sat, 18 Jan 2003 14:46:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5] initrd/mkinitrd still not working
Message-ID: <Pine.LNX.4.44.0301181444260.20185-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone *please* point me to the version of mkinitrd which works
with the new module code? The mkinitrd from Redhat and Slackware can not
find scsi modules which are in the module tree and modeles.dep. If I
build initrd by hand based on what worked for 2.5.47 it starts to load a
*still* can't find the module.

If this functionality is among the capabilities which were removed
during the module loading functionality downgrade, could someone just
say so?

Make output:

make -j2 -f scripts/Makefile.build obj=net/sunrpc
make -j2 -f scripts/Makefile.build obj=net/unix
make -j2 -f scripts/Makefile.build obj=lib
make -j2 -f scripts/Makefile.build obj=arch/i386/lib
make -j2 -f scripts/Makefile.build obj=arch/i386/boot BOOTIMAGE=arch/i386/boot/bzImage install
make -j2 -f scripts/Makefile.build obj=arch/i386/boot/compressed \
				IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.5.56 arch/i386/boot/bzImage System.map ""
No module sym53c8xx found for kernel 2.5.56

real	0m10.521s
user	0m13.490s
sys	0m1.460s

Module is present and found by depmod:

bilbo:root> find /lib/modules/2.5.56 -name 'sym53*'
/lib/modules/2.5.56/kernel/drivers/scsi/sym53c8xx_2
/lib/modules/2.5.56/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko
bilbo:root> grep sym53 /lib/modules/2.5.56/modules.dep
/lib/modules/2.5.56/kernel/drivers/scsi/sym53c8xx_2/sym53c8xx.ko:
bilbo:root> exit

Note: tried it in every kernel from 2.5.48-58, this is not just a 2.5.56
bug, I was just trying to get another feature working, without a root
filesystem it's not productive to test :-(

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


