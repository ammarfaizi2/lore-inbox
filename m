Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJFC0q>; Fri, 5 Oct 2001 22:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274879AbRJFC0g>; Fri, 5 Oct 2001 22:26:36 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:12548 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S274875AbRJFC0Y>; Fri, 5 Oct 2001 22:26:24 -0400
Message-ID: <3BBE6BE4.B0BA5B@delusion.de>
Date: Sat, 06 Oct 2001 04:26:44 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Compile fixes for 2.4.10-ac7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,

Below is a patch for -ac7 that fixes a few gcc warnings, namely:

* Adds a missing return statement in ppro_with_ram_bug
* Ifdefs out disable_ide_dma because its only caller is also ifdef'd
  out

Also note that the recent smbfs updates introduced a second definition
for ERRdiskfull in include/linux/smbno.h (lines 43, 107). I am not sure
which one needs to go.

Regards,
-Udo.

diff -urN linux-2.4.10-ac/arch/i386/kernel/dmi_scan.c linux-2.4.10-ac-mod/arch/i386/kernel/dmi_scan.c
--- linux-2.4.10-ac/arch/i386/kernel/dmi_scan.c Sat Oct  6 03:54:02 2001
+++ linux-2.4.10-ac-mod/arch/i386/kernel/dmi_scan.c     Sat Oct  6 04:14:34 2001
@@ -190,7 +190,8 @@
  *     rule needs to be improved to match specific BIOS revisions with
  *     corruption problems
  */
-
+
+#if 0
 static __init int disable_ide_dma(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_BLK_DEV_IDE
@@ -203,6 +204,7 @@
 #endif
        return 0;
 }
+#endif

 /*
  * Reboot options and system auto-detection code provided by
diff -urN linux-2.4.10-ac/arch/i386/kernel/setup.c linux-2.4.10-ac-mod/arch/i386/kernel/setup.c
--- linux-2.4.10-ac/arch/i386/kernel/setup.c    Sat Oct  6 03:54:02 2001
+++ linux-2.4.10-ac-mod/arch/i386/kernel/setup.c        Sat Oct  6 04:11:03 2001
@@ -2925,6 +2925,7 @@
                return 1;
        }
        printk(KERN_INFO "Your Pentium Pro seems ok.\n");
+       return 0;
 }

 /*
