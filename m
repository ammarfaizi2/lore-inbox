Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265045AbUEYSxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUEYSxP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUEYSwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:52:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:23793 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265043AbUEYSvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:51:33 -0400
From: lm240504@comcast.net
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invisible threads in 2.6
Date: Tue, 25 May 2004 18:51:32 +0000
Message-Id: <052520041851.2507.40B395B3000EE32A000009CB2200735834CBCFCACFCBCD0304@comcast.net>
X-Mailer: AT&T Message Center Version 1 (May  6 2004)
X-Authenticated-Sender: bG0yNDA1MDRAY29tY2FzdC5uZXQ=
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NextPart_Webmail_9m3u9jl4l_2507_1085511092_0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NextPart_Webmail_9m3u9jl4l_2507_1085511092_0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

> my kernel:
> # cat /proc/version 
> Linux version 2.6.6-rc3-mm2 (root@phoebee) (gcc version 3.3.2 20031218 (Gentoo
> Linux 3.3.2-r5, propolice-3.3-7)) #6 Fri May 7 10:56:06 CEST 2004
> 
> I just compiled your example and ran it:
> # ./thread_test 
> 
<snip>
> On my -mm patched kernel I can see them.

I tried 2.6.6-rc3-mm2, and didn't see any difference:

# cat /proc/version
Linux version 2.6.6-rc3-mm2 (lmakhlis@levlinux) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #3 SMP Tue May 25 14:04:28 EDT 2004
                                                                                
# ./thread_test &
[749]
                                                                                
# ls /proc/749/task
ls: /proc/749/task: No such file or directory
                                                                                
# ps axw
...
  749 tty1     Z      0:00 [thread_test <defunct>]
...

I have now tested it on Fedora Core 2 (2.6.5), SLES 9 Beta (2.6.5) and RHL 9 w/ 2.6.6-rc3-mm2, with identical results.  Could it have anything to do with which thread library the program is using?  Here's mine:

# ldd ./thread_test
        libpthread.so.0 => /lib/tls/libpthread.so.0 (0x40028000)
        libc.so.6 => /lib/tls/libc.so.6 (0x42000000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x40000000)

# strace ./pthread_test
<see attachment>

Lev




--NextPart_Webmail_9m3u9jl4l_2507_1085511092_0
Content-Type: application/octet-stream; name="strace.out"
Content-Transfer-Encoding: 7bit

execve("./thread_test", ["./thread_test"], [/* 11 vars */]) = 0
uname({sys="Linux", node="levlinux", ...}) = 0
brk(0)                                  = 0x804a000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=69902, ...}) = 0
old_mmap(NULL, 69902, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p?\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=80592, ...}) = 0
old_mmap(NULL, 54612, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40028000
old_mmap(0x40033000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xa000) = 0x40033000
old_mmap(0x40034000, 5460, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40034000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360W\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1539996, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40036000
old_mmap(0x42000000, 1267276, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
old_mmap(0x42130000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0x42130000
old_mmap(0x42133000, 9804, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42133000
close(3)                                = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x400368a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40016000, 69902)               = 0
set_tid_address(0x400368e8)             = 729
rt_sigaction(SIGRTMIN, {0x4002bed0, [], SA_RESTORER, 0x400318f8}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [33], NULL, 8) = 0
getrlimit(0x3, 0xbffffd14)              = 0
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40037000
brk(0)                                  = 0x804a000
brk(0x804b000)                          = 0x804b000
brk(0)                                  = 0x804b000
mprotect(0x40037000, 4096, PROT_NONE)   = 0
clone(child_stack=0x40837a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [730], {entry_number:6, base_addr:0x40837b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 730
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40838000
mprotect(0x40838000, 4096, PROT_NONE)   = 0
clone(child_stack=0x41038a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [731], {entry_number:6, base_addr:0x41038b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 731
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x41039000
mprotect(0x41039000, 4096, PROT_NONE)   = 0
clone(child_stack=0x41839a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [732], {entry_number:6, base_addr:0x41839b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 732
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x42136000
mprotect(0x42136000, 4096, PROT_NONE)   = 0
clone(child_stack=0x42936a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [733], {entry_number:6, base_addr:0x42936b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 733
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x42937000
mprotect(0x42937000, 4096, PROT_NONE)   = 0
clone(child_stack=0x43137a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [734], {entry_number:6, base_addr:0x43137b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 734
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x43138000
mprotect(0x43138000, 4096, PROT_NONE)   = 0
clone(child_stack=0x43938a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [735], {entry_number:6, base_addr:0x43938b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 735
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x43939000
mprotect(0x43939000, 4096, PROT_NONE)   = 0
clone(child_stack=0x44139a90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [736], {entry_number:6, base_addr:0x44139b30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 736
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4413a000
mprotect(0x4413a000, 4096, PROT_NONE)   = 0
clone(child_stack=0x4493aa90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [737], {entry_number:6, base_addr:0x4493ab30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 737
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4493b000
mprotect(0x4493b000, 4096, PROT_NONE)   = 0
clone(child_stack=0x4513ba90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [738], {entry_number:6, base_addr:0x4513bb30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 738
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4513c000
mprotect(0x4513c000, 4096, PROT_NONE)   = 0
clone(child_stack=0x4593ca90, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID|CLONE_DETACHED, [739], {entry_number:6, base_addr:0x4593cb30, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 739
_exit(0)                                = ?

--NextPart_Webmail_9m3u9jl4l_2507_1085511092_0--
