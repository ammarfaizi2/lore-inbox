Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935540AbWK2MnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935540AbWK2MnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 07:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935546AbWK2MnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 07:43:18 -0500
Received: from twin.jikos.cz ([213.151.79.26]:53952 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S935540AbWK2MnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 07:43:17 -0500
Date: Wed, 29 Nov 2006 13:42:28 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compile fix on x86 without X86_LOCAL_APIC (was 2.6.19-rc6-mm2)
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611291222240.28502@twin.jikos.cz>
References: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2006, Andrew Morton wrote:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/

When i386 kernel is compiled without CONFIG_X86_LOCAL_APIC, this happens:

In file included from arch/i386/kernel/traps.c:51:
include/asm/nmi.h:46:1: warning: "trigger_all_cpu_backtrace" redefined
In file included from arch/i386/kernel/traps.c:32:
include/linux/nmi.h:25:1: warning: this is the location of the previous definition
In file included from arch/i386/kernel/traps.c:51:
include/asm/nmi.h:46:1: warning: "trigger_all_cpu_backtrace" redefined
In file included from arch/i386/kernel/traps.c:32:
include/linux/nmi.h:25:1: warning: this is the location of the previous definition

This is because x86_64-mm-all-cpu-backtrace.patch makes 
trigger_all_cpu_backtrace to be defined twice in such case. This fixes it.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 include/asm-i386/nmi.h   |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
diff --git a/include/asm-i386/nmi.h b/include/asm-i386/nmi.h
index 571a32c..02a3f7f 100644
--- a/include/asm-i386/nmi.h
+++ b/include/asm-i386/nmi.h
@@ -42,7 +42,9 @@ extern int proc_nmi_enabled(struct ctl_t
 			void __user *, size_t *, loff_t *);
 extern int unknown_nmi_panic;
 
+#ifdef ARCH_HAS_NMI_WATCHDOG
 void __trigger_all_cpu_backtrace(void);
 #define trigger_all_cpu_backtrace() __trigger_all_cpu_backtrace()
+#endif
 
 #endif /* ASM_NMI_H */

