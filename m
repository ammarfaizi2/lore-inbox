Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313147AbSDDL7m>; Thu, 4 Apr 2002 06:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313149AbSDDL7d>; Thu, 4 Apr 2002 06:59:33 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:21222 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313147AbSDDL7N>; Thu, 4 Apr 2002 06:59:13 -0500
Date: Thu, 4 Apr 2002 03:59:10 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: torvalds@transmeta.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.8-pre1/kernel/exit.c change caused BUG() at boot time
Message-ID: <20020404035910.A281@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	When I attempted to boot linux-2.5.8-pre1, I got a kernel
BUG() for exit.c line 519.  The was a small change to to kernel/exit.c
in 2.5.8-pre1 which deleted a kernel_lock() call.  Restoring that line
resulted in a kernel that booted fine.  I am sending this email from
the machine running that kernel (so I guess a matching release of
the kernel lock is already in the code).

	Here is the patch.  Of course, it would be helpful if someone
who actually understands this could take a look at it.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="exit.diff"

--- linux-2.5.8-pre1/kernel/exit.c	2002-04-03 23:38:32.000000000 -0800
+++ linux/kernel/exit.c	2002-04-04 03:52:18.000000000 -0800
@@ -499,6 +499,7 @@
 	acct_process(code);
 	__exit_mm(tsk);
 
+	lock_kernel();
 	sem_exit();
 	__exit_files(tsk);
 	__exit_fs(tsk);

--OgqxwSJOaUobr8KG--
