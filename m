Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVBIGhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVBIGhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 01:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVBIGhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 01:37:33 -0500
Received: from fsmlabs.com ([168.103.115.128]:63210 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261795AbVBIGh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 01:37:28 -0500
Date: Tue, 8 Feb 2005 23:38:12 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: John Levon <levon@movementarian.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] OProfile: exit.text referenced in init.text
Message-ID: <Pine.LNX.4.61.0502082312010.26742@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linker doesn't complain, but i got this error on ARM which has 
similar code.

oprofile_arch_exit: discarded in section `.exit.text' from arch/arm/oprofile/built-in.o
arch/arm/oprofile/built-in.o(.init.text+0x4c): In function `oprofile_init':
: relocation truncated to fit: R_ARM_PC24 oprofile_arch_exit

oprofile_arch_init()
	<error path>
	oprofile_arch_exit()
		__exit nmi_exit()
			__exit exit_driverfs()

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

===== arch/i386/oprofile/nmi_int.c 1.27 vs edited =====
--- 1.27/arch/i386/oprofile/nmi_int.c	2005-01-30 23:33:47 -07:00
+++ edited/arch/i386/oprofile/nmi_int.c	2005-02-08 23:08:33 -07:00
@@ -70,7 +70,7 @@ static int __init init_driverfs(void)
 }
 
 
-static void __exit exit_driverfs(void)
+static void exit_driverfs(void)
 {
 	sysdev_unregister(&device_oprofile);
 	sysdev_class_unregister(&oprofile_sysclass);
@@ -420,7 +420,7 @@ int __init nmi_init(struct oprofile_oper
 }
 
 
-void __exit nmi_exit(void)
+void nmi_exit(void)
 {
 	if (using_nmi)
 		exit_driverfs();
