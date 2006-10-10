Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWJJWiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWJJWiN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030612AbWJJWiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:38:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59778 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030613AbWJJWhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:37:46 -0400
To: torvalds@osdl.org
Subject: [PATCH 6/16] befs: introduce on-disk endian types
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQEL-0008VI-QI@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:37:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sat, 24 Dec 2005 01:32:03 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/befs/befs_fs_types.h |    4 ++++
 fs/befs/endian.h        |   36 ++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/fs/befs/befs_fs_types.h b/fs/befs/befs_fs_types.h
index d124b4c..128066b 100644
--- a/fs/befs/befs_fs_types.h
+++ b/fs/befs/befs_fs_types.h
@@ -79,6 +79,10 @@ enum inode_flags {
  * On-Disk datastructures of BeFS
  */
 
+typedef u64 __bitwise fs64;
+typedef u32 __bitwise fs32;
+typedef u16 __bitwise fs16;
+
 typedef u64 befs_off_t;
 typedef u64 befs_time_t;
 
diff --git a/fs/befs/endian.h b/fs/befs/endian.h
index d77a26e..979c543 100644
--- a/fs/befs/endian.h
+++ b/fs/befs/endian.h
@@ -12,57 +12,57 @@ #define LINUX_BEFS_ENDIAN
 #include <linux/byteorder/generic.h>
 
 static inline u64
-fs64_to_cpu(const struct super_block *sb, u64 n)
+fs64_to_cpu(const struct super_block *sb, fs64 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return le64_to_cpu(n);
+		return le64_to_cpu((__force __le64)n);
 	else
-		return be64_to_cpu(n);
+		return be64_to_cpu((__force __be64)n);
 }
 
-static inline u64
+static inline fs64
 cpu_to_fs64(const struct super_block *sb, u64 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return cpu_to_le64(n);
+		return (__force fs64)cpu_to_le64(n);
 	else
-		return cpu_to_be64(n);
+		return (__force fs64)cpu_to_be64(n);
 }
 
 static inline u32
-fs32_to_cpu(const struct super_block *sb, u32 n)
+fs32_to_cpu(const struct super_block *sb, fs32 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return le32_to_cpu(n);
+		return le32_to_cpu((__force __le32)n);
 	else
-		return be32_to_cpu(n);
+		return be32_to_cpu((__force __be32)n);
 }
 
-static inline u32
+static inline fs32
 cpu_to_fs32(const struct super_block *sb, u32 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return cpu_to_le32(n);
+		return (__force fs32)cpu_to_le32(n);
 	else
-		return cpu_to_be32(n);
+		return (__force fs32)cpu_to_be32(n);
 }
 
 static inline u16
-fs16_to_cpu(const struct super_block *sb, u16 n)
+fs16_to_cpu(const struct super_block *sb, fs16 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return le16_to_cpu(n);
+		return le16_to_cpu((__force __le16)n);
 	else
-		return be16_to_cpu(n);
+		return be16_to_cpu((__force __be16)n);
 }
 
-static inline u16
+static inline fs16
 cpu_to_fs16(const struct super_block *sb, u16 n)
 {
 	if (BEFS_SB(sb)->byte_order == BEFS_BYTESEX_LE)
-		return cpu_to_le16(n);
+		return (__force fs16)cpu_to_le16(n);
 	else
-		return cpu_to_be16(n);
+		return (__force fs16)cpu_to_be16(n);
 }
 
 /* Composite types below here */
-- 
1.4.2.GIT


