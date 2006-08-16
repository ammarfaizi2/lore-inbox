Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWHPJBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWHPJBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWHPJBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:01:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61386 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751028AbWHPJBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:01:12 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kexec warning fix
Message-Id: <20060816090105.9A4E9180063@magilla.sf.frob.com>
Date: Wed, 16 Aug 2006 02:01:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a couple of compiler warnings, and adds paranoia checks to boot.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 kernel/kexec.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 50087ec..989c7cd 100644  
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -995,7 +995,8 @@ asmlinkage long sys_kexec_load(unsigned 
 	image = xchg(dest_image, image);
 
 out:
-	xchg(&kexec_lock, 0); /* Release the mutex */
+	locked = xchg(&kexec_lock, 0); /* Release the mutex */
+	BUG_ON(!locked);
 	kimage_free(image);
 
 	return result;
@@ -1061,7 +1062,8 @@ void crash_kexec(struct pt_regs *regs)
 			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(kexec_crash_image);
 		}
-		xchg(&kexec_lock, 0);
+		locked = xchg(&kexec_lock, 0);
+		BUG_ON(!locked);
 	}
 }
 
