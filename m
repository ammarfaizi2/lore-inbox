Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWB0WsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWB0WsH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWB0WbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:18 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63874 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932348AbWB0WbK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:10 -0500
Message-Id: <20060227223317.828557000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:02 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, schwidefsky@de.ibm.com
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       maximilian attems <maks@sternwelten.at>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 02/39] [PATCH] s390: add #ifdef __KERNEL__ to asm-s390/setup.h
Content-Disposition: inline; filename=s390-klibc-build-fix-for-2.6.15.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Based on a patch from Maximilian Attems <maks@sternwelten.at> .  Nothing in
asm-s390/setup.h is of interest for user space.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 include/asm-s390/setup.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.15.4.orig/include/asm-s390/setup.h
+++ linux-2.6.15.4/include/asm-s390/setup.h
@@ -8,6 +8,8 @@
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
 
+#ifdef __KERNEL__
+
 #include <asm/types.h>
 
 #define PARMAREA		0x10400
@@ -114,7 +116,7 @@ extern u16 ipl_devno;
 				 IPL_PARMBLOCK_ORIGIN)
 #define IPL_PARMBLOCK_SIZE	(IPL_PARMBLOCK_START->hdr.length)
 
-#else 
+#else /* __ASSEMBLY__ */
 
 #ifndef __s390x__
 #define IPL_DEVICE        0x10404
@@ -127,6 +129,6 @@ extern u16 ipl_devno;
 #endif /* __s390x__ */
 #define COMMAND_LINE      0x10480
 
-#endif
-
-#endif
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* _ASM_S390_SETUP_H */

--
