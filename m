Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbTCGAQb>; Thu, 6 Mar 2003 19:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbTCGAQb>; Thu, 6 Mar 2003 19:16:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3082 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261319AbTCGAQM>;
	Thu, 6 Mar 2003 19:16:12 -0500
Date: Thu, 6 Mar 2003 16:16:55 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] klibc for 2.5.64 - try 2
Message-ID: <20030307001655.GB13766@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   
Here's a series of changesets that add klibc support to the 2.5.64
kernel.  The only change since the last time I sent this is an addition
of a LICENSE file to the klibc directory, and a merge with your latest
bk tree.

Please pull from:
        bk://kernel.bkbits.net/gregkh/linux/klibc-2.5
  
If you have any problems or questions with them, please let me know.

I've attached a short changelog of the different things in this
repository below, along with a diffstat of the resulting changes

Note, the Cset exclude is for Kai's cset that moved mounting of the root
fs into userspace, we can start making those kind of changes later.  The
only changes here is to add klibc to the build, and add a small example
program to the initramfs image that gets unpacked at boot time and run.

I've also placed a patch of all of this, against a clean 2.5.64 kernel
at:
	kernel.org/pub/linux/kernel/people/gregkh/klibc/klibc-2.5.64.patch.gz
for those who don't want to use BitKeeper.

thanks,

greg k-h

--------------
Changes from your bk tree:

Arnd Bergmann <arnd@bergmann-dalldorf.de>:
  o KLIBC: fix for non-i386 build

Arnd Bergmann <arndb@de.ibm.com>:
  o klibc: gen_init_cpio file generation fix

Greg Kroah-Hartman <greg@kroah.com>:
  o KLIBC: added LICENSE file for klibc portion
  o Cset exclude: kai@tp1.ruhr-uni-bochum.de|ChangeSet|20030217001132|22043
  o KLIBC: fix up some type errors that were highlighted by the posix timer changes
  o KLIBC: delete usr/root/hello
  o klibc: add file support to gen_init_cpio.c
  o klibc: fix up the hello_world example

Kai Germaschewski <kai-germaschewski@uiowa.edu>:
  o klibc make clean

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o klibc: Move mounting of the root filesystem into userspace
  o klibc: Silence too ambitious warnings
  o klibc: Stop on error when building the CPIO
  o klibc: Fix the "hello" example (for real)
  o klibc: Fix a compiler warning
  o kbuild/klibc: Integrate klibc into the build
  o klibc: Merge klibc-0.77

-------------
Diffstat:

 Makefile                                        |   37 
 scripts/Makefile.build                          |    6 
 scripts/Makefile.clean                          |   11 
 scripts/Makefile.lib                            |    3 
 scripts/Makefile.user                           |  209 +
 usr/Makefile                                    |   40 
 usr/gen_init_cpio.c                             |   91 
 usr/lib/CAVEATS                                 |   51 
 usr/lib/LICENSE                                 |   73 
 usr/lib/MCONFIG                                 |   48 
 usr/lib/Makefile                                |  141 
 usr/lib/README                                  |   57 
 usr/lib/SOCKETCALLS                             |   21 
 usr/lib/SYSCALLS                                |  146 
 usr/lib/__shared_init.c                         |   56 
 usr/lib/__signal.c                              |   22 
 usr/lib/__static_init.c                         |   40 
 usr/lib/abort.c                                 |   19 
 usr/lib/alarm.c                                 |   29 
 usr/lib/arch/README                             |   67 
 usr/lib/arch/alpha/MCONFIG                      |   17 
 usr/lib/arch/alpha/Makefile.inc                 |   93 
 usr/lib/arch/alpha/README-gcc                   |   23 
 usr/lib/arch/alpha/crt0.S                       |   21 
 usr/lib/arch/alpha/divide.c                     |   57 
 usr/lib/arch/alpha/include/klibc/archsetjmp.h   |   24 
 usr/lib/arch/alpha/include/klibc/archsys.h      |   53 
 usr/lib/arch/alpha/include/machine/asm.h        |   44 
 usr/lib/arch/alpha/pipe.c                       |   28 
 usr/lib/arch/alpha/setjmp.S                     |   61 
 usr/lib/arch/arm/MCONFIG                        |   26 
 usr/lib/arch/arm/Makefile.inc                   |   31 
 usr/lib/arch/arm/crt0.S                         |   25 
 usr/lib/arch/arm/include/klibc/archsetjmp.h     |   14 
 usr/lib/arch/arm/include/klibc/archsys.h        |   12 
 usr/lib/arch/arm/setjmp-arm.S                   |   40 
 usr/lib/arch/arm/setjmp-thumb.S                 |   58 
 usr/lib/arch/cris/MCONFIG                       |   11 
 usr/lib/arch/cris/Makefile.inc                  |   10 
 usr/lib/arch/cris/include/klibc/archsys.h       |   12 
 usr/lib/arch/i386/MCONFIG                       |   24 
 usr/lib/arch/i386/Makefile.inc                  |   27 
 usr/lib/arch/i386/crt0.S                        |   33 
 usr/lib/arch/i386/exits.S                       |   45 
 usr/lib/arch/i386/include/klibc/archsetjmp.h    |   19 
 usr/lib/arch/i386/include/klibc/archsys.h       |   96 
 usr/lib/arch/i386/include/klibc/diverr.h        |   16 
 usr/lib/arch/i386/libgcc/__ashldi3.S            |   29 
 usr/lib/arch/i386/libgcc/__ashrdi3.S            |   29 
 usr/lib/arch/i386/libgcc/__lshrdi3.S            |   29 
 usr/lib/arch/i386/libgcc/__muldi3.S             |   34 
 usr/lib/arch/i386/libgcc/__negdi2.S             |   21 
 usr/lib/arch/i386/setjmp.S                      |   58 
 usr/lib/arch/i386/socketcall.S                  |   38 
 usr/lib/arch/ia64/MCONFIG                       |   11 
 usr/lib/arch/ia64/Makefile.inc                  |   10 
 usr/lib/arch/ia64/include/klibc/archsys.h       |   12 
 usr/lib/arch/m68k/MCONFIG                       |   11 
 usr/lib/arch/m68k/Makefile.inc                  |   10 
 usr/lib/arch/m68k/include/klibc/archsys.h       |   12 
 usr/lib/arch/mips/MCONFIG                       |   18 
 usr/lib/arch/mips/Makefile.inc                  |   24 
 usr/lib/arch/mips/crt0.S                        |   25 
 usr/lib/arch/mips/include/klibc/archsetjmp.h    |   39 
 usr/lib/arch/mips/include/klibc/archsys.h       |   12 
 usr/lib/arch/mips/include/machine/asm.h         |   11 
 usr/lib/arch/mips/include/sgidefs.h             |   20 
 usr/lib/arch/mips/pipe.S                        |   16 
 usr/lib/arch/mips/setjmp.S                      |   82 
 usr/lib/arch/mips/vfork.S                       |   19 
 usr/lib/arch/mips64/MCONFIG                     |   11 
 usr/lib/arch/mips64/Makefile.inc                |   10 
 usr/lib/arch/mips64/include/klibc/archsys.h     |   12 
 usr/lib/arch/parisc/MCONFIG                     |   11 
 usr/lib/arch/parisc/Makefile.inc                |   10 
 usr/lib/arch/parisc/include/klibc/archsys.h     |   12 
 usr/lib/arch/ppc/MCONFIG                        |   11 
 usr/lib/arch/ppc/Makefile.inc                   |   15 
 usr/lib/arch/ppc/crt0.S                         |   29 
 usr/lib/arch/ppc/include/klibc/archsetjmp.h     |   36 
 usr/lib/arch/ppc/include/klibc/archsys.h        |   55 
 usr/lib/arch/ppc/setjmp.S                       |   35 
 usr/lib/arch/ppc64/MCONFIG                      |   11 
 usr/lib/arch/ppc64/Makefile.inc                 |   10 
 usr/lib/arch/ppc64/crt0.S                       |   38 
 usr/lib/arch/ppc64/include/klibc/archsys.h      |   52 
 usr/lib/arch/s390/MCONFIG                       |   13 
 usr/lib/arch/s390/Makefile.inc                  |   16 
 usr/lib/arch/s390/crt0.S                        |   25 
 usr/lib/arch/s390/include/klibc/archsetjmp.h    |   15 
 usr/lib/arch/s390/include/klibc/archsys.h       |   41 
 usr/lib/arch/s390/setjmp.S                      |   32 
 usr/lib/arch/s390x/MCONFIG                      |   13 
 usr/lib/arch/s390x/Makefile.inc                 |   16 
 usr/lib/arch/s390x/crt0.S                       |   21 
 usr/lib/arch/s390x/include/klibc/archsetjmp.h   |   15 
 usr/lib/arch/s390x/include/klibc/archsys.h      |   41 
 usr/lib/arch/s390x/setjmp.S                     |   36 
 usr/lib/arch/sh/MCONFIG                         |   11 
 usr/lib/arch/sh/Makefile.inc                    |   10 
 usr/lib/arch/sh/include/klibc/archsys.h         |   12 
 usr/lib/arch/sparc/MCONFIG                      |   18 
 usr/lib/arch/sparc/Makefile.inc                 |   44 
 usr/lib/arch/sparc/crt0.S                       |    2 
 usr/lib/arch/sparc/crt0i.S                      |  100 
 usr/lib/arch/sparc/divrem.m4                    |  276 +
 usr/lib/arch/sparc/include/klibc/archsetjmp.h   |   16 
 usr/lib/arch/sparc/include/klibc/archsys.h      |   65 
 usr/lib/arch/sparc/include/machine/asm.h        |  192 +
 usr/lib/arch/sparc/include/machine/frame.h      |  138 
 usr/lib/arch/sparc/include/machine/trap.h       |  141 
 usr/lib/arch/sparc/setjmp.S                     |   38 
 usr/lib/arch/sparc/smul.S                       |  160 
 usr/lib/arch/sparc/umul.S                       |  193 +
 usr/lib/arch/sparc64/MCONFIG                    |   21 
 usr/lib/arch/sparc64/Makefile.inc               |   13 
 usr/lib/arch/sparc64/crt0.S                     |    2 
 usr/lib/arch/sparc64/include/klibc/archsetjmp.h |   16 
 usr/lib/arch/sparc64/include/klibc/archsys.h    |  157 
 usr/lib/arch/sparc64/setjmp.S                   |   55 
 usr/lib/arch/x86_64/MCONFIG                     |   16 
 usr/lib/arch/x86_64/Makefile.inc                |   16 
 usr/lib/arch/x86_64/crt0.S                      |   22 
 usr/lib/arch/x86_64/exits.S                     |   35 
 usr/lib/arch/x86_64/include/klibc/archsetjmp.h  |   21 
 usr/lib/arch/x86_64/include/klibc/archsys.h     |   32 
 usr/lib/arch/x86_64/setjmp.S                    |   54 
 usr/lib/assert.c                                |   13 
 usr/lib/atexit.c                                |   10 
 usr/lib/atexit.h                                |   19 
 usr/lib/atoi.c                                  |    3 
 usr/lib/atol.c                                  |    3 
 usr/lib/atoll.c                                 |    3 
 usr/lib/atox.c                                  |   14 
 usr/lib/brk.c                                   |   24 
 usr/lib/bsd_signal.c                            |   11 
 usr/lib/calloc.c                                |   21 
 usr/lib/closelog.c                              |   18 
 usr/lib/creat.c                                 |   12 
 usr/lib/ctypes.c                                |  281 +
 usr/lib/exec_l.c                                |   57 
 usr/lib/execl.c                                 |    8 
 usr/lib/execle.c                                |    8 
 usr/lib/execlp.c                                |    8 
 usr/lib/execlpe.c                               |    8 
 usr/lib/execv.c                                 |   13 
 usr/lib/execvp.c                                |   13 
 usr/lib/execvpe.c                               |   73 
 usr/lib/exitc.c                                 |   36 
 usr/lib/fdatasync.c                             |   15 
 usr/lib/fgetc.c                                 |   20 
 usr/lib/fgets.c                                 |   33 
 usr/lib/fopen.c                                 |   46 
 usr/lib/fork.c                                  |   29 
 usr/lib/fprintf.c                               |   19 
 usr/lib/fputc.c                                 |   14 
 usr/lib/fputs.c                                 |   15 
 usr/lib/fread.c                                 |   35 
 usr/lib/fread2.c                                |   13 
 usr/lib/fwrite.c                                |   35 
 usr/lib/fwrite2.c                               |   13 
 usr/lib/getcwd.c                                |   15 
 usr/lib/getdomainname.c                         |   25 
 usr/lib/getenv.c                                |   22 
 usr/lib/gethostname.c                           |   25 
 usr/lib/getopt.c                                |   74 
 usr/lib/getpriority.c                           |   25 
 usr/lib/globals.c                               |   10 
 usr/lib/include/alloca.h                        |   13 
 usr/lib/include/arpa/inet.h                     |   24 
 usr/lib/include/assert.h                        |   22 
 usr/lib/include/bits32/bitsize/limits.h         |   14 
 usr/lib/include/bits32/bitsize/stddef.h         |   18 
 usr/lib/include/bits32/bitsize/stdint.h         |   34 
 usr/lib/include/bits32/bitsize/stdintconst.h    |   18 
 usr/lib/include/bits32/bitsize/stdintlimits.h   |   22 
 usr/lib/include/bits64/bitsize/limits.h         |   14 
 usr/lib/include/bits64/bitsize/stddef.h         |   13 
 usr/lib/include/bits64/bitsize/stdint.h         |   36 
 usr/lib/include/bits64/bitsize/stdintconst.h    |   18 
 usr/lib/include/bits64/bitsize/stdintlimits.h   |   22 
 usr/lib/include/ctype.h                         |  117 
 usr/lib/include/dirent.h                        |   20 
 usr/lib/include/elf.h                           |   12 
 usr/lib/include/endian.h                        |   41 
 usr/lib/include/errno.h                         |    8 
 usr/lib/include/fcntl.h                         |   11 
 usr/lib/include/grp.h                           |   13 
 usr/lib/include/inttypes.h                      |  226 +
 usr/lib/include/klibc/compiler.h                |   61 
 usr/lib/include/klibc/diverr.h                  |   16 
 usr/lib/include/klibc/extern.h                  |   14 
 usr/lib/include/limits.h                        |   40 
 usr/lib/include/net/if.h                        |    1 
 usr/lib/include/net/if_arp.h                    |    1 
 usr/lib/include/net/if_ether.h                  |    1 
 usr/lib/include/net/if_packet.h                 |    1 
 usr/lib/include/netinet/in.h                    |   29 
 usr/lib/include/netinet/in6.h                   |   10 
 usr/lib/include/netinet/ip.h                    |   13 
 usr/lib/include/netinet/tcp.h                   |   11 
 usr/lib/include/netinet/udp.h                   |   19 
 usr/lib/include/poll.h                          |   16 
 usr/lib/include/sched.h                         |   23 
 usr/lib/include/setjmp.h                        |   43 
 usr/lib/include/signal.h                        |   72 
 usr/lib/include/stdarg.h                        |   14 
 usr/lib/include/stddef.h                        |   24 
 usr/lib/include/stdint.h                        |  113 
 usr/lib/include/stdio.h                         |  109 
 usr/lib/include/stdlib.h                        |   94 
 usr/lib/include/string.h                        |   37 
 usr/lib/include/sys/dirent.h                    |   13 
 usr/lib/include/sys/fsuid.h                     |   14 
 usr/lib/include/sys/ioctl.h                     |   14 
 usr/lib/include/sys/klog.h                      |   24 
 usr/lib/include/sys/mman.h                      |   21 
 usr/lib/include/sys/module.h                    |  158 
 usr/lib/include/sys/mount.h                     |   55 
 usr/lib/include/sys/param.h                     |   11 
 usr/lib/include/sys/reboot.h                    |   25 
 usr/lib/include/sys/resource.h                  |   15 
 usr/lib/include/sys/select.h                    |   13 
 usr/lib/include/sys/socket.h                    |   50 
 usr/lib/include/sys/socketcalls.h               |   28 
 usr/lib/include/sys/stat.h                      |   23 
 usr/lib/include/sys/syscall.h                   |   15 
 usr/lib/include/sys/time.h                      |   16 
 usr/lib/include/sys/times.h                     |   14 
 usr/lib/include/sys/types.h                     |  127 
 usr/lib/include/sys/uio.h                       |   15 
 usr/lib/include/sys/utime.h                     |   10 
 usr/lib/include/sys/utsname.h                   |   23 
 usr/lib/include/sys/vfs.h                       |   14 
 usr/lib/include/sys/wait.h                      |   19 
 usr/lib/include/syslog.h                        |   53 
 usr/lib/include/termios.h                       |   86 
 usr/lib/include/time.h                          |   14 
 usr/lib/include/unistd.h                        |  106 
 usr/lib/include/utime.h                         |   15 
 usr/lib/inet/inet_addr.c                        |   14 
 usr/lib/inet/inet_aton.c                        |   23 
 usr/lib/inet/inet_ntoa.c                        |   19 
 usr/lib/inet/inet_ntop.c                        |   52 
 usr/lib/inet/inet_pton.c                        |   74 
 usr/lib/interp.S                                |   11 
 usr/lib/isatty.c                                |   21 
 usr/lib/libgcc/__divdi3.c                       |   29 
 usr/lib/libgcc/__divsi3.c                       |   29 
 usr/lib/libgcc/__moddi3.c                       |   29 
 usr/lib/libgcc/__modsi3.c                       |   29 
 usr/lib/libgcc/__udivdi3.c                      |   13 
 usr/lib/libgcc/__udivmoddi4.c                   |   32 
 usr/lib/libgcc/__udivmodsi4.c                   |   32 
 usr/lib/libgcc/__udivsi3.c                      |   13 
 usr/lib/libgcc/__umoddi3.c                      |   16 
 usr/lib/libgcc/__umodsi3.c                      |   16 
 usr/lib/llseek.c                                |   34 
 usr/lib/lrand48.c                               |   42 
 usr/lib/makeerrlist.pl                          |   80 
 usr/lib/malloc.c                                |  192 +
 usr/lib/malloc.h                                |   51 
 usr/lib/memccpy.c                               |   23 
 usr/lib/memchr.c                                |   18 
 usr/lib/memcmp.c                                |   19 
 usr/lib/memcpy.c                                |   29 
 usr/lib/memmem.c                                |   44 
 usr/lib/memmove.c                               |   34 
 usr/lib/memset.c                                |   30 
 usr/lib/memswap.c                               |   23 
 usr/lib/mmap.c                                  |   51 
 usr/lib/nice.c                                  |   22 
 usr/lib/onexit.c                                |   39 
 usr/lib/pause.c                                 |   21 
 usr/lib/perror.c                                |   12 
 usr/lib/printf.c                                |   19 
 usr/lib/pty.c                                   |   31 
 usr/lib/puts.c                                  |   13 
 usr/lib/qsort.c                                 |   42 
 usr/lib/raise.c                                 |   11 
 usr/lib/readdir.c                               |   66 
 usr/lib/realloc.c                               |   49 
 usr/lib/reboot.c                                |   15 
 usr/lib/recv.c                                  |   11 
 usr/lib/sbrk.c                                  |   23 
 usr/lib/seed48.c                                |   19 
 usr/lib/select.c                                |    9 
 usr/lib/send.c                                  |   11 
 usr/lib/setegid.c                               |   10 
 usr/lib/setenv.c                                |  124 
 usr/lib/seteuid.c                               |   10 
 usr/lib/setpgrp.c                               |   10 
 usr/lib/setresgid.c                             |   29 
 usr/lib/setresuid.c                             |   30 
 usr/lib/sha1hash.c                              |  317 +
 usr/lib/sigaction.c                             |   19 
 usr/lib/siglist.c                               |  115 
 usr/lib/siglongjmp.c                            |   16 
 usr/lib/signal.c                                |   11 
 usr/lib/sigpending.c                            |   19 
 usr/lib/sigprocmask.c                           |   19 
 usr/lib/sigsuspend.c                            |   19 
 usr/lib/sleep.c                                 |   20 
 usr/lib/snprintf.c                              |   16 
 usr/lib/socketcalls.pl                          |   67 
 usr/lib/socketcalls/socketcommon.h              |   25 
 usr/lib/sprintf.c                               |   18 
 usr/lib/srand48.c                               |   16 
 usr/lib/sscanf.c                                |   17 
 usr/lib/strcat.c                                |   11 
 usr/lib/strchr.c                                |   16 
 usr/lib/strcmp.c                                |   20 
 usr/lib/strcpy.c                                |   20 
 usr/lib/strdup.c                                |   17 
 usr/lib/strerror.c                              |   25 
 usr/lib/strlen.c                                |   14 
 usr/lib/strncat.c                               |   11 
 usr/lib/strncmp.c                               |   20 
 usr/lib/strncpy.c                               |   22 
 usr/lib/strntoimax.c                            |   13 
 usr/lib/strntoumax.c                            |   75 
 usr/lib/strrchr.c                               |   18 
 usr/lib/strsep.c                                |   21 
 usr/lib/strspn.c                                |   67 
 usr/lib/strstr.c                                |   10 
 usr/lib/strtoimax.c                             |    3 
 usr/lib/strtok.c                                |   16 
 usr/lib/strtol.c                                |    3 
 usr/lib/strtoll.c                               |    3 
 usr/lib/strtoul.c                               |    3 
 usr/lib/strtoull.c                              |    3 
 usr/lib/strtoumax.c                             |    3 
 usr/lib/strtox.c                                |   13 
 usr/lib/syscalls.pl                             |   78 
 usr/lib/syscalls/syscommon.h                    |   29 
 usr/lib/syslog.c                                |   68 
 usr/lib/tests/getenvtest.c                      |   26 
 usr/lib/tests/getopttest.c                      |   31 
 usr/lib/tests/hello.c                           |    7 
 usr/lib/tests/idtest.c                          |   14 
 usr/lib/tests/malloctest.c                      | 4145 ++++++++++++++++++++++++
 usr/lib/tests/memstrtest.c                      |   29 
 usr/lib/tests/microhello.c                      |    9 
 usr/lib/tests/minihello.c                       |    7 
 usr/lib/tests/minips.c                          |  452 ++
 usr/lib/tests/nfs_no_rpc.c                      |  538 +++
 usr/lib/tests/setjmptest.c                      |   36 
 usr/lib/tests/testrand48.c                      |   19 
 usr/lib/tests/testvsnp.c                        |  115 
 usr/lib/time.c                                  |   27 
 usr/lib/umount.c                                |   12 
 usr/lib/unsetenv.c                              |   40 
 usr/lib/usleep.c                                |   15 
 usr/lib/utime.c                                 |   30 
 usr/lib/vfprintf.c                              |   26 
 usr/lib/vprintf.c                               |   11 
 usr/lib/vsnprintf.c                             |  433 ++
 usr/lib/vsprintf.c                              |   11 
 usr/lib/vsscanf.c                               |  365 ++
 usr/lib/wait.c                                  |   12 
 usr/lib/wait3.c                                 |   12 
 usr/lib/waitpid.c                               |   12 
 usr/root/Makefile                               |    3 
 usr/root/hello.c                                |   13 
 364 files changed, 18288 insertions(+), 9 deletions(-)
