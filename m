Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269551AbRHQDUV>; Thu, 16 Aug 2001 23:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269543AbRHQDUM>; Thu, 16 Aug 2001 23:20:12 -0400
Received: from sciurus.rentec.com ([192.5.35.161]:63917 "EHLO
	sciurus.rentec.com") by vger.kernel.org with ESMTP
	id <S269541AbRHQDT7>; Thu, 16 Aug 2001 23:19:59 -0400
Date: Thu, 16 Aug 2001 23:20:07 -0400 (EDT)
From: Dirk Wetter <dirkw@rentec.com>
To: <linux-kernel@vger.kernel.org>
Subject: ntfs module doesn't compile in 2.4.9
Message-ID: <Pine.LNX.4.33.0108162314370.3551-100000@monster-m.rentec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

i fixed it for myself by redoing the changes (don't know what the
first arg of min is supposed to be):

--- fs/ntfs/unistr.c.OLD        Thu Aug 16 22:26:06 2001
+++ fs/ntfs/unistr.c    Thu Aug 16 23:00:36 2001
@@ -96,7 +96,7 @@
        __u32 cnt;
        wchar_t c1, c2;

-       for (cnt = 0; cnt < min(unsigned int, name1_len, name2_len); ++cnt)
+       for (cnt = 0; cnt < min(name1_len, name2_len); ++cnt)
        {
                c1 = le16_to_cpu(*name1++);
                c2 = le16_to_cpu(*name2++);

--- fs/ntfs/macros.h.OLD        Thu Aug 16 23:07:50 2001
+++ fs/ntfs/macros.h    Thu Aug 16 23:08:04 2001
@@ -11,6 +11,12 @@
 #define NTFS_INO2VOL(ino)      (&((ino)->i_sb->u.ntfs_sb))
 #define NTFS_LINO2NINO(ino)     (&((ino)->u.ntfs_i))

+/* Classical min and max macros still missing in standard headers... */
+#ifndef min
+#define min(a,b)        ((a) <= (b) ? (a) : (b))
+#define max(a,b)        ((a) >= (b) ? (a) : (b))
+#endif
+
 #define IS_MAGIC(a,b)          (*(int*)(a) == *(int*)(b))
 #define IS_MFT_RECORD(a)       IS_MAGIC((a),"FILE")
 #define IS_INDEX_RECORD(a)     IS_MAGIC((a),"INDX")




	~dirkw

