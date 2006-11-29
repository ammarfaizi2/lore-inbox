Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758107AbWK2VUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbWK2VUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758110AbWK2VUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:20:13 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:52649 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758107AbWK2VUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:20:12 -0500
Date: Wed, 29 Nov 2006 13:17:08 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: ak@suse.de, akpm <akpm@osdl.org>
Subject: [PATCH] alternatives/paravirt: use NULL for pointers
Message-Id: <20061129131708.ebbdd36c.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Use NULL instead of 0 for pointers.

arch/x86_64/kernel/../../i386/kernel/alternative.c:432:18: warning: Using plain integer as NULL pointer
arch/x86_64/kernel/../../i386/kernel/alternative.c:432:44: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/asm-i386/alternative.h   |    5 +++--
 include/asm-x86_64/alternative.h |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- linux-2.6.19-rc6-mm2.orig/include/asm-i386/alternative.h
+++ linux-2.6.19-rc6-mm2/include/asm-i386/alternative.h
@@ -5,6 +5,7 @@
 
 #include <asm/types.h>
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 
 struct alt_instr {
@@ -125,8 +126,8 @@ void apply_paravirt(struct paravirt_patc
 static inline void
 apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
 {}
-#define __start_parainstructions 0
-#define __stop_parainstructions 0
+#define __start_parainstructions NULL
+#define __stop_parainstructions NULL
 #endif
 
 #endif /* _I386_ALTERNATIVE_H */
--- linux-2.6.19-rc6-mm2.orig/include/asm-x86_64/alternative.h
+++ linux-2.6.19-rc6-mm2/include/asm-x86_64/alternative.h
@@ -3,6 +3,7 @@
 
 #ifdef __KERNEL__
 
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <asm/cpufeature.h>
 
@@ -140,8 +141,8 @@ void apply_paravirt(struct paravirt_patc
 static inline void
 apply_paravirt(struct paravirt_patch *start, struct paravirt_patch *end)
 {}
-#define __start_parainstructions 0
-#define __stop_parainstructions 0
+#define __start_parainstructions NULL
+#define __stop_parainstructions NULL
 #endif
 
 #endif /* _X86_64_ALTERNATIVE_H */


---
