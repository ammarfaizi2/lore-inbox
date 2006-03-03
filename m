Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751076AbWCCH5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbWCCH5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbWCCH5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:57:03 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:640 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751076AbWCCH5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:57:03 -0500
Message-Id: <20060303075734.954369000@sorel.sous-sol.org>
References: <20060303075542.659414000@sorel.sous-sol.org>
Date: Thu, 02 Mar 2006 23:55:44 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Tony Luck <tony.luck@intel.com>
Subject: [PATCH 2/4] [PATCH] [IA64] die_if_kernel() can return (CVE-2006-0742)
Content-Disposition: inline; filename=die_if_kernel-can-return.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

arch/ia64/kernel/unaligned.c erroneously marked die_if_kernel()
with a "noreturn" attribute ... which is silly (it returns whenever
the argument regs say that the fault happened in user mode, as one
might expect given the "if_kernel" part of its name!).  Thanks to
Alan and Gareth for pointing this out.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/ia64/kernel/unaligned.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.5.orig/arch/ia64/kernel/unaligned.c
+++ linux-2.6.15.5/arch/ia64/kernel/unaligned.c
@@ -24,7 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/unaligned.h>
 
-extern void die_if_kernel(char *str, struct pt_regs *regs, long err) __attribute__ ((noreturn));
+extern void die_if_kernel(char *str, struct pt_regs *regs, long err);
 
 #undef DEBUG_UNALIGNED_TRAP
 

--
