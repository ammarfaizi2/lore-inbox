Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263135AbUJ2IQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUJ2IQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUJ2IQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:16:38 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:62434 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263135AbUJ2IPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:15:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] v850: Work around include-definition-loop problem in <asm-v850/posix_types.h>
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20041029081545.3CA584D9@mctpc71>
Date: Fri, 29 Oct 2004 17:15:45 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 include/asm-v850/posix_types.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -ruN -X../cludes linux-2.6.9-uc0/include/asm-v850/posix_types.h linux-2.6.9-uc0-v850-20041028/include/asm-v850/posix_types.h
--- linux-2.6.9-uc0/include/asm-v850/posix_types.h	2003-09-29 13:19:13 +0900
+++ linux-2.6.9-uc0-v850-20041028/include/asm-v850/posix_types.h	2004-10-28 13:32:47 +0900
@@ -54,7 +54,9 @@
 
 #if defined(__KERNEL__) || !defined(__GLIBC__) || (__GLIBC__ < 2)
 
-#include <asm/bitops.h>
+/* We used to include <asm/bitops.h> here, which seems the right thing, but
+   it caused nasty include-file definition order problems.  Removing the
+   include seems to work, so fingers crossed...  */
 
 #undef	__FD_SET
 #define __FD_SET(fd, fd_set) \
