Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbTCIAiy>; Sat, 8 Mar 2003 19:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbTCIAiy>; Sat, 8 Mar 2003 19:38:54 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:22581 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262324AbTCIAiw>; Sat, 8 Mar 2003 19:38:52 -0500
Message-ID: <3E6A1FB2.8040007@myrealbox.com>
Date: Sat, 08 Mar 2003 16:52:02 +0000
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre5-ac2:  kernel oops with "swapoff -a"
References: <fa.ft2aqc1.154k31h@ifi.uio.no> <fa.ohdbn4e.1rgcs92@ifi.uio.no>
In-Reply-To: <fa.ohdbn4e.1rgcs92@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sat, 2003-03-08 at 11:07, walt wrote:
> 
>>When I do "swapoff -a" I still see the kernel oops that began with -pre4-ac7
>>and has propagated to every 'ac' kernel since then.

> Can you send me an strace swapoff -a ?

# strace swapon -a
execve("/sbin/swapon", ["swapon", "-a"], [/* 36 vars */]) = 0
uname({sys="Linux", node="k9.localnet", ...}) = 0
brk(0)                                  = 0x804aa08
open("/etc/ld.so.preload", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
close(3)                                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=49489, ...}) = 0
mmap2(NULL, 49489, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0_\1\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1411261, ...}) = 0
mmap2(NULL, 1236740, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40021000
mprotect(0x40146000, 36612, PROT_NONE)  = 0
mmap2(0x40146000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x124) 
= 0x40146000
mmap2(0x4014b000, 16132, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014b000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4014f000
munmap(0x40014000, 49489)               = 0
brk(0)                                  = 0x804aa08
brk(0x804ba08)                          = 0x804ba08
brk(0x804c000)                          = 0x804c000
open("/proc/swaps", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40014000
read(3, "Filename\t\t\tType\t\tSize\tUsed\tPrior"..., 1024) = 36
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
open("/etc/fstab", O_RDONLY)            = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1205, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40014000
read(3, "# Copyright 1999-2002 Gentoo Tec"..., 4096) = 1205
stat64("/dev/hda10", {st_mode=S_IFBLK|0600, st_rdev=makedev(3, 10), ...}) = 0
swapon("/dev/hda10")                    = 0
read(3, "", 4096)                       = 0
_exit(0)                                = ?

========================================================================

# strace swapoff -a
execve("/sbin/swapoff", ["swapoff", "-a"], [/* 36 vars */]) = 0
uname({sys="Linux", node="k9.localnet", ...}) = 0
brk(0)                                  = 0x804aa08
open("/etc/ld.so.preload", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
close(3)                                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=49489, ...}) = 0
mmap2(NULL, 49489, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0_\1\000"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1411261, ...}) = 0
mmap2(NULL, 1236740, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40021000
mprotect(0x40146000, 36612, PROT_NONE)  = 0
mmap2(0x40146000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x124) 
= 0x40146000
mmap2(0x4014b000, 16132, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014b000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x4014f000
munmap(0x40014000, 49489)               = 0
brk(0)                                  = 0x804aa08
brk(0x804ba08)                          = 0x804ba08
brk(0x804c000)                          = 0x804c000
open("/proc/swaps", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40014000
read(3, "Filename\t\t\tType\t\tSize\tUsed\tPrior"..., 1024) = 99
read(3, "", 1024)                       = 0
close(3)                                = 0
munmap(0x40014000, 4096)                = 0
swapoff("/dev/ide/host0/bus0/target0/lun0/part10") = 0
open("/etc/fstab", O_RDONLY)            = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=1205, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x40014000
read(3, "# Copyright 1999-2002 Gentoo Tec"..., 4096) = 1205
swapoff("/dev/hda10")                   = -1 EINVAL (Invalid argument)
read(3, "", 4096)                       = 0
_exit(0)                                = ?

