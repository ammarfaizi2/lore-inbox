Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbULBPqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbULBPqw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbULBPqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:46:52 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:39619 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261652AbULBPqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:46:40 -0500
Subject: [PATCH 3/6] Audit task comm if exe cannot be determined
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1102002103.26015.104.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Dec 2004 10:41:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.10-rc2-mm4 ensures that the comm is included in the audit message if
avc_audit is unable to determine the exe due to the mmap_sem being
held.  This is helpful in tracking down the causes of permission
denials that occur in the mmap/mprotect hooks.

Signed-off-by:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by:  James Morris <jmorris@redhat.com>

 security/selinux/avc.c |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2.6.10-rc2-mm4/security/selinux/avc.c.orig	2004-12-01 13:02:56.299974456 -0500
+++ linux-2.6.10-rc2-mm4/security/selinux/avc.c	2004-12-01 13:25:15.445393408 -0500
@@ -566,6 +566,8 @@ void avc_audit(u32 ssid, u32 tsid,
 					vma = vma->vm_next;
 				}
 				up_read(&mm->mmap_sem);
+			} else {
+				audit_log_format(ab, " comm=%s", tsk->comm);
 			}
 			if (tsk != current)
 				mmput(mm);

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

