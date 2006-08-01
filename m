Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWHALPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWHALPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWHALFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60892 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932635AbWHALFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:33 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 13/33] x86_64: Remove assumptions about the kernel start address from e820/bad_addr()
Date: Tue,  1 Aug 2006 05:03:28 -0600
Message-Id: <1154430237548-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/e820.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/e820.c b/arch/x86_64/kernel/e820.c
index 61f029f..56dd525 100644
--- a/arch/x86_64/kernel/e820.c
+++ b/arch/x86_64/kernel/e820.c
@@ -69,9 +69,14 @@ #ifdef CONFIG_BLK_DEV_INITRD
 		return 1;
 	} 
 #endif
-	/* kernel code + 640k memory hole (later should not be needed, but 
+	/* 640k memory hole (later should not be needed, but
 	   be paranoid for now) */
-	if (last >= 640*1024 && addr < __pa_symbol(&_end)) { 
+	if (last >= 640*1024 && addr < HIGH_MEMORY) {
+		*addrp = HIGH_MEMORY;
+	}
+
+	/* kernel code */
+	if (last >= __pa_symbol(&_text) && addr < __pa_symbol(&_end)) {
 		*addrp = __pa_symbol(&_end);
 		return 1;
 	}
-- 
1.4.2.rc2.g5209e

