Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbQKJCXZ>; Thu, 9 Nov 2000 21:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130819AbQKJCXQ>; Thu, 9 Nov 2000 21:23:16 -0500
Received: from linuxcare.com.au ([203.29.91.49]:36100 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130601AbQKJCW5>; Thu, 9 Nov 2000 21:22:57 -0500
Message-Id: <200011100222.eAA2MoJ10471@wattle.linuxcare.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] obvious change to apm.c
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10468.973822969.1@linuxcare.com.au>
Date: Fri, 10 Nov 2000 13:22:49 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Obvious patch since daemonize() now does this stuff.

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher, Linuxcare, Inc.
+61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -ruN 2.4.0-test11pre2/arch/i386/kernel/apm.c 2.4.0-test11pre2-sfr/arch/i386/kernel/apm.c
--- 2.4.0-test11pre2/arch/i386/kernel/apm.c	Wed Nov  1 09:36:12 2000
+++ 2.4.0-test11pre2-sfr/arch/i386/kernel/apm.c	Fri Nov 10 13:20:28 2000
@@ -1422,9 +1422,6 @@
 
 	kapmd_running = 1;
 
-	exit_files(current);	/* daemonize doesn't do exit_files */
-	current->files = init_task.files;
-	atomic_inc(&current->files->count);
 	daemonize();
 
 	strcpy(current->comm, "kapm-idled");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
