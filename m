Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUC2RjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 12:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUC2RjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 12:39:00 -0500
Received: from frigo.cybercat.ca ([207.96.251.197]:35234 "EHLO cybercat.qc.ca")
	by vger.kernel.org with ESMTP id S263015AbUC2Ris (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 12:38:48 -0500
Message-ID: <030701c415b4$b3e0d790$6400a8c0@defiant>
From: "Nicolas Ross" <rossnick-lists@cybercat.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Host/lookup seg fault's with vanilla kernel
Date: Mon, 29 Mar 2004 11:17:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a tao linux (redhat enterprise clone) box with a vanilla 2.4.24
kernel from kernel.org. When booted with my compiled kernel, and with the
glibc i686 rpms installed, utils from the bind-utils rpm (nslookup, dig,
host and the like) all seg faults when used.

This doesn't happen with the stock kernel, which I cannot use for other
mathers. I've tried enabling/disabling options in the kernel config, with no
luck.

when I do an strace of "host www.yahoo.com" I get (only the last few lines)
:

open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\31"..., 512) =
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=52584, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40433000
old_mmap(NULL, 55564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40434000
old_mmap(0x40440000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0xb000) = 0x40440000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40442000
set_thread_area({entry_number:-1 -> -1, base_addr:0x40442080, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}) = -1 ENOSYS (Function not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x40442080, limit:1048575,
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}, 16) = 0
munmap(0x40017000, 14454)               = 0
set_tid_address(0x404420c8)             = -1 ENOSYS (Function not
implemented)
rt_sigaction(SIGRTMIN, {0x40256620, [], SA_RESTORER|SA_SIGINFO, 0x4025ce40},
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGINT, {0x40226290, ~[RTMIN], SA_RESTORER, 0x4025ce48}, NULL,
8) = 0
rt_sigaction(SIGTERM, {0x40226290, ~[RTMIN], SA_RESTORER, 0x4025ce48}, NULL,
8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT TERM], NULL, 8) = 0
getpid()                                = 1231
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
close(3)                                = 0
socket(PF_INET6, SOCK_STREAM, IPPROTO_IP) = -1 EAFNOSUPPORT (Address family
not supported by protocol)
futex(0x4023c1f0, FUTEX_WAKE, 2147483647) = -1 ENOSYS (Function not
implemented)
brk(0)                                  = 0x8056808
brk(0x8077808)                          = 0x8077808
brk(0)                                  = 0x8077808
brk(0x8078000)                          = 0x8078000
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x40443000
mprotect(0x40443000, 4096, PROT_NONE)   = 0
clone(child_stack=0x40c43b08,
flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM
|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED,
parent_tidptr=0x40c43bf8, {entry_number:0, base_addr:0x40c43bb0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, useable:1}, child_tidptr=0x40c43bf8) = 1232
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++


And I got :

request_module[net-pf-10]: fork failed, errno 1

In the kernel logs.

I've search this mailing list, and others, I've found similar problems, but
no solutions was provided.

Can someone point me to a possible cause of this behaviour ?

Thanks


