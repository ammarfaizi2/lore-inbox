Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVBGNuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVBGNuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 08:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVBGNuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 08:50:17 -0500
Received: from mo00.iij4u.or.jp ([210.130.0.19]:3536 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261416AbVBGNuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 08:50:11 -0500
Date: Mon, 7 Feb 2005 22:49:44 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yuasa@hh.iij4u.or.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.11-rc3-mm1] mips: add unknown page size string
Message-Id: <20050207224944.58d3718d.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch had fixed the following warning.

arch/mips/lib-32/dump_tlb.c: In function 'dump_tlb':
arch/mips/lib-32/dump_tlb.c:69: warning: control may reach end of non-void function 'msk2str' being inlined

This patch adds return value, when page size is not match.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/lib-32/dump_tlb.c a/arch/mips/lib-32/dump_tlb.c
--- a-orig/arch/mips/lib-32/dump_tlb.c	Thu Feb  3 10:55:52 2005
+++ a/arch/mips/lib-32/dump_tlb.c	Sun Feb  6 11:59:29 2005
@@ -32,6 +32,8 @@
 	case PM_256M:	return "256Mb";
 #endif
 	}
+
+	return "unknown";
 }
 
 #define BARRIER()					\
diff -urN -X dontdiff a-orig/arch/mips/lib-64/dump_tlb.c a/arch/mips/lib-64/dump_tlb.c
--- a-orig/arch/mips/lib-64/dump_tlb.c	Thu Feb  3 10:57:16 2005
+++ a/arch/mips/lib-64/dump_tlb.c	Sun Feb  6 11:59:59 2005
@@ -32,6 +32,8 @@
 	case PM_256M:	return "256Mb";
 #endif
 	}
+
+	return "unknown";
 }
 
 #define BARRIER()					\
