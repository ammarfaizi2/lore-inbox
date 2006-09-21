Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWIUHQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWIUHQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 03:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWIUHQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 03:16:06 -0400
Received: from aun.it.uu.se ([130.238.12.36]:49315 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750865AbWIUHQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 03:16:04 -0400
Date: Thu, 21 Sep 2006 09:12:39 +0200 (MEST)
Message-Id: <200609210712.k8L7CdrR015591@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: ak@suse.de, jbeulich@novell.com
Subject: [PATCH 2.6.18] x86_64: silence warning when stack unwinding is disabled
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling kernel 2.6.18 on x86_64 with CONFIG_STACK_UNWIND=n gives:

arch/x86_64/kernel/traps.c: In function 'show_trace':
arch/x86_64/kernel/traps.c:287: warning: cast to pointer from integer of different size

This is because UNW_SP() evaluates to 0, of type int, which
is cast to a pointer by traps.c. Fix: evaluate to 0UL instead.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.18/include/asm-x86_64/unwind.h.~1~	2006-09-20 19:28:57.000000000 +0200
+++ linux-2.6.18/include/asm-x86_64/unwind.h	2006-09-20 20:17:52.000000000 +0200
@@ -95,7 +95,7 @@ static inline int arch_unw_user_mode(con
 #else
 
 #define UNW_PC(frame) ((void)(frame), 0)
-#define UNW_SP(frame) ((void)(frame), 0)
+#define UNW_SP(frame) ((void)(frame), 0UL)
 
 static inline int arch_unw_user_mode(const void *info)
 {
