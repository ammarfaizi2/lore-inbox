Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271581AbSISQrs>; Thu, 19 Sep 2002 12:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271638AbSISQrs>; Thu, 19 Sep 2002 12:47:48 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:19132 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S271581AbSISQrq>;
	Thu, 19 Sep 2002 12:47:46 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209191652.g8JGqgv10535@eng2.beaverton.ibm.com>
Subject: /dev/null broken in 2.5.36 ?
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Sep 2002 09:52:42 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/dev/null seems to be broken in 2.5.36 (and also 2.5.35)

[root@elm3b81 root]# uname -a
Linux elm3b81 2.5.36 #0 SMP Thu Sep 19 09:11:08 PDT 2002 i686 unknown

[root@elm3b81 root]# dd if=/dev/null of=/tmp/file bs=512 count=100
0+0 records in
0+0 records out

[root@elm3b81 root]# ls -l /tmp/file
-rw-r--r--    1 root     root            0 Sep 19 09:28 /tmp/file

[root@elm3b81 root]# ls -l /dev/null
crw-rw-rw-    1 root     root       1,   3 Aug 30  2001 /dev/null

Here is the strace:
-------------------

As you can from strace output, read on /dev/null returned "0" bytes.
I wonder why ?


execve("/bin/dd", ["dd", "if=/dev/null", "of=/tmp/file", "bs=512", "count=100"], [/* 23 vars */]) = 0
uname({sys="Linux", node="elm3b81", ...}) = 0
brk(0)                                  = 0x8050000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=56456, ...}) = 0
old_mmap(NULL, 56456, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \306\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=5772268, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40025000
old_mmap(NULL, 1290088, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40026000
mprotect(0x40158000, 36712, PROT_NONE)  = 0
old_mmap(0x40158000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x131000) = 0x40158000
old_mmap(0x4015d000, 16232, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015d000
close(3)                                = 0
munmap(0x40017000, 56456)               = 0
brk(0)                                  = 0x8050000
brk(0x8050028)                          = 0x8050028
brk(0x8051000)                          = 0x8051000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2601, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2601
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
open("/usr/lib/locale/en_US/LC_IDENTIFICATION", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=370, ...}) = 0
mmap2(NULL, 370, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MEASUREMENT", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=28, ...}) = 0
mmap2(NULL, 28, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_TELEPHONE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=64, ...}) = 0
mmap2(NULL, 64, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40019000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_ADDRESS", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=160, ...}) = 0
mmap2(NULL, 160, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001a000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_NAME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=82, ...}) = 0
mmap2(NULL, 82, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001b000
brk(0x8052000)                          = 0x8052000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_PAPER", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=39, ...}) = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=39, ...}) = 0
mmap2(NULL, 39, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001c000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=57, ...}) = 0
mmap2(NULL, 57, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001d000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_MONETARY", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=291, ...}) = 0
mmap2(NULL, 291, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001e000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_COLLATE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=21499, ...}) = 0
mmap2(NULL, 21499, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001f000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_TIME", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2456, ...}) = 0
mmap2(NULL, 2456, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40161000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_NUMERIC", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=59, ...}) = 0
mmap2(NULL, 59, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40162000
close(3)                                = 0
open("/usr/lib/locale/en_US/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=173408, ...}) = 0
mmap2(NULL, 173408, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40163000
close(3)                                = 0
close(0)                                = 0
open("/dev/null", O_RDONLY|O_LARGEFILE) = 0
close(1)                                = 0
open("/tmp/file", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = 1
fstat64(1, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
rt_sigaction(SIGINT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x80494f0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x80494f0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x80494f0, [], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR1, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR1, {0x8049550, [], 0x4000000}, NULL, 8) = 0
brk(0x8055000)                          = 0x8055000
read(0, "", 512)                        = 0	<<<<<<<<<<<<<<<<<<<<<<<<<*********
open("/usr/share/locale/en_US/LC_MESSAGES/fileutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/fileutils.mo", O_RDONLY) = -1 ENOENT (No such file or directory)
write(2, "0+0 records in\n", 15)        = 15
write(2, "0+0 records out\n", 16)       = 16
close(0)                                = 0
close(1)                                = 0
_exit(0)                                = ?
