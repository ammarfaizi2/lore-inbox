Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSCKHZv>; Mon, 11 Mar 2002 02:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293633AbSCKHZl>; Mon, 11 Mar 2002 02:25:41 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20901 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293276AbSCKHZc>; Mon, 11 Mar 2002 02:25:32 -0500
Date: Mon, 11 Mar 2002 02:25:29 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux390@de.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch to fix s390 cross-compilation in 2.4.18
Message-ID: <20020311022529.A29248@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The s390 cannot be cross-compiled, because necessary -I is missing
from gcc flags of assembler modules. Also I straightened flags up
a little bit (removed duplicated -D__ASSEMBLY__).

-- Pete

diff -ur -X dontdiff linux-2.4.18-0.1.s390/arch/s390/kernel/Makefile linux-2.4.18-0.1-x.s390/arch/s390/kernel/Makefile
--- linux-2.4.18-0.1.s390/arch/s390/kernel/Makefile	Thu Oct 11 09:04:57 2001
+++ linux-2.4.18-0.1-x.s390/arch/s390/kernel/Makefile	Thu Feb 28 13:24:26 2002
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 .S.o:
-	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -c $< -o $*.o
+	$(CC) $(AFLAGS) -traditional -c $< -o $*.o
 
 all: kernel.o head.o init_task.o
 
diff -ur -X dontdiff linux-2.4.18-0.1.s390/arch/s390/lib/Makefile linux-2.4.18-0.1-x.s390/arch/s390/lib/Makefile
--- linux-2.4.18-0.1.s390/arch/s390/lib/Makefile	Wed Apr 11 19:02:28 2001
+++ linux-2.4.18-0.1-x.s390/arch/s390/lib/Makefile	Thu Feb 28 13:25:29 2002
@@ -2,13 +2,8 @@
 # Makefile for s390-specific library files..
 #
 
-ifdef SMP
 .S.o:
-	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -c $< -o $*.o
-else
-.S.o:
-	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $*.o
-endif
+	$(CC) $(AFLAGS) -traditional -c $< -o $*.o
 
 L_TARGET = lib.a
 
diff -ur -X dontdiff linux-2.4.18-0.1.s390/arch/s390x/kernel/Makefile linux-2.4.18-0.1-x.s390/arch/s390x/kernel/Makefile
--- linux-2.4.18-0.1.s390/arch/s390x/kernel/Makefile	Thu Oct 11 09:04:57 2001
+++ linux-2.4.18-0.1-x.s390/arch/s390x/kernel/Makefile	Wed Mar  6 19:35:54 2002
@@ -8,7 +8,7 @@
 # Note 2! The CFLAGS definitions are now in the main makefile...
 
 .S.o:
-	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -c $< -o $*.o
+	$(CC) $(AFLAGS) -traditional -c $< -o $*.o
 
 all: kernel.o head.o init_task.o
 
diff -ur -X dontdiff linux-2.4.18-0.1.s390/arch/s390x/lib/Makefile linux-2.4.18-0.1-x.s390/arch/s390x/lib/Makefile
--- linux-2.4.18-0.1.s390/arch/s390x/lib/Makefile	Wed Apr 11 19:02:29 2001
+++ linux-2.4.18-0.1-x.s390/arch/s390x/lib/Makefile	Thu Feb 28 13:36:02 2002
@@ -2,13 +2,8 @@
 # Makefile for s390-specific library files..
 #
 
-ifdef SMP
 .S.o:
-	$(CC) -D__ASSEMBLY__ $(AFLAGS) -traditional -c $< -o $*.o
-else
-.S.o:
-	$(CC) -D__ASSEMBLY__ -traditional -c $< -o $*.o
-endif
+	$(CC) $(AFLAGS) -traditional -c $< -o $*.o
 
 L_TARGET = lib.a
 
