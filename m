Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbTILAru (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 20:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbTILArO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 20:47:14 -0400
Received: from students2.iit.edu ([216.47.143.102]:1014 "EHLO
	students2.iit.edu") by vger.kernel.org with ESMTP id S261616AbTILArB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 20:47:01 -0400
Date: Thu, 11 Sep 2003 19:45:11 -0500
From: Jesse Yurkovich <yurkjes@iit.edu>
Subject: Bad directories w/Reiserfs on linux-2.6.0-test4
To: linux-kernel@vger.kernel.org
Message-id: <200309111945.11122.yurkjes@iit.edu>
Organization: Illinois Institute of Technology
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_TVl8O6r2YYGJpr+Q6j4Oow)"
User-Agent: KMail/1.5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_TVl8O6r2YYGJpr+Q6j4Oow)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hello,
  This is about the third time I've seen this error on recent kernels:

  Sometimes my directories, say  dir/subdir, become dir//subdir.  This 
confuses many tools and I've even experienced some 'D' state processes trying 
to access such a directory.  My most recent problem is that even though 'ls -
l' shows dir/subdir ... 'rm -r' thinks it's dir//subdir and refuses to remove 
it.  Confusingly, however, 'mv' works and I can move the directory around.  
Also cd'ing into the directory is fine too.

$ ls -l
total 1
drwxr-xr-x    3 jesse    users          72 Sep 10 14:47 datatable-backup

$ cd datatable-backup; ls -l
total 1
drwxr-xr-x    2 jesse    users         256 Sep 10 15:10 CVS

$ rm -r datatable-backup/
rm: cannot remove directory `datatable-backup//CVS': Directory not empty


I've attached the strace file

-Jesse

--Boundary_(ID_TVl8O6r2YYGJpr+Q6j4Oow)
Content-type: text/plain; charset=us-ascii; name=rm-strace
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=rm-strace

$ strace rm -r datatable-backup/

execve("/bin/rm", ["rm", "-r", "datatable-backup/"], [/* 54 vars */]) = 0
uname({sys="Linux", node="mojo-jojo", ...}) = 0
brk(0)                                  = 0x8050000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/usr/qt/3/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/qt/3/lib/i686/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
open("/usr/qt/3/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/qt/3/lib/i686", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
open("/usr/qt/3/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/qt/3/lib/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
open("/usr/qt/3/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/qt/3/lib", {st_mode=S_IFDIR|0755, st_size=504, ...}) = 0
open("/usr/kde/3.1/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/kde/3.1/lib/i686/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
open("/usr/kde/3.1/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/kde/3.1/lib/i686", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
open("/usr/kde/3.1/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/kde/3.1/lib/mmx", 0xbfffe8c0) = -1 ENOENT (No such file or directory)
open("/usr/kde/3.1/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/usr/kde/3.1/lib", {st_mode=S_IFDIR|0755, st_size=35768, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=36417, ...}) = 0
mmap2(NULL, 36417, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\5X\1\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1441647, ...}) = 0
mmap2(NULL, 1207044, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001d000
mprotect(0x4013e000, 23300, PROT_NONE)  = 0
mmap2(0x4013e000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x120) = 0x4013e000
mmap2(0x40142000, 6916, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40142000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40144000
munmap(0x40014000, 36417)               = 0
brk(0)                                  = 0x8050000
brk(0x8051000)                          = 0x8051000
brk(0)                                  = 0x8051000
ioctl(0, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
brk(0)                                  = 0x8051000
brk(0x8052000)                          = 0x8052000
brk(0)                                  = 0x8052000
brk(0x8053000)                          = 0x8053000
brk(0)                                  = 0x8053000
brk(0x8054000)                          = 0x8054000
access("datatable-backup/", W_OK)       = 0
unlink("datatable-backup/")             = -1 EISDIR (Is a directory)
open(".", O_RDONLY|O_LARGEFILE|O_DIRECTORY) = 3
lstat64("datatable-backup/", {st_mode=S_IFDIR|0755, st_size=72, ...}) = 0
chdir("datatable-backup/")              = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=72, ...}) = 0
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=72, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40145000
getdents64(4, /* 3 entries */, 131072)  = 72
access("CVS", W_OK)                     = 0
unlink("CVS")                           = -1 EISDIR (Is a directory)
lstat64("CVS", {st_mode=S_IFDIR|0755, st_size=256, ...}) = 0
chdir("CVS")                            = 0
munmap(0x40145000, 135168)              = 0
close(4)                                = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=256, ...}) = 0
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=256, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40145000
getdents64(4, /* 0 entries */, 131072)  = 0
munmap(0x40145000, 135168)              = 0
close(4)                                = 0
chdir("..")                             = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=72, ...}) = 0
access("CVS", W_OK)                     = 0
rmdir("CVS")                            = -1 ENOTEMPTY (Directory not empty)
write(2, "rm: ", 4rm: )                     = 4
write(2, "cannot remove directory `datatab"..., 47cannot remove directory `datatable-backup//CVS') = 47
write(2, ": Directory not empty", 21: Directory not empty)   = 21
write(2, "\n", 1
)                       = 1
open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=72, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
mmap2(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40145000
getdents64(4, /* 3 entries */, 131072)  = 72
getdents64(4, /* 0 entries */, 131072)  = 0
munmap(0x40145000, 135168)              = 0
close(4)                                = 0
fchdir(3)                               = 0
lstat64(".", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
_exit(1)


--Boundary_(ID_TVl8O6r2YYGJpr+Q6j4Oow)--
