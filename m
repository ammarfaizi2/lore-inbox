Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSLQP4O>; Tue, 17 Dec 2002 10:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSLQP4O>; Tue, 17 Dec 2002 10:56:14 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:49606 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S261624AbSLQP4O>; Tue, 17 Dec 2002 10:56:14 -0500
From: Thomas Schlichter <schlicht@rumms.uni-mannheim.de>
Message-ID: <1040140891.3dff4a5bcf8f5@rumms.uni-mannheim.de>
Date: Tue, 17 Dec 2002 17:01:31 +0100
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Compile warnings due to missing __inline__ in fs/xfs/xfs_log.h
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the __inline__ directive in front of the _lsn_cmp function is not used with
the gcc version 2.95.x, compile-warnings result from many files including this
header-file.

Is there any reason why this function is not inlined with these compiler
versions? As I used following patch and compiled the kernel with my
gcc2.95.3(SuSE) and an other gcc2.95.4(Debian) these compiler warnings
disappeared and no additional warning or error occured...

Is there an difference between '__inline__' and 'inline'?
Is 'inline' not part of the ANSI-C standard and so should be preferred?

Thanks

  Thomas Schlichter


diff -u linux-2.5.52/fs/xfs/xfs_log.h linux-2.5.52_patched/fs/xfs/xfs_log.h
--- linux-2.5.52/fs/xfs/xfs_log.h	Mon Dec 16 03:08:24 2002
+++ linux-2.5.52_patched/fs/xfs/xfs_log.h	Tue Dec 17 15:00:13 2002
@@ -52,12 +52,7 @@
  * By comparing each compnent, we don't have to worry about extra
  * endian issues in treating two 32 bit numbers as one 64 bit number
  */
-static
-#ifdef __GNUC__
-# if !((__GNUC__ == 2) && (__GNUC_MINOR__ == 95))
-__inline__
-#endif
-#endif
+static inline
 xfs_lsn_t	_lsn_cmp(xfs_lsn_t lsn1, xfs_lsn_t lsn2, xfs_arch_t arch)
 {
 	if (CYCLE_LSN(lsn1, arch) != CYCLE_LSN(lsn2, arch))

