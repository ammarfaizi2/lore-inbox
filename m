Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRD1WTB>; Sat, 28 Apr 2001 18:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRD1WSw>; Sat, 28 Apr 2001 18:18:52 -0400
Received: from pop.gmx.net ([194.221.183.20]:27177 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135664AbRD1WSe>;
	Sat, 28 Apr 2001 18:18:34 -0400
Message-Id: <3.0.6.32.20010429001835.007ad3a0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sun, 29 Apr 2001 00:18:35 +0200
To: linux-kernel@vger.kernel.org, linux-parport@torque.net
From: Felix Odenkirchen <F.Odenkirchen@gmx.net>
Subject: 2.4.4 broken parport_pc.c as module on non-PCI machine
Cc: torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!
Compiling plain 2.4.4 kernel on a i486 with_out_ PCI support, I encountered the following error with PC parallel port as a module:

parport_pc.c: In function `parport_pc_find_ports':
parport_pc.c:2618: too many arguments to function `parport_pc_init_superio'
make[2]: *** [parport_pc.o] Error 1
make[1]: *** [_modsubdir_parport] Error 2
make: *** [_mod_drivers] Error 2

This was caused by a non-pci substitute for __init parport_pc_init_superio which lacked the proper argument definitions. I tried to add those, and it compiled just fine for me.
Therefor I proposed the appended fix.
Any comments are welcome and encouraged, please CC me.
/Felix


diff -urN linux.vanilla/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
--- linux.vanilla/drivers/parport/parport_pc.c  Sat Apr 21 01:23:12 2001
+++ linux/drivers/parport/parport_pc.c  Sat Apr 28 19:27:22 2001
@@ -2576,7 +2576,7 @@
 }
 #else
 static struct pci_driver parport_pc_pci_driver;
-static int __init parport_pc_init_superio(void) {return 0;}
+static int __init parport_pc_init_superio (int autoirq, int autodma) {return 0;}
 #endif /* CONFIG_PCI */

 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */

-- 
+----------------------------------------------------------------------+
     F.Odenkirchen@gmx.net        http://www.uni-karlsruhe.de/~ugyb
+----------------------------------------------------------------------+
