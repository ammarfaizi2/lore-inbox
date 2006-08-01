Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932634AbWHALPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbWHALPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWHALFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61148 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932638AbWHALFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:33 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 15/33] x86_64: Fix kernel direct mapping size check
Date: Tue,  1 Aug 2006 05:03:30 -0600
Message-Id: <11544302382314-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using physical addresse of _end which has nothing to
do with knowing if the kernel fits within it's reserved
virtual addresses, verify the virtual address of _end fits
within in the kernel virtual address mapping.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/head64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/head64.c b/arch/x86_64/kernel/head64.c
index 36647ce..454498c 100644
--- a/arch/x86_64/kernel/head64.c
+++ b/arch/x86_64/kernel/head64.c
@@ -116,7 +116,7 @@ #ifdef CONFIG_X86_IO_APIC
 		disable_apic = 1;
 #endif
 	/* You need early console to see that */
-	if (__pa_symbol(&_end) >= KERNEL_TEXT_SIZE)
+	if (((unsigned long)&_end) >= (__START_KERNEL_map + KERNEL_TEXT_SIZE))
 		panic("Kernel too big for kernel mapping\n");
 
 	setup_boot_cpu_data();
-- 
1.4.2.rc2.g5209e

