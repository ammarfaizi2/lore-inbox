Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVCRLuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVCRLuV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVCRLuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:50:21 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:19164 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261588AbVCRLuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:50:09 -0500
Date: Fri, 18 Mar 2005 11:50:04 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       jdike@karaya.com
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH UML 2.6] Fix compilation due to mismerge.
Message-ID: <Pine.LNX.4.60.0503181145540.28979@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus/Andrew/Jeff,

The recent slew of UML updates that appeared in BK seems to have gone 
wrong somewhere.  The file "arch/um/kernel/syscall_user.c" contains 
identical content twice over, thus breaking compilation.

Below is a patch to fix this.  Please apply.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- ntfs-2.6-devel/arch/um/kernel/syscall_user.c.old	2005-03-18 11:40:12.544681735 +0000
+++ ntfs-2.6-devel/arch/um/kernel/syscall_user.c	2005-03-18 11:37:42.732441897 +0000
@@ -46,51 +46,3 @@ void record_syscall_end(int index, long 
  * c-file-style: "linux"
  * End:
  */
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <sys/time.h>
-#include "kern_util.h"
-#include "syscall_user.h"
-
-struct {
-	int syscall;
-	int pid;
-	long result;
-	struct timeval start;
-	struct timeval end;
-} syscall_record[1024];
-
-int record_syscall_start(int syscall)
-{
-	int max, index;
-
-	max = sizeof(syscall_record)/sizeof(syscall_record[0]);
-	index = next_syscall_index(max);
-
-	syscall_record[index].syscall = syscall;
-	syscall_record[index].pid = current_pid();
-	syscall_record[index].result = 0xdeadbeef;
-	gettimeofday(&syscall_record[index].start, NULL);
-	return(index);
-}
-
-void record_syscall_end(int index, long result)
-{
-	syscall_record[index].result = result;
-	gettimeofday(&syscall_record[index].end, NULL);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
