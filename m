Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVCXU2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVCXU2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbVCXU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:28:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:51914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262657AbVCXU22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:28:28 -0500
Date: Thu, 24 Mar 2005 12:28:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: cliff white <cliffw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2 - ppc32 build fails.
Message-Id: <20050324122808.72f622cd.akpm@osdl.org>
In-Reply-To: <20050324110233.55b5053a@es175>
References: <20050324110233.55b5053a@es175>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cliff white <cliffw@osdl.org> wrote:
>
> 
> Error message:
> 
>   CC      arch/ppc/kernel/setup.o
> In file included from arch/ppc/kernel/setup.c:43:
> include/asm/ppc_sys.h:29:2: #error "need definition of ppc_sys_devices"
> In file included from arch/ppc/kernel/setup.c:43:
> include/asm/ppc_sys.h:61: warning: parameter has incomplete type
> include/asm/ppc_sys.h:64: warning: parameter has incomplete type

This should fix it.


From: Kumar Gala <galak@freescale.com>


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/setup.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN arch/ppc/kernel/setup.c~ppc32-report-chipset-version-in-common-proc-cpuinfo-handling-fix arch/ppc/kernel/setup.c
--- 25/arch/ppc/kernel/setup.c~ppc32-report-chipset-version-in-common-proc-cpuinfo-handling-fix	2005-03-24 12:27:39.000000000 -0800
+++ 25-akpm/arch/ppc/kernel/setup.c	2005-03-24 12:27:39.000000000 -0800
@@ -40,7 +40,10 @@
 #include <asm/nvram.h>
 #include <asm/xmon.h>
 #include <asm/ocp.h>
+
+#if defined(CONFIG_85xx) || defined(CONFIG_83xx)
 #include <asm/ppc_sys.h>
+#endif
 
 #if defined CONFIG_KGDB
 #include <asm/kgdb.h>
@@ -247,7 +250,7 @@ int show_cpuinfo(struct seq_file *m, voi
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   lpj / (500000/HZ), (lpj / (5000/HZ)) % 100);
 
-#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
+#if defined(CONFIG_85xx) || defined(CONFIG_83xx)
 	if (cur_ppc_sys_spec->ppc_sys_name)
 		seq_printf(m, "chipset\t\t: %s\n",
 			cur_ppc_sys_spec->ppc_sys_name);
_

