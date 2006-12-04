Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936948AbWLDOyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936948AbWLDOyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936921AbWLDOyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:54:14 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:31629 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936929AbWLDOyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:54:04 -0500
Date: Mon, 4 Dec 2006 15:53:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Bad kexec control page allocation.
Message-ID: <20061204145355.GQ32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Bad kexec control page allocation.

KEXEC_CONTROL_MEMORY_LIMIT is an unsigned long value and therefore
should be defined as one. Otherwise the kexec control page can be
allocated above 2GB which will cause a specification exception on the
sam31 instruction in the s390 kexec relocation code.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/kexec.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/include/asm-s390/kexec.h linux-2.6-patched/include/asm-s390/kexec.h
--- linux-2.6/include/asm-s390/kexec.h	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/kexec.h	2006-12-04 14:50:48.000000000 +0100
@@ -26,7 +26,7 @@
 
 /* Maximum address we can use for the control pages */
 /* Not more than 2GB */
-#define KEXEC_CONTROL_MEMORY_LIMIT (1<<31)
+#define KEXEC_CONTROL_MEMORY_LIMIT (1UL<<31)
 
 /* Allocate one page for the pdp and the second for the code */
 #define KEXEC_CONTROL_CODE_SIZE 4096
