Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbULWLc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbULWLc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 06:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbULWLc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 06:32:56 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:8851 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261212AbULWLcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 06:32:50 -0500
Date: Thu, 23 Dec 2004 12:32:48 +0100
To: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
Subject: Re: cannot eject drive using pktcdvd
Message-ID: <20041223113248.GB27920@gamma.logic.tuwien.ac.at>
References: <20041025144846.GA2137@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m3hdmeue78.fsf@telia.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Peter, hi list!

Peter Osterlund wrote:
> I can't reproduce any of these problems on my laptop. I run FC3 and
> kernel 2.6.10-rc3-bk6. I tried both with a USB CDRW drive and an IDE
> DVD+RW drive.

I can reproduce this problem, in fact I experienced it myself and
disabled udftools.

> More info is needed. What distribution? What kernel? And please
> provide strace logs from eject when it fails.

kernel:		2.6.10-rc3-mm1
distribution:	debian/sid

I have straced the eject command for normal user (failed) and root
(succeeded) and the diff is short and simple:

--- strace.eject.user   2004-12-23 12:26:05.000000000 +0100
+++ strace.eject.root   2004-12-23 12:26:19.000000000 +0100
@@ -62,7 +62,10 @@
 munmap(0xb7c9a000, 4096)                = 0
 open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 3
 ioctl(3, CDROMEJECT, 0xbffffb68)        = -1 EIO (Input/output error)
-ioctl(3, FIBMAP, 0xbffffa10)            = -1 EPERM (Operation not permitted)
+ioctl(3, FIBMAP, 0xbffffa10)            = 0
+ioctl(3, FIBMAP, 0xbffffa10)            = 0
+ioctl(3, FIBMAP, 0xbffffa10)            = 0
+ioctl(3, BLKRRPART, 0xbffffa10)         = -1 EINVAL (Invalid argument)
 ioctl(3, FDEJECT, 0xbffffb68)           = -1 EINVAL (Invalid argument)

But in both cases I get
	eject: unable to eject, last error: Invalid argument
although as root it did work.

The complete strace.eject.user is attached.


Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AHENNY (adj.)
The way people stand when examining other people's bookshelves.
			--- Douglas Adams, The Meaning of Liff

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="strace.eject.user"

execve("/usr/bin/eject", ["eject", "/dev/hdc"], [/* 27 vars */]) = 0
uname({sys="Linux", node="gandalf", ...}) = 0
brk(0)                                  = 0x804e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fe9000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=99507, ...}) = 0
old_mmap(NULL, 99507, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7fd0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360Y\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1253924, ...}) = 0
old_mmap(NULL, 1260140, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xb7e9c000
old_mmap(0xb7fc5000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0xb7fc5000
old_mmap(0xb7fcd000, 10860, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fcd000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e9b000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e9b460, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7fd0000, 99507)               = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2093808, ...}) = 0
mmap2(NULL, 2093808, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7c9b000
close(3)                                = 0
brk(0)                                  = 0x804e000
brk(0x806f000)                          = 0x806f000
brk(0)                                  = 0x806f000
access("/dev/hdc", F_OK)                = 0
readlink("/dev/hdc", 0xbfffeb10, 4095)  = -1 EINVAL (Invalid argument)
stat64("/dev/hdc", {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=424, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7c9a000
read(3, "/dev/hda4 / ext3 rw,errors=remou"..., 4096) = 424
stat64("/dev/hda4", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 4), ...}) = 0
stat64("proc", 0xbfffedfc)              = -1 ENOENT (No such file or directory)
stat64("sysfs", 0xbfffedfc)             = -1 ENOENT (No such file or directory)
stat64("devpts", 0xbfffedfc)            = -1 ENOENT (No such file or directory)
stat64("tmpfs", 0xbfffedfc)             = -1 ENOENT (No such file or directory)
stat64("/dev/hda1", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 1), ...}) = 0
stat64("/dev/hda2", {st_mode=S_IFBLK|0660, st_rdev=makedev(3, 2), ...}) = 0
stat64("/dev", {st_mode=S_IFDIR|0755, st_size=3620, ...}) = 0
stat64("none", 0xbfffedfc)              = -1 ENOENT (No such file or directory)
stat64("usbfs", 0xbfffedfc)             = -1 ENOENT (No such file or directory)
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7c9a000, 4096)                = 0
open("/etc/fstab", O_RDONLY)            = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=936, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7c9a000
read(3, "# /etc/fstab: static file system"..., 4096) = 936
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7c9a000, 4096)                = 0
open("/etc/mtab", O_RDONLY)             = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=424, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7c9a000
read(3, "/dev/hda4 / ext3 rw,errors=remou"..., 4096) = 424
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7c9a000, 4096)                = 0
open("/dev/hdc", O_RDONLY|O_NONBLOCK)   = 3
ioctl(3, CDROMEJECT, 0xbffffb68)        = -1 EIO (Input/output error)
ioctl(3, FIBMAP, 0xbffffa10)            = -1 EPERM (Operation not permitted)
ioctl(3, FDEJECT, 0xbffffb68)           = -1 EINVAL (Invalid argument)
ioctl(3, MGSL_IOCGPARAMS or MTIOCTOP or SNDCTL_MIDI_MPUMODE, 0xbffffb20) = -1 EINVAL (Invalid argument)
write(2, "eject: unable to eject, last err"..., 53eject: unable to eject, last error: Invalid argument
) = 53
exit_group(1)                           = ?

--dDRMvlgZJXvWKvBx--
