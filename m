Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSJTHuW>; Sun, 20 Oct 2002 03:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSJTHuW>; Sun, 20 Oct 2002 03:50:22 -0400
Received: from whitsun.whitsunday.net.au ([203.25.188.10]:4878 "EHLO
	mail1.whitsunday.net.au") by vger.kernel.org with ESMTP
	id <S262604AbSJTHuV> convert rfc822-to-8bit; Sun, 20 Oct 2002 03:50:21 -0400
From: John W Fort <johnf@whitsunday.net.au>
To: linux-kernel@vger.kernel.org
Cc: dledford@redhat.com
Subject: [PATCH] 2.5.44 INI-A100U2W compilation fix
Date: Sun, 20 Oct 2002 17:57:16 +1000
Message-ID: <gbo4ru86f0ft8ojiv0mpum0ehkd3cvlor8@4ax.com>
X-Mailer: Forte Agent 1.92/32.572
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In patch-2.5.44 Mike Anderson <andmike@us.ibm.com> made a cleanup to the
Scsi Host setup.

This caused the following errors on trying to compile.

drivers/scsi/inia100.c:98: unknown field `next' specified in initializer
drivers/scsi/inia100.c:98: warning: missing braces around initializer
drivers/scsi/inia100.c:98: warning: (near initialization for `driver_template.shtp_list')
drivers/scsi/inia100.c:98: unknown field `module' specified in initializer
drivers/scsi/inia100.c:98: unknown field `proc_name' specified in initializer
drivers/scsi/inia100.c:98: warning: initialization from incompatible pointer type
make[2]: *** [drivers/scsi/inia100.o] Error 1

Several of the drivers Mike modified only had the one-line change to remove
the 'next' field.  I tried it and bingo, it works and passed my tests.

The version change is what Doug Ledford intended in patch-2.5.25 back in
June 2002.  (See inia100.c "inia100_Version")


--- drivers/scsi/inia100.h.old	Sun Oct 20 17:26:31 2002
+++ drivers/scsi/inia100.h	Sun Oct 20 17:26:53 2002
@@ -85,10 +85,9 @@
 
 extern int inia100_biosparam(Scsi_Disk *, struct block_device *, int *);
 
-#define inia100_REVID "Initio INI-A100U2W SCSI device driver; Revision: 1.02c"
+#define inia100_REVID "Initio INI-A100U2W SCSI device driver; Revision: 1.02d"
 
 #define INIA100	{ \
-	next:		NULL,						\
 	module:		NULL,						\
 	proc_name:	"inia100", \
 	proc_info:	NULL,				\


-- 
Just a Fort


