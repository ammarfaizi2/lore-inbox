Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSKBPQc>; Sat, 2 Nov 2002 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSKBPQc>; Sat, 2 Nov 2002 10:16:32 -0500
Received: from [212.104.37.2] ([212.104.37.2]:41226 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261263AbSKBPQ3>; Sat, 2 Nov 2002 10:16:29 -0500
Date: Sat, 2 Nov 2002 16:13:20 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: lord@sgi.com
Subject: [2.5.45] Unable to umount XFS filesystems
Message-ID: <20021102151320.GA308@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
with kernel  2.5.45 I'm  unable to unmount  XFS filesystems. 'umount' is
blocked in D state:

root@(none):~# ps xfa
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:04 init [1]   
    2 ?        SWN    0:00 [ksoftirqd/0]
    3 ?        SW     0:00 [events/0]
    4 ?        SW     0:00 [kswapd0]
    5 ?        SW     0:00 [pdflush]
    6 ?        SW     0:00 [pdflush]
    7 ?        SW     0:00 [aio/0]
    8 ?        SW     0:00 [pagebufd]
    9 ?        SW     0:00 [pagebuf/0]
   29 ?        SW     0:00 [reiserfs/0]
   93 vc/1     S      0:00 -bash
  140 vc/1     D      0:00  \_ umount /home
   94 vc/2     S      0:00 -bash
  153 vc/2     S      0:00  \_ script /tmp/xfs.typescript
  154 vc/2     S      0:00      \_ script /tmp/xfs.typescript
  155 pts/0    S      0:00          \_ bash -i
  156 pts/0    R      0:00              \_ ps xfa
   95 vc/3     S      0:00 /sbin/agetty 38400 tty3 linux
   96 vc/4     S      0:00 /sbin/agetty 38400 tty4 linux
   97 vc/5     S      0:00 /sbin/agetty 38400 tty5 linux
   98 vc/6     S      0:00 /sbin/agetty 38400 tty6 linux
   99 vc/10    S      0:00 /sbin/agetty 38400 tty10 linux
  100 vc/11    S      0:00 /sbin/agetty 38400 tty11 linux
  114 ?        S      0:00 /sbin/devfsd /dev


root@(none):~# strace umount /usr/download
execve("/sbin/umount", ["umount", "/usr/download"], [/* 31 vars */]) = 0
brk(0)                                  = 0x8051000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/usr/local/qt/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/usr/local/qt/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/usr/local/qt/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/usr/local/qt/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = 0
open("/usr/local/kde/lib/i686/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/usr/local/kde/lib/i686/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/usr/local/kde/lib/mmx/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/usr/local/kde/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64(0xbfffec1c, 0xbfffec7c)          = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(0x3, 0xbfffec3c)                = 0
old_mmap(NULL, 40857, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\313\1"..., 1024) = 1024
fstat64(0x3, 0xbfffec7c)                = 0
old_mmap(NULL, 1284160, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40021000
mprotect(0x40151000, 38976, PROT_NONE)  = 0
old_mmap(0x40151000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12f000) = 0x40151000
old_mmap(0x40157000, 14400, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40157000
close(3)                                = 0
munmap(0x40017000, 40857)               = 0
brk(0)                                  = 0x8051000
brk(0x8051028)                          = 0x8051028
brk(0x8052000)                          = 0x8052000
SYS_199(0x401558e0, 0, 0x40156600, 0x40153c50, 0xbffff964) = 0
semop(1075140832, 0x40153c50, 0)        = 0
brk(0x8054000)                          = 0x8054000
readlink("/usr", 0xbfffe840, 4095)      = -1 EINVAL (Invalid argument)
readlink("/usr/download", 0xbfffe840, 4095) = -1 EINVAL (Invalid argument)
open("/etc/mtab", O_RDONLY|0x8000)      = 3
fstat64(0x3, 0xbffff620)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
read(3, "/dev/hda5 / ext2 rw 0 0\n/dev/hda"..., 4096) = 190
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
oldumount("/usr/download" <unfinished ...>

umount blocks here. I was able to umount correctly a ext2 and a reiserfs
partition. SysRq-S  and SysRq-U  stops  when syncing  or unmounting  XFS
filesystems. No messages from the kernel.

XFS support is compiled in the kernel.

HTH,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente
