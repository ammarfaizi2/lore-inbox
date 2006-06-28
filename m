Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423158AbWF1FSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423158AbWF1FSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWF1FSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:18:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:51149 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423153AbWF1FSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:18:16 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 03/31] Core klibc code
Date: Tue, 27 Jun 2006 22:17:03 -0700
Message-Id: <klibc.200606272217.03@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] Core klibc code

The actual klibc library.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 7e8269dfd52a48d7b5017a1aaac410e9656c8139
tree 765b566dc009f529c44a7351bd1896478b9a90bd
parent 6af9454fcd8dc22f657feff4f31923e3aa73c475
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:25 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:50:25 -0700

 usr/include/Kbuild                        |   11 +
 usr/include/alloca.h                      |   12 +
 usr/include/arpa/inet.h                   |   22 +
 usr/include/assert.h                      |   22 +
 usr/include/bits32/bitsize.h              |    3 
 usr/include/bits32/bitsize/limits.h       |   14 +
 usr/include/bits32/bitsize/stddef.h       |   18 +
 usr/include/bits32/bitsize/stdint.h       |   34 ++
 usr/include/bits32/bitsize/stdintconst.h  |   18 +
 usr/include/bits32/bitsize/stdintlimits.h |   22 +
 usr/include/bits64/bitsize.h              |    3 
 usr/include/bits64/bitsize/limits.h       |   14 +
 usr/include/bits64/bitsize/stddef.h       |   13 +
 usr/include/bits64/bitsize/stdint.h       |   34 ++
 usr/include/bits64/bitsize/stdintconst.h  |   18 +
 usr/include/bits64/bitsize/stdintlimits.h |   22 +
 usr/include/byteswap.h                    |   15 +
 usr/include/ctype.h                       |  140 ++++++++
 usr/include/dirent.h                      |   33 ++
 usr/include/elf.h                         |   11 +
 usr/include/endian.h                      |   15 +
 usr/include/errno.h                       |   13 +
 usr/include/fcntl.h                       |   47 +++
 usr/include/grp.h                         |   13 +
 usr/include/inttypes.h                    |  226 +++++++++++++
 usr/include/klibc/compiler.h              |  123 +++++++
 usr/include/klibc/diverr.h                |   15 +
 usr/include/klibc/endian.h                |   39 ++
 usr/include/klibc/extern.h                |   16 +
 usr/include/klibc/stathelp.h              |   24 +
 usr/include/klibc/sysconfig.h             |  166 ++++++++++
 usr/include/limits.h                      |   40 ++
 usr/include/malloc.h                      |   21 +
 usr/include/net/if.h                      |    7 
 usr/include/net/if_arp.h                  |    1 
 usr/include/net/if_packet.h               |    1 
 usr/include/net/route.h                   |    1 
 usr/include/netinet/if_ether.h            |    1 
 usr/include/netinet/in.h                  |   39 ++
 usr/include/netinet/in6.h                 |   10 +
 usr/include/netinet/ip.h                  |   13 +
 usr/include/netinet/tcp.h                 |   11 +
 usr/include/netinet/udp.h                 |   19 +
 usr/include/netpacket/packet.h            |    1 
 usr/include/paths.h                       |   74 ++++
 usr/include/poll.h                        |    1 
 usr/include/sched.h                       |   36 ++
 usr/include/setjmp.h                      |   43 +++
 usr/include/signal.h                      |   97 ++++++
 usr/include/stdarg.h                      |   14 +
 usr/include/stddef.h                      |   24 +
 usr/include/stdint.h                      |  116 +++++++
 usr/include/stdio.h                       |  128 ++++++++
 usr/include/stdlib.h                      |   94 ++++++
 usr/include/string.h                      |   47 +++
 usr/include/sys/dirent.h                  |   32 ++
 usr/include/sys/elf32.h                   |  113 +++++++
 usr/include/sys/elf64.h                   |  113 +++++++
 usr/include/sys/elfcommon.h               |  187 +++++++++++
 usr/include/sys/fsuid.h                   |   14 +
 usr/include/sys/inotify.h                 |   16 +
 usr/include/sys/ioctl.h                   |   14 +
 usr/include/sys/klog.h                    |   24 +
 usr/include/sys/md.h                      |   32 ++
 usr/include/sys/mman.h                    |   24 +
 usr/include/sys/mount.h                   |   71 ++++
 usr/include/sys/param.h                   |   11 +
 usr/include/sys/poll.h                    |   20 +
 usr/include/sys/reboot.h                  |   25 +
 usr/include/sys/resource.h                |   15 +
 usr/include/sys/select.h                  |   17 +
 usr/include/sys/sendfile.h                |   14 +
 usr/include/sys/socket.h                  |   44 +++
 usr/include/sys/socketcalls.h             |   28 ++
 usr/include/sys/splice.h                  |   19 +
 usr/include/sys/stat.h                    |   33 ++
 usr/include/sys/statfs.h                  |    1 
 usr/include/sys/syscall.h                 |   13 +
 usr/include/sys/sysinfo.h                 |   12 +
 usr/include/sys/sysmacros.h               |   34 ++
 usr/include/sys/time.h                    |   18 +
 usr/include/sys/times.h                   |   14 +
 usr/include/sys/types.h                   |  111 +++++++
 usr/include/sys/uio.h                     |   15 +
 usr/include/sys/un.h                      |   10 +
 usr/include/sys/utime.h                   |   10 +
 usr/include/sys/utsname.h                 |   23 +
 usr/include/sys/vfs.h                     |  115 +++++++
 usr/include/sys/wait.h                    |   28 ++
 usr/include/syslog.h                      |   62 ++++
 usr/include/termios.h                     |   91 +++++
 usr/include/time.h                        |   18 +
 usr/include/unistd.h                      |  159 +++++++++
 usr/include/utime.h                       |   14 +
 usr/klibc/CAVEATS                         |   60 ++++
 usr/klibc/Kbuild                          |  186 +++++++++++
 usr/klibc/LICENSE                         |   73 ++++
 usr/klibc/README                          |   80 +++++
 usr/klibc/SOCKETCALLS.def                 |   21 +
 usr/klibc/SYSCALLS.def                    |  260 +++++++++++++++
 usr/klibc/__put_env.c                     |   74 ++++
 usr/klibc/__shared_init.c                 |    2 
 usr/klibc/__signal.c                      |   20 +
 usr/klibc/__static_init.c                 |    2 
 usr/klibc/abort.c                         |   18 +
 usr/klibc/alarm.c                         |   25 +
 usr/klibc/arch/README                     |   81 +++++
 usr/klibc/asprintf.c                      |   30 ++
 usr/klibc/assert.c                        |   14 +
 usr/klibc/atexit.c                        |   10 +
 usr/klibc/atexit.h                        |   18 +
 usr/klibc/atoi.c                          |    3 
 usr/klibc/atol.c                          |    3 
 usr/klibc/atoll.c                         |    3 
 usr/klibc/atox.c                          |   14 +
 usr/klibc/brk.c                           |   24 +
 usr/klibc/bsd_signal.c                    |   11 +
 usr/klibc/bsearch.c                       |   26 ++
 usr/klibc/calloc.c                        |   20 +
 usr/klibc/clearenv.c                      |   17 +
 usr/klibc/closelog.c                      |   18 +
 usr/klibc/creat.c                         |   12 +
 usr/klibc/ctype/ctypefunc.h               |   13 +
 usr/klibc/ctype/isalnum.c                 |    2 
 usr/klibc/ctype/isalpha.c                 |    2 
 usr/klibc/ctype/isascii.c                 |    2 
 usr/klibc/ctype/isblank.c                 |    2 
 usr/klibc/ctype/iscntrl.c                 |    2 
 usr/klibc/ctype/isdigit.c                 |    2 
 usr/klibc/ctype/isgraph.c                 |    2 
 usr/klibc/ctype/islower.c                 |    2 
 usr/klibc/ctype/isprint.c                 |    2 
 usr/klibc/ctype/ispunct.c                 |    2 
 usr/klibc/ctype/isspace.c                 |    2 
 usr/klibc/ctype/isupper.c                 |    2 
 usr/klibc/ctype/isxdigit.c                |    2 
 usr/klibc/ctype/tolower.c                 |    2 
 usr/klibc/ctype/toupper.c                 |    2 
 usr/klibc/ctypes.c                        |  284 +++++++++++++++++
 usr/klibc/daemon.c                        |   35 ++
 usr/klibc/env.h                           |   10 +
 usr/klibc/exec_l.c                        |   59 ++++
 usr/klibc/execl.c                         |    8 
 usr/klibc/execle.c                        |    8 
 usr/klibc/execlp.c                        |    8 
 usr/klibc/execlpe.c                       |    8 
 usr/klibc/execv.c                         |   11 +
 usr/klibc/execvp.c                        |   11 +
 usr/klibc/execvpe.c                       |   75 ++++
 usr/klibc/exit.c                          |   30 ++
 usr/klibc/fgetc.c                         |   19 +
 usr/klibc/fgets.c                         |   31 ++
 usr/klibc/fopen.c                         |   39 ++
 usr/klibc/fork.c                          |   21 +
 usr/klibc/fprintf.c                       |   19 +
 usr/klibc/fputc.c                         |   14 +
 usr/klibc/fputs.c                         |   15 +
 usr/klibc/fread.c                         |   33 ++
 usr/klibc/fread2.c                        |   13 +
 usr/klibc/fstatfs.c                       |   19 +
 usr/klibc/fwrite.c                        |   33 ++
 usr/klibc/fwrite2.c                       |   13 +
 usr/klibc/getcwd.c                        |   15 +
 usr/klibc/getdomainname.c                 |   25 +
 usr/klibc/getenv.c                        |   24 +
 usr/klibc/gethostname.c                   |   25 +
 usr/klibc/getopt.c                        |   97 ++++++
 usr/klibc/getpgrp.c                       |   10 +
 usr/klibc/getpriority.c                   |   23 +
 usr/klibc/getpt.c                         |   17 +
 usr/klibc/globals.c                       |   10 +
 usr/klibc/inet/bindresvport.c             |   46 +++
 usr/klibc/inet/inet_addr.c                |   14 +
 usr/klibc/inet/inet_aton.c                |   22 +
 usr/klibc/inet/inet_ntoa.c                |   16 +
 usr/klibc/inet/inet_ntop.c                |   53 +++
 usr/klibc/inet/inet_pton.c                |   78 +++++
 usr/klibc/interp.S                        |   13 +
 usr/klibc/isatty.c                        |   20 +
 usr/klibc/jrand48.c                       |   24 +
 usr/klibc/libc_init.c                     |  107 ++++++
 usr/klibc/libgcc/__ashldi3.c              |   23 +
 usr/klibc/libgcc/__ashrdi3.c              |   23 +
 usr/klibc/libgcc/__clzsi2.c               |   36 ++
 usr/klibc/libgcc/__divdi3.c               |   29 ++
 usr/klibc/libgcc/__divsi3.c               |   29 ++
 usr/klibc/libgcc/__lshrdi3.c              |   23 +
 usr/klibc/libgcc/__moddi3.c               |   29 ++
 usr/klibc/libgcc/__modsi3.c               |   29 ++
 usr/klibc/libgcc/__udivdi3.c              |   13 +
 usr/klibc/libgcc/__udivmoddi4.c           |   32 ++
 usr/klibc/libgcc/__udivmodsi4.c           |   32 ++
 usr/klibc/libgcc/__udivsi3.c              |   13 +
 usr/klibc/libgcc/__umoddi3.c              |   16 +
 usr/klibc/libgcc/__umodsi3.c              |   16 +
 usr/klibc/llseek.c                        |   30 ++
 usr/klibc/lrand48.c                       |   13 +
 usr/klibc/makeerrlist.pl                  |   98 ++++++
 usr/klibc/malloc.c                        |  200 ++++++++++++
 usr/klibc/malloc.h                        |   47 +++
 usr/klibc/memccpy.c                       |   23 +
 usr/klibc/memchr.c                        |   19 +
 usr/klibc/memcmp.c                        |   19 +
 usr/klibc/memcpy.c                        |   29 ++
 usr/klibc/memmem.c                        |   52 +++
 usr/klibc/memmove.c                       |   36 ++
 usr/klibc/memrchr.c                       |   19 +
 usr/klibc/memset.c                        |   30 ++
 usr/klibc/memswap.c                       |   24 +
 usr/klibc/mmap.c                          |   40 ++
 usr/klibc/mrand48.c                       |   13 +
 usr/klibc/nice.c                          |   19 +
 usr/klibc/nrand48.c                       |   11 +
 usr/klibc/nullenv.c                       |    8 
 usr/klibc/onexit.c                        |   23 +
 usr/klibc/open.c                          |   22 +
 usr/klibc/openat.c                        |   22 +
 usr/klibc/pause.c                         |   17 +
 usr/klibc/perror.c                        |   13 +
 usr/klibc/ppoll.c                         |   19 +
 usr/klibc/printf.c                        |   19 +
 usr/klibc/pselect.c                       |   42 ++
 usr/klibc/pty.c                           |   31 ++
 usr/klibc/putchar.c                       |   15 +
 usr/klibc/putenv.c                        |   37 ++
 usr/klibc/puts.c                          |   13 +
 usr/klibc/qsort.c                         |   42 ++
 usr/klibc/raise.c                         |   11 +
 usr/klibc/readdir.c                       |   57 +++
 usr/klibc/realloc.c                       |   48 +++
 usr/klibc/reboot.c                        |   15 +
 usr/klibc/recv.c                          |   11 +
 usr/klibc/remove.c                        |   18 +
 usr/klibc/sbrk.c                          |   45 +++
 usr/klibc/seed48.c                        |   18 +
 usr/klibc/send.c                          |   11 +
 usr/klibc/setegid.c                       |   10 +
 usr/klibc/setenv.c                        |   42 ++
 usr/klibc/seteuid.c                       |   10 +
 usr/klibc/setpgrp.c                       |   10 +
 usr/klibc/sha1hash.c                      |  317 +++++++++++++++++++
 usr/klibc/sigabbrev.c                     |  121 +++++++
 usr/klibc/sigaction.c                     |   60 ++++
 usr/klibc/siglist.c                       |  121 +++++++
 usr/klibc/siglongjmp.c                    |   15 +
 usr/klibc/sigpending.c                    |   18 +
 usr/klibc/sigprocmask.c                   |   18 +
 usr/klibc/sigsuspend.c                    |   18 +
 usr/klibc/sleep.c                         |   20 +
 usr/klibc/snprintf.c                      |   16 +
 usr/klibc/socketcalls.pl                  |   88 +++++
 usr/klibc/socketcalls/Kbuild              |   50 +++
 usr/klibc/socketcalls/socketcommon.h      |   16 +
 usr/klibc/sprintf.c                       |   18 +
 usr/klibc/srand48.c                       |   15 +
 usr/klibc/sscanf.c                        |   17 +
 usr/klibc/statfs.c                        |   19 +
 usr/klibc/strcasecmp.c                    |   24 +
 usr/klibc/strcat.c                        |   11 +
 usr/klibc/strchr.c                        |   19 +
 usr/klibc/strcmp.c                        |   21 +
 usr/klibc/strcpy.c                        |   20 +
 usr/klibc/strcspn.c                       |   10 +
 usr/klibc/strdup.c                        |   17 +
 usr/klibc/strerror.c                      |   33 ++
 usr/klibc/strlcat.c                       |   31 ++
 usr/klibc/strlcpy.c                       |   27 ++
 usr/klibc/strlen.c                        |   13 +
 usr/klibc/strncasecmp.c                   |   24 +
 usr/klibc/strncat.c                       |   22 +
 usr/klibc/strncmp.c                       |   21 +
 usr/klibc/strncpy.c                       |   24 +
 usr/klibc/strndup.c                       |   17 +
 usr/klibc/strnlen.c                       |   18 +
 usr/klibc/strntoimax.c                    |   13 +
 usr/klibc/strntoumax.c                    |   76 +++++
 usr/klibc/strpbrk.c                       |   12 +
 usr/klibc/strrchr.c                       |   21 +
 usr/klibc/strsep.c                        |   21 +
 usr/klibc/strsignal.c                     |   26 ++
 usr/klibc/strspn.c                        |   10 +
 usr/klibc/strstr.c                        |   11 +
 usr/klibc/strtoimax.c                     |    3 
 usr/klibc/strtok.c                        |   15 +
 usr/klibc/strtol.c                        |    3 
 usr/klibc/strtoll.c                       |    3 
 usr/klibc/strtotimespec.c                 |    5 
 usr/klibc/strtotimeval.c                  |    5 
 usr/klibc/strtotimex.c                    |   39 ++
 usr/klibc/strtoul.c                       |    3 
 usr/klibc/strtoull.c                      |    3 
 usr/klibc/strtoumax.c                     |    3 
 usr/klibc/strtox.c                        |   13 +
 usr/klibc/strxspn.c                       |   29 ++
 usr/klibc/strxspn.h                       |   12 +
 usr/klibc/syscalls.pl                     |  286 +++++++++++++++++
 usr/klibc/syscalls/Kbuild                 |   94 ++++++
 usr/klibc/syscalls/syscommon.h            |   33 ++
 usr/klibc/syslog.c                        |   89 +++++
 usr/klibc/system.c                        |   61 ++++
 usr/klibc/sysv_signal.c                   |   11 +
 usr/klibc/time.c                          |   23 +
 usr/klibc/umount.c                        |   12 +
 usr/klibc/unsetenv.c                      |   44 +++
 usr/klibc/usleep.c                        |   15 +
 usr/klibc/utime.c                         |   24 +
 usr/klibc/vasprintf.c                     |   25 +
 usr/klibc/version                         |    1 
 usr/klibc/vfork.c                         |   13 +
 usr/klibc/vfprintf.c                      |   26 ++
 usr/klibc/vprintf.c                       |   11 +
 usr/klibc/vsnprintf.c                     |  488 +++++++++++++++++++++++++++++
 usr/klibc/vsprintf.c                      |   11 +
 usr/klibc/vsscanf.c                       |  378 ++++++++++++++++++++++
 usr/klibc/wait.c                          |   12 +
 usr/klibc/wait3.c                         |   12 +
 usr/klibc/waitpid.c                       |   12 +
 317 files changed, 11252 insertions(+), 0 deletions(-)

Patch suppressed due to size (324 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/03-core-klibc-code.patch
