Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSKUBlA>; Wed, 20 Nov 2002 20:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbSKUBlA>; Wed, 20 Nov 2002 20:41:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13551 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262804AbSKUBk6>; Wed, 20 Nov 2002 20:40:58 -0500
Date: Wed, 20 Nov 2002 17:56:27 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: davidel@xmailserver.org
cc: hannal@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] remove extra sys_ in epoll system call
Message-ID: <58880000.1037843786@w-hlinder>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Davide,

	Is sys part of the name of epoll? That will make the
system call actually sys_sys_epoll_*. This patch removes
the extra sys in the places where it is not needed if that is
the case. If it is supposed to be sys_sys then the asmlinkage
calls should be changes to reflect that. Let me know what you
think.

Hanna

-----
diff -Nru linux-2.5.48/arch/um/kernel/sys_call_table.c 
linux-epoll/arch/um/kernel/sys_call_table.c
--- linux-2.5.48/arch/um/kernel/sys_call_table.c	Sun Nov 17 20:29:52 2002
+++ linux-epoll/arch/um/kernel/sys_call_table.c	Wed Nov 20 16:25:48 2002
@@ -487,9 +487,9 @@
 	[ __NR_free_hugepages ] = sys_ni_syscall,
 	[ __NR_exit_group ] = sys_exit_group,
 	[ __NR_lookup_dcookie ] = sys_lookup_dcookie,
-	[ __NR_sys_epoll_create ] = sys_epoll_create,
-	[ __NR_sys_epoll_ctl ] = sys_epoll_ctl,
-	[ __NR_sys_epoll_wait ] = sys_epoll_wait,
+	[ __NR_epoll_create ] = sys_epoll_create,
+	[ __NR_epoll_ctl ] = sys_epoll_ctl,
+	[ __NR_epoll_wait ] = sys_epoll_wait,
         [ __NR_remap_file_pages ] = sys_remap_file_pages,

 	ARCH_SYSCALLS
diff -Nru linux-2.5.48/include/asm-i386/unistd.h 
linux-epoll/include/asm-i386/unistd.h
--- linux-2.5.48/include/asm-i386/unistd.h	Sun Nov 17 20:29:49 2002
+++ linux-epoll/include/asm-i386/unistd.h	Wed Nov 20 17:30:51 2002
@@ -258,9 +258,9 @@
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
-#define __NR_sys_epoll_create	254
-#define __NR_sys_epoll_ctl	255
-#define __NR_sys_epoll_wait	256
+#define __NR_epoll_create	254
+#define __NR_epoll_ctl		255
+#define __NR_epoll_wait		256
 #define __NR_remap_file_pages	257
 #define __NR_set_tid_address	258

diff -Nru linux-2.5.48/include/asm-ppc/unistd.h 
linux-epoll/include/asm-ppc/unistd.h
--- linux-2.5.48/include/asm-ppc/unistd.h	Sun Nov 17 20:29:27 2002
+++ linux-epoll/include/asm-ppc/unistd.h	Wed Nov 20 17:30:24 2002
@@ -240,9 +240,9 @@
 #define __NR_free_hugepages	233
 #define __NR_exit_group		234
 #define __NR_lookup_dcookie	235
-#define __NR_sys_epoll_create	236
-#define __NR_sys_epoll_ctl	237
-#define __NR_sys_epoll_wait	238
+#define __NR_epoll_create	236
+#define __NR_epoll_ctl		237
+#define __NR_epoll_wait		238
 #define __NR_remap_file_pages	239

 #define __NR(n)	#n

