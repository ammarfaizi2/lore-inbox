Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbSASQbV>; Sat, 19 Jan 2002 11:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbSASQbN>; Sat, 19 Jan 2002 11:31:13 -0500
Received: from 90dyn204.com21.casema.net ([62.234.21.204]:20364 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S280126AbSASQa4>; Sat, 19 Jan 2002 11:30:56 -0500
Message-Id: <200201191630.RAA14567@cave.bitwizard.nl>
Subject: ls command is slow..... (reiserfs, VM)?
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Sat, 19 Jan 2002 17:30:51 +0100 (MET)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

the "ls" command is horribly slow on my system....

I'm doing some stuff with large files. From the old days when files
couldn't be larger than 2G, I'm manipulating 1G files.

There is currently a program runnning that will make a file sparse if
it finds only zeroes in a block. It's reading between 20 and 30Mb per
second off the disks, and currently finding only zeros, so there is no
writing going on.

Linux version 2.4.16 (root@cave) (gcc version egcs-2.91.66
  19990314/Linux (egcs-1.1.2 release)) #15 Fri Jan 18 13:00:57 MET 2002

There are 4 maxtor 160G IDE disks raided to something that looks more
like 600G....

# df .
Filesystem            Size  Used Avail Use% Mounted on
/dev/md0              603G  133G  470G  23% /recover5

The format is "reiserfs". 

Is this an odd situation for "VM", Is this related to the reiserfs?
The raid?

 From the strace below, you can see that most of the time is spent in
simple "stat" calls.

Before the trace below, I did the same "ls" which could have cached
all info some 10 seconds before. If I repeat the command, within a few
seconds, things are fast.

I can live with the current situation. I'm reporting this as a
data-point, so that Linux can become better. If someone wants me to do
some quick tests, 


				Roger. 

obelix /recover5/bd450r# strace -tt ls -arlts 
15:12:02.984954 execve("/bin/ls", ["ls", "-arlts"], [/* 37 vars */]) = 0
15:12:02.989312 uname({sys="Linux", node="obelix", ...}) = 0
15:12:02.989534 brk(0)                  = 0x8054244
15:12:02.989667 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
15:12:02.989784 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
15:12:02.989933 open("/etc/ld.so.cache", O_RDONLY) = 3
15:12:02.990056 fstat64(3, {st_mode=S_IFREG|0644, st_size=7680, ...}) = 0
15:12:02.990387 old_mmap(NULL, 7680, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
15:12:02.990494 close(3)                = 0
15:12:02.990590 open("/lib/librt.so.1", O_RDONLY) = 3
15:12:02.991183 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\"\0"..., 1024) = 1024
15:12:02.991362 fstat64(3, {st_mode=S_IFREG|0755, st_size=36672, ...}) = 0
15:12:02.991483 old_mmap(NULL, 71892, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40018000
15:12:02.991578 mprotect(0x4001e000, 47316, PROT_NONE) = 0
15:12:02.991663 old_mmap(0x4001e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x5000) = 0x4001e000
15:12:02.994586 old_mmap(0x40020000, 39124, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40020000
15:12:02.994767 close(3)                = 0
15:12:02.994923 open("/lib/libc.so.6", O_RDONLY) = 3
15:12:02.995040 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\330"..., 1024) = 1024
15:12:02.995189 fstat64(3, {st_mode=S_IFREG|0755, st_size=1384168, ...}) = 0
15:12:02.995306 old_mmap(NULL, 1201988, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002a000
15:12:02.995399 mprotect(0x40145000, 42820, PROT_NONE) = 0
15:12:02.995655 old_mmap(0x40145000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x11a000) = 0x40145000
15:12:02.995801 old_mmap(0x4014c000, 14148, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4014c000
15:12:02.995937 close(3)                = 0
15:12:02.996087 open("/lib/libpthread.so.0", O_RDONLY) = 3
15:12:02.996192 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`P\0\000"..., 1024) = 1024
15:12:02.996329 fstat64(3, {st_mode=S_IFREG|0755, st_size=106843, ...}) = 0
15:12:02.996694 old_mmap(NULL, 88860, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40150000
15:12:02.996820 mprotect(0x4015e000, 31516, PROT_NONE) = 0
15:12:02.996908 old_mmap(0x4015e000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xd000) = 0x4015e000
15:12:03.002216 close(3)                = 0
15:12:03.009451 munmap(0x40016000, 7680) = 0
15:12:03.009804 getrlimit(0x3, 0xbffff91c) = 0
15:12:03.009906 setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
15:12:03.010181 getpid()                = 8823
15:12:03.010473 rt_sigaction(SIGRTMIN, {0x401593b0, [], 0x4000000}, NULL, 8) = 0
15:12:03.010590 rt_sigaction(SIGRT_1, {0x40159440, [], 0x4000000}, NULL, 8) = 0
15:12:03.010735 rt_sigaction(SIGRT_2, {0x40159550, [], 0x4000000}, NULL, 8) = 0
15:12:03.010835 rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
15:12:03.010953 _sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff724, 32, (nil), 0}) = 0
15:12:03.019603 brk(0)                  = 0x8054244
15:12:03.019979 brk(0x8054274)          = 0x8054274
15:12:03.020504 brk(0x8055000)          = 0x8055000
15:12:03.020864 ioctl(1, SNDCTL_TMR_TIMEBASE, {B38400 opost isig icanon echo ...}) = 0
15:12:03.021032 ioctl(1, 0x5413, {ws_row=53, ws_col=90, ws_xpixel=562, ws_ypixel=693}) = 0
15:12:03.021208 brk(0x8058000)          = 0x8058000
15:12:03.024003 open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOTDIR (Not a directory)
15:12:03.024206 open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
15:12:03.024300 fstat64(3, {st_mode=S_IFDIR|0755, st_size=1639, ...}) = 0
15:12:03.024715 fcntl64(3, F_SETFD, FD_CLOEXEC) = 0
15:12:03.024851 brk(0x805a000)          = 0x805a000
15:12:03.024981 getdents64(0x3, 0x80570a8, 0x1000, 0) = 2040
15:12:03.025169 lstat64(".", {st_mode=S_IFDIR|0755, st_size=1639, ...}) = 0
15:12:03.025310 lstat64("..", {st_mode=S_IFDIR|0755, st_size=183, ...}) = 0
15:12:03.025423 lstat64("disk.img", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.127089 lstat64("disk.img10", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.264818 lstat64("disk.img11", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.323979 lstat64("disk.img12", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.389440 lstat64("disk.img13", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.452280 lstat64("disk.img14", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.701409 lstat64("disk.img15", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.741297 lstat64("disk.img16", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.826020 lstat64("disk.img17", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.880361 lstat64("disk.img18", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:03.916180 lstat64("disk.img19", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:04.051966 lstat64("disk.img20", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:04.110954 lstat64("disk.img21", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:04.643874 lstat64("disk.img22", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:04.788162 lstat64("disk.img23", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:04.896356 lstat64("disk.img24", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:04.997907 lstat64("disk.img25", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:05.028377 lstat64("disk.img26", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:05.205541 lstat64("disk.img27", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:05.227154 lstat64("disk.img28", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:05.724142 lstat64("disk.img29", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:06.009835 lstat64("disk.img30", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:06.064456 lstat64("disk.img31", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:06.394721 lstat64("disk.img32", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:07.367021 lstat64("disk.img33", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:07.575743 lstat64("disk.img34", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:08.049331 lstat64("disk.img35", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:08.720390 lstat64("disk.img36", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:08.886175 lstat64("disk.img37", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:08.957344 lstat64("disk.img38", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:09.087656 lstat64("disk.img39", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:09.395794 lstat64("disk.img40", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:09.512514 lstat64("disk.img41", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:09.541018 lstat64("disk.img42", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:09.838616 lstat64("disk.img43", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.000392 lstat64("disk.img44", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.141981 lstat64("disk.img45", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.339458 lstat64("disk.img46", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.339643 lstat64("disk.img47", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.339751 lstat64("disk.img48", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.339853 lstat64("disk.img49", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.339952 lstat64("disk.img50", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.340427 lstat64("disk.img51", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.340746 lstat64("disk.img52", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.341057 lstat64("disk.img53", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.341339 lstat64("disk.img54", {st_mode=S_IFREG|0600, st_size=1073741824, ...}) = 0
15:12:10.341452 lstat64("disk.img55", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:10.341563 lstat64("disk.img56", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:10.393099 lstat64("disk.img57", {st_mode=S_IFREG|0644, st_size=289554432, ...}) = 0
15:12:10.501033 lstat64("disk.img58", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
15:12:10.501367 lstat64("disk.img59", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
15:12:10.501620 lstat64("disk.img55_v3CIOj", {st_mode=S_IFREG|0600, st_size=0, ...}) = 0
15:12:10.501855 lstat64("entr.0", {st_mode=S_IFREG|0644, st_size=9437184, ...}) = 0
15:12:10.543718 lstat64("disk.img1", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:10.665958 lstat64("disk.img2", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:10.788943 lstat64("disk.img3", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:10.819028 lstat64("disk.img4", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:10.873779 lstat64("disk.img5", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:11.058686 lstat64("disk.img6", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:11.140920 lstat64("disk.img7", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:11.167953 lstat64("disk.img8", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:11.262581 lstat64("disk.img9", {st_mode=S_IFREG|0644, st_size=1073741824, ...}) = 0
15:12:11.347519 getdents64(0x3, 0x80570a8, 0x1000, 0) = 0
15:12:11.347683 close(3)                = 0
15:12:11.347960 open("/etc/mtab", O_RDONLY) = 3
15:12:11.348098 fstat64(3, {st_mode=S_IFREG|0644, st_size=496, ...}) = 0
15:12:11.348183 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
15:12:11.348276 read(3, "proc /proc proc rw 0 0\ndevpts /d"..., 4096) = 496
15:12:11.348582 close(3)                = 0
15:12:11.348639 munmap(0x40016000, 4096) = 0
15:12:11.348785 open("/proc/meminfo", O_RDONLY) = 3
15:12:11.348891 fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
15:12:11.348968 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
15:12:11.349033 read(3, "        total:    used:    free:"..., 4096) = 520
15:12:11.349227 close(3)                = 0
15:12:11.349385 munmap(0x40016000, 4096) = 0
15:12:11.349449 brk(0x805c000)          = 0x805c000
15:12:11.349792 fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 6), ...}) = 0
15:12:11.349880 old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
15:12:11.350043 write(1, "total 25767923\n", 15total 25767923
) = 15
15:12:11.353471 socket(PF_UNIX, SOCK_STREAM, 0) = 3
15:12:11.353948 connect(3, {sin_family=AF_UNIX, path="/var/run/.nscd_socket"}, 110) = 0
15:12:11.354237 write(3, "\2\0\0\0\1\0\0\0\2\0\0\0", 12) = 12
15:12:11.354438 write(3, "0\0", 2)      = 2
15:12:11.354563 read(3, "`\"\26@\1\0\0\0\5\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0\5\0\0\0"..., 36) = 36
15:12:11.354671 read(3, "root\0x\0root\0/root\0/bin/tcsh\0", 28) = 28
15:12:11.354757 close(3)                = 0
15:12:11.354886 socket(PF_UNIX, SOCK_STREAM, 0) = 3
15:12:11.355141 connect(3, {sin_family=AF_UNIX, path="/var/run/.nscd_socket"}, 110) = 0
15:12:11.355310 writev(3, [{"\2\0\0\0\3\0\0\0\2\0\0\0", 12}, {"0\0", 2}], 2) = 14
15:12:11.355535 read(3, "x!\26@\1\0\0\0\5\0\0\0\2\0\0\0\0\0\0\0\3\0\0\0", 24) = 24
15:12:11.355744 readv(3, [{"\5\0\0\0\6\0\0\0\10\0\0\0", 12}, {"root\0x\0", 7}], 2) = 19
15:12:11.355851 read(3, "root\0wolff\0patrick\0", 19) = 19
15:12:11.355932 close(3)                = 0
15:12:11.356087 open("/etc/localtime", O_RDONLY) = -1 ENOENT (No such file or directory)
15:12:11.356379 gettimeofday({1011453131, 356415}, NULL) = 0
15:12:11.356512 write(1, "      1 drwxr-xr-x   10 root    "..., 67      1 drwxr-xr-x   10 root     root          183 Jan 19 09:21 ..
) = 67
15:12:11.356634 write(1, "1048576 -rw-r--r--    1 root    "..., 751048576 -rw-r--r--    1 root     root     1073741824 Jan 19 09:30 disk.img
) = 75
15:12:11.356746 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 09:57 disk.img1
) = 76
15:12:11.356947 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 10:09 disk.img2
) = 76
15:12:11.357187 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 10:20 disk.img3
) = 76
15:12:11.357300 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 10:28 disk.img4
) = 76
15:12:11.357411 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 10:37 disk.img5
) = 76
15:12:11.357612 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 10:46 disk.img6
) = 76
15:12:11.357723 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 10:54 disk.img7
) = 76
15:12:11.357833 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:03 disk.img8
) = 76
15:12:11.357989 write(1, "1048576 -rw-r--r--    1 root    "..., 761048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:12 disk.img9
) = 76
15:12:11.358221 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:20 disk.img10
) = 77
15:12:11.358331 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:29 disk.img11
) = 77
15:12:11.358441 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:37 disk.img12
) = 77
15:12:11.358653 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:47 disk.img13
) = 77
15:12:11.358797 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 11:55 disk.img14
) = 77
15:12:11.358993 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 12:01 disk.img15
) = 77
15:12:11.359105 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 12:07 disk.img16
) = 77
15:12:11.359331 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 12:13 disk.img17
) = 77
15:12:11.359466 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 12:20 disk.img18
) = 77
15:12:11.359575 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 12:26 disk.img19
) = 77
15:12:11.359820 write(1, "   9216 -rw-r--r--    1 root    "..., 71   9216 -rw-r--r--    1 root     root      9437184 Jan 19 12:44 entr.0
) = 71
15:12:11.359931 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 14:39 disk.img55
) = 77
15:12:11.360068 write(1, "1048576 -rw-r--r--    1 root    "..., 771048576 -rw-r--r--    1 root     root     1073741824 Jan 19 14:43 disk.img56
) = 77
15:12:11.360169 write(1, "      0 -rw-r--r--    1 root    "..., 75      0 -rw-r--r--    1 root     root            0 Jan 19 14:45 disk.img59
) = 75
15:12:11.360251 write(1, "      0 -rw-r--r--    1 root    "..., 75      0 -rw-r--r--    1 root     root            0 Jan 19 14:45 disk.img58
) = 75
15:12:11.360332 write(1, " 282768 -rw-r--r--    1 root    "..., 76 282768 -rw-r--r--    1 root     root     289554432 Jan 19 14:45 disk.img57
) = 76
15:12:11.360414 write(1, "1044116 -rw-------    1 root    "..., 771044116 -rw-------    1 root     root     1073741824 Jan 19 14:45 disk.img20
) = 77
15:12:11.360496 write(1, "1037772 -rw-------    1 root    "..., 771037772 -rw-------    1 root     root     1073741824 Jan 19 14:47 disk.img21
) = 77
15:12:11.360577 write(1, " 325248 -rw-------    1 root    "..., 77 325248 -rw-------    1 root     root     1073741824 Jan 19 14:48 disk.img22
) = 77
15:12:11.360658 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:48 disk.img23
) = 77
15:12:11.360740 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:49 disk.img24
) = 77
15:12:11.360821 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:50 disk.img25
) = 77
15:12:11.360903 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:51 disk.img26
) = 77
15:12:11.361072 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:51 disk.img27
) = 77
15:12:11.361154 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:52 disk.img28
) = 77
15:12:11.361235 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:53 disk.img29
) = 77
15:12:11.361316 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:54 disk.img30
) = 77
15:12:11.361397 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:54 disk.img31
) = 77
15:12:11.361477 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:55 disk.img32
) = 77
15:12:11.361558 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:56 disk.img33
) = 77
15:12:11.361640 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:56 disk.img34
) = 77
15:12:11.361720 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:57 disk.img35
) = 77
15:12:11.361802 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:58 disk.img36
) = 77
15:12:11.361882 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:59 disk.img37
) = 77
15:12:11.361963 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 14:59 disk.img38
) = 77
15:12:11.362044 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:00 disk.img39
) = 77
15:12:11.362125 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:01 disk.img40
) = 77
15:12:11.362206 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:02 disk.img41
) = 77
15:12:11.362288 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:02 disk.img42
) = 77
15:12:11.363345 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:03 disk.img43
) = 77
15:12:11.363457 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:04 disk.img44
) = 77
15:12:11.363555 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:04 disk.img45
) = 77
15:12:11.363655 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:05 disk.img46
) = 77
15:12:11.363781 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:06 disk.img47
) = 77
15:12:11.363883 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:07 disk.img48
) = 77
15:12:11.363985 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:07 disk.img49
) = 77
15:12:11.364067 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:08 disk.img50
) = 77
15:12:11.364148 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:09 disk.img51
) = 77
15:12:11.364230 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:10 disk.img52
) = 77
15:12:11.364311 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:10 disk.img53
) = 77
15:12:11.364391 write(1, "      4 -rw-------    1 root    "..., 77      4 -rw-------    1 root     root     1073741824 Jan 19 15:11 disk.img54
) = 77
15:12:11.364472 write(1, "      0 -rw-------    1 root    "..., 82      0 -rw-------    1 root     root            0 Jan 19 15:11 disk.img55_v3CIOj
) = 82
15:12:11.364553 write(1, "      2 drwxr-xr-x    2 root    "..., 66      2 drwxr-xr-x    2 root     root         1639 Jan 19 15:11 .
) = 66
15:12:11.365907 munmap(0x40016000, 4096) = 0
15:12:11.366016 _exit(0)                = ?

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-- End of included mail.

----- End of forwarded message from Mail Delivery Subsystem -----

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
