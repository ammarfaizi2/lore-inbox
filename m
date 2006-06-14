Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWFNOAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWFNOAk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWFNOAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:00:40 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:8237 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964950AbWFNOAi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:00:38 -0400
Date: Wed, 14 Jun 2006 16:00:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch 8/24] s390: __syscall_return error check.
Message-ID: <20060614140038.GI9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] __syscall_return error check.

Fix __syscall_return macro: valid error numbers are in the range
of -1..-4095.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/asm-s390/unistd.h |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -urpN linux-2.6/include/asm-s390/unistd.h linux-2.6-patched/include/asm-s390/unistd.h
--- linux-2.6/include/asm-s390/unistd.h	2006-06-14 14:29:24.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/unistd.h	2006-06-14 14:29:41.000000000 +0200
@@ -392,11 +392,9 @@
 
 #endif
 
-/* user-visible error numbers are in the range -1 - -122: see <asm-s390/errno.h> */
-
 #define __syscall_return(type, res)			     \
 do {							     \
-	if ((unsigned long)(res) >= (unsigned long)(-125)) { \
+	if ((unsigned long)(res) >= (unsigned long)(-4095)) {\
 		errno = -(res);				     \
 		res = -1;				     \
 	}						     \
