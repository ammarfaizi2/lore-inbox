Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVCVSBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVCVSBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVCVSBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:01:12 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:14470 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261501AbVCVR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:40 -0500
Subject: [patch 01/12] uml: fix compile
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:13 +0100
Message-Id: <20050322162118.C3CA4A8A0@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quick compile fix for i386-only change (which interacts with UML since we
include headers from include/asm-$(SUBARCH)), which keeps the old behaviour
and hence should cause no problems.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-um/signal.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/asm-um/signal.h~uml-fix-compile include/asm-um/signal.h
--- linux-2.6.11/include/asm-um/signal.h~uml-fix-compile	2005-03-21 20:13:13.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-um/signal.h	2005-03-21 20:13:13.000000000 +0100
@@ -11,6 +11,9 @@
 #define do_signal do_signal_renamed
 #include "asm/arch/signal.h"
 #undef do_signal
+#undef ptrace_signal_deliver
+
+#define ptrace_signal_deliver(regs, cookie) do {} while(0)
 
 #endif
 
_
