Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314554AbSDSEsc>; Fri, 19 Apr 2002 00:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSDSEsa>; Fri, 19 Apr 2002 00:48:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59286 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314552AbSDSErJ>;
	Fri, 19 Apr 2002 00:47:09 -0400
Date: Fri, 19 Apr 2002 00:47:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] (4/6) alpha fixes
In-Reply-To: <Pine.GSO.4.21.0204190046270.20383-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0204190046520.20383-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -urN C8-pptr/arch/alpha/kernel/process.c C8-cpu_idle/arch/alpha/kernel/process.c
--- C8-pptr/arch/alpha/kernel/process.c	Fri Mar  8 02:09:42 2002
+++ C8-cpu_idle/arch/alpha/kernel/process.c	Thu Apr 18 23:26:58 2002
@@ -54,15 +54,21 @@
 	return 0;
 }
 
+void default_idle(void)
+{
+	barrier();
+}
+
 void
 cpu_idle(void)
 {
 	while (1) {
+		void (*idle)(void) = default_idle;
 		/* FIXME -- EV6 and LCA45 know how to power down
 		   the CPU.  */
 
 		while (!need_resched())
-			barrier();
+			idle();
 		schedule();
 	}
 }


