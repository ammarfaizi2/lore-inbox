Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKQ6C>; Mon, 11 Dec 2000 11:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLKQ5m>; Mon, 11 Dec 2000 11:57:42 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:55026 "HELO
	seatle.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S129183AbQLKQ5h>; Mon, 11 Dec 2000 11:57:37 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: 2.2.18 and aacraid patch
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 11 Dec 2000 17:27:01 +0100
Message-ID: <m2d7eyj54a.fsf@seatle.mandrakesoft.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I think you forgot some revert of the aaccraid patch, thing like that
:

#ifdef CONFIG_SCSI_AACRAID
#include "aacraid/include/linit.h"
#endif

in drivers/scsci/hosts.c

make no sense.

revert patch attached

PS: even if it doen't change anything actually it may help when need
to apply the patch to don't have reject.

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel


--- linux/drivers/scsi/hosts.c.chmou	Mon Dec 11 12:19:25 2000
+++ linux/drivers/scsi/hosts.c	Mon Dec 11 12:25:42 2000
@@ -131,10 +131,6 @@
 #include "aha1740.h"
 #endif
 
-#ifdef CONFIG_SCSI_AACRAID
-#include "aacraid/include/linit.h"
-#endif
-
 #ifdef CONFIG_SCSI_AIC7XXX
 #include "aic7xxx.h"
 #endif
@@ -492,9 +488,6 @@
 #endif
 #ifdef CONFIG_SCSI_AHA1740
     AHA1740,
-#endif
-#ifdef CONFIG_SCSI_AACRAID
-    AAC_HOST_TEMPLATE_ENTRY,
 #endif
 #ifdef CONFIG_SCSI_AIC7XXX
     AIC7XXX,
--- linux/arch/i386/defconfig.chmou	Mon Dec 11 12:19:23 2000
+++ linux/arch/i386/defconfig	Mon Dec 11 12:21:41 2000
@@ -166,7 +166,6 @@
 # CONFIG_SCSI_AHA152X is not set
 # CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AHA1740 is not set
-# CONFIG_SCSI_AACRAID is not set
 # CONFIG_SCSI_AIC7XXX is not set
 # CONFIG_SCSI_IPS is not set
 # CONFIG_SCSI_ADVANSYS is not set
--- linux/MAINTAINERS.chmou	Mon Dec 11 12:19:23 2000
+++ linux/MAINTAINERS	Mon Dec 11 12:22:32 2000
@@ -93,12 +93,6 @@
 L:	linux-net@vger.kernel.org
 S:	Maintained
 
-AACRAID ADAPTEC RAID DRIVER
-P:	Brian M. Boerner
-M:	aacraid@ntc.adaptec.com
-L:	To Be Announced
-S:	Maintained
-
 AD1816 SOUND DRIVER
 P:	Thorsten Knabe
 M:	Thorsten Knabe <tek@rbg.informatik.tu-darmstadt.de>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
