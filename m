Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275654AbRJAWSQ>; Mon, 1 Oct 2001 18:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275650AbRJAWSH>; Mon, 1 Oct 2001 18:18:07 -0400
Received: from cpe.atm0-0-0-209183.boanxx7.customer.tele.dk ([62.242.151.103]:25491
	"HELO mail.hswn.dk") by vger.kernel.org with SMTP
	id <S275645AbRJAWRt>; Mon, 1 Oct 2001 18:17:49 -0400
Date: Tue, 2 Oct 2001 00:18:16 +0200
Message-Id: <200110012218.f91MIGU10233@hswn.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.11-pre2
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com>
From: <henrik@hswn.dk> Henrik Stoerner
X-Newsreader: NN version 6.5.6 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get:

gcc -D__KERNEL__ -I/home/src/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c sysrq.c
sysrq.c: In function `sysrq_handle_mountro':
sysrq.c:234: too many arguments to function `wakeup_bdflush'
make[3]: *** [sysrq.o] Error 1
make[3]: Leaving directory `/home/src/linux-2.4/drivers/char'

Seems this patch to drivers/char/sysrq.c should not be in:

 static void sysrq_handle_mountro(int key, struct pt_regs *pt_regs,
                struct kbd_struct *kbd, struct tty_struct *tty) {
        emergency_sync_scheduled = EMERG_REMOUNT;
-       wakeup_bdflush();
+       wakeup_bdflush(0);
 }

-- 
Henrik Storner <henrik@hswn.dk> 

