Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285750AbRLHCEv>; Fri, 7 Dec 2001 21:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285751AbRLHCEl>; Fri, 7 Dec 2001 21:04:41 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:44559 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S285750AbRLHCEb>; Fri, 7 Dec 2001 21:04:31 -0500
Message-ID: <3C11752C.15FA7EBE@delusion.de>
Date: Sat, 08 Dec 2001 03:04:28 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Compile fixes for 2.5.1-pre7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Below a trivial patch which fixes compiler warnings for -pre7.

Regards,
Udo.

diff -urN -X dontdiff linux-vanilla/init/do_mounts.c linux-2.5.1/init/do_mounts.c
--- linux-vanilla/init/do_mounts.c      Sat Dec  8 02:58:00 2001
+++ linux-2.5.1/init/do_mounts.c        Sat Dec  8 02:46:18 2001
@@ -29,6 +29,9 @@

 extern void rd_load(void);
 extern void initrd_load(void);
+extern int get_filesystem_list(char *);
+extern void floppy_eject(void);
+extern void wait_for_keypress(void);

 #ifdef CONFIG_BLK_DEV_INITRD
 unsigned int real_root_dev;    /* do_proc_dointvec cannot handle kdev_t */
diff -urN -X dontdiff linux-vanilla/kernel/device.c linux-2.5.1/kernel/device.c
--- linux-vanilla/kernel/device.c       Sat Dec  8 02:58:00 2001
+++ linux-2.5.1/kernel/device.c Sat Dec  8 02:56:05 2001
@@ -899,7 +899,6 @@
 int __init device_driver_init(void)
 {
        int error = 0;
-       int pid;

        DBG("DEV: Initialising Device Tree\n");
