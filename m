Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317957AbSGWGCz>; Tue, 23 Jul 2002 02:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317958AbSGWGCz>; Tue, 23 Jul 2002 02:02:55 -0400
Received: from [196.26.86.1] ([196.26.86.1]:11199 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317957AbSGWGCx>; Tue, 23 Jul 2002 02:02:53 -0400
Date: Tue, 23 Jul 2002 08:23:49 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: odd memory corruption in 2.5.27?
Message-ID: <Pine.LNX.4.44.0207230822040.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

	kernel is 2.5.27, the box was doing a 'make -j2 bzImage' at the 
time on an NFS mounted filesystem, the server is 2.4.19-re5-ac3

(gdb) list *0xc014b09c
0xc014b09c is in filp_close (open.c:834).
829      */
830     int filp_close(struct file *filp, fl_owner_t id)
831     {
832             int retval;
833
834             if (!file_count(filp)) {
835                     printk(KERN_ERR "VFS: Close: file count is 0\n");
836                     return 0;
837             }
838             retval = 0;

Unable to handle kernel NULL pointer dereference at virtual address 0000008c
 printing eip:
c014b09c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c014b09c>]    Not tainted
EFLAGS: 00010206
eax: cea36a44   ebx: cea36920   ecx: cb235b30   edx: 00000078
esi: 00000078   edi: 00000001   ebp: cea36920   esp: ca9bfddc
ds: 0018   es: 0018   ss: 0018
Process fixdep (pid: 1015, threadinfo=ca9be000 task=c8245980)
Stack: cea36920 00000001 00000001 0000000a c01202db 00000078 cea36920 ca9be000
       c8245980 cea36920 00000000 c0120e40 00000000 c036bb00 ca9bff28 00000002
       c0314a6f 00000001 c0340018 c0310018 ffffff00 c0108622 00000010 00000202
Call Trace: [<c01202db>] [<c0120e40>] [<c0108622>] [<c0115261>] [<c014cd1d>] 
   [<c01616ac>] [<c0157cda>] [<c0159020>] [<c012f75c>] [<c0114e90>] [<c01080a0>]
   [<c0120018>] [<c014cd1d>] [<c0154970>] [<c0154ed1>] [<c014b066>] [<c01075db>]

Code: 8b 46 14 85 c0 75 12 68 c0 6e 31 c0 e8 13 1b fd ff 5a 31 c0 

>>EIP; c014b09c <filp_close+c/130>   <=====
Trace; c01202db <put_files_struct+4b/d0>
Trace; c0120e40 <do_exit+210/520>
Trace; c0108622 <die+f2/100>
Trace; c0115261 <do_page_fault+3d1/506>
Trace; c014cd1d <fget+4d/70>
Trace; c01616ac <dput+1c/240>
Trace; c0157cda <permission+1a/30>
Trace; c0159020 <link_path_walk+a30/a60>
Trace; c012f75c <zap_pmd_range+4c/60>
Trace; c0114e90 <do_page_fault+0/506>
Trace; c01080a0 <error_code+34/40>
Trace; c0120018 <will_become_orphaned_pgrp+48/d0>
Trace; c014cd1d <fget+4d/70>
Trace; c0154970 <vfs_fstat+10/40>
Trace; c0154ed1 <sys_fstat64+11/30>
Trace; c014b066 <sys_open+66/70>
Trace; c01075db <syscall_call+7/b>
Code;  c014b09c <filp_close+c/130>
00000000 <_EIP>:
Code;  c014b09c <filp_close+c/130>   <=====
   0:   8b 46 14                  mov    0x14(%esi),%eax   <=====
Code;  c014b09f <filp_close+f/130>
   3:   85 c0                     test   %eax,%eax
Code;  c014b0a1 <filp_close+11/130>
   5:   75 12                     jne    19 <_EIP+0x19> c014b0b5 <filp_close+25/130>
Code;  c014b0a3 <filp_close+13/130>
   7:   68 c0 6e 31 c0            push   $0xc0316ec0
Code;  c014b0a8 <filp_close+18/130>
   c:   e8 13 1b fd ff            call   fffd1b24 <_EIP+0xfffd1b24> c011cbc0 <printk+0/210>
Code;  c014b0ad <filp_close+1d/130>
  11:   5a                        pop    %edx
Code;  c014b0ae <filp_close+1e/130>
  12:   31 c0                     xor    %eax,%eax

-- 
function.linuxpower.ca

