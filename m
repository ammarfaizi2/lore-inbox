Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbSLNCO0>; Fri, 13 Dec 2002 21:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267527AbSLNCOZ>; Fri, 13 Dec 2002 21:14:25 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:37894
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267525AbSLNCOZ>; Fri, 13 Dec 2002 21:14:25 -0500
Subject: [PATCH] remove error message on illegal ioctl
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039832542.5305.455.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Dec 2002 21:22:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This error message is uber annoying and needs to go.  Non-root can flood
the console with this junk on invalid SCSI CD-ROM ioctl(),
and that is exactly what gnome-cd does.

An illegal ioctl() returns an error to the program.  That is
sufficient - we do not need KERN_ERROR warnings all over the place.
Especially when any user can cause them at any rate.

This patch, against 2.5.51, removes the message.  Linus, please
apply.

	Robert Love

 drivers/scsi/sr_ioctl.c |    3 ---
 1 files changed, 3 deletions(-)


diff -urN linux-2.5.51/drivers/scsi/sr_ioctl.c linux/drivers/scsi/sr_ioctl.c
--- linux-2.5.51/drivers/scsi/sr_ioctl.c	2002-12-10 17:45:03.000000000 -0500
+++ linux/drivers/scsi/sr_ioctl.c	2002-12-11 00:44:24.000000000 -0500
@@ -156,9 +156,6 @@
 			err = -ENOMEDIUM;
 			break;
 		case ILLEGAL_REQUEST:
-			if (!cgc->quiet)
-				printk(KERN_ERR "%s: CDROM (ioctl) reports ILLEGAL "
-				       "REQUEST.\n", cd->cdi.name);
 			err = -EIO;
 			if (SRpnt->sr_sense_buffer[12] == 0x20 &&
 			    SRpnt->sr_sense_buffer[13] == 0x00)




