Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270144AbRHOU7r>; Wed, 15 Aug 2001 16:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271448AbRHOU7h>; Wed, 15 Aug 2001 16:59:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53006 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270144AbRHOU71>; Wed, 15 Aug 2001 16:59:27 -0400
Subject: Re: 2.4.9-pre[34] changes in drivers/char/vt.c broke Sparc64
To: maxk@qualcomm.com (Maksim Krasnyanskiy)
Date: Wed, 15 Aug 2001 22:02:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Maksim Krasnyanskiy" at Aug 15, 2001 01:37:17 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X7nm-00042d-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Have you guys noticed that new vt.c in 2.4.9-pre[34] doesn't compile on
> Sparc64 (and Sparc32) ?

I dont have sparcs to check, so I reply on the sparc maintains

> sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs    -c -o vt.o vt.c
> In file included from vt.c:27:
> /usr/src/linux/include/linux/irq.h:57: asm/hw_irq.h: No such file or directory

Russell posted a fix for this, and he' sright that removing it can be done

> vt.c: In function `vt_ioctl':
> vt.c:507: `kbd_rate' undeclared (first use in this function)
> vt.c:507: (Each undeclared identifier is reported only once
> vt.c:507: for each function it appears in.)
> vt.c:514: `kbd_rate' used prior to declaration
> vt.c:514: warning: implicit declaration of function `kbd_rate'
> 
> Simple commenting out #include <linux/irq.h> and ioctl code that uses kbd_rate works.
> Whoever changed vt.c please post correct fix.

You need a sparc hacker to do this. If there are sparcs implementing the PC
keyboard controller (eg the pci ones) then kbd_rate needs implementing and
XFree86 needs recompiling to fix cases where the keyboard can be hung solid

Alan
