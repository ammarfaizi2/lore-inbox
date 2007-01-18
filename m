Return-Path: <linux-kernel-owner+w=401wt.eu-S1752058AbXARPKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbXARPKs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 10:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbXARPKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 10:10:47 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:48070 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbXARPKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 10:10:47 -0500
X-Originating-Ip: 74.109.98.130
Date: Thu, 18 Jan 2007 10:04:56 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH]  Centralize the macro definition of "__packed".
Message-ID: <Pine.LNX.4.64.0701180959470.19826@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Centralize the attribute macro definition of "__packed" so no
subsystem has to do that explicitly.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  compile tested to make sure the HFS subsystem still builds.  now
there's just 50 gazillion usages of "__attribute__((packed))" that can
be tightened up.


 fs/hfs/hfs.h                 |    2 --
 fs/hfsplus/hfsplus_raw.h     |    2 --
 include/linux/compiler-gcc.h |    1 +
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 88099ab..1445e3a 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -83,8 +83,6 @@

 /*======== HFS structures as they appear on the disk ========*/

-#define __packed __attribute__ ((packed))
-
 /* Pascal-style string of up to 31 characters */
 struct hfs_name {
 	u8 len;
diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
index 4920553..fe99fe8 100644
--- a/fs/hfsplus/hfsplus_raw.h
+++ b/fs/hfsplus/hfsplus_raw.h
@@ -15,8 +15,6 @@

 #include <linux/types.h>

-#define __packed __attribute__ ((packed))
-
 /* Some constants */
 #define HFSPLUS_SECTOR_SIZE        512
 #define HFSPLUS_SECTOR_SHIFT         9
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 6e1c44a..b6e39f5 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -27,6 +27,7 @@
 #define __inline__	__inline__	__attribute__((always_inline))
 #define __inline	__inline	__attribute__((always_inline))
 #define __deprecated			__attribute__((deprecated))
+#define __packed			__attribute__((packed))
 #define  noinline			__attribute__((noinline))
 #define __attribute_pure__		__attribute__((pure))
 #define __attribute_const__		__attribute__((__const__))

