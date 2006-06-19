Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWFSMZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWFSMZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWFSMZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932414AbWFSMZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:11 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 08/15] frv: wrong syscall
Date: Mon, 19 Jun 2006 13:25:01 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122501.10060.84183.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

The FRV arch should use fstatat64 not newfstatat.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/entry.S  |    2 +-
 include/asm-frv/unistd.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/frv/kernel/entry.S b/arch/frv/kernel/entry.S
index a9b5952..81d94e4 100644
--- a/arch/frv/kernel/entry.S
+++ b/arch/frv/kernel/entry.S
@@ -1474,7 +1474,7 @@ sys_call_table:
 	.long sys_mknodat
 	.long sys_fchownat
 	.long sys_futimesat
-	.long sys_newfstatat		/* 300 */
+	.long sys_fstatat64		/* 300 */
 	.long sys_unlinkat
 	.long sys_renameat
 	.long sys_linkat
diff --git a/include/asm-frv/unistd.h b/include/asm-frv/unistd.h
index 2662a3e..dec80c1 100644
--- a/include/asm-frv/unistd.h
+++ b/include/asm-frv/unistd.h
@@ -306,7 +306,7 @@ #define __NR_mkdirat		296
 #define __NR_mknodat		297
 #define __NR_fchownat		298
 #define __NR_futimesat		299
-#define __NR_newfstatat		300
+#define __NR_fstatat64		300
 #define __NR_unlinkat		301
 #define __NR_renameat		302
 #define __NR_linkat		303

