Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbTDJViQ (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264182AbTDJViQ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:38:16 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:60007 "EHLO
	mail.larvalstage.com") by vger.kernel.org with ESMTP
	id S264181AbTDJViP (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:38:15 -0400
Date: Thu, 10 Apr 2003 13:49:58 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.67-bk2] trivial compile fix for drivers/char/sx.c
Message-ID: <Pine.LNX.4.53.0304101345150.1935@quinn.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch below fixes following compile breakage:

  gcc -Wp,-MD,drivers/char/.sx.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=sx -DKBUILD_MODNAME=sx -c -o drivers/char/.tmp_sx.o 
drivers/char/sx.c
drivers/char/sx.c: In function `sx_fw_ioctl':
drivers/char/sx.c:1728: warning: implicit declaration of function 
`get_user'
drivers/char/sx.c:1733: warning: implicit declaration of function 
`copy_from_user'
drivers/char/sx.c:1659: warning: `nbytes' might be used uninitialized in 
this function
drivers/char/sx.c:1659: warning: `offset' might be used uninitialized in 
this function
drivers/char/sx.c:1660: warning: `data' might be used uninitialized in 
this function
drivers/char/sx.c: In function `sx_ioctl':
drivers/char/sx.c:1818: warning: implicit declaration of function 
`put_user'
drivers/char/sx.c:1822: warning: implicit declaration of function 
`verify_area'
drivers/char/sx.c:1822: `VERIFY_READ' undeclared (first use in this 
function)
drivers/char/sx.c:1822: (Each undeclared identifier is reported only once
drivers/char/sx.c:1822: for each function it appears in.)
drivers/char/sx.c:1831: `VERIFY_WRITE' undeclared (first use in this 
function)
drivers/char/sx.c: At top level:
drivers/char/sx.c:259: warning: `sx_pci_tbl' defined but not used
make[2]: *** [drivers/char/sx.o] Error 1
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2


John Kim



diff -Nau linux-2.5.67-bk2/drivers/char/sx.c 
linux-2.5.67-bk2-new/drivers/char/sx.c
--- linux-2.5.67-bk2/drivers/char/sx.c	2003-04-10 11:28:00.000000000 -0400
+++ linux-2.5.67-bk2-new/drivers/char/sx.c	2003-04-10 13:36:14.000000000 -0400
@@ -239,6 +239,7 @@
 #include "sxwindow.h"
 
 #include <linux/generic_serial.h>
+#include <asm/uaccess.h>
 #include "sx.h"
 
 
