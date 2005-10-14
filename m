Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVJNO2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJNO2R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 10:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVJNO2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 10:28:17 -0400
Received: from smtpout.mac.com ([17.250.248.88]:37863 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750727AbVJNO2R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 10:28:17 -0400
X-PGP-Universal: processed;
	by AlPB on Fri, 14 Oct 2005 09:28:18 -0500
Date: Fri, 14 Oct 2005 09:28:15 -0500
From: Mark Rustad <MRustad@mac.com>
Subject: [PATCH 2.6.14-rc4] kbuild: Eliminate build error when KALLSYMS not defined
To: linux-kernel@vger.kernel.org
X-Priority: 3
Message-ID: <r02010500-1042-C24A71793CBE11DA99900011248907EC@[10.64.61.29]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.5 (Blindsider)
In-Reply-To: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
References: <A7D1D429-D1C7-4FBD-80F2-B3EDFF9E2200@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I encountered a build error with 2.6.14-rc4 when CONFIG_KALLSYMS is not defined. The error
message in a fragment of the output was:

  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
/bin/sh: line 1: +@: command not found
make[3]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
  CHK     include/linux/compile.h

The following patch seems to fix it. I can't say that I really know why, but noticed this
construct elsewhere in the Makefile and it seems to work.


--- a/Makefile	2005-10-12 10:42:37.787722969 -0500
+++ b/Makefile	2005-10-12 10:42:58.396913248 -0500
@@ -662,6 +662,7 @@
 # Generate System.map and verify that the content is consistent
 
 define rule_vmlinux__
+	:
 	$(if $(CONFIG_KALLSYMS),,+$(call cmd,vmlinux_version))
 
 	$(call cmd,vmlinux__)

Signed-off-by: Mark Rustad <mrustad@mac.com>
