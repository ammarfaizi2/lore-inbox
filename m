Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132815AbRADMUX>; Thu, 4 Jan 2001 07:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132963AbRADMUN>; Thu, 4 Jan 2001 07:20:13 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:36612 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132815AbRADMTz>; Thu, 4 Jan 2001 07:19:55 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200101041219.NAA03487@green.mif.pg.gda.pl>
Subject: [PATCH] ide patch problem
To: andre@suse.com (Andre M. Hedrick)
Date: Thu, 4 Jan 2001 13:19:10 +0100 (CET)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   Your ide.2.2.18.1221.patch does not compile on alpha:

cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8
-mcpu=ev56 -Wa,-m21164a -DBWIO_ENABLED   -c -o ide-geometry.o ide-geometry.c
In file included from ide-geometry.c:5:
/usr/src/linux/include/linux/mc146818rtc.h:29: parse error before `rtc_lock'
/usr/src/linux/include/linux/mc146818rtc.h:29: warning: type defaults to
`int' in declaration of `rtc_lock'
/usr/src/linux/include/linux/mc146818rtc.h:29: warning: data definition has
no type or storage class
make[3]: *** [ide-geometry.o] Error 1
make[3]: Leaving directory /usr/src/linux/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory /usr/src/linux/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory /usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

The following patch fixes the problem, but I'm not sure whether it is
correct :

--- drivers/block/ide-geometry.c.old	Thu Jan  4 12:51:29 2001
+++ drivers/block/ide-geometry.c	Thu Jan  4 13:18:02 2001
@@ -2,6 +2,7 @@
  * linux/drivers/ide/ide-geometry.c
  */
 #include <linux/config.h>
+#include <linux/mm.h>
 #include <linux/mc146818rtc.h>
 #include <linux/ide.h>
 #include <asm/io.h>

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
