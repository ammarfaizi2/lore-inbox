Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUGBQbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUGBQbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264550AbUGBQ36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:29:58 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:43166
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S264717AbUGBQ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:28:31 -0400
Date: Fri, 2 Jul 2004 17:28:07 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200407021628.i62GS7ZS002412@voidhawk.shadowen.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] add TRAP_BAD_SYSCALL_EXITS config for i386
Cc: akpm@osdl.org, apw@shadowen.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be code recently added to -bk and thereby -mm which supports
extra debug for preempt on system call exit.  Oddly there doesn't seem
to be configuration options to enable them.  Below is a possible patch
to allow enabling this on i386.  Sadly the most obvious menu to add this
to is the Kernel Hacking menu, but that is defined in architecture specific
configuration.  If this makes sense I could patch the other arches?

Comments?

-apw

=== 8< ===
Add a configuration option to allow enabling TRAP_BAD_SYSCALL_EXITS to the
Kernel Hacking menu.

Revision: $Rev: 356 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---
 Kconfig |    7 +++++++
 1 files changed, 7 insertions(+)

diff -upN reference/arch/i386/Kconfig current/arch/i386/Kconfig
--- reference/arch/i386/Kconfig	2004-07-02 14:00:51.000000000 +0100
+++ current/arch/i386/Kconfig	2004-07-02 16:40:49.000000000 +0100
@@ -1492,6 +1492,13 @@ config X86_MPPARSE
 	depends on X86_LOCAL_APIC && !X86_VISWS
 	default y
 
+config TRAP_BAD_SYSCALL_EXITS
+	bool "Debug bad system call exits"
+	help
+	  If you say Y here the kernel will check for system calls which
+	  return without clearing preempt.
+        default n
+
 endmenu
 
 source "security/Kconfig"
