Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVE0AiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVE0AiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 20:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVE0AiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 20:38:10 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:11504 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261175AbVE0Ah7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 20:37:59 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Roland McGrath <roland@redhat.com>
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
Date: Thu, 26 May 2005 20:37:56 -0400
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       mtk-lkml@gmx.net, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
References: <200505270011.j4R0BuwN011311@magilla.sf.frob.com>
In-Reply-To: <200505270011.j4R0BuwN011311@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505262037.57204.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 20:11, Roland McGrath wrote:
> You are using the test with an old glibc that doesn't know about the waitid
> systme call.  Use strace to see what system calls are actually being made.

I am using the current version of glibc - 2.3.4 - and man pages seem to know 
about the waitid sys call and WCONTINUED(Since Linux 2.6.10). Also waitid 
succeeds if I remove WCONTINUED flag, so it would seem that WCONTINUED  is 
not supported on X86_64 - I am running a 2.6.11-gentoo kernel. 

Here is the strace output -
--------------------------------------------------------------------------
strace ./a.out esc 10 2 restart
execve("./a.out", ["./a.out", "esc", "10", "2", "restart"], [/* 51 vars */]) = 
0
uname({sys="Linux", node="tux-gentoo", ...}) = 0
brk(0)                                  = 0x502000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x2aaaaaac0000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=91598, ...}) = 0
mmap(NULL, 91598, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2aaaaaac1000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\310\1\0"..., 640) = 
640
lseek(3, 64, SEEK_SET)                  = 64
read(3, "\6\0\0\0\5\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0"..., 616) = 
616
lseek(3, 680, SEEK_SET)                 = 680
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0"..., 32) = 32
fstat(3, {st_mode=S_IFREG|0755, st_size=1270208, ...}) = 0
lseek(3, 64, SEEK_SET)                  = 64
read(3, "\6\0\0\0\5\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0"..., 616) = 
616
mmap(NULL, 2248808, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 
0x2aaaaabc1000
mprotect(0x2aaaaacdd000, 1085544, PROT_NONE) = 0
mmap(0x2aaaaadc1000, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x100000) = 0x2aaaaadc1000
mmap(0x2aaaaade2000, 16488, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x2aaaaade2000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x2aaaaade7000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x2aaaaade8000
mprotect(0x2aaaaaddc000, 12288, PROT_READ) = 0
arch_prctl(ARCH_SET_FS, 0x2aaaaade7ae0) = 0
munmap(0x2aaaaaac1000, 91598)           = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, ")\371\226%\260\224\'\351", 8)  = 8
close(3)                                = 0
getpid()                                = 7682
write(1, "Parent\'s PID is 7682\n", 21Parent's PID is 7682
) = 21
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x2aaaaade7b70) = 7683
child (PID = 7683) started
rt_sigaction(SIGUSR1, {0x400aa0, [], SA_RESTORER|SA_RESTART, 0x2aaaaabefca0}, 
NULL, 8) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x2aaaaade7b70) = 7684
write(1, "Error Code from waitid - -1\n", 28Error Code from waitid - -1
) = 28
dup(2)                                  = 3
fcntl(3, F_GETFL)                       = 0x8002 (flags O_RDWR|O_LARGEFILE)
brk(0)                                  = 0x502000
brk(0x523000)                           = 0x523000
fstat(3, {st_mode=S_IFCHR|0600, st_rdev=makedev(136, 3), ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0x2aaaaaac1000
lseek(3, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
write(3, "waitid: Operation not supported\n", 32waitid: Operation not 
supported
) = 32
close(3)                                = 0
munmap(0x2aaaaaac1000, 4096)            = 0
exit_group(1)

-- 
Question: Is it better to abide by the rules until they're changed or
help speed the change by breaking them?
