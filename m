Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317051AbSFWP5p>; Sun, 23 Jun 2002 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317054AbSFWP5o>; Sun, 23 Jun 2002 11:57:44 -0400
Received: from mta3.srv.hcvlny.cv.net ([167.206.5.9]:12423 "EHLO
	mta3.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S317051AbSFWP5n>; Sun, 23 Jun 2002 11:57:43 -0400
Date: Sun, 23 Jun 2002 12:03:02 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: piggy broken in 2.5.24 build
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D15F136.90800@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
References: <linux.kernel.Pine.LNX.4.44.0206222143550.7338-100000@chaos.physics.uiowa.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Sat, 22 Jun 2002, sean darcy wrote:

> 
> Well, could you try to 
> 
> cd /opt/kernel/linux-2.5.24/arch/i386/boot/compressed
> objcopy -O binary -R .note -R .comment -S /opt/kernel/linux-2.5.24/vmlinux 
> _tmp_piggy
> 
> and see if that generates _tmp_piggy in that directory?
> 
> --Kai


Nope .It generates a segmentation fault!. I'm running 2.4.18, binutils 
2.12.90. I'm going to try a different binutils.

  Here's strace:

[root@daddy compressed]# strace objcopy -O binary -R .note -R .comment 
-S /opt/kernel/linux-2.5.24/vmlinux _tmp_piggy
execve("/usr/bin/objcopy", ["objcopy", "-O", "binary", "-R", ".note", 
"-R", ".comment", "-S", "/opt/kernel/linux-2.5.24/vmlinux", 
"_tmp_piggy"], [/* 28 vars */]) = 0
uname({sys="Linux", node="daddy", ...}) = 0
brk(0)                                  = 0x807c66c
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
open("/lib/libNoVersion.so.1", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0755, st_size=6135, ...}) = 0
close(3)                                = 0
open("/lib/libNoVersion.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\10\0\000"..., 
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=6135, ...}) = 0
old_mmap(NULL, 7248, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40014000
mprotect(0x40015000, 3152, PROT_NONE)   = 0
old_mmap(0x40015000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0) = 0x40015000
close(3)                                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=76711, ...}) = 0
old_mmap(NULL, 76711, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`u\1B4\0"..., 
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1401027, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40029000
old_mmap(0x42000000, 1264928, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
0x42000000
mprotect(0x4212c000, 36128, PROT_NONE)  = 0
old_mmap(0x4212c000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0x12c000) = 0x4212c000
old_mmap(0x42131000, 15648, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x42131000
close(3)                                = 0
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++




