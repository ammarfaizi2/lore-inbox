Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936964AbWLDO6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936964AbWLDO6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936978AbWLDO6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:58:06 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:46649 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936971AbWLDO5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:57:45 -0500
Date: Mon, 4 Dec 2006 15:57:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Don't use small stacks when lockdep is used.
Message-ID: <20061204145735.GH32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Don't use small stacks when lockdep is used.

The lock dependency validator adds a bunch of extra stack frames to
the stack, which can cause stack overflows. Especially seen on 31 bit
where the small stack is only 4k.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-12-04 14:50:32.000000000 +0100
+++ linux-2.6-patched/arch/s390/Kconfig	2006-12-04 14:51:07.000000000 +0100
@@ -178,7 +178,7 @@ config PACK_STACK
 
 config SMALL_STACK
 	bool "Use 4kb/8kb for kernel stack instead of 8kb/16kb"
-	depends on PACK_STACK
+	depends on PACK_STACK && !LOCKDEP
 	help
 	  If you say Y here and the compiler supports the -mkernel-backchain
 	  option the kernel will use a smaller kernel stack size. For 31 bit
