Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVKQN0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKQN0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKQN0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:26:00 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:23757 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750797AbVKQN0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:26:00 -0500
Date: Thu, 17 Nov 2005 18:55:57 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 6/10] kdump:   x86_64 add elfcorehdr command line option
Message-ID: <20051117132557.GJ3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com> <20051117132315.GH3981@in.ibm.com> <20051117132437.GI3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117132437.GI3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o elfcorehdr= specifies the location of elf core header stored by the
  crashed kernel. This command line option will be passed by the 
  kexec-tools to capture kernel.

Changes in this version :

o Added more comments in kernel-parameters.txt and in code.

Signed-off-by:Murali M Chakravarthy <muralim@in.ibm.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/Documentation/kernel-parameters.txt |    7 ++++---
 linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/setup.c          |    9 +++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff -puN arch/x86_64/kernel/setup.c~x86_64-elfcorehdr-command-line-option arch/x86_64/kernel/setup.c
--- linux-2.6.15-rc1-1M-dynamic/arch/x86_64/kernel/setup.c~x86_64-elfcorehdr-command-line-option	2005-11-17 11:11:07.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/x86_64/kernel/setup.c	2005-11-17 11:11:07.000000000 +0530
@@ -42,6 +42,7 @@
 #include <linux/edd.h>
 #include <linux/mmzone.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -417,6 +418,14 @@ static __init void parse_cmdline_early (
 		}
 #endif
 
+#ifdef CONFIG_CRASH_DUMP
+		/* elfcorehdr= specifies the location of elf core header
+		 * stored by the crashed kernel. This option will be passed
+		 * by kexec loader to the capture kernel.
+		 */
+		else if(!memcmp(from, "elfcorehdr=", 11))
+			elfcorehdr_addr = memparse(from+11, &from);
+#endif
 	next_char:
 		c = *(from++);
 		if (!c)
diff -puN Documentation/kernel-parameters.txt~x86_64-elfcorehdr-command-line-option Documentation/kernel-parameters.txt
--- linux-2.6.15-rc1-1M-dynamic/Documentation/kernel-parameters.txt~x86_64-elfcorehdr-command-line-option	2005-11-17 11:11:07.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/Documentation/kernel-parameters.txt	2005-11-17 11:11:07.000000000 +0530
@@ -475,10 +475,11 @@ running once the system is up.
 			See Documentation/block/as-iosched.txt and
 			Documentation/block/deadline-iosched.txt for details.
 
-	elfcorehdr=	[IA-32]
+	elfcorehdr=	[IA-32, X86_64]
 			Specifies physical address of start of kernel core
-			image elf header.
-			See Documentation/kdump.txt for details.
+			image elf header. Generally kexec loader will
+			pass this option to capture kernel.
+			See Documentation/kdump/kdump.txt for details.
 
 	enforcing	[SELINUX] Set initial enforcing status.
 			Format: {"0" | "1"}
_
