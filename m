Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSE2TH6>; Wed, 29 May 2002 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315431AbSE2TH5>; Wed, 29 May 2002 15:07:57 -0400
Received: from mailhost2.teleline.es ([195.235.113.141]:3098 "EHLO
	tsmtp7.mail.isp") by vger.kernel.org with ESMTP id <S315429AbSE2TH5>;
	Wed, 29 May 2002 15:07:57 -0400
Date: Wed, 29 May 2002 21:08:00 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: linux-kernel@vger.kernel.org
Subject: IDE cd in 2.4.19-pre8-ac3: cat /dev/hdb : Cannot allocate memory
Message-Id: <20020529210800.32d536e5.DiegoCG@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the erros message that I receive sometimes when I try to do cat
/dev/hdb (cdrom),

#cat /dev/hdb: Cannot allocate memory.

Of course, I have enought mem. This error happens whne I try to mount
the cdrom. It doesn't happens always, only a few times, but when it
appears, it doesn't disappears. This does'nt happens with marcelo tree,
but it's been happening in ac from several releases. 2.5 tree works
always, too.

I paste the output of strace, it it helps....

execve("/bin/cat", ["cat", "/dev/hdb"], [/* 32 vars */]) = 0
uname({sys="Linux", node="diego", ...}) = 0
brk(0)                                  = 0x804b048
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory) open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75631, ...}) = 0
old_mmap(NULL, 75631, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\30\222"...,
1024) = 1024 fstat64(3, {st_mode=S_IFREG|0755, st_size=1153784, ...}) =
0 old_mmap(NULL, 1166560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40027000 mprotect(0x4013a000, 40160, PROT_NONE)  = 0
old_mmap(0x4013a000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x113000) = 0x4013a000 old_mmap(0x40140000, 15584,
PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =
0x40140000 close(3)                                = 0
munmap(0x40014000, 75631)               = 0
brk(0)                                  = 0x804b048
brk(0x804b070)                          = 0x804b070
brk(0x804c000)                          = 0x804c000
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 0), ...}) = 0
open("/dev/hdb", O_RDONLY|O_LARGEFILE)  = -1 ENOMEM (Cannot allocate
memory) write(2, "cat: ", 5cat: )                    = 5
write(2, "/dev/hdb", 8/dev/hdb)                 = 8
write(2, ": Cannot allocate memory", 24: Cannot allocate memory) = 24
write(2, "\n", 1
)                       = 1
close(1)                                = 0
_exit(1)                                = ?



And this is the output of mount /cdrom:
execve("/bin/mount", ["mount", "/cdrom"], [/* 32 vars */]) = 0
uname({sys="Linux", node="diego", ...}) = 0
brk(0)                                  = 0x805b380
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory) open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75631, ...}) = 0
old_mmap(NULL, 75631, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\30\222"...,
1024) = 1024 fstat64(3, {st_mode=S_IFREG|0755, st_size=1153784, ...}) =
0 old_mmap(NULL, 1166560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =
0x40027000 mprotect(0x4013a000, 40160, PROT_NONE)  = 0
old_mmap(0x4013a000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x113000) = 0x4013a000 old_mmap(0x40140000, 15584,
PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =
0x40140000 close(3)                                = 0
munmap(0x40014000, 75631)               = 0
brk(0)                                  = 0x805b380
brk(0x805b3a8)                          = 0x805b3a8
brk(0x805c000)                          = 0x805c000
open("/dev/null", O_RDWR|O_LARGEFILE)   = 3
close(3)                                = 0
getuid32()                              = 0
geteuid32()                             = 0
lstat64("/etc/mtab", {st_mode=S_IFREG|0644, st_size=195, ...}) = 0
brk(0x805e000)                          = 0x805e000
readlink("/cdrom", 0xbfffe8e4, 4095)    = -1 EINVAL (Invalid argument)
open("/etc/fstab", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=557, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0x40014000 read(3, "# /etc/fstab: static file system"..., 4096)
= 557 read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
stat64("/sbin/mount.iso9660", 0xbffff71c) = -1 ENOENT (No such file or
directory) rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
mount("/dev/cdrom", "/cdrom", "iso9660",
MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|0xc0ed0000, 0x805ca08) = -1
ENOMEM (Cannot allocate memory) rt_sigprocmask(SIG_UNBLOCK, ~[TRAP
SEGV], NULL, 8) = 0 write(2, "mount: Cannot allocate memory\n", 30mount:
Cannot allocate memory) = 30
_exit(32)                               = ?
