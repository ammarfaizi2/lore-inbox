Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVASICK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVASICK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbVASIBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:01:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53183 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261632AbVASHdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:41 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/29] vmlinux-fix-physical-addrs
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In vmlinux.lds.h the code is carefull to define every section so vmlinux
properly reports the correct physical load address of code, as well as
it's virtual address.  

The new SECURITY_INIT definition fails to follow that convention and
and causes incorrect physical address to appear in the vmlinux if
there are any security initcalls.

This patch updates the SECURITY_INIT to follow the convention in the rest of the
file.

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 vmlinux.lds.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/include/asm-generic/vmlinux.lds.h linux-2.6.11-rc1-mm1-nokexec-vmlinux-fix-physical-addrs/include/asm-generic/vmlinux.lds.h
--- linux-2.6.11-rc1-mm1-nokexec-x86_64-apic-virtwire-on-shutdown/include/asm-generic/vmlinux.lds.h	Fri Jan  7 12:54:13 2005
+++ linux-2.6.11-rc1-mm1-nokexec-vmlinux-fix-physical-addrs/include/asm-generic/vmlinux.lds.h	Tue Jan 18 22:45:34 2005
@@ -73,7 +73,7 @@
 	}
 
 #define SECURITY_INIT							\
-	.security_initcall.init : {					\
+	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
 		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
 		*(.security_initcall.init) 				\
 		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
