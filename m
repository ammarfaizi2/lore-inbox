Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbVH1WZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbVH1WZi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 18:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVH1WZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 18:25:38 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:7075 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S1750904AbVH1WZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 18:25:38 -0400
Subject: [PATCH 2.6.13-rc6-mm2] v9fs: remove sparse bitwise warnings
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
       V9FS Developers <v9fs-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 17:25:20 -0500
Message-Id: <1125267920.15492.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] v9fs: remove sparse bitwise warnings

Fixed a bunch of cast conversions to remove -Wbitwise warnings from
sparse.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---
commit fec4b0831dba7e27e9531d0566eec1a5646f3e79
tree dfc14f433354a8dcdb049bc8137e7f31d7cbda3e
parent 67fefd3d8da2c41c41dfd9cd69765b74e246f31f
author Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005 17:23:47
-0500
committer Eric Van Hensbergen <ericvh@gmail.com> Sun, 28 Aug 2005
17:23:47 -0500

 fs/9p/conv.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/9p/conv.c b/fs/9p/conv.c
--- a/fs/9p/conv.c
+++ b/fs/9p/conv.c
@@ -88,7 +88,7 @@ static inline void buf_put_int16(struct 
 {
 	buf_check_size(buf, 2);
 
-	*(u16 *) buf->p = cpu_to_le16(val);
+	*(__le16 *) buf->p = cpu_to_le16(val);
 	buf->p += 2;
 }
 
@@ -96,7 +96,7 @@ static inline void buf_put_int32(struct 
 {
 	buf_check_size(buf, 4);
 
-	*(u32 *)buf->p = cpu_to_le32(val);
+	*(__le32 *)buf->p = cpu_to_le32(val);
 	buf->p += 4;
 }
 
@@ -104,7 +104,7 @@ static inline void buf_put_int64(struct 
 {
 	buf_check_size(buf, 8);
 
-	*(u64 *)buf->p = cpu_to_le64(val);
+	*(__le64 *)buf->p = cpu_to_le64(val);
 	buf->p += 8;
 }
 
@@ -147,7 +147,7 @@ static inline u16 buf_get_int16(struct c
 	u16 ret = 0;
 
 	buf_check_size(buf, 2);
-	ret = le16_to_cpu(*(u16 *)buf->p);
+	ret = le16_to_cpu(*(__le16 *)buf->p);
 
 	buf->p += 2;
 
@@ -159,7 +159,7 @@ static inline u32 buf_get_int32(struct c
 	u32 ret = 0;
 
 	buf_check_size(buf, 4);
-	ret = le32_to_cpu(*(u32 *)buf->p);
+	ret = le32_to_cpu(*(__le32 *)buf->p);
 
 	buf->p += 4;
 
@@ -171,7 +171,7 @@ static inline u64 buf_get_int64(struct c
 	u64 ret = 0;
 
 	buf_check_size(buf, 8);
-	ret = le64_to_cpu(*(u64 *)buf->p);
+	ret = le64_to_cpu(*(__le64 *)buf->p);
 
 	buf->p += 8;
 


