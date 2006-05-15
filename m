Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWEOJ2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWEOJ2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWEOJ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:28:51 -0400
Received: from math.ut.ee ([193.40.36.2]:36746 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S932235AbWEOJ2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:28:51 -0400
Date: Mon, 15 May 2006 12:28:49 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: nfsservctl() compatibility broken on AMD64?
Message-ID: <Pine.SOC.4.61.0605151220130.27015@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use the latest amd64 kernel (2.6.17-rc3 compiled last 
week) with Debian Sarge 32-bit userland (is it reasonable to expect it 
to work?).

There's a problem with exportfs. I can export to IP ranges OK but I can 
not export to single hosts - nfsservctl() returns EFAULT.

Documentation/Changes tells I need at least nfs-utils 1.0.5, sarge has 
1.0.6-3.1 so this should be OK.

# strace -o /tmp/log exportfs -a
192.168.0.1:/home: Bad address
# cat /tmp/log
execve("/usr/sbin/exportfs", ["exportfs", "-a"], [/* 12 vars */]) = 0
uname({sys="Linux", node="kaamel", ...}) = 0
brk(0)                                  = 0x8056000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f1b000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=93540, ...}) = 0
old_mmap(NULL, 93540, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7f04000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`Z\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1254660, ...}) = 0
old_mmap(NULL, 1264972, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xf7dcf000
old_mmap(0xf7ef9000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x129000) = 0xf7ef9000
old_mmap(0xf7f02000, 7500, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f02000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7dce000
set_thread_area({entry_number:-1 -> 12, base_addr:0xf7dce460, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xf7f04000, 93540)               = 0
getpid()                                = 23227
rt_sigaction(SIGUSR1, {0x804e400, [USR1], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGUSR2, {0x804e400, [USR2], SA_RESTART}, {SIG_DFL}, 8) = 0
stat64("/proc/fs/nfs/filehandle", 0xffffd14c) = -1 ENOENT (No such file or directory)
stat64("/proc/fs/nfsd/filehandle", 0xffffd14c) = -1 ENOENT (No such file or directory)
brk(0)                                  = 0x8056000
brk(0x8077000)                          = 0x8077000
brk(0)                                  = 0x8077000
open("/etc/exports", O_RDONLY)          = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=142, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f1a000
read(3, "# /etc/exports: the access contr"..., 4096) = 142
lstat64("/home", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
gettimeofday({1147685220, 816184}, NULL) = 0
getpid()                                = 23227
open("/etc/resolv.conf", O_RDONLY)      = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=194, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f19000
read(4, "# Dynamic resolv.conf(5) file fo"..., 4096) = 194
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xf7f19000, 4096)                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 4
connect(4, {sa_family=AF_FILE, path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f19000
read(4, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 465
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xf7f19000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=93540, ...}) = 0
old_mmap(NULL, 93540, PROT_READ, MAP_PRIVATE, 4, 0) = 0xf7db7000
close(4)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnss_files.so.2", O_RDONLY) = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\35"..., 512) = 512
fstat64(4, {st_mode=S_IFREG|0644, st_size=34748, ...}) = 0
old_mmap(NULL, 38044, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0xf7f10000
old_mmap(0xf7f19000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x8000) = 0xf7f19000
close(4)                                = 0
munmap(0xf7db7000, 93540)               = 0
open("/etc/host.conf", O_RDONLY)        = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=26, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f0f000
read(4, "order hosts,bind\nmulti on\n", 4096) = 26
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xf7f0f000, 4096)                = 0
open("/etc/hosts", O_RDONLY)            = 4
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f0f000
read(4, "127.0.0.1\tlocalhost.localdomain\t"..., 4096) = 254
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xf7f0f000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=93540, ...}) = 0
old_mmap(NULL, 93540, PROT_READ, MAP_PRIVATE, 4, 0) = 0xf7db7000
close(4)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnss_dns.so.2", O_RDONLY) = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\16"..., 512) = 512
fstat64(4, {st_mode=S_IFREG|0644, st_size=13976, ...}) = 0
old_mmap(NULL, 12704, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0xf7f0c000
old_mmap(0xf7f0f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0x3000) = 0xf7f0f000
close(4)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libresolv.so.2", O_RDONLY) = 4
read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220)\0"..., 512) = 512
fstat64(4, {st_mode=S_IFREG|0644, st_size=64924, ...}) = 0
old_mmap(NULL, 73640, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0xf7da5000
old_mmap(0xf7db4000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 0xf000) = 0xf7db4000
old_mmap(0xf7db5000, 8104, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7db5000
close(4)                                = 0
munmap(0xf7db7000, 93540)               = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
connect(4, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.74.8")}, 28) = 0
send(4, "g\350\1\0\0\1\0\0\0\0\0\0\0011\0010\003168\003192\7in-"..., 42, 0) = 42
gettimeofday({1147685220, 818364}, NULL) = 0
poll([{fd=4, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
ioctl(4, FIONREAD, [119])               = 0
recvfrom(4, "g\350\205\203\0\1\0\0\0\1\0\0\0011\0010\003168\003192\7"..., 1024, 0, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.74.8")}, [16]) = 119
close(4)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 4
connect(4, {sa_family=AF_FILE, path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No such file or directory)
close(4)                                = 0
open("/etc/hosts", O_RDONLY)            = 4
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f0b000
read(4, "127.0.0.1\tlocalhost.localdomain\t"..., 4096) = 254
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xf7f0b000, 4096)                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
connect(4, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.74.8")}, 28) = 0
send(4, "g\351\1\0\0\1\0\0\0\0\0\0\0011\0010\003168\003192\7in-"..., 42, 0) = 42
gettimeofday({1147685220, 849469}, NULL) = 0
poll([{fd=4, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
ioctl(4, FIONREAD, [139])               = 0
recvfrom(4, "g\351\205\203\0\1\0\0\0\1\0\0\0011\0010\003168\003192\7"..., 1024, 0, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.74.8")}, [16]) = 139
close(4)                                = 0
read(3, "", 4096)                       = 0
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xf7f1a000, 4096)                = 0
open("/var/lib/nfs/etab", O_RDONLY)     = 3
rt_sigaction(SIGALRM, {0x804ded0, [], 0}, {SIG_DFL}, 8) = 0
alarm(10)                               = 0
fcntl64(3, F_SETLKW, {type=F_RDLCK, whence=SEEK_SET, start=0, len=0}) = 0
alarm(0)                                = 10
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
open("/var/lib/nfs/etab", O_RDONLY)     = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=150, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f1a000
read(4, "/home\t192.168.0.1(rw,async,wdela"..., 4096) = 150
lstat64("/home", {st_mode=S_IFDIR|S_ISGID|0775, st_size=4096, ...}) = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 5
connect(5, {sa_family=AF_FILE, path="/var/run/.nscd_socket"}, 110) = -1 ENOENT (No such file or directory)
close(5)                                = 0
open("/etc/hosts", O_RDONLY)            = 5
fcntl64(5, F_GETFD)                     = 0
fcntl64(5, F_SETFD, FD_CLOEXEC)         = 0
fstat64(5, {st_mode=S_IFREG|0644, st_size=254, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f0b000
read(5, "127.0.0.1\tlocalhost.localdomain\t"..., 4096) = 254
read(5, "", 4096)                       = 0
close(5)                                = 0
munmap(0xf7f0b000, 4096)                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 5
connect(5, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.74.8")}, 28) = 0
send(5, "g\352\1\0\0\1\0\0\0\0\0\0\0011\0010\003168\003192\7in-"..., 42, 0) = 42
gettimeofday({1147685220, 850802}, NULL) = 0
poll([{fd=5, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
ioctl(5, FIONREAD, [139])               = 0
recvfrom(5, "g\352\205\203\0\1\0\0\0\1\0\0\0011\0010\003168\003192\7"..., 1024, 0, {sa_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("192.168.74.8")}, [16]) = 139
close(5)                                = 0
read(4, "", 4096)                       = 0
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0xf7f1a000, 4096)                = 0
close(3)                                = 0
open("/var/lib/nfs/rmtab", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f1a000
read(3, "", 4096)                       = 0
fdatasync(3)                            = 0
close(3)                                = 0
munmap(0xf7f1a000, 4096)                = 0
open("/proc/fs/nfs/exports", O_RDONLY)  = 3
close(3)                                = 0
open("/proc/fs/nfs/exports", O_RDONLY)  = 3
rt_sigaction(SIGALRM, {0x804ded0, [], 0}, {SIG_DFL}, 8) = 0
alarm(10)                               = 0
fcntl64(3, F_SETLKW, {type=F_RDLCK, whence=SEEK_SET, start=0, len=0}) = 0
alarm(0)                                = 10
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
open("/proc/fs/nfs/exports", O_RDONLY)  = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f1a000
read(4, "# Version 1.1\n# Path Client(Flag"..., 1024) = 41
read(4, "", 1024)                       = 0
read(4, "", 1024)                       = 0
close(4)                                = 0
munmap(0xf7f1a000, 4096)                = 0
close(3)                                = 0
nfsservctl(0x1, 0xffffbd40, 0)          = -1 EFAULT (Bad address)
write(2, "192.168.0.1:/home: Bad address\n", 31) = 31
open("/var/lib/nfs/etab", O_RDWR|O_CREAT, 036767260150) = 3
rt_sigaction(SIGALRM, {0x804ded0, [], 0}, {SIG_DFL}, 8) = 0
alarm(10)                               = 0
fcntl64(3, F_SETLKW, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
alarm(0)                                = 10
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
open("/var/lib/nfs/etab.tmp", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7f1a000
write(4, "/home\t192.168.0.1(rw,async,wdela"..., 150) = 150
close(4)                                = 0
munmap(0xf7f1a000, 4096)                = 0
open("/var/lib/nfs/etab.tmp", O_RDONLY) = 4
open("/var/lib/nfs/etab", O_RDONLY)     = 5
read(4, "/home\t192.168.0.1(rw,async,wdela"..., 4096) = 150
read(5, "/home\t192.168.0.1(rw,async,wdela"..., 4096) = 150
read(4, "", 4096)                       = 0
read(5, "", 4096)                       = 0
close(4)                                = 0
close(5)                                = 0
unlink("/var/lib/nfs/etab.tmp")         = 0
close(3)                                = 0
open("/var/lib/nfs/xtab", O_RDWR|O_CREAT, 036767400626) = 3
rt_sigaction(SIGALRM, {0x804ded0, [], 0}, {SIG_DFL}, 8) = 0
alarm(10)                               = 0
fcntl64(3, F_SETLKW, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
alarm(0)                                = 10
rt_sigaction(SIGALRM, {SIG_DFL}, NULL, 8) = 0
open("/var/lib/nfs/xtab.tmp", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
close(4)                                = 0
open("/var/lib/nfs/xtab.tmp", O_RDONLY) = 4
open("/var/lib/nfs/xtab", O_RDONLY)     = 5
read(4, "", 4096)                       = 0
read(5, "", 4096)                       = 0
close(4)                                = 0
close(5)                                = 0
unlink("/var/lib/nfs/xtab.tmp")         = 0
close(3)                                = 0
exit_group(0)                           = ?

-- 
Meelis Roos (mroos@linux.ee)
