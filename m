Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130294AbQKRSbq>; Sat, 18 Nov 2000 13:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbQKRSbg>; Sat, 18 Nov 2000 13:31:36 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:49417 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130294AbQKRSbX>;
	Sat, 18 Nov 2000 13:31:23 -0500
Date: Sat, 18 Nov 2000 19:01:07 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux/time.h name space pollution in 2.4.0-test11-pre6/pre7
Message-ID: <20001118190107.D23033@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

include/linux/time.h leaks out mktime, creating a possible conflict with
POSIX mktime. This patch puts mktime and a few helper functions into
#ifdef __KERNEL__

Originally for 2.4.0-test11-pre6, but applies also to 2.4.0-test11-pre7

Cheers, Werner

---------------------------------- cut here -----------------------------------

--- linux.orig/include/linux/time.h	Mon Oct  2 20:01:17 2000
+++ linux/include/linux/time.h	Sat Nov 18 18:45:15 2000
@@ -12,6 +12,8 @@
 };
 #endif /* _STRUCT_TIMESPEC */
 
+#ifdef __KERNEL__
+
 /*
  * Change timeval to jiffies, trying to avoid the
  * most obvious overflows..
@@ -79,6 +81,8 @@
 	  )*60 + min /* now have minutes */
 	)*60 + sec; /* finally seconds */
 }
+
+#endif /* __KERNEL__ */
 
 
 struct timeval {

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
