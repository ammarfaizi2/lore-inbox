Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262390AbREXWHX>; Thu, 24 May 2001 18:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262393AbREXWHO>; Thu, 24 May 2001 18:07:14 -0400
Received: from B0e60.pppool.de ([213.7.14.96]:30724 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S262390AbREXWHH>;
	Thu, 24 May 2001 18:07:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: [2.4.4ac15/16] problems with stat or link
Date: Fri, 25 May 2001 00:06:11 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052500061100.01519@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,


I get the mentioned error as often as longer the system is running. E.g.:
> ls kviewshell/.libs/libkmultipage.so

The following is what strace say's:
(The problem-zone can be found between two lines)

3795  execve("/usr/local/bin/ls", ["ls", "-l", 
"kviewshell/.libs/libkmultipage.so"], [/* 54 vars */]) = 0
3795  brk(0)                            = 0x804fbf0
3795  open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or 
directory)
3795  open("/etc/ld.so.cache", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0644, st_size=48328, ...}) = 0
3795  mmap(NULL, 48328, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40015000
3795  close(4)                          = 0
3795  open("/lib/libc.so.6", O_RDONLY)  = 4
3795  fstat(4, {st_mode=S_IFREG|0755, st_size=4145658, ...}) = 0
3795  read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \217\1"..., 
4096) = 4096
3795  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40021000
3795  mmap(NULL, 982684, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40022000
3795  mprotect(0x4010a000, 32412, PROT_NONE) = 0
3795  mmap(0x4010a000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 
0xe7000) = 0x4010a000
3795  mmap(0x4010f000, 11932, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4010f000
3795  close(4)                          = 0
3795  mprotect(0x40022000, 950272, PROT_READ|PROT_WRITE) = 0
3795  mprotect(0x40022000, 950272, PROT_READ|PROT_EXEC) = 0
3795  munmap(0x40015000, 48328)         = 0
3795  personality(PER_LINUX)            = 0
3795  getpid()                          = 3795
3795  brk(0)                            = 0x804fbf0
3795  brk(0x804fc20)                    = 0x804fc20
3795  brk(0x8050000)                    = 0x8050000
3795  open("/share/locale/locale.alias", O_RDONLY) = 4
3795  SYS_197(0x4, 0xbfffb538, 0x4010e3a0, 0x804fc18, 0x4) = 0
3795  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40015000
3795  read(4, "# Locale name alias data base.\n#"..., 4096) = 2265
3795  brk(0x8051000)                    = 0x8051000
3795  read(4, "", 4096)                 = 0
3795  close(4)                          = 0
3795  munmap(0x40015000, 4096)          = 0
[...]
3795  open("/share/locale/de_DE/LC_MESSAGES", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFDIR|0555, st_size=66, ...}) = 0
3795  close(4)                          = 0
3795  open("/share/locale/de_DE/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0444, st_size=44, ...}) = 0
3795  mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40015000
3795  close(4)                          = 0
[....]
3795  open("/share/locale/de_DE/LC_MONETARY", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0444, st_size=94, ...}) = 0
3795  mmap(NULL, 94, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40016000
3795  close(4)                          = 0
3795  brk(0x8052000)                    = 0x8052000
[...]
3795  open("/share/locale/de_DE/LC_COLLATE", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0444, st_size=29970, ...}) = 0
3795  mmap(NULL, 29970, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40017000
3795  close(4)                          = 0
[...]
3795  open("/share/locale/de_DE/LC_TIME", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0444, st_size=492, ...}) = 0
3795  mmap(NULL, 492, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4001f000
3795  close(4)                          = 0
[...]
3795  open("/share/locale/de_DE/LC_NUMERIC", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0444, st_size=27, ...}) = 0
3795  mmap(NULL, 27, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40020000
3795  close(4)                          = 0
[...]
3795  open("/share/locale/de_DE/LC_CTYPE", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0444, st_size=87756, ...}) = 0
3795  mmap(NULL, 87756, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40112000
3795  close(4)                          = 0
3795  time(NULL)                        = 990738510
3795  ioctl(1, TCGETS, {B38400 opost isig icanon echo ...}) = 0
3795  ioctl(1, TIOCGWINSZ, {ws_row=50, ws_col=80, ws_xpixel=0, ws_ypixel=0}) 
= 0
3795  brk(0x8055000)                    = 0x8055000

---------------------------------------------------------------------------------------------

3795  lstat("kviewshell/.libs/libkmultipage.so", 0xbffff718) = -1 EIO 
(Input/output error)

-----------------------------------------------------------------------------------------------

3795  write(2, "ls: ", 4)               = 4
3795  write(2, "kviewshell/.libs/libkmultipage.s"..., 33) = 33
[...]
3795  open("/share/locale/de/LC_MESSAGES/libc.mo", O_RDONLY) = 4
3795  fstat(4, {st_mode=S_IFREG|0644, st_size=94208, ...}) = 0
3795  mmap(NULL, 94208, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40128000
3795  close(4)                          = 0
3795  write(2, ": Eingabe-/Ausgabefehler", 24) = 24
3795  write(2, "\n", 1)                 = 1
3795  close(1)                          = 0
3795  _exit(1)                          = ?


Another example is:
> umount /boot


That's what strace is saying:

3762  execve("/bin/umount", ["umount", "/boot/"], [/* 54 vars */]) = 0
3762  brk(0)                            = 0x80507a0
3762  open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or 
directory)
3762  open("/etc/ld.so.cache", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0644, st_size=48328, ...}) = 0
3762  mmap(NULL, 48328, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40015000
3762  close(4)                          = 0
3762  open("/lib/libc.so.6", O_RDONLY)  = 4
3762  fstat(4, {st_mode=S_IFREG|0755, st_size=4145658, ...}) = 0
3762  read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \217\1"..., 
4096) = 4096
3762  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40021000
3762  mmap(NULL, 982684, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x40022000
3762  mprotect(0x4010a000, 32412, PROT_NONE) = 0
3762  mmap(0x4010a000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 
0xe7000) = 0x4010a000
3762  mmap(0x4010f000, 11932, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4010f000
3762  close(4)                          = 0
3762  mprotect(0x40022000, 950272, PROT_READ|PROT_WRITE) = 0
3762  mprotect(0x40022000, 950272, PROT_READ|PROT_EXEC) = 0
3762  munmap(0x40015000, 48328)         = 0
3762  personality(PER_LINUX)            = 0
3762  getpid()                          = 3762
3762  brk(0)                            = 0x80507a0
3762  brk(0x80507d0)                    = 0x80507d0
3762  brk(0x8051000)                    = 0x8051000
3762  open("/share/locale/locale.alias", O_RDONLY) = 4
3762  SYS_197(0x4, 0xbfffb564, 0x4010e3a0, 0x80507c8, 0x4) = 0
3762  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40015000
3762  read(4, "# Locale name alias data base.\n#"..., 4096) = 2265
3762  read(4, "", 4096)                 = 0
3762  close(4)                          = 0
3762  munmap(0x40015000, 4096)          = 0
[...]
3762  open("/share/locale/de_DE/LC_MESSAGES", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFDIR|0555, st_size=66, ...}) = 0
3762  close(4)                          = 0
3762  open("/share/locale/de_DE/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0444, st_size=44, ...}) = 0
3762  mmap(NULL, 44, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40015000
3762  close(4)                          = 0
[...]
3762  open("/share/locale/de_DE/LC_MONETARY", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0444, st_size=94, ...}) = 0
3762  mmap(NULL, 94, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40016000
3762  close(4)                          = 0
[...]
3762  open("/share/locale/de_DE/LC_COLLATE", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0444, st_size=29970, ...}) = 0
3762  mmap(NULL, 29970, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40017000
3762  close(4)                          = 0
3762  brk(0x8053000)                    = 0x8053000
[...]
3762  open("/share/locale/de_DE/LC_TIME", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0444, st_size=492, ...}) = 0
3762  mmap(NULL, 492, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4001f000
3762  close(4)                          = 0
[...]
3762  open("/share/locale/de_DE/LC_NUMERIC", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0444, st_size=27, ...}) = 0
3762  mmap(NULL, 27, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40020000
3762  close(4)                          = 0
[...]
3762  open("/share/locale/de_DE/LC_CTYPE", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0444, st_size=87756, ...}) = 0
3762  mmap(NULL, 87756, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40112000
3762  close(4)                          = 0
3762  getuid()                          = 0
3762  geteuid()                         = 0
3762  brk(0x8055000)                    = 0x8055000
3762  readlink("/boot", 0xbfffe7fc, 4095) = -1 EINVAL (Invalid argument)
3762  open("/etc/mtab", O_RDONLY)       = 4
3762  SYS_197(0x4, 0xbffff670, 0x4010e3a0, 0x8053ba0, 0x4) = 0
3762  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x40128000
3762  read(4, "/dev/hda1 / reiserfs rw 0 0\nproc"..., 4096) = 276
3762  read(4, "", 4096)                 = 0
3762  close(4)                          = 0
3762  munmap(0x40128000, 4096)          = 0
3762  oldumount("/boot/")               = 0
3762  lstat("/etc/mtab", {st_mode=S_IFREG|0644, st_size=276, ...}) = 0
3762  open("/etc/mtab", O_RDWR|O_CREAT, 0644) = 4
3762  close(4)                          = 0
3762  rt_sigaction(SIGHUP, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGINT, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGQUIT, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGILL, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGTRAP, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGABRT, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGBUS, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGFPE, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGKILL, {0x804af20, ~[], 0x4000000}, NULL, 8) = -1 EINVAL 
(Invalid argument)
3762  rt_sigaction(SIGUSR1, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGSEGV, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGUSR2, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGPIPE, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGALRM, {0x804af50, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGTERM, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  rt_sigaction(SIGSTKFLT, {0x804af20, ~[], 0x4000000}, NULL, 8) = 0
3762  getpid()                          = 3762

----------------------------------------------------------------------------------------------------

3762  open("/etc/mtab~3762", O_WRONLY|O_CREAT, 0) = 4
3762  close(4)                          = 0
3762  link("/etc/mtab~3762", "/etc/mtab~") = -1 ENOENT (No such file or 
directory)
3762  unlink("/etc/mtab~3762")          = 0

------------------------------------------------------------------------------------------------------

[....]
3762  open("/share/locale/de/LC_MESSAGES/libc.mo", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0644, st_size=94208, ...}) = 0
3762  mmap(NULL, 94208, PROT_READ, MAP_PRIVATE, 4, 0) = 0x40128000
3762  close(4)                          = 0
[...]
3762  open("/usr/share/locale/de/LC_MESSAGES/util-linux.mo", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0644, st_size=174815, ...}) = 0
3762  mmap(NULL, 174815, PROT_READ, MAP_PRIVATE, 4, 0) = 0x4013f000
3762  close(4)                          = 0
3762  lstat("/lib", {st_mode=S_IFDIR|0555, st_size=5384, ...}) = 0
3762  lstat("/lib/gconv", {st_mode=S_IFLNK|0777, st_size=10, ...}) = 0
3762  readlink("/lib/gconv", "/usr/gconv", 4095) = 10
3762  lstat("/usr", {st_mode=S_IFDIR|0755, st_size=888, ...}) = 0
3762  lstat("/usr/gconv", {st_mode=S_IFDIR|0555, st_size=3817, ...}) = 0
3762  open("/usr/gconv/gconv-modules", O_RDONLY) = 4
3762  SYS_197(0x4, 0xbfffb3c4, 0x4010e3a0, 0x80544d8, 0x4) = 0
3762  mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0x4016a000
3762  read(4, "# GNU libc iconv configuration.\n"..., 4096) = 4096
3762  brk(0x8056000)                    = 0x8056000
3762  read(4, "20-1969-RO//\nmodule\tJIS_C6220-19"..., 4096) = 4096
3762  brk(0x8057000)                    = 0x8057000
3762  brk(0x8058000)                    = 0x8058000
3762  brk(0x8059000)                    = 0x8059000
3762  read(4, "RNAL\t\tISO8859-3\t1\nmodule\tINTERNA"..., 4096) = 4096
3762  brk(0x805a000)                    = 0x805a000
3762  brk(0x805b000)                    = 0x805b000
3762  read(4, "SO_6937-2\t1\n\n#\tfrom\t\t\tto\t\t\tmodul"..., 4096) = 4096
3762  brk(0x805c000)                    = 0x805c000
3762  brk(0x805d000)                    = 0x805d000
3762  read(4, "M256//\nmodule\tIBM256//\t\tINTERNAL"..., 4096) = 4096
3762  brk(0x805e000)                    = 0x805e000
3762  brk(0x805f000)                    = 0x805f000
3762  read(4, "module\t\tcost\nalias\tCP855//\t\t\tIBM"..., 4096) = 4096
3762  brk(0x8060000)                    = 0x8060000
3762  brk(0x8061000)                    = 0x8061000
3762  brk(0x8062000)                    = 0x8062000
3762  read(4, "IBM1004//\nalias\tOS2LATIN1//\t\tIBM"..., 4096) = 4096
3762  brk(0x8063000)                    = 0x8063000
3762  brk(0x8064000)                    = 0x8064000
3762  read(4, "_P27-1\t1\nmodule\tINTERNAL\t\tIEC_P2"..., 4096) = 4096
3762  brk(0x8065000)                    = 0x8065000
3762  brk(0x8066000)                    = 0x8066000
3762  read(4, "le\tINTERNAL\t\tNATS-DANO//\t\tNATS-D"..., 4096) = 4096
3762  brk(0x8067000)                    = 0x8067000
3762  brk(0x8068000)                    = 0x8068000
3762  read(4, "", 4096)                 = 0
3762  close(4)                          = 0
3762  munmap(0x4016a000, 4096)          = 0
3762  open("/usr/gconv/ISO8859-1.so", O_RDONLY) = 4
3762  fstat(4, {st_mode=S_IFREG|0755, st_size=32768, ...}) = 0
3762  read(4, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\6\0"..., 
4096) = 4096
3762  mmap(NULL, 7304, PROT_READ|PROT_EXEC, MAP_PRIVATE, 4, 0) = 0x4016a000
3762  mprotect(0x4016b000, 3208, PROT_NONE) = 0
3762  mmap(0x4016b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 4, 
0) = 0x4016b000
3762  close(4)                          = 0
3762  write(2, "Verkn\374pfung f\374r die Lock-Datei /"..., 160) = 160
3762  write(2, "\n", 1)                 = 1
3762  _exit(16)                         = ?


You can sometimes get rid of the problem, if you do a unmount and mount of 
the affected partition.
The problem is on local filesystems as well as on nfs-mounted filesystems 
(which resides on the server on reiserfs too).
If the problem is on a nfs-mounted FS, you can see, that in the original FS 
the file can be stat'ed without any problem (using telnet or ssh e.g.).

I've got no problems with 2.4.4ac9 (I didn't use the patches 10-14).

Versions:
Linux athlon 2.4.4-ac16 #1 Don Mai 24 22:47:31 CEST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.76.1
binutils               2.9.5.0.12
util-linux             2.10s
mount                  2.10s
modutils               2.4.5
e2fsprogs              1.19
PPP                    2.4.0b1
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.2
Net-tools              1.56
Kbd                    0.96
Sh-utils               2.0g
Modules Loaded         ext2 nfs lockd sunrpc 8139too sis900 serial parport_pc 
lp parport unix

I'm using reiserfs, 3.5.x disk format.


Regards,
Andreas Hartmann
