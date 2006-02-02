Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161076AbWBBJyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161076AbWBBJyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWBBJyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:54:05 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:59522 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161076AbWBBJyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:54:04 -0500
Date: Thu, 2 Feb 2006 10:53:18 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] s390: fix compat syscall wrapper
Message-ID: <20060202095318.GB22815@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Patch 9ad11ab48b1ad618bf47076e9e579f267f5306c2 changes the type of the first
argument of some compat syscalls from int to unsigned int. Add these changes
to the s390 compat wrapper as well.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/compat_wrapper.S |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 6e27ac6..83b33fe 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1486,7 +1486,7 @@ sys_inotify_rm_watch_wrapper:
 
 	.globl compat_sys_openat_wrapper
 compat_sys_openat_wrapper:
-	lgfr	%r2,%r2			# int
+	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# const char *
 	lgfr	%r4,%r4			# int
 	lgfr	%r5,%r5			# int
@@ -1518,14 +1518,14 @@ sys_fchownat_wrapper:
 
 	.globl compat_sys_futimesat_wrapper
 compat_sys_futimesat_wrapper:
-	lgfr	%r2,%r2			# int
+	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgtr	%r4,%r4			# struct timeval *
 	jg	compat_sys_futimesat
 
 	.globl compat_sys_newfstatat_wrapper
 compat_sys_newfstatat_wrapper:
-	lgfr	%r2,%r2			# int
+	llgfr	%r2,%r2			# unsigned int
 	llgtr	%r3,%r3			# char *
 	llgtr	%r4,%r4			# struct stat *
 	lgfr	%r5,%r5			# int
