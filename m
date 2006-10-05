Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWJEQ6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWJEQ6X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWJEQ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:58:23 -0400
Received: from xenotime.net ([66.160.160.81]:57002 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751503AbWJEQ6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:58:22 -0400
Date: Thu, 5 Oct 2006 09:59:44 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Voluspa <lista1@comhem.se>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: Merge window closed: v2.6.19-rc1
Message-Id: <20061005095944.f0c75c9f.rdunlap@xenotime.net>
In-Reply-To: <20061005184916.3bc76868@loke.fish.not>
References: <20061005184916.3bc76868@loke.fish.not>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006 18:49:16 +0200 Voluspa wrote:

>   AR      arch/x86_64/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      vmlinux
> arch/x86_64/kernel/built-in.o: In function `print_trace_warning_symbol':
> traps.c:(.text.print_trace_warning_symbol+0xa): undefined reference to
> `print_symbol'
> make: *** [vmlinux] Error 1

You don't have CONFIG_KALLSYMS enabled?

Does this patch fix the build for you?

---
From: Randy Dunlap <rdunlap@xenotime.net>

Include linux/kallsyms.h unconditionally for print_symbol().

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/x86_64/kernel/traps.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc1-pv.orig/arch/x86_64/kernel/traps.c
+++ linux-2619-rc1-pv/arch/x86_64/kernel/traps.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
+#include <linux/kallsyms.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
@@ -115,7 +116,6 @@ static int call_trace = 1;
 #endif
 
 #ifdef CONFIG_KALLSYMS
-# include <linux/kallsyms.h>
 void printk_address(unsigned long address)
 {
 	unsigned long offset = 0, symsize;

