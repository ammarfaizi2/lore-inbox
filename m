Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266435AbTBQC4j>; Sun, 16 Feb 2003 21:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTBQC4j>; Sun, 16 Feb 2003 21:56:39 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:52409 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S266435AbTBQC42>; Sun, 16 Feb 2003 21:56:28 -0500
Date: Sun, 16 Feb 2003 21:06:09 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] klibc for 2.5.59 bk
In-Reply-To: <20030209125759.GA14981@kroah.com>
Message-ID: <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Greg KH wrote:

> > Greg KH, Fri, Feb 07, 2003 05:59:19 +0100:
> > > Hi all,
> > > 
> > > Thanks to Arnd Bergmann, it looks like the klibc and initramfs code is
> > > now working.  I've created a patch against Linus's latest bk tree and
> > > put it at:
> > > 	http://www.kroah.com/linux/klibc/klibc-2.5.59-2.patch.gz
> > 
> > was the following part of the patch intended? (hello_world?)
> 
> Yes it was.  It shows how to add a binary file to the initramfs image,
> and have it executed by the kernel during the early boot process.
> 
> The fact that the program didn't really do anything significant isn't
> important here.

I did some work on integrating klibc into kbuild now. I used your patch as 
guide line, though I started from scratch with klibc-0.77. The build 
should work fine (reminder: "make KBUILD_VERBOSE=0 ..." will give you much 
more readable output), but I probably broke some non-x86 architectures 
in the process.

To do something more useful than "hello world", I actually moved some part 
of finding / mounting the final root system into userspace, though only 
conditional on CONFIG_INITRAMFS.

My tree is at 

	Pull from http://linux-isdn.bkbits.net/linux-2.5.klibc

If people want a GNU patch, I can mail that privately, it was too large to 
attach it here.

--Kai


-----------------------------------------------------------------------------
ChangeSet@1.1027.1.2, 2003-02-15 16:55:46-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Merge klibc-0.77
  
  That's just a cp -r klibc-0.77/klibc/* linux/usr/lib

 ----------------------------------------------------------------------------
 CAVEATS                                 |   51 
 MCONFIG                                 |   49 
 Makefile                                |  134 +
 README                                  |   57 
 SOCKETCALLS                             |   21 
 SYSCALLS                                |  146 +
 __shared_init.c                         |   56 
 __signal.c                              |   22 
 __static_init.c                         |   40 
 abort.c                                 |   19 
 alarm.c                                 |   29 
 arch/README                             |   67 
 arch/alpha/MCONFIG                      |   17 
 arch/alpha/Makefile.inc                 |   93 
 arch/alpha/README-gcc                   |   23 
 arch/alpha/crt0.S                       |   21 
 arch/alpha/divide.c                     |   57 
 arch/alpha/include/klibc/archsetjmp.h   |   24 
 arch/alpha/include/klibc/archsys.h      |   53 
 arch/alpha/include/machine/asm.h        |   44 
 arch/alpha/pipe.c                       |   28 
 arch/alpha/setjmp.S                     |   61 
 arch/arm/MCONFIG                        |   26 
 arch/arm/Makefile.inc                   |   31 
 arch/arm/crt0.S                         |   25 
 arch/arm/include/klibc/archsetjmp.h     |   14 
 arch/arm/include/klibc/archsys.h        |   12 
 arch/arm/setjmp-arm.S                   |   40 
 arch/arm/setjmp-thumb.S                 |   58 
 arch/cris/MCONFIG                       |   11 
 arch/cris/Makefile.inc                  |   10 
 arch/cris/include/klibc/archsys.h       |   12 
 arch/i386/MCONFIG                       |   24 
 arch/i386/Makefile.inc                  |   27 
 arch/i386/crt0.S                        |   33 
 arch/i386/exits.S                       |   45 
 arch/i386/include/klibc/archsetjmp.h    |   19 
 arch/i386/include/klibc/archsys.h       |   96 
 arch/i386/include/klibc/diverr.h        |   16 
 arch/i386/libgcc/__ashldi3.S            |   29 
 arch/i386/libgcc/__ashrdi3.S            |   29 
 arch/i386/libgcc/__lshrdi3.S            |   29 
 arch/i386/libgcc/__muldi3.S             |   34 
 arch/i386/libgcc/__negdi2.S             |   21 
 arch/i386/setjmp.S                      |   58 
 arch/i386/socketcall.S                  |   38 
 arch/ia64/MCONFIG                       |   11 
 arch/ia64/Makefile.inc                  |   10 
 arch/ia64/include/klibc/archsys.h       |   12 
 arch/m68k/MCONFIG                       |   11 
 arch/m68k/Makefile.inc                  |   10 
 arch/m68k/include/klibc/archsys.h       |   12 
 arch/mips/MCONFIG                       |   18 
 arch/mips/Makefile.inc                  |   24 
 arch/mips/crt0.S                        |   25 
 arch/mips/include/klibc/archsetjmp.h    |   39 
 arch/mips/include/klibc/archsys.h       |   12 
 arch/mips/include/machine/asm.h         |   11 
 arch/mips/include/sgidefs.h             |   20 
 arch/mips/pipe.S                        |   16 
 arch/mips/setjmp.S                      |   82 
 arch/mips/vfork.S                       |   19 
 arch/mips64/MCONFIG                     |   11 
 arch/mips64/Makefile.inc                |   10 
 arch/mips64/include/klibc/archsys.h     |   12 
 arch/parisc/MCONFIG                     |   11 
 arch/parisc/Makefile.inc                |   10 
 arch/parisc/include/klibc/archsys.h     |   12 
 arch/ppc/MCONFIG                        |   11 
 arch/ppc/Makefile.inc                   |   15 
 arch/ppc/crt0.S                         |   29 
 arch/ppc/include/klibc/archsetjmp.h     |   36 
 arch/ppc/include/klibc/archsys.h        |   55 
 arch/ppc/setjmp.S                       |   35 
 arch/ppc64/MCONFIG                      |   11 
 arch/ppc64/Makefile.inc                 |   10 
 arch/ppc64/crt0.S                       |   38 
 arch/ppc64/include/klibc/archsys.h      |   52 
 arch/s390/MCONFIG                       |   13 
 arch/s390/Makefile.inc                  |   16 
 arch/s390/crt0.S                        |   25 
 arch/s390/include/klibc/archsetjmp.h    |   15 
 arch/s390/include/klibc/archsys.h       |   41 
 arch/s390/setjmp.S                      |   32 
 arch/s390x/MCONFIG                      |   13 
 arch/s390x/Makefile.inc                 |   16 
 arch/s390x/crt0.S                       |   21 
 arch/s390x/include/klibc/archsetjmp.h   |   15 
 arch/s390x/include/klibc/archsys.h      |   41 
 arch/s390x/setjmp.S                     |   36 
 arch/sh/MCONFIG                         |   11 
 arch/sh/Makefile.inc                    |   10 
 arch/sh/include/klibc/archsys.h         |   12 
 arch/sparc/MCONFIG                      |   18 
 arch/sparc/Makefile.inc                 |   44 
 arch/sparc/crt0.S                       |    2 
 arch/sparc/crt0i.S                      |  100 
 arch/sparc/divrem.m4                    |  276 ++
 arch/sparc/include/klibc/archsetjmp.h   |   16 
 arch/sparc/include/klibc/archsys.h      |   65 
 arch/sparc/include/machine/asm.h        |  192 +
 arch/sparc/include/machine/frame.h      |  138 +
 arch/sparc/include/machine/trap.h       |  141 +
 arch/sparc/setjmp.S                     |   38 
 arch/sparc/smul.S                       |  160 +
 arch/sparc/umul.S                       |  193 +
 arch/sparc64/MCONFIG                    |   21 
 arch/sparc64/Makefile.inc               |   13 
 arch/sparc64/crt0.S                     |    2 
 arch/sparc64/include/klibc/archsetjmp.h |   16 
 arch/sparc64/include/klibc/archsys.h    |  157 +
 arch/sparc64/setjmp.S                   |   55 
 arch/x86_64/MCONFIG                     |   16 
 arch/x86_64/Makefile.inc                |   16 
 arch/x86_64/crt0.S                      |   22 
 arch/x86_64/exits.S                     |   35 
 arch/x86_64/include/klibc/archsetjmp.h  |   21 
 arch/x86_64/include/klibc/archsys.h     |   32 
 arch/x86_64/setjmp.S                    |   54 
 assert.c                                |   13 
 atexit.c                                |   10 
 atexit.h                                |   19 
 atoi.c                                  |    3 
 atol.c                                  |    3 
 atoll.c                                 |    3 
 atox.c                                  |   14 
 brk.c                                   |   24 
 bsd_signal.c                            |   11 
 calloc.c                                |   21 
 closelog.c                              |   18 
 creat.c                                 |   12 
 ctypes.c                                |  281 ++
 exec_l.c                                |   57 
 execl.c                                 |    8 
 execle.c                                |    8 
 execlp.c                                |    8 
 execlpe.c                               |    8 
 execv.c                                 |   13 
 execvp.c                                |   13 
 execvpe.c                               |   73 
 exitc.c                                 |   36 
 fdatasync.c                             |   15 
 fgetc.c                                 |   20 
 fgets.c                                 |   33 
 fopen.c                                 |   46 
 fork.c                                  |   29 
 fprintf.c                               |   19 
 fputc.c                                 |   14 
 fputs.c                                 |   15 
 fread.c                                 |   35 
 fread2.c                                |   13 
 fwrite.c                                |   35 
 fwrite2.c                               |   13 
 getcwd.c                                |   15 
 getdomainname.c                         |   25 
 getenv.c                                |   22 
 gethostname.c                           |   25 
 getopt.c                                |   74 
 getpriority.c                           |   25 
 globals.c                               |   10 
 include/alloca.h                        |   13 
 include/arpa/inet.h                     |   24 
 include/assert.h                        |   22 
 include/bits32/bitsize/limits.h         |   14 
 include/bits32/bitsize/stddef.h         |   18 
 include/bits32/bitsize/stdint.h         |   34 
 include/bits32/bitsize/stdintconst.h    |   18 
 include/bits32/bitsize/stdintlimits.h   |   22 
 include/bits64/bitsize/limits.h         |   14 
 include/bits64/bitsize/stddef.h         |   13 
 include/bits64/bitsize/stdint.h         |   36 
 include/bits64/bitsize/stdintconst.h    |   18 
 include/bits64/bitsize/stdintlimits.h   |   22 
 include/ctype.h                         |  117 
 include/dirent.h                        |   20 
 include/elf.h                           |   12 
 include/endian.h                        |   41 
 include/errno.h                         |    8 
 include/fcntl.h                         |   11 
 include/grp.h                           |   13 
 include/inttypes.h                      |  226 +
 include/klibc/compiler.h                |   61 
 include/klibc/diverr.h                  |   16 
 include/klibc/extern.h                  |   14 
 include/limits.h                        |   40 
 include/net/if.h                        |    1 
 include/net/if_arp.h                    |    1 
 include/net/if_ether.h                  |    1 
 include/net/if_packet.h                 |    1 
 include/netinet/in.h                    |   29 
 include/netinet/in6.h                   |   10 
 include/netinet/ip.h                    |   13 
 include/netinet/tcp.h                   |   11 
 include/netinet/udp.h                   |   19 
 include/poll.h                          |   16 
 include/sched.h                         |   23 
 include/setjmp.h                        |   43 
 include/signal.h                        |   72 
 include/stdarg.h                        |   14 
 include/stddef.h                        |   24 
 include/stdint.h                        |  113 
 include/stdio.h                         |  109 
 include/stdlib.h                        |   94 
 include/string.h                        |   37 
 include/sys/dirent.h                    |   13 
 include/sys/fsuid.h                     |   14 
 include/sys/ioctl.h                     |   14 
 include/sys/klog.h                      |   24 
 include/sys/mman.h                      |   21 
 include/sys/module.h                    |  158 +
 include/sys/mount.h                     |   55 
 include/sys/param.h                     |   11 
 include/sys/reboot.h                    |   25 
 include/sys/resource.h                  |   15 
 include/sys/select.h                    |   13 
 include/sys/socket.h                    |   50 
 include/sys/socketcalls.h               |   28 
 include/sys/stat.h                      |   23 
 include/sys/syscall.h                   |   15 
 include/sys/time.h                      |   16 
 include/sys/times.h                     |   14 
 include/sys/types.h                     |  126 
 include/sys/uio.h                       |   15 
 include/sys/utime.h                     |   10 
 include/sys/utsname.h                   |   23 
 include/sys/vfs.h                       |   14 
 include/sys/wait.h                      |   19 
 include/syslog.h                        |   53 
 include/termios.h                       |   86 
 include/time.h                          |   14 
 include/unistd.h                        |  106 
 include/utime.h                         |   15 
 inet/inet_addr.c                        |   14 
 inet/inet_aton.c                        |   23 
 inet/inet_ntoa.c                        |   19 
 inet/inet_ntop.c                        |   52 
 inet/inet_pton.c                        |   74 
 interp.S                                |   11 
 isatty.c                                |   21 
 libgcc/__divdi3.c                       |   29 
 libgcc/__divsi3.c                       |   29 
 libgcc/__moddi3.c                       |   29 
 libgcc/__modsi3.c                       |   29 
 libgcc/__udivdi3.c                      |   13 
 libgcc/__udivmoddi4.c                   |   32 
 libgcc/__udivmodsi4.c                   |   32 
 libgcc/__udivsi3.c                      |   13 
 libgcc/__umoddi3.c                      |   16 
 libgcc/__umodsi3.c                      |   16 
 llseek.c                                |   34 
 lrand48.c                               |   42 
 makeerrlist.pl                          |   80 
 malloc.c                                |  192 +
 malloc.h                                |   51 
 memccpy.c                               |   23 
 memchr.c                                |   18 
 memcmp.c                                |   19 
 memcpy.c                                |   29 
 memmem.c                                |   44 
 memmove.c                               |   34 
 memset.c                                |   30 
 memswap.c                               |   23 
 mmap.c                                  |   51 
 nice.c                                  |   22 
 onexit.c                                |   39 
 pause.c                                 |   21 
 perror.c                                |   12 
 printf.c                                |   19 
 pty.c                                   |   31 
 puts.c                                  |   13 
 qsort.c                                 |   42 
 raise.c                                 |   11 
 readdir.c                               |   66 
 realloc.c                               |   49 
 reboot.c                                |   15 
 recv.c                                  |   11 
 sbrk.c                                  |   23 
 seed48.c                                |   19 
 select.c                                |    9 
 send.c                                  |   11 
 setegid.c                               |   10 
 setenv.c                                |  124 
 seteuid.c                               |   10 
 setpgrp.c                               |   10 
 setresgid.c                             |   29 
 setresuid.c                             |   30 
 sha1hash.c                              |  317 ++
 sigaction.c                             |   19 
 siglist.c                               |  115 
 siglongjmp.c                            |   16 
 signal.c                                |   11 
 sigpending.c                            |   19 
 sigprocmask.c                           |   19 
 sigsuspend.c                            |   19 
 sleep.c                                 |   20 
 snprintf.c                              |   16 
 socketcalls.pl                          |   62 
 socketcommon.h                          |   25 
 sprintf.c                               |   18 
 srand48.c                               |   16 
 sscanf.c                                |   17 
 strcat.c                                |   11 
 strchr.c                                |   16 
 strcmp.c                                |   20 
 strcpy.c                                |   20 
 strdup.c                                |   17 
 strerror.c                              |   25 
 strlen.c                                |   14 
 strncat.c                               |   11 
 strncmp.c                               |   20 
 strncpy.c                               |   22 
 strntoimax.c                            |   13 
 strntoumax.c                            |   75 
 strrchr.c                               |   18 
 strsep.c                                |   21 
 strspn.c                                |   67 
 strstr.c                                |   10 
 strtoimax.c                             |    3 
 strtok.c                                |   16 
 strtol.c                                |    3 
 strtoll.c                               |    3 
 strtoul.c                               |    3 
 strtoull.c                              |    3 
 strtoumax.c                             |    3 
 strtox.c                                |   13 
 syscalls.pl                             |   72 
 syscommon.h                             |   29 
 syslog.c                                |   68 
 tests/getenvtest.c                      |   26 
 tests/getopttest.c                      |   31 
 tests/hello.c                           |    7 
 tests/idtest.c                          |   14 
 tests/malloctest.c                      | 4145 ++++++++++++++++++++++++++++++++
 tests/memstrtest.c                      |   29 
 tests/microhello.c                      |    9 
 tests/minihello.c                       |    7 
 tests/minips.c                          |  452 +++
 tests/nfs_no_rpc.c                      |  538 ++++
 tests/setjmptest.c                      |   36 
 tests/testrand48.c                      |   19 
 tests/testvsnp.c                        |  115 
 time.c                                  |   27 
 umount.c                                |   12 
 unsetenv.c                              |   40 
 usleep.c                                |   15 
 utime.c                                 |   30 
 vfprintf.c                              |   26 
 vprintf.c                               |   11 
 vsnprintf.c                             |  433 +++
 vsprintf.c                              |   11 
 vsscanf.c                               |  365 ++
 wait.c                                  |   12 
 wait3.c                                 |   12 
 waitpid.c                               |   12 
 354 files changed, 17793 insertions(+)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.3, 2003-02-15 23:09:41-06:00, kai@tp1.ruhr-uni-bochum.de
  kbuild/klibc: Integrate klibc into the build.
  
  Basically, add a scripts/Makefile.user, which does similar things to
  scripts/Makefile.build, but compiles userspace for the target instead.
  
  It's tested for a static klibc on i386, building the shared lib works, too,
  but is not further integrated.
  
  This patch also adds gregkh's hello test program, which works as well.

 ----------------------------------------------------------------------------
 b/Makefile                           |   39 ++++++
 b/scripts/Makefile.build             |    6 -
 b/scripts/Makefile.clean             |   11 +
 b/scripts/Makefile.lib               |    3 
 b/scripts/Makefile.user              |  209 +++++++++++++++++++++++++++++++++++
 b/usr/Makefile                       |   28 ++++
 b/usr/lib/MCONFIG                    |   39 +++---
 b/usr/lib/Makefile                   |  159 +++++++++++++-------------
 b/usr/lib/socketcalls.pl             |   11 +
 b/usr/lib/socketcalls/socketcommon.h |   25 ++++
 b/usr/lib/syscalls.pl                |   12 +-
 b/usr/lib/syscalls/syscommon.h       |   29 ++++
 b/usr/root/Makefile                  |    3 
 b/usr/root/hello                     |binary
 b/usr/root/hello.c                   |    8 +
 usr/lib/socketcommon.h               |   25 ----
 usr/lib/syscommon.h                  |   29 ----
 17 files changed, 471 insertions(+), 165 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.4, 2003-02-15 23:11:51-06:00, greg@kroah.com
  klibc: fix up the hello_world example
  
  stdout doesn't go anywhere useful when spawned from the kernel :)

 ----------------------------------------------------------------------------
 hello.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.5, 2003-02-15 23:16:53-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Fix a compiler warning

 ----------------------------------------------------------------------------
 sha1hash.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.6, 2003-02-15 23:20:13-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Fix the "hello" example (for real)
  
  Greg's fix used fwrite on a file descriptor obtained from open(), which
  only works by luck, since for klibc FILE * == fd.
  
  Use standard C lib functions for open/close.

 ----------------------------------------------------------------------------
 hello.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.7, 2003-02-15 23:21:47-06:00, greg@kroah.com
  klibc: add file support to gen_init_cpio.c

 ----------------------------------------------------------------------------
 gen_init_cpio.c |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.8, 2003-02-15 23:24:10-06:00, arndb@de.ibm.com
  klibc: gen_init_cpio file generation fix
  
  I found what kept initramfs from working here: While creating
  of initramfs_data.cpio.gz, the padding between a file header
  and the file contents was wrong, which can be verified by
  unpacking the archive by hand.

 ----------------------------------------------------------------------------
 gen_init_cpio.c |    1 +
 1 files changed, 1 insertion(+)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.9, 2003-02-15 23:33:21-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Stop on error when building the CPIO
  
  gen_init_cpio still referenced hello in usr/hello_world, but I put it
  into usr/root. This is now corrected, however it also pointed out the
  common problem that the error code of gen_init_cpio is ignored since
  it's output is piped to gzip. To fix that, make the generation of the
  .cpio.gz a two step process.

 ----------------------------------------------------------------------------
 Makefile        |   24 +++++++++++++++++-------
 gen_init_cpio.c |    2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.10, 2003-02-16 18:06:13-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Silence too ambitious warnings
  
  gcc complained about unused function parameters and things, that's just
  a little too much.

 ----------------------------------------------------------------------------
 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

-----------------------------------------------------------------------------
ChangeSet@1.1027.1.11, 2003-02-16 18:11:32-06:00, kai@tp1.ruhr-uni-bochum.de
  klibc: Move mounting of the root filesystem into userspace
  
  When selecting CONFIG_INITRAMFS, init/do_mounts.c is not compiled anymore,
  and it's task is taken over by a small /sbin/init running in initramfs.
  
  However, this is a proof of concept only, the userspace code only handles
  mounting a local filesystem, no support for nfs / initrd / devfs yet.

 ----------------------------------------------------------------------------
 init/Kconfig        |   10 +
 init/Makefile       |    7 
 init/do_mounts.c    |    6 
 init/main.c         |   22 ++
 scripts/Makefile    |    4 
 usr/Makefile        |    2 
 usr/gen_init_cpio.c |    2 
 usr/root/Makefile   |    5 
 usr/root/init.c     |  442 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 489 insertions(+), 11 deletions(-)





