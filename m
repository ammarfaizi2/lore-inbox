Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314520AbSDXDeN>; Tue, 23 Apr 2002 23:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314521AbSDXDeM>; Tue, 23 Apr 2002 23:34:12 -0400
Received: from mail.mesatop.com ([208.164.122.9]:23052 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S314520AbSDXDeM>;
	Tue, 23 Apr 2002 23:34:12 -0400
Subject: [PATCH] 2.5.9-dj1, fix for make xconfig in drivers/isdn/Config.in
From: Steven Cole <elenstev@mesatop.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Apr 2002 21:31:59 -0600
Message-Id: <1019619120.29017.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read that some of you got this while doing make xconfig.

[steven@localhost linux-2.5.9-dj1]$ make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/home/steven/kernels/linux-2.5.9-dj1/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/isdn/Config.in: 10: incorrect argument
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/home/steven/kernels/linux-2.5.9-dj1/scripts'
make: *** [xconfig] Error 2

This fix seems to be the obvious one.

Steven

--- linux-2.5.9-dj1/drivers/isdn/Config.in.orig	Tue Apr 23 21:14:37 2002
+++ linux-2.5.9-dj1/drivers/isdn/Config.in	Tue Apr 23 21:22:10 2002
@@ -7,7 +7,7 @@
 if [ "$CONFIG_NET" != "n" ]; then
    bool 'ISDN support' CONFIG_ISDN_BOOL
 
-   if [ "$CONFIG_ISDN_BOOL" == "y" ]; then
+   if [ "$CONFIG_ISDN_BOOL" = "y" ]; then
       mainmenu_option next_comment
       comment 'Old ISDN4Linux'
 



