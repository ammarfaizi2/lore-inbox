Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270467AbRIJLEV>; Mon, 10 Sep 2001 07:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270495AbRIJLEM>; Mon, 10 Sep 2001 07:04:12 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:19681 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270467AbRIJLEH>; Mon, 10 Sep 2001 07:04:07 -0400
Date: Mon, 10 Sep 2001 04:04:25 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: fibrechannel@compaq.com, compaqandlinux@cpqlin.van-dijk.net, ehm@cris.com,
        cwl@iol.unh.edu, linux-kernel@vger.kernel.org
Subject: PATCH and ioctl collision: linux-2.4.10-pre7/drivers/scsi/cpqfcTSinit.c did not compile
Message-ID: <20010910040425.A5645@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.10-pre7/drivers/scsi/cpqfcTSinit.c does not compile
becuase it is missing <linux/init.h> and because SCSI_IOCTL_FC_TARGET_ADDRESS
and SCSI_IOCTL_FC_TDR are not defined.  The following patch fixes that.
The scsi ioctl definitions are copied from sources that I found by
searching for "SCSI_IOCTL_FC_TARGET_ADDRESS" on google, but I had to
renumber SCSI_IOCTL_FC_TARGET_ADDRESS due to a number collision with
another scsi ioctl.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=diff

--- linux-2.4.10-pre7/include/scsi/scsi.h	Fri Apr 27 13:59:19 2001
+++ linux/include/scsi/scsi.h	Mon Sep 10 03:53:58 2001
@@ -214,6 +214,12 @@
 /* Used to get the PCI location of a device */
 #define SCSI_IOCTL_GET_PCI 0x5387
 
+/* Used to invoke Target Defice Reset for Fibre Channel */
+#define SCSI_IOCTL_FC_TDR 0x5388
+
+/* Used to get Fibre Channel WWN and port_id from device */
+#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5389
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
--- linux-2.4.10-pre7/drivers/scsi/cpqfcTSinit.c	Sun Aug 12 10:51:41 2001
+++ linux/drivers/scsi/cpqfcTSinit.c	Mon Sep 10 03:54:23 2001
@@ -63,6 +63,7 @@
 
 #include <linux/config.h>  
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/version.h> 
 
 /* Embedded module documentation macros - see module.h */

--17pEHd4RhPHOinZp--
