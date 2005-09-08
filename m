Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVIHFKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVIHFKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVIHFKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:10:54 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:16038 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932502AbVIHFKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:10:53 -0400
Message-ID: <431FC7DA.6090309@comcast.net>
Date: Thu, 08 Sep 2005 01:10:50 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.13-mm1 X86_64: All 32bit programs segfault
References: <431FB5FF.1030700@comcast.net> <200509080600.39368.ak@suse.de>
In-Reply-To: <200509080600.39368.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>Hmm - not many x86-64 patches in mm1. 2.6.13 definitely works.
>  
>
2.6.13-git7 works. So something in -mm has gone bad (if not x86_64, may 
be i386 or arch-independent changes?)
It seems it has got something to do with the sys_set_tid_address as 
evident from the strace output below.
Another thing - If I set LD_ASSUME_KERNEL=2.4 and then run the binary, 
it works fine.

> Last lines of strace -f + the kernel message from dmesg might be useful.

dmesg
--------------------
Sep  7 00:14:23 localhost kernel: mozilla-xremote[4492]: segfault at 
00000000000002e8 rip 0000000000c40471 rsp 00000000ffffd334 error 4
Sep  7 00:14:24 localhost kernel: thunderbird-bin[4500]: segfault at 
00000000000002e8 rip 0000000000c40471 rsp 00000000ffffcfe4 error 4
Sep  7 00:15:02 localhost kernel: mozilla-xremote[4518]: segfault at 
00000000000002e8 rip 0000000000c40471 rsp 00000000ffffce84 error 4 Sep  
7 00:15:02 localhost kernel: thunderbird-bin[4526]: segfault at 
00000000000002e8 rip 0000000000c40471 rsp 00000000ffffbbe4 error 4

strace -f ./thunderbird
---------------------------
[pid  2888] fstat64(0x3, 0xffffb25c)    = 0
[pid  2888] old_mmap(0x12c8c00c7d000, 8804682956805, 
PROT_READ|PROT_WRITE, 0xc /* MAP_??? 
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_POPULATE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_EXECUTABLE|MAP_LOCKED|0xfffe0000, 
1, 0xb071e0ffffb14c) = 0xc7d000
[pid  2888] old_mmap(0x100000c8f000, 8873402433539, 
PROT_READ|PROT_WRITE, 0xc /* MAP_??? 
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_POPULATE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_EXECUTABLE|MAP_LOCKED|0xfffe0000, 
1, 0xb071e0ffffb14c) = 0xc8f000
[pid  2888] close(3)                    = 0
[pid  2888] old_mmap(0x100000000000, 146028888067, 
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 
0x4 /* MAP_??? 
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_POPULATE|MAP_GROWSDOWN|MAP_DENYWRITE|MAP_EXECUTABLE|0xb00680, 
48, 0x800b071e0) = 0x5599e000
[pid  2888] old_mmap(0x100000000000, 146028888067, 
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 
0x4 /* MAP_??? 
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_POPULATE|MAP_GROWSDOWN|MAP_DENYWRITE|MAP_EXECUTABLE|0xb00680, 
19, 0x800b071e0) = 0x5599f000
[pid  2888] old_mmap(0x100000000000, 146028888067, 
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 
0x4 /* MAP_??? 
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_POPULATE|MAP_GROWSDOWN|MAP_DENYWRITE|MAP_EXECUTABLE|0xb00680, 
2832, 0x2000b033df) = 0x559a0000
[pid  2888] set_thread_area(0xffffce20) = 0
[pid  2888] mprotect(0xc34000, 8192, PROT_READ) = 0
[pid  2888] mprotect(0xc73000, 4096, PROT_READ) = 0
[pid  2888] mprotect(0xc4a000, 4096, PROT_READ) = 0
[pid  2888] mprotect(0xc79000, 4096, PROT_READ) = 0
[pid  2888] mprotect(0xb0d000, 4096, PROT_READ) = 0
[pid  2888] munmap(0x555d8000, 155672)  = 0
[pid  2888] set_tid_address(0x559a0608) = 2888
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[pid  2888] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
Process 2883 resumed
Process 2888 detached
[pid  2883] <... chroot resumed> )      = 2888
[ Process PID=2883 runs in 64 bit mode. ]
[pid  2883] fstat(2, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), 
...}) = 0
[pid  2883] mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaada2d000
[pid  2883] open("/usr/share/locale/locale.alias", O_RDONLY) = 3
[pid  2883] fstat(3, {st_mode=S_IFREG|0644, st_size=2528, ...}) = 0
[pid  2883] mmap(NULL, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaada2e000
[pid  2883] read(3, "# Locale name alias data base.\n#"..., 4096) = 2528
[pid  2883] read(3, "", 4096)           = 0
[pid  2883] close(3)                    = 0
[pid  2883] munmap(0x2aaaada2e000, 4096) = 0
[pid  2883] open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2883] open("/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2883] open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2883] open("/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2883] open("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", 
O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2883] open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = 
-1 ENOENT (No such file or directory)
[pid  2883] write(2, "./run-mozilla.sh: line 159:  288"..., 
76./run-mozilla.sh: line 159:  2888 Segmentation fault      "$prog" 
${1+"$@"}
) = 76
[pid  2883] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  2883] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid  2883] wait4(-1, 0x7fffffe133d4, WNOHANG, NULL) = -1 ECHILD (No 
child processes)
[pid  2883] rt_sigreturn(0xffffffffffffffff) = 0
[pid  2883] rt_sigaction(SIGINT, {SIG_DFL}, {0x4312b5, [], SA_RESTORER, 
0x3116d2f330}, 8) = 0
[pid  2883] rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
[pid  2883] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  2883] rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
[pid  2883] stat("core", 0x7fffffe138e0) = -1 ENOENT (No such file or 
directory)[pid  2883] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  2883] rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
[pid  2883] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  2883] rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
[pid  2883] read(255, "\nexit $exitcode\n", 8192) = 16
[pid  2883] rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
[pid  2883] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  2883] munmap(0x2aaaada2d000, 4096) = 0
[pid  2883] exit_group(139)             = ?
Process 2870 resumed
Process 2883 detached
<... wait4 resumed> [{WIFEXITED(s) && WEXITSTATUS(s) == 139}], 0, NULL) 
= 2883
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(-1, 0x7fffffbf54e4, WNOHANG, NULL) = -1 ECHILD (No child processes)
rt_sigreturn(0xffffffffffffffff)        = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4312b5, [], SA_RESTORER, 
0x3116d2f330}, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "exitcode=$?\n\n## Stop addon scrip"..., 6653) = 91
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/home/paragw/.thunderbird/init.d/", 
O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOENT (No such file or directory)
open("./init.d/", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
getdents64(3, /* 3 entries */, 4096)    = 80
getdents64(3, /* 0 entries */, 4096)    = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
access("/home/paragw/.thunderbird/init.d/K*", X_OK) = -1 ENOENT (No such 
file or directory)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
access("./init.d/K*", X_OK)             = -1 ENOENT (No such file or 
directory)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
exit_group(139)

>-Andi
>
>  
>


