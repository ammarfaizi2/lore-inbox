Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270822AbRHXBq0>; Thu, 23 Aug 2001 21:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270824AbRHXBqQ>; Thu, 23 Aug 2001 21:46:16 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:49320 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S270822AbRHXBqF>; Thu, 23 Aug 2001 21:46:05 -0400
Message-ID: <3B85B1E8.99D125C1@bigfoot.com>
Date: Thu, 23 Aug 2001 18:46:16 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: mount failure, SCSI emulation, 2.2.20pre9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI emulation fails, same CD-R using ATAPI is OK.
Any suggestions as to where else to look?

Other iso9660 CD-R's mount in the emulation drive.

rgds,
tim.

--- SCSI emulation fails ---
[tim@abit tim]# ls -l /dev/cdrom
lrwxrwxrwx    1 root     root            3 Feb  2  2001 /dev/cdrom -> sr0
[tim@abit tim]# cat /proc/version
Linux version 2.2.20p9ai (root@abit) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #5 Thu Aug 23 17:56:21 PDT 2001
[tim@abit tim]# mount -V
mount: mount-2.10r
[tim@abit tim]# strace mount -t iso9660 -o ro /dev/cdrom /cdrom
execve("/bin/mount", ["mount", "-t", "iso9660", "-o", "ro", "/dev/cdrom", "/cdrom"], [/* 31 vars */]) = 0
...
lstat("/etc/mtab", {st_mode=S_IFREG|0644, st_size=211, ...}) = 0
stat("/sbin/mount.iso9660", 0xbffff7bc) = -1 ENOENT (No such file or directory)
rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
mount("/dev/cdrom", "/cdrom", "iso9660", MS_RDONLY|0xc0ed0000, 0x805a900) = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_UNBLOCK, ~[TRAP SEGV], NULL, 8) = 0
...
write(2, "mount: wrong fs type, bad option"..., 104mount: wrong fs type, bad option, bad superblock on /dev/cdrom,
       or too many mounted file systems
) = 104
stat("/dev/cdrom", {st_mode=S_IFBLK|0600, st_rdev=makedev(11, 0), ...}) = 0
open("/dev/cdrom", O_RDONLY|O_NONBLOCK|O_LARGEFILE) = 3
ioctl(3, BLKGETSIZE, 0xbffff950)        = -1 EINVAL (Invalid argument)
_exit(32)                               = ?

--- same CD-R, ATAPI works ---
[tim@dell tim]# ls -l /dev/cdrom
lrwxrwxrwx    1 root     root            8 Jul 26 17:00 /dev/cdrom -> /dev/hdb
[tim@dell tim]# cat /proc/version
Linux version 2.2.20p6i5i (root@abit) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #3 Mon Jun 25 21:44:03 PDT 2001
[tim@dell tim]# mount -V
mount: mount-2.10f
[tim@dell tim]# strace mount -t iso9660 -o ro /dev/cdrom /cdrom
execve("/bin/mount", ["mount", "-t", "iso9660", "-o", "ro", "/dev/cdrom", "/cdrom"], [/* 26 vars */]) = 0
...
lstat("/etc/mtab", {st_mode=S_IFREG|0644, st_size=129, ...}) = 0
rt_sigprocmask(SIG_BLOCK, ~[TRAP SEGV], NULL, 8) = 0
mount("/dev/cdrom", "/cdrom", "iso9660", MS_RDONLY|0xc0ed0000, 0x80592b0) = 0
brk(0x805c000)                          = 0x805c000
readlink("/dev", 0xbfffe8a0, 4095)      = -1 EINVAL (Invalid argument)
readlink("/dev/cdrom", "/dev/hdb", 4095) = 8
readlink("/dev", 0xbfffe8a0, 4095)      = -1 EINVAL (Invalid argument)
readlink("/dev/hdb", 0xbfffe8a0, 4095)  = -1 EINVAL (Invalid argument)
readlink("/cdrom", 0xbfffe89c, 4095)    = -1 EINVAL (Invalid argument)
open("/etc/mtab", O_RDWR|O_CREAT, 0644) = 3
close(3)                                = 0
rt_sigaction(SIGHUP, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGINT, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGQUIT, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGILL, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGTRAP, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGABRT, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGBUS, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGFPE, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGKILL, {0x804d550, ~[], 0x4000000}, NULL, 8) = -1 EINVAL (Invalid argument)
rt_sigaction(SIGUSR1, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGSEGV, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGUSR2, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGPIPE, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGALRM, {0x804d580, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGTERM, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
rt_sigaction(SIGSTKFLT, {0x804d550, ~[], 0x4000000}, NULL, 8) = 0
getpid()                                = 1677
open("/etc/mtab~1677", O_WRONLY|O_CREAT, 0) = 3
close(3)                                = 0
link("/etc/mtab~1677", "/etc/mtab~")    = 0
unlink("/etc/mtab~1677")                = 0
open("/etc/mtab~", O_WRONLY)            = 3
fcntl(3, F_SETLK, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
close(3)                                = 0
open("/etc/mtab", O_RDWR|O_APPEND|O_CREAT, 0666) = 3
fstat64(0x3, 0xbffff718)                = -1 ENOSYS (Function not implemented)
fstat(3, {st_mode=S_IFREG|0644, st_size=129, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40019000
fstat(3, {st_mode=S_IFREG|0644, st_size=129, ...}) = 0
_llseek(3, 0, [0], SEEK_SET)            = 0
read(3, "/dev/hda2 / ext2 rw 0 0\nnone /pr"..., 129) = 129
fstat(3, {st_mode=S_IFREG|0644, st_size=129, ...}) = 0
_llseek(3, 129, [129], SEEK_SET)        = 0
write(3, "/dev/hdb /cdrom iso9660 ro 0 0\n", 31) = 31
close(3)                                = 0
munmap(0x40019000, 4096)                = 0
unlink("/etc/mtab~")                    = 0
rt_sigprocmask(SIG_UNBLOCK, ~[TRAP SEGV], NULL, 8) = 0
_exit(0)                                = ?
[tim@dell tim]# ls -l /cdrom
total 48
-rw-r--r--    4 root     root        18385 Aug 16 13:18 COPYING
-rw-r--r--    4 root     root         4247 Aug 16 13:18 README
-rw-r--r--    3 root     root         8748 Aug 16 13:18 RELEASE-NOTES
-rw-r--r--    4 root     root         1908 Aug 16 13:18 RPM-GPG-KEY
drwxr-xr-x    4 root     root         2048 Aug 16 14:15 RedHat
-r--r--r--    1 root     root          503 Aug 16 14:15 TRANS.TBL
-rwxr-xr-x    4 root     root          538 Aug 16 13:18 autorun
-r--r--r--    1 root     root         2048 Aug 16 14:15 boot.cat
drwxr-xr-x    6 root     root         4096 Aug 16 14:10 dosutils
drwxr-xr-x   10 root     root         2048 Aug 16 14:11 images

--
