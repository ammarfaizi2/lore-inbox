Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSGOENj>; Mon, 15 Jul 2002 00:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSGOENi>; Mon, 15 Jul 2002 00:13:38 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:14016 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S317315AbSGOENh>; Mon, 15 Jul 2002 00:13:37 -0400
Message-ID: <3D324C5F.9309F049@cisco.com>
Date: Mon, 15 Jul 2002 09:45:27 +0530
From: Manik Raina <manik@cisco.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch, 2.5] : removing unwanted variable from init/main.c
Content-Type: multipart/mixed;
 boundary="------------C6759E70B3ABEC50C023AFB3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C6759E70B3ABEC50C023AFB3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------C6759E70B3ABEC50C023AFB3
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

--------------C6759E70B3ABEC50C023AFB3--

