Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263434AbRFAJiI>; Fri, 1 Jun 2001 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263435AbRFAJht>; Fri, 1 Jun 2001 05:37:49 -0400
Received: from lech.pse.pl ([194.92.3.7]:59556 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id <S263434AbRFAJhp>;
	Fri, 1 Jun 2001 05:37:45 -0400
Date: Fri, 1 Jun 2001 11:37:24 +0200
From: Lech Szychowski <lech.szychowski@pse.pl>
To: thunder7@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: kernel-2.4.5
Message-ID: <20010601113724.A3444@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
In-Reply-To: <E155a3W-00084H-00@the-village.bc.nu> <3B16C002.E615CB80@home.com> <20010601105611.A3610@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010601105611.A3610@middle.of.nowhere>
User-Agent: Mutt/1.3.18i
Organization: Polskie Sieci Elektroenergetyczne S.A.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/hda10	/space1			reiserfs	defaults 1 2

/dev/sdb1 /var/log/LOGS reiserfs defaults 0 0

> strace umount /space1:
> 
> open("/usr/lib/locale/en_US/LC_TIME", O_RDONLY) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=2441, ...}) = 0
> old_mmap(NULL, 2441, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4001f000
> close(3)                                = 0
> open("/usr/lib/locale/en_US/LC_NUMERIC", O_RDONLY) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
> old_mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40020000
> close(3)                                = 0
> open("/usr/lib/locale/en_US/LC_CTYPE", O_RDONLY) = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=104804, ...}) = 0
> old_mmap(NULL, 104804, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40137000
> close(3)                                = 0
> SYS_199(0x40131ad8, 0, 0x40132760, 0x40130210, 0) = 0
> semop(1074993880, 0x40130210, 0)        = 0
> brk(0x8056000)                          = 0x8056000
> readlink("/space1", 0xbfffe51c, 4095)   = -1 EINVAL (Invalid argument)
> open("/etc/mtab", O_RDONLY)             = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=680, ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40021000
> read(3, "/dev/hde1 / ext2 rw 0 0\nproc /pr"..., 4096) = 680
> read(3, "", 4096)                       = 0
> close(3)                                = 0
> munmap(0x40021000, 4096)                = 0
> oldumount("/space1"

strace /sbin/umount /dev/sdb1

execve("/sbin/umount", ["/sbin/umount", "/dev/sdb1"], [/* 30 vars */]) = 0
brk(0)                                  = 0x80500c0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(0x3, 0xbfffedb4)                = 0
old_mmap(NULL, 37548, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40017000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\264\323"..., 1024) = 1024
fstat64(0x3, 0xbfffedfc)                = 0
old_mmap(NULL, 1116516, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40021000
mprotect(0x40128000, 39268, PROT_NONE)  = 0
old_mmap(0x40128000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x106000) = 0x40128000
old_mmap(0x4012e000, 14692, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4012e000
close(3)                                = 0
munmap(0x40017000, 37548)               = 0
getpid()                                = 421
brk(0)                                  = 0x80500c0
brk(0x80500e8)                          = 0x80500e8
brk(0x8051000)                          = 0x8051000
SYS_199(0x4012ca58, 0, 0x4012d760, 0x4012b1f0, 0) = 0
semop(1074973272, 0x4012b1f0, 0)        = 0
brk(0x8053000)                          = 0x8053000
readlink("/dev", 0xbfffe96c, 4095)      = -1 EINVAL (Invalid argument)
readlink("/dev/sdb1", 0xbfffe96c, 4095) = -1 EINVAL (Invalid argument)
open("/etc/mtab", O_RDONLY|0x8000)      = 3
fstat64(0x3, 0xbffff6ec)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
read(3, "/dev/sda6 / ext2 rw 0 0\n/dev/sda"..., 4096) = 273
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40017000, 4096)                = 0
oldumount("/var/log/LOGS"

> and there it hangs. The kernel doesn't hang,

Ditto.

> but while 'mount' displays
> /space1 as mounted, ls /space1/ says nothing. df -m reveals:
> 
> Filesystem           1M-blocks      Used Available Use% Mounted on
> /dev/hda10                2015       907      1005  48% /space1

In my case:

- before umount:

root@logs2:/mnt# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda6              8130996   1356716   6354584  18% /
/dev/sda7              8130996        20   7711280   1% /spare
/dev/sda8              2038472        44   1933204   1% /home
/dev/sda9              2038472     41964   1891284   3% /tmp
/dev/sda10            14016248     46444  13969804   1% /mnt
/dev/sdb1             35542688     32840  35509848   1% /mnt/log/LOGS

- after (unfinished od course) umount:

lech7@logs2:~$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda6              8130996   1356572   6354728  18% /
/dev/sda7              8130996        20   7711280   1% /spare
/dev/sda8              2038472        44   1933204   1% /home
/dev/sda9              2038472     41968   1891280   3% /tmp
/dev/sda10            14016248     46540  13969708   1% /var
/dev/sdb1             14016248     46540  13969708   1% /var/log/LOGS

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
