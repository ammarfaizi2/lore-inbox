Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271421AbRHOUiH>; Wed, 15 Aug 2001 16:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271425AbRHOUh5>; Wed, 15 Aug 2001 16:37:57 -0400
Received: from miro.qualcomm.com ([129.46.64.223]:33962 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S271421AbRHOUhq>; Wed, 15 Aug 2001 16:37:46 -0400
Message-Id: <4.3.1.0.20010815133146.034a75c0@mail1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.1
Date: Wed, 15 Aug 2001 13:37:17 -0700
To: linux-kernel@vger.kernel.org
From: Maksim Krasnyanskiy <maxk@qualcomm.com>
Subject: 2.4.9-pre[34] changes in drivers/char/vt.c broke Sparc64
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Have you guys noticed that new vt.c in 2.4.9-pre[34] doesn't compile on Sparc64 (and Sparc32) ?

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o vt.o vt.c
In file included from vt.c:27:
/usr/src/linux/include/linux/irq.h:57: asm/hw_irq.h: No such file or directory
vt.c: In function `vt_ioctl':
vt.c:507: `kbd_rate' undeclared (first use in this function)
vt.c:507: (Each undeclared identifier is reported only once
vt.c:507: for each function it appears in.)
vt.c:514: `kbd_rate' used prior to declaration
vt.c:514: warning: implicit declaration of function `kbd_rate'

Simple commenting out #include <linux/irq.h> and ioctl code that uses kbd_rate works.
Whoever changed vt.c please post correct fix.

Thanks
Max

Maksim Krasnyanskiy	
Senior Kernel Engineer
Qualcomm Incorporated

maxk@qualcomm.com
http://bluez.sf.net
http://vtun.sf.net

