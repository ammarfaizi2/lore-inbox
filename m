Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271486AbRIROQN>; Tue, 18 Sep 2001 10:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271537AbRIROQD>; Tue, 18 Sep 2001 10:16:03 -0400
Received: from ares.sot.com ([195.74.13.236]:40710 "EHLO ares.sot.com")
	by vger.kernel.org with ESMTP id <S271486AbRIROPm>;
	Tue, 18 Sep 2001 10:15:42 -0400
Date: Tue, 18 Sep 2001 17:16:05 +0300 (EEST)
From: Yaroslav Popovitch <yp@ares.sot.com>
To: linux-kernel@vger.kernel.org
Subject: scsi/cpqfc.o BUG in kernel-2.4.10-pre11
Message-ID: <Pine.LNX.4.10.10109181635001.25020-100000@ares.sot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that cpqfc driver is not compilable,because
in file cpqfcTSinit.c are used two undefined macro.

SCSI_IOCTL_FC_TARGET_ADDRESS, line 662 of cpqfcTSinit.c
SCSI_IOCTL_FC_TDR	     ,line 680 -//-

As I understand they should be defined in scsi.h

One of defines was in kernel-2.2
Another was in  someone patch.

I made unified patch.But I do not guarantee,that defines are 100%
correct.

MY PATCH:

diff -ur kernel-2.4.10/linux/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- kernel-2.4.10/linux/drivers/scsi/scsi.h     Wed Aug 15 22:23:11 2001
+++ linux/drivers/scsi/scsi.h   Fri Sep 14 21:34:08 2001
@@ -848,6 +848,10 @@
 
 #endif
 
+#define SCSI_IOCTL_FC_TARGET_ADDRESS 0x5387
+
+/* Used to invoke Target Defice Reset for Fibre Channel */
+#define SCSI_IOCTL_FC_TDR 0x5388
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically

THX,YP

