Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292338AbSBBSBT>; Sat, 2 Feb 2002 13:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292341AbSBBSBC>; Sat, 2 Feb 2002 13:01:02 -0500
Received: from gear.torque.net ([204.138.244.1]:8211 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S292335AbSBBSAn>;
	Sat, 2 Feb 2002 13:00:43 -0500
Message-ID: <3C5C1E8A.9D0FFAD3@torque.net>
Date: Sat, 02 Feb 2002 12:14:50 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>
Subject: [PATCH] lk 2.5.3 scsi generic (sg) driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lk 2.5.3 the sg driver tries to set up both address
and page+offset in scatterlist entries. Unfortunately
asm-i386/pci.h's pci_map_sg() contains this check:

                if (sg[i].address && sg[i].page)
                        BUG();

which kills that strategy when the sym53c8xx driver
uses pci_map_sg(). This patch has been posted earlier
for lk 2.5.3-pre5 and is still required for lk 2.5.3

Doug Gilbert


--- linux/drivers/scsi/sg.c     Thu Jan 24 18:45:01 2002
+++ linux/drivers/scsi/sg.c3523 Thu Jan 24 20:53:28 2002
@@ -19,7 +19,7 @@
  */
 #include <linux/config.h>
 #ifdef CONFIG_PROC_FS
- static char sg_version_str[] = "Version: 3.5.23 (20020103)";
+ static char sg_version_str[] = "Version: 3.5.23 (20020124)";
 #endif
  static int sg_version_num = 30523; /* 2 digits for each component */
 /*
@@ -76,7 +76,7 @@
 #include <linux/version.h>
 #endif /* LINUX_VERSION_CODE */

-#define SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST
+/* #define SG_STILL_HAVE_ADDRESS_IN_SCATTERLIST */

 #define SG_ALLOW_DIO_DEF 0
 #define SG_ALLOW_DIO_CODE      /* compile out be commenting this define */


