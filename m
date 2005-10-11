Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVJKWek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVJKWek (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 18:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVJKWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 18:34:40 -0400
Received: from [151.97.230.9] ([151.97.230.9]:11953 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1751240AbVJKWej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 18:34:39 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] uml: compile-time fix recent patch
Date: Tue, 11 Oct 2005 21:01:01 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051011190101.8637.13495.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Give an empty definition for clear_can_do_skas() when it is not needed. Thanks
to Junichi Uekawa <dancer@netfort.gr.jp> for reporting the breakage and
providing a fix (I re-fixed it in an IMHO cleaner way).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -6,6 +6,7 @@
 #ifndef __OS_H__
 #define __OS_H__
 
+#include "uml-config.h"
 #include "asm/types.h"
 #include "../os/include/file.h"
 
@@ -159,7 +160,11 @@ extern int can_do_skas(void);
 
 /* Make sure they are clear when running in TT mode. Required by
  * SEGV_MAYBE_FIXABLE */
+#ifdef UML_CONFIG_MODE_SKAS
 #define clear_can_do_skas() do { ptrace_faultinfo = proc_mm = 0; } while (0)
+#else
+#define clear_can_do_skas() do {} while (0)
+#endif
 
 /* mem.c */
 extern int create_mem_file(unsigned long len);

