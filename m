Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUDVSIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUDVSIX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264541AbUDVSIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:08:23 -0400
Received: from motgate.mot.com ([129.188.136.100]:11516 "EHLO motgate.mot.com")
	by vger.kernel.org with ESMTP id S264613AbUDVSIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:08:13 -0400
Message-ID: <40880A0B.E9A569F5@eng.mcd.mot.com>
Date: Thu, 22 Apr 2004 11:08:11 -0700
From: Tom Armistead <tarmiste@eng.mcd.mot.com>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fixes to MVME5100 support in 2.6.5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch corrects problems of compiling and running the 2.6 kernel on
the MVME5100 board.    The existing MVME5100 platform support in 2.6
does not compile and run due to a moved include file (pplus.h) and a
changed interface to openpic_init().  This patch corrects those
problems.

Thanks,
Tom Armistead

============

diff -uprN origlinux-2.6.5/arch/ppc/platforms/mvme5100_pci.c
linux-2.6.5/arch/ppc/platforms/mvme5100_pci.c
--- origlinux-2.6.5/arch/ppc/platforms/mvme5100_pci.c   Sun Apr  4
06:36:18 2004
+++ linux-2.6.5/arch/ppc/platforms/mvme5100_pci.c       Fri Apr 16
16:26:02 2004
@@ -22,7 +22,7 @@
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
 #include <platforms/mvme5100.h>
-#include <asm/pplus.h>
+#include "pplus.h"

 static inline int
 mvme5100_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned
char pin)
diff -uprN origlinux-2.6.5/arch/ppc/platforms/mvme5100_setup.c
linux-2.6.5/arch/ppc/platforms/mvme5100_setup.c
--- origlinux-2.6.5/arch/ppc/platforms/mvme5100_setup.c Sun Apr  4
06:36:54 2004
+++ linux-2.6.5/arch/ppc/platforms/mvme5100_setup.c     Fri Apr 16
16:27:27 2004
@@ -43,7 +43,7 @@
 #include <asm/todc.h>
 #include <asm/pci-bridge.h>
 #include <asm/bootinfo.h>
-#include <asm/pplus.h>
+#include "pplus.h"

 extern char cmd_line[];

@@ -137,14 +137,14 @@ mvme5100_init_IRQ(void)
                ppc_md.progress("init_irq: enter", 0);

 #ifdef CONFIG_MVME5100_IPMC761_PRESENT
-       openpic_init(1, NUM_8259_INTERRUPTS, NULL, -1);
+       openpic_init(NUM_8259_INTERRUPTS);

        for(i=0; i < NUM_8259_INTERRUPTS; i++)
                irq_desc[i].handler = &i8259_pic;

        i8259_init(NULL);
 #else
-       openpic_init(1, 0, NULL, -1);
+       openpic_init(0);
 #endif

        if ( ppc_md.progress )


