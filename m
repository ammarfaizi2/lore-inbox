Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUCIXHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUCIXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 18:07:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:39367 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262265AbUCIXHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 18:07:14 -0500
Date: Tue, 9 Mar 2004 15:09:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Print function names during do_initcall debugging
Message-Id: <20040309150913.16d4d628.akpm@osdl.org>
In-Reply-To: <20040309222559.GX17857@lug-owl.de>
References: <20040309222559.GX17857@lug-owl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>
> Please merge the following patch. It prints __init function names while
> all calls are executed at do_initcalls().

Nice, thanks.  I tried to do this in the original patch but the kallsyms
stuff wasn't set up at that stage.  Someone must have moved something.

However I suspect you didn't test it with CONFIG_KALLSYMS=n: it will be
missing newlines in the output.



 25-akpm/init/main.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN init/main.c~initcall_debug-print_symbol init/main.c
--- 25/init/main.c~initcall_debug-print_symbol	Tue Mar  9 15:07:16 2004
+++ 25-akpm/init/main.c	Tue Mar  9 15:07:59 2004
@@ -37,6 +37,7 @@
 #include <linux/profile.h>
 #include <linux/rcupdate.h>
 #include <linux/moduleparam.h>
+#include <linux/kallsyms.h>
 #include <linux/writeback.h>
 #include <linux/cpu.h>
 #include <linux/efi.h>
@@ -513,8 +514,11 @@ static void __init do_initcalls(void)
 	for (call = &__initcall_start; call < &__initcall_end; call++) {
 		char *msg;
 
-		if (initcall_debug)
-			printk("calling initcall 0x%p\n", *call);
+		if (initcall_debug) {
+			printk(KERN_DEBUG "Calling initcall 0x%p", *call);
+			print_symbol(": %s()", (unsigned long) *call);
+			printk("\n");
+		}
 
 		(*call)();
 

_

