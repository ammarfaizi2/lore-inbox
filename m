Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbVFVW3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVFVW3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVFVW3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:29:11 -0400
Received: from 67.Red-80-25-56.pooles.rima-tde.net ([80.25.56.67]:33084 "EHLO
	estila.tuxedo-es.org") by vger.kernel.org with ESMTP
	id S262546AbVFVWPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:15:45 -0400
Subject: [patch 1/1] selinux: minor cleanup in the hooks.c:file_map_prot_check() code
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, jmorris@redhat.com,
       lorenzo@gnu.org
From: lorenzo@gnu.org
Date: Thu, 23 Jun 2005 00:15:40 +0200
Message-Id: <20050622221541.CE72F56C741@estila.tuxedo-es.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Minor cleanup of the SELinux hooks code (hooks.c) around
some definitions of return values.

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 security/selinux/hooks.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN security/selinux/hooks.c~selinux-kernel-cleanup-1 security/selinux/hooks.c
--- linux-2.6.11/security/selinux/hooks.c~selinux-kernel-cleanup-1	2005-06-21 13:26:23.000000000 +0200
+++ linux-2.6.11-lorenzo/security/selinux/hooks.c	2005-06-23 00:11:23.129839992 +0200
@@ -2419,6 +2419,8 @@ static int selinux_file_ioctl(struct fil
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
+	int rc;
+
 #ifndef CONFIG_PPC32
 	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
 		/*
@@ -2426,7 +2428,7 @@ static int file_map_prot_check(struct fi
 		 * private file mapping that will also be writable.
 		 * This has an additional check.
 		 */
-		int rc = task_has_perm(current, current, PROCESS__EXECMEM);
+		rc = task_has_perm(current, current, PROCESS__EXECMEM);
 		if (rc)
 			return rc;
 	}
@@ -2485,7 +2487,7 @@ static int selinux_file_mprotect(struct 
 		 * check ability to execute the possibly modified content.
 		 * This typically should only occur for text relocations.
 		 */
-		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
+		rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
 		if (rc)
 			return rc;
 	}
_
