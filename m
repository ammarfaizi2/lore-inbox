Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267512AbUH1SKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267512AbUH1SKp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 14:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUH1SKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 14:10:45 -0400
Received: from smtp0.libero.it ([193.70.192.33]:20907 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S267551AbUH1SKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 14:10:22 -0400
From: Giacomo Lozito <city_hunter@azzurra.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for userspace usage of include/linux/crc-ccitt.h in 2.6.9-rc1
Date: Sat, 28 Aug 2004 20:12:46 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fsMMBbHlpx4s27M"
Message-Id: <200408282012.47295.city_hunter@azzurra.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_fsMMBbHlpx4s27M
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


This patch solves the issue described in this post:
http://lkml.org/lkml/2004/8/26/119
by using __u16 and __u8 in place of u16 and u8, that aren't exported outside 
the kernel.

If it's really trivial to use u16 and u8 for crc-ccitt.h, another way of 
solving this could be to use #ifdef __KERNEL__
in crc-ccitt.h to separate userspace usage from kernel matters.

Regards,
Giacomo Lozito

--Boundary-00=_fsMMBbHlpx4s27M
Content-Type: text/x-diff;
  charset="us-ascii";
  name="crc-ccitt.h.2.6.9-rc1.userspace.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="crc-ccitt.h.2.6.9-rc1.userspace.patch"

--- a/include/linux/crc-ccitt.h	2004-08-28 19:40:39.000000000 +0200
+++ b/include/linux/crc-ccitt.h	2004-08-28 19:38:10.000000000 +0200
@@ -3,11 +3,11 @@
 
 #include <linux/types.h>
 
-extern u16 const crc_ccitt_table[256];
+extern __u16 const crc_ccitt_table[256];
 
-extern u16 crc_ccitt(u16 crc, const u8 *buffer, size_t len);
+extern __u16 crc_ccitt(__u16 crc, const __u8 *buffer, size_t len);
 
-static inline u16 crc_ccitt_byte(u16 crc, const u8 c)
+static inline __u16 crc_ccitt_byte(__u16 crc, const __u8 c)
 {
 	return (crc >> 8) ^ crc_ccitt_table[(crc ^ c) & 0xff];
 }

--Boundary-00=_fsMMBbHlpx4s27M--
