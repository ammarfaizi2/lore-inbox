Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318748AbSICKdv>; Tue, 3 Sep 2002 06:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318750AbSICKdv>; Tue, 3 Sep 2002 06:33:51 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:10758 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S318748AbSICKdu>; Tue, 3 Sep 2002 06:33:50 -0400
From: zwane@commfireservices.com
Subject: [PATCH][2.5.33] oops on futexfs mount
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
X-Originating-IP: 196.28.7.236
X-Mailer: Webmin 0.910
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bound1031049454"
Message-Id: <20020903103734.4412BBC51@hemi.commfireservices.com>
Date: Tue,  3 Sep 2002 06:37:34 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--bound1031049454
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Rusty,
	I know it's in the don't do that category ;)

Index: linux-2.5.33/kernel/futex.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.33/kernel/futex.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 futex.c
--- linux-2.5.33/kernel/futex.c	31 Aug 2002 22:32:06 -0000	1.1.1.1
+++ linux-2.5.33/kernel/futex.c	3 Sep 2002 08:51:31 -0000
@@ -359,6 +359,7 @@
 static struct file_system_type futex_fs_type = {
 	.name		= "futexfs",
 	.get_sb		= futexfs_get_sb,
+	.kill_sb	= kill_anon_super,
 };
 
 static int __init init(void)

Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: cf729240   ebx: cf729200   ecx: 00000001   edx: 00000000
esi: c552e000   edi: c0441d20   ebp: c54f3000   esp: c552fee8
ds: 0068   es: 0068   ss: 0068
Stack: c0155088 cf729200 cf7edcf8 cf7edcf8 c016b538 cf7edcf8 ffffffea c17df194
       cf7edcf8 c016cac8 cf729200 cd66b824 42029c74 00000000 00001000 c54e8000
       00000000 c552ff50 c016ccfb c552ff50 c54e8000 00000000 00000000 c54f3000
Call Trace: [<c0155088>] [<c016b538>] [<c016cac8>] [<c016ccfb>] [<c0140068>]
   [<c016cb2c>] [<c016d362>] [<c0107bdf>]
Code:  Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c0155088 <deactivate_super+98/140>
Trace; c016b538 <__mntput+18/30>
Trace; c016cac8 <do_add_mount+128/140>
Trace; c016ccfb <do_mount+17b/1a0>
Trace; c0140068 <s_show+198/2c0>
Trace; c016cb2c <copy_mount_options+4c/a0>
Trace; c016d362 <sys_mount+e2/180>
Trace; c0107bdf <syscall_call+7/b>


--bound1031049454--
