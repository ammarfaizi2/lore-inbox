Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131794AbQLMVYB>; Wed, 13 Dec 2000 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131841AbQLMVXw>; Wed, 13 Dec 2000 16:23:52 -0500
Received: from ns.caldera.de ([212.34.180.1]:54533 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130746AbQLMVXm>;
	Wed, 13 Dec 2000 16:23:42 -0500
Date: Wed, 13 Dec 2000 21:53:09 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-kernel@vger.kernel.org
Subject: [hch@caldera.de: [PATCH] fix 2.4.0-test12 scsi makefile]
Message-ID: <20001213215309.A10895@caldera.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Christoph Hellwig <hch@caldera.de> -----

Date: Wed, 13 Dec 2000 21:52:21 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] fix 2.4.0-test12 scsi makefile
X-Mailer: Mutt 1.0i

Hi Linus,

this patch makes scsi usable not in the common case where scsi itself
is built into the kernel and some drivers are modules - the patch in
2.4.0-test12 made it work for modules only on parisc64 - now it
should work everywhere.

The comment in the patch explains how it works.

Please apply.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


diff -uNr --exclude-from=dontdiff linux-2.4.0-test12/drivers/scsi/Makefile linux/drivers/scsi/Makefile
--- linux-2.4.0-test12/drivers/scsi/Makefile	Tue Dec 12 22:41:34 2000
+++ linux/drivers/scsi/Makefile	Wed Dec 13 22:12:02 2000
@@ -140,6 +140,9 @@
 obj-m		:= $(filter-out	$(obj-y), $(obj-m))
 int-m		:= $(filter-out	$(int-y), $(int-m))
 
+# Take multi-part drivers out of obj-y and put components in.
+obj-y		:= $(filter-out $(list-multi), $(obj-y)) $(int-y)
+
 O_OBJS		:= $(filter-out	$(export-objs), $(obj-y))
 OX_OBJS		:= $(filter	$(export-objs), $(obj-y))
 M_OBJS		:= $(sort $(filter-out	$(export-objs), $(obj-m)))

----- End forwarded message -----

-- 
Of course it doesn't work. We've performed a software upgrade.
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
