Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVFUFor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFUFor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 01:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVFTWlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:41:25 -0400
Received: from coderock.org ([193.77.147.115]:60826 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262166AbVFTWC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:02:56 -0400
Message-Id: <20050620215529.609366000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:55:30 +0200
From: domen@coderock.org
To: rathamahata@php4.ru
Cc: linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@mail.ru>,
       domen@coderock.org
Subject: [patch 1/1] fs/befs/endian.h: fix sparse warnings
Content-Disposition: inline; filename=sparse-fs_befs_endian.h.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Dobriyan <adobriyan@mail.ru>


Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 endian.h |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

Index: quilt/fs/befs/endian.h
===================================================================
--- quilt.orig/fs/befs/endian.h
+++ quilt/fs/befs/endian.h
@@ -16,9 +16,9 @@ static inline u64
 fs64_to_cpu(const struct super_block *sb, u64 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return le64_to_cpu(n);
+		return le64_to_cpu((__le64 __force) n);
 	else
-		return be64_to_cpu(n);
+		return be64_to_cpu((__be64 __force) n);
 }
 
 static inline u64
@@ -34,9 +34,9 @@ static inline u32
 fs32_to_cpu(const struct super_block *sb, u32 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return le32_to_cpu(n);
+		return le32_to_cpu((__le32 __force) n);
 	else
-		return be32_to_cpu(n);
+		return be32_to_cpu((__be32 __force) n);
 }
 
 static inline u32
@@ -52,9 +52,9 @@ static inline u16
 fs16_to_cpu(const struct super_block *sb, u16 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return le16_to_cpu(n);
+		return le16_to_cpu((__le16 __force) n);
 	else
-		return be16_to_cpu(n);
+		return be16_to_cpu((__be16 __force) n);
 }
 
 static inline u16
@@ -73,15 +73,9 @@ fsrun_to_cpu(const struct super_block *s
 {
 	befs_block_run run;
 
-	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE) {
-		run.allocation_group = le32_to_cpu(n.allocation_group);
-		run.start = le16_to_cpu(n.start);
-		run.len = le16_to_cpu(n.len);
-	} else {
-		run.allocation_group = be32_to_cpu(n.allocation_group);
-		run.start = be16_to_cpu(n.start);
-		run.len = be16_to_cpu(n.len);
-	}
+	run.allocation_group = fs32_to_cpu(sb, n.allocation_group);
+	run.start = fs16_to_cpu(sb, n.start);
+	run.len = fs16_to_cpu(sb, n.len);
 	return run;
 }
 

--
