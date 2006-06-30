Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWF3OqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWF3OqY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWF3OqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:46:24 -0400
Received: from mailhost.alabanza.com ([209.239.39.56]:13279 "EHLO
	mailhost.alabanza.com") by vger.kernel.org with ESMTP
	id S1751273AbWF3OqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:46:23 -0400
From: eclark <eclark@alabanza.com>
To: linux-kernel@vger.kernel.org
Subject: re: problem with new kernel
Date: Fri, 30 Jun 2006 10:46:17 -0400
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301046.17526.eclark@alabanza.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previous, I was using a RH stock kernel. This was rebuilt to be monolithic 
with allthe required modules. However, now any binary which uses 
set_thread_area segfaults. I know this is a kernel issue, as other kernels I 
have used do not have this same issue. I am running 2.4.33-pre. Below is an 
example strace of nslookup, one of the relevant binaries now segfaulting.
Above the big strace (total strace of nslookup) is where I believe the problem 
is coming from. Any help would be appreciated, as I have no clue what went 
wrong with this kernel build.

---

set_thread_area({entry_number:-1 -> -1, base_addr:0x4044ec60, limit:1048575, 
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, 
seg_not_present:0, useable:1}) = -1 ENOSYS (Function not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x4044ec60, limit:1048575, 
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, 
seg_not_present:0, useable:1}, 16) = 0
---

 [root@dev linux-2.4.32]# strace /usr/bin/nslookup foo.com
execve("/usr/bin/nslookup", ["/usr/bin/nslookup", "foo.com"], [/* 20 vars */]) 
= 0
uname({sys="Linux", node="dev.test.com", ...}) = 0
brk(0)                                  = 0x80566c8
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=43271, ...}) = 0
old_mmap(NULL, 43271, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/usr/lib/libdns.so.16", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\"\1"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1026680, ...}) = 0
old_mmap(NULL, 1030972, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40021000
old_mmap(0x40119000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xf7000) = 0x40119000
close(3)                                = 0
open("/usr/lib/libisc.so.7", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200z\0"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=221592, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4011d000
old_mmap(NULL, 224824, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4011e000
old_mmap(0x40154000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x35000) = 0x40154000
close(3)                                = 0
open("/lib/libcrypto.so.4", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\252"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=976284, ...}) = 0
old_mmap(NULL, 989496, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40155000
old_mmap(0x40232000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xdd000) = 0x40232000
old_mmap(0x40244000, 10552, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x40244000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 <\0\000"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=91040, ...}) = 0
old_mmap(NULL, 84864, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40247000
old_mmap(0x40259000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x11000) = 0x40259000
old_mmap(0x4025a000, 7040, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x4025a000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0G\0\000"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=98004, ...}) = 0
old_mmap(NULL, 65140, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4025c000
old_mmap(0x40269000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xc000) = 0x40269000
old_mmap(0x4026a000, 7796, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x4026a000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200X\1"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1572440, ...}) = 0
old_mmap(NULL, 1279916, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4026c000
old_mmap(0x4039f000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x132000) = 0x4039f000
old_mmap(0x403a2000, 10156, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x403a2000
close(3)                                = 0
open("/usr/kerberos/lib/libgssapi_krb5.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340H\0"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=76712, ...}) = 0
old_mmap(NULL, 75588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x403a5000
old_mmap(0x403b7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x12000) = 0x403b7000
close(3)                                = 0
open("/usr/kerberos/lib/libkrb5.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\362"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=385252, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x403b8000
old_mmap(NULL, 384636, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x403b9000
old_mmap(0x40415000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x5c000) = 0x40415000
close(3)                                = 0
open("/usr/kerberos/lib/libcom_err.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\t\0"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=5540, ...}) = 0
old_mmap(NULL, 4520, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40417000
old_mmap(0x40418000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x1000) = 0x40418000
close(3)                                = 0
open("/usr/kerberos/lib/libk5crypto.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0&\0\000"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=72552, ...}) = 0
old_mmap(NULL, 73108, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40419000
old_mmap(0x4042a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x11000) = 0x4042a000
close(3)                                = 0
open("/lib/libresolv.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20*\0\000"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=76540, ...}) = 0
old_mmap(NULL, 73604, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4042b000
old_mmap(0x4043a000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xf000) = 0x4043a000
old_mmap(0x4043b000, 8068, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x4043b000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\32"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=14868, ...}) = 0
old_mmap(NULL, 12244, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4043d000
old_mmap(0x4043f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0x1000) = 0x4043f000
close(3)                                = 0
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\31"..., 512) = 
512
fstat64(3, {st_mode=S_IFREG|0755, st_size=52584, ...}) = 0
old_mmap(NULL, 55564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40440000
old_mmap(0x4044c000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 
0xb000) = 0x4044c000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4044e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4044f000
set_thread_area({entry_number:-1 -> -1, base_addr:0x4044ec60, limit:1048575, 
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, 
seg_not_present:0, useable:1}) = -1 ENOSYS (Function not implemented)
modify_ldt(1, {entry_number:0, base_addr:0x4044ec60, limit:1048575, 
seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, 
seg_not_present:0, useable:1}, 16) = 0
munmap(0x40016000, 43271)               = 0
set_tid_address(0x4044eca8)             = -1 ENOSYS (Function not implemented)
rt_sigaction(SIGRTMIN, {0x40260660, [], SA_RESTORER|SA_SIGINFO, 0x40266f80}, 
NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
rt_sigaction(SIGINT, {0x4013da50, ~[RTMIN], SA_RESTORER, 0x40266f88}, NULL, 8) 
= 0
rt_sigaction(SIGTERM, {0x4013da50, ~[RTMIN], SA_RESTORER, 0x40266f88}, NULL, 
8) = 0
rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [HUP INT TERM], NULL, 8) = 0
socket(PF_INET, SOCK_STREAM, IPPROTO_IP) = 3
close(3)                                = 0
socket(PF_INET6, SOCK_STREAM, IPPROTO_IP) = -1 EAFNOSUPPORT (Address family 
not supported by protocol)
futex(0x401546b0, FUTEX_WAKE, 2147483647) = -1 ENOSYS (Function not 
implemented)
brk(0)                                  = 0x80566c8
brk(0x80776c8)                          = 0x80776c8
brk(0)                                  = 0x80776c8
brk(0x8078000)                          = 0x8078000
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40450000
mprotect(0x40450000, 4096, PROT_NONE)   = 0
clone(child_stack=0x40c50b04, flags=CLONE_VM|CLONE_FS|CLONE_FILES|
CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|
CLONE_CHILD_CLEARTID|CLONE_DETACHED, parent_tidptr=0x40c50bf8, 
{entry_number:0, base_addr:0x40c50bb0, limit:1048575, seg_32bit:1, 
contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, 
useable:1}, child_tidptr=0x40c50bf8) = 5404
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
