Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318791AbSG0REh>; Sat, 27 Jul 2002 13:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318792AbSG0REh>; Sat, 27 Jul 2002 13:04:37 -0400
Received: from mx2.airmail.net ([209.196.77.99]:29961 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S318791AbSG0REd>;
	Sat, 27 Jul 2002 13:04:33 -0400
Date: Sat, 27 Jul 2002 12:02:46 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] warning fix for ide.h
Message-ID: <20020727170246.GA22926@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I saw this when building 2.5.29 ...

make[2]: Entering directory `/mnt/src/linux-2.5.29/drivers/ide'
gcc -Wp,-MD,./.ide-cd.o.d -D__KERNEL__ -I/mnt/src/linux-2.5.29/include
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i586 -nostdinc -iwithprefix include -DMODULE
-DKBUILD_BASENAME=ide_cd   -c -o ide-cd.o ide-cd.c
ide-cd.c: In function `ide_cdrom_do_request':
ide-cd.c:1623: warning: implicit declaration of function `ide_stall_queue'

Adding a prototype to ide.h removes the warning.

--- linux-2.5.29/include/linux/ide.h.old	2002-07-27 09:10:24.000000000 -0500
+++ linux-2.5.29/include/linux/ide.h	2002-07-27 12:00:49.000000000 -0500
@@ -656,6 +656,7 @@
 extern int ide_spin_wait_hwgroup(struct ata_device *);
 extern void ide_timer_expiry(unsigned long data);
 extern void ata_irq_request(int irq, void *data, struct pt_regs *regs);
+extern void ide_stall_queue(struct ata_device * drive, unsigned long timeout);
 extern void do_ide_request(request_queue_t * q);
 extern void ide_init_subdrivers(void);
 

-- 
They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
