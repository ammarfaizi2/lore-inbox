Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316849AbSGHLkX>; Mon, 8 Jul 2002 07:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316851AbSGHLkW>; Mon, 8 Jul 2002 07:40:22 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:20618 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S316849AbSGHLkU>; Mon, 8 Jul 2002 07:40:20 -0400
Message-ID: <3D297AC4.E6CF2AA5@cisco.com>
Date: Mon, 08 Jul 2002 17:13:00 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] { 2.5 } : removing local variable from init/main.c
Content-Type: multipart/mixed;
 boundary="------------94F6540D309830FD5D5AFA44"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------94F6540D309830FD5D5AFA44
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


	Removing a variable from stack which is not needed.
--------------94F6540D309830FD5D5AFA44
Content-Type: text/plain; charset=us-ascii;
 name="mempages"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mempages"

diff -u -U 6 -r linux-2.5.24/init/main.c nice/init/main.c
--- linux-2.5.24/init/main.c	Fri Jun 21 04:23:46 2002
+++ nice/init/main.c	Fri Jul  5 15:16:56 2002
@@ -330,13 +330,12 @@
  *	Activate the first processor.
  */
 
 asmlinkage void __init start_kernel(void)
 {
 	char * command_line;
-	unsigned long mempages;
 	extern char saved_command_line[];
 /*
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
  */
 	lock_kernel();
@@ -381,19 +380,16 @@
 		initrd_start = 0;
 	}
 #endif
 	mem_init();
 	kmem_cache_sizes_init();
 	pgtable_cache_init();
-
-	mempages = num_physpages;
-
-	fork_init(mempages);
+	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
-	vfs_caches_init(mempages);
+	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
 #if defined(CONFIG_SYSVIPC)

--------------94F6540D309830FD5D5AFA44--

