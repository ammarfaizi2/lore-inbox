Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129595AbQLWFAP>; Sat, 23 Dec 2000 00:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbQLWE7y>; Fri, 22 Dec 2000 23:59:54 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:13319 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129595AbQLWE7o>; Fri, 22 Dec 2000 23:59:44 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test13pre4ac2 fix net/irda/irnet/Config.in: 1: bad if condition 
Date: Fri, 22 Dec 2000 21:30:20 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <00122221302000.15446@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following error with 2.4.0-test13-pre4-ac2:

[root@localhost linux-2.4.0-test13-pre4-ac2]# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.0-test13-pre4-ac2/scripts'
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
net/irda/irnet/Config.in: 1: bad if condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.0-test13-pre4-ac2/scripts'
make: *** [xconfig] Error 2

Here is a patch to fix it:
Steven

diff -u linux/net/irda/irnet/Config.in.orig linux/net/irda/irnet/Config.in
--- linux/net/irda/irnet/Config.in.orig Fri Dec 22 20:36:16 2000
+++ linux/net/irda/irnet/Config.in      Fri Dec 22 21:16:29 2000
@@ -1,4 +1,4 @@
-if [ $CONFIG_NETDEVICES != "n" ]; then
+if [ "$CONFIG_NETDEVICES" != "n" ]; then
    dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA $CONFIG_PPP
 fi
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
