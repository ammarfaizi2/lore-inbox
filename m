Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLWUbR>; Sat, 23 Dec 2000 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQLWUbH>; Sat, 23 Dec 2000 15:31:07 -0500
Received: from uberbox.mesatop.com ([208.164.122.9]:6665 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129532AbQLWUa4>; Sat, 23 Dec 2000 15:30:56 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test13-pre4 fix drivers/ieee1394/Makefile
Date: Sat, 23 Dec 2000 11:17:08 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: ebi4@ozob.net
MIME-Version: 1.0
Message-Id: <00122311170801.07144@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebi4 wrote:
>ld: cannot open drivers/ieee1394/ieee1394.a: No such file or directory
>make: *** [vmlinux] Error 1

Changing the order of a few lines in linux/drivers/ieee1394/Makefile fixes 
this problem.  Here is the patch:
Steven

diff -u linux/drivers/ieee1394/Makefile.orig linux/drivers/ieee1394/Makefile
--- linux/drivers/ieee1394/Makefile.orig        Sat Dec 23 11:03:06 2000
+++ linux/drivers/ieee1394/Makefile     Sat Dec 23 11:04:08 2000
@@ -23,7 +23,7 @@
 obj-$(CONFIG_IEEE1394_VIDEO1394) += video1394.o
 obj-$(CONFIG_IEEE1394_RAWIO) += raw1394.o
 
+include $(TOPDIR)/Rules.make
+
 ieee1394.o: $(ieee1394-objs)
        $(LD) -r -o $@ $(ieee1394-objs)
-
-include $(TOPDIR)/Rules.make
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
