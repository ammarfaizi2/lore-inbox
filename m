Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131487AbRBKBNH>; Sat, 10 Feb 2001 20:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131511AbRBKBM4>; Sat, 10 Feb 2001 20:12:56 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:25100 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S131487AbRBKBMs>; Sat, 10 Feb 2001 20:12:48 -0500
Date: Sun, 11 Feb 2001 02:12:33 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
cc: <alan@lxorguk.ukuu.org.uk>
Subject: 2.2.19pre9 & aic7xxx
Message-ID: <Pine.LNX.4.30.0102110205340.2737-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
In linux/drivers/scsi/hosts.c we have line:
#include "aic7xxx.h"  and during compilation we gets a error:

hosts.c:139: aic7xxx.h: No such file or directory
hosts.c:500: `AIC7XXX' undeclared here (not in a function)
hosts.c:500: initializer element for `builtin_scsi_hosts[0]' is not
constant
make[3]: *** [hosts.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/scsi'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/scsi'
make[1]: *** [_subdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2


and IMHO shuld be:

#include "aic7xxx/aic7xxx.h"

there is super little patch :-)

diff -ur linux.org/drivers/scsi/hosts.c linux/drivers/scsi/hosts.c
--- linux.org/drivers/scsi/hosts.c      Sun Feb 11 02:06:02 2001
+++ linux/drivers/scsi/hosts.c  Sun Feb 11 02:08:05 2001
@@ -136,7 +136,7 @@
 #endif

 #ifdef CONFIG_SCSI_AIC7XXX
-#include "aic7xxx.h"
+#include "aic7xxx/aic7xxx.h"
 #endif

 #ifdef CONFIG_SCSI_IPS



-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
