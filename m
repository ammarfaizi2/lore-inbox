Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUELWKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUELWKa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUELWKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:10:30 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:35639 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261580AbUELWJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:09:58 -0400
Message-Id: <200405122209.i4CM9vqS013716@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: ppc64 HDIO_TASK_* ioctls 2.4, 2.6
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-20308396050"
Date: Wed, 12 May 2004 17:09:57 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-20308396050
Content-Type: text/plain; charset=us-ascii


Howdy,

  I need a some guidance on enabling the ioctls on ppc64 to allow
  the smartmontools to run the appropriate set of commands.

  Does this look ok?

  Have sniff tested, and the smart tools do run without ioctl errors.

++doug


--==_Exmh_-20308396050
Content-Type: application/octet-stream ; name="ppc64-26-hdio-ioctls.diff"
Content-Description: ppc64-26-hdio-ioctls.diff

Index: arch/ppc64/kernel/ioctl32.c
===================================================================
RCS file: /cvs/linuxppc64/sles-9-7/arch/ppc64/kernel/ioctl32.c,v
retrieving revision 1.1.1.1
diff -w -p -u -r1.1.1.1 ioctl32.c
--- arch/ppc64/kernel/ioctl32.c	4 May 2004 16:43:27 -0000	1.1.1.1
+++ arch/ppc64/kernel/ioctl32.c	10 May 2004 14:46:20 -0000
@@ -349,6 +349,11 @@ COMPATIBLE_IOCTL(TIOCSLTC)
 /* Little p (/dev/rtc, /dev/envctrl, etc.) */
 COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
+COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
+#ifdef CONFIG_IDE_TASK_IOCTL
+COMPATIBLE_IOCTL(HDIO_DRIVE_TASKFILE),
+COMPATIBLE_IOCTL(HDIO_DRIVE_TASK),
+#endif CONFIG_IDE_TASK_IOCTL
 
 /* And these ioctls need translation */
 

--==_Exmh_-20308396050
Content-Type: application/octet-stream ; name="ppc64-24-hdio-ioctls.diff"
Content-Description: ppc64-24-hdio-ioctls.diff

Index: arch/ppc64/kernel/ioctl32.c
===================================================================
RCS file: /cvs/linuxppc64/sles8-sp3aa/arch/ppc64/kernel/ioctl32.c,v
retrieving revision 1.1.1.1
retrieving revision 1.1.1.1.2.3
diff -w -p -u -r1.1.1.1 -r1.1.1.1.2.3
--- arch/ppc64/kernel/ioctl32.c	23 Apr 2004 15:59:34 -0000	1.1.1.1
+++ arch/ppc64/kernel/ioctl32.c	6 May 2004 00:31:17 -0000	1.1.1.1.2.3
@@ -3846,6 +3846,10 @@ COMPATIBLE_IOCTL(HDIO_SET_UNMASKINTR),
 COMPATIBLE_IOCTL(HDIO_SET_NOWERR),
 COMPATIBLE_IOCTL(HDIO_SET_32BIT),
 COMPATIBLE_IOCTL(HDIO_SET_MULTCOUNT),
+#ifdef CONFIG_IDE_TASK_IOCTL
+COMPATIBLE_IOCTL(HDIO_DRIVE_TASKFILE),
+COMPATIBLE_IOCTL(HDIO_DRIVE_TASK),
+#endif CONFIG_IDE_TASK_IOCTL
 COMPATIBLE_IOCTL(HDIO_DRIVE_CMD),
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE),
 COMPATIBLE_IOCTL(HDIO_SCAN_HWIF),

--==_Exmh_-20308396050--


