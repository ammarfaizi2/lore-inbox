Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130007AbQL1LvI>; Thu, 28 Dec 2000 06:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130417AbQL1Lu6>; Thu, 28 Dec 2000 06:50:58 -0500
Received: from [151.17.201.167] ([151.17.201.167]:23362 "EHLO proxy.teamfab.it")
	by vger.kernel.org with ESMTP id <S130007AbQL1Lut>;
	Thu, 28 Dec 2000 06:50:49 -0500
Message-ID: <3A4B21F9.75221782@teamfab.it>
Date: Thu, 28 Dec 2000 12:20:25 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.72C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: [patch-2.2.18] some trivial patch...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

the first patch is a must for kernels that load scsi driver from initrd
;)
the second one allow "make install" to work also if lilo isn't
installed..

main.patch :

diff -ur linux-2.2.18.orig/init/main.c linux-2.2.18.tl/init/main.c
--- linux-2.2.18.orig/init/main.c       Mon Dec 11 01:49:44 2000
+++ linux-2.2.18.tl/init/main.c Thu Dec 28 11:37:27 2000
@@ -485,7 +485,7 @@
        { "hdk",     0x3900 },
        { "hdl",     0x3940 },
 #endif
-#ifdef CONFIG_BLK_DEV_SD
+#if defined(CONFIG_BLK_DEV_SD) || defined(CONFIG_BLK_DEV_SD_MODULE)
        { "sda",     0x0800 },
        { "sdb",     0x0810 },
        { "sdc",     0x0820 },


nolilo.patch :

diff -u -r kernel-2.2.18-orig/arch/i386/boot/install.sh
kernel-2.2.18-teamlinux/arch/i386/boot/install.sh
--- kernel-2.2.18-orig/arch/i386/boot/install.sh        Tue Jan  3
12:57:26 1995
+++ kernel-2.2.18-teamlinux/arch/i386/boot/install.sh   Tue Dec 19
16:21:24 2000
@@ -36,4 +36,10 @@
 cat $2 > $4/vmlinuz
 cp $3 $4/System.map

-if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
+if [ -x /sbin/lilo ]; then
+       /sbin/lilo
+elif [ -x /etc/lilo/install ]; then
+       /etc/lilo/install
+fi
+
+# Grub rulez ;)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
