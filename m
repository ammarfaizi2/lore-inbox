Return-Path: <linux-kernel-owner+w=401wt.eu-S966995AbWLIJvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966995AbWLIJvb (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967211AbWLIJvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:51:31 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:16219 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966995AbWLIJv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:51:29 -0500
Date: Sat, 9 Dec 2006 01:51:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: virtualization@lists.osdl.org, akpm <akpm@osdl.org>, chrisw@sous-sol.org,
       rusty@rustcorp.com.au, jeremy@goop.org, zach@vmware.com
Subject: [PATCH] no paravirt for X86_VOYAGER or X86_VISWS
Message-Id: <20061209015131.fc19aeb3.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Since Voyager and Visual WS already define ARCH_SETUP,
it looks like PARAVIRT shouldn't be offered for them.

In file included from arch/i386/kernel/setup.c:63:
include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
In file included from include/asm/msr.h:5,
                 from include/asm/processor.h:17,
                 from include/asm/thread_info.h:16,
                 from include/linux/thread_info.h:21,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/i386/kernel/setup.c:26:
include/asm/paravirt.h:163:1: warning: this is the location of the previous definition
In file included from arch/i386/kernel/setup.c:63:
include/asm-i386/mach-visws/setup_arch.h:8:1: warning: "ARCH_SETUP" redefined
In file included from include/asm/msr.h:5,
                 from include/asm/processor.h:17,
                 from include/asm/thread_info.h:16,
                 from include/linux/thread_info.h:21,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:46,
                 from arch/i386/kernel/setup.c:26:
include/asm/paravirt.h:163:1: warning: this is the location of the previous definition

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/i386/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19-git13.orig/arch/i386/Kconfig
+++ linux-2.6.19-git13/arch/i386/Kconfig
@@ -190,6 +190,7 @@ endchoice
 config PARAVIRT
 	bool "Paravirtualization support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on !(X86_VISWS || X86_VOYAGER)
 	help
 	  Paravirtualization is a way of running multiple instances of
 	  Linux on the same machine, under a hypervisor.  This option


---
