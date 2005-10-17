Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVJQVLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVJQVLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJQVLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:11:50 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:10077 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932332AbVJQVLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:11:44 -0400
Date: Mon, 17 Oct 2005 23:12:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Mark Rustad <MRustad@mac.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Eliminate build error when KALLSYMS not defined
Message-ID: <20051017211229.GA14723@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please apply before -final. It eliminates annoying output when
we do not compile with CONFIG_KALLSYMS enabled.

From: Mark Rustad <MRustad@mac.com>

The following build error happens with 2.6.14-rc4
when CONFIG_KALLSYMS is not defined. The error
message in a fragment of the output was:

  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
/bin/sh: line 1: +@: command not found
make[3]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
  CHK     include/linux/compile.h

The following patch fixes it.

Signed-off-by: Mark Rustad <mrustad@mac.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

diff --git a/Makefile b/Makefile
index 4e0d7c6..a3ffa20 100644
--- a/Makefile
+++ b/Makefile
@@ -660,8 +660,10 @@ quiet_cmd_sysmap = SYSMAP 
 # Link of vmlinux
 # If CONFIG_KALLSYMS is set .version is already updated
 # Generate System.map and verify that the content is consistent
-
+# Use + in front of the vmlinux_version rule to silent warning with make -j2
+# First command is ':' to allow us to use + in front of the rule
 define rule_vmlinux__
+	:
 	$(if $(CONFIG_KALLSYMS),,+$(call cmd,vmlinux_version))
 
 	$(call cmd,vmlinux__)
