Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132809AbRDNBM2>; Fri, 13 Apr 2001 21:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132708AbRDNBMS>; Fri, 13 Apr 2001 21:12:18 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:63196 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132809AbRDNBMD>; Fri, 13 Apr 2001 21:12:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] tmpfs and loop
Date: Fri, 13 Apr 2001 21:11:26 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01041321112600.23961@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

loop and temp fs do not get along well (2.4.3-ac5) 

oscar% dd if=/dev/zero of=/tmp/disk bs=4096 count=1000
1000+0 records in
1000+0 records out

oscar% sudo mke2fs /tmp/disk
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
 ...
Writing inode tables: done
Writing superblocks and filesystem accounting information: done

oscar% sudo mount /tmp/disk /snap -oloop -text2
ioctl: LOOP_SET_FD: Invalid argument

oscar% sudo mount /tmp/test /snap -oloop -text2
/tmp/test: No such file or directory
oscar% ls -l /tmp/test
ls: /tmp/test: No such file or directory
oscar% sudo mount /tmp/disk /snap -oloop -text2
ioctl: LOOP_SET_FD: Invalid argument
oscar% sudo strace mount /tmp/disk /snap -oloop -text2
execve("/bin/mount", ["mount", "/tmp/disk", "/snap", "-oloop", "-text2"], [/* 34 vars */]) = 0
uname({sys="Linux", node="oscar", ...}) = 0
brk(0)                                  = 0x805ac40
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=66123, ...}) = 0
old_mmap(NULL, 66123, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0008\322"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1108076, ...}) = 0
old_mmap(NULL, 1123780, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40028000
mprotect(0x40131000, 38340, PROT_NONE)  = 0
old_mmap(0x40131000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x108000) = 0x40131000
old_mmap(0x40137000, 13764, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40137000
close(3)                                = 0
munmap(0x40017000, 66123)               = 0
getpid()                                = 24752
brk(0)                                  = 0x805ac40
brk(0x805ac68)                          = 0x805ac68
brk(0x805b000)                          = 0x805b000
open("/dev/null", O_RDWR|O_LARGEFILE)   = 3
close(3)                                = 0
brk(0x805c000)                          = 0x805c000
getuid32()                              = 0
geteuid32()                             = 0
lstat64("/etc/mtab", {st_mode=S_IFREG|0644, st_size=262, ...}) = 0
stat64("/dev/loop0", {st_mode=S_IFBLK|0660, st_rdev=makedev(7, 0), ...}) = 0
open("/dev/loop0", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, 0x4c03, 0xbffff7fc)            = -1 ENXIO (No such device or address)
close(3)                                = 0
open("/tmp/disk", O_RDWR|O_LARGEFILE)   = 3
open("/dev/loop0", O_RDWR|O_LARGEFILE)  = 4
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
ioctl(4, 0x4c00, 0x3)                   = -1 EINVAL (Invalid argument)
write(2, "ioctl: LOOP_SET_FD: Invalid argu"..., 37ioctl: LOOP_SET_FD: Invalid argument
) = 37
_exit(32)                               = ?
oscar%

Filesystem           1k-blocks      Used Available Use% Mounted on
tmpfs                   768000      2556    765444   1% /tmp

Bug?

Ed Tomlinson <tomlins@cam.org>
