Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130187AbRBZHMq>; Mon, 26 Feb 2001 02:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130188AbRBZHMh>; Mon, 26 Feb 2001 02:12:37 -0500
Received: from www.wen-online.de ([212.223.88.39]:11526 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130187AbRBZHM3>;
	Mon, 26 Feb 2001 02:12:29 -0500
Date: Mon, 26 Feb 2001 08:11:55 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marc Lehmann <pcg@goof.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux swap freeze STILL in 2.4.x
In-Reply-To: <20010225202526.B8890@cerebro.laendle>
Message-ID: <Pine.LNX.4.33.0102260801240.1408-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2001, Marc Lehmann wrote:

> Oh, and one last thing I forgot: loop devices. Since 2.4.1 (the first
> version I used) through 2.4.2 and 2.4.2ac3 I only get:
>
> cerebro:~# strace -f -o x losetup -e rc6 /dev/loop0 /dev/hdd
> Memory Fault
>
> And then no access to the loop device works anymore (clearly this is after
> the 2.4.0.something crypto-patch applied, so this is probably not a 2.4.2
> issue anyway since there is no 2.4.2 crypto patch).

Hmm.. I remember having this problem and it was a problem with strace.
I fiddled with it and got it to work, but damned if I remember what
I did (had to be something trivial since I know jack spit about it:).

Anyway, it works fine here with virgin 2.4.2, so it seems unlikely it's
a kernel problem.

259   execve("/sbin/losetup", ["losetup", "/dev/loop0", "/dev/hda5"], [/* 47 vars */]) = 0
259   brk(0)                            = 134525772
259   old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
259   open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
259   open("/etc/ld.so.cache", O_RDONLY) = 4
259   fstat64(4, {st_mode=S_IFREG|0644, st_size=78316, ...}) = 0
259   old_mmap(NULL, 78316, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40019000
259   close(4)                          = 0
259   open("/lib/libc.so.6", O_RDONLY)  = 4
259   read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\324"..., 1024) = 1024
259   fstat64(4, {st_mode=S_IFREG|0755, st_size=1401805, ...}) = 0
259   old_mmap(NULL, 1134564, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4002d000
259   mprotect(0x40138000, 40932, PROT_NONE) = 0
259   old_mmap(0x40138000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x10a000) = 0x40138000
259   old_mmap(0x4013f000, 12260, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4013f000
259   close(4)                          = 0
259   munmap(0x40019000, 78316)         = 0
259   getpid()                          = 259
259   brk(0)                            = 134525772
259   brk(0x804b374)                    = 134525812
259   brk(0x804c000)                    = 134529024
259   open("/dev/hda5", O_RDWR)         = 4
259   open("/dev/loop0", O_RDWR)        = -1 ENOSYS (Function not implemented)
259   open("/dev/loop0", O_RDWR)        = -1 ENOSYS (Function not implemented)
259   open("/dev/loop0", O_RDWR)        = 5
259   mlockall(0x3, 0xbffff9d3)         = 0
259   ioctl(5, LOOP_SET_FD, 0x4)        = 0
259   ioctl(5, LOOP_SET_STATUS, 0xbffff700) = 0
259   close(5)                          = 0
259   close(4)                          = 0
259   _exit(0)                          = ?

