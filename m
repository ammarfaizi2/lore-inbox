Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136216AbRD0VJ5>; Fri, 27 Apr 2001 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136218AbRD0VJs>; Fri, 27 Apr 2001 17:09:48 -0400
Received: from cc885639-a.flushing1.mi.home.com ([24.182.96.34]:13828 "HELO
	caesar.lynix.com") by vger.kernel.org with SMTP id <S136216AbRD0VJi>;
	Fri, 27 Apr 2001 17:09:38 -0400
Date: Fri, 27 Apr 2001 17:10:24 +0000
From: Subba Rao <subba9@home.com>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: init process in 2.2.19
Message-ID: <20010427171024.B924@home.com>
Reply-To: Subba Rao <subba9@home.com>
In-Reply-To: <200104271251.HAA45696@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104271251.HAA45696@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Fri, Apr 27, 2001 at 07:51:08AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  0, Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> wrote:
> Subba Rao <subba9@home.com>:
> > I am trying to add a process which is to be managed by init. I have added the
> > following entry to /etc/inittab
> > 
> > SV:2345:respawn:env - PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin svscan /service </dev/null 2> dev/console
> > 
> > After saving, I execute the following command:
> > 
> > 	# kill -HUP 1
> > 
> > This does not start the process I have added. The process that I have added
> > only starts when I do:
> > 
> > 	# init u
> > or
> > 	# telinit u
> > 
> > PS - The process will not start even after a reboot. I have to manually do one
> > of the above commands as root.
> > 
> > My kernel version is : 2.2.19
> > Distro : Slackware
> > GCC : gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> > 
> > Any help appreciated.
> 
> I'm using Slackware 7.1, so one of the following possible solutions may work:
> 

Forgot to mention that I am using Slackware 7.1 too

> A second possibility (try this first - its easer:
> 	I see that the daemon is to run in modes "2345". There is a possiblity
> 	that you have this entry near the beginning of the inittab. If so, try
> 	putting it at the end. I believe that init runs each line of the
> 	inittab for a given run level in the same order that it appears in the
> 	file. Putting the entry last should allow it to be started AFTER
> 	all file systems are mounted - the  entry for multiuser mode is:
> 
> 	# Script to run when going multi user.
> 	rc:2345:wait:/etc/rc.d/rc.M
>
>	<SNIP>
> 

Thank you for replying!

I have tried those methods and they did not work. What I did as recommended
by someone, is that I added "strace" to the process in /etc/inittab

SV:2345:respawn:strace env - PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin svscan /service </dev/null 2>/backup/strace.out

Instead of sending the strace messages to the console, I saved them to a file.
Part of the log is at the end of this note. Most of these messages seem to be
from the memory module.

If anyone could look at these messages and let me know how to fix it, I would
appreciate it.

Thank you in advance for any help!
-- 

Subba Rao
subba9@home.com
http://members.home.net/subba9/

GPG public key ID 27FC9217

----------------------------------------------------------------------------


execve("/usr/bin/env", ["env", "-", "PATH=/usr/local/bin:/usr/sbin:/usr/bin:/bin", "svscan", "/service"], [/* 16 vars */]) = 0
brk(0)                                  = 0x804a3c0
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=22195, ...}) = 0
old_mmap(NULL, 22195, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=1013224, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\250\206"..., 4096) = 4096
old_mmap(NULL, 954492, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001a000
mprotect(0x400fc000, 28796, PROT_NONE)  = 0
old_mmap(0x400fc000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe1000) = 0x400fc000
old_mmap(0x40100000, 12412, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40100000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40104000
mprotect(0x4001a000, 925696, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001a000, 925696, PROT_READ|PROT_EXEC) = 0
munmap(0x40014000, 22195)               = 0
personality(PER_LINUX)                  = 0
getpid()                                = 880
brk(0)                                  = 0x804a3c0
brk(0x804a3f8)                          = 0x804a3f8
brk(0x804b000)                          = 0x804b000
execve("/usr/local/bin/svscan", ["svscan", "/service"], [/* 1 var */]) = 0
brk(0)                                  = 0x8053d20
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=22195, ...}) = 0
old_mmap(NULL, 22195, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40014000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
fstat(3, {st_mode=S_IFREG|0755, st_size=1013224, ...}) = 0
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\250\206"..., 4096) = 4096
old_mmap(NULL, 954492, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4001a000
mprotect(0x400fc000, 28796, PROT_NONE)  = 0
old_mmap(0x400fc000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe1000) = 0x400fc000
old_mmap(0x40100000, 12412, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40100000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40104000
mprotect(0x4001a000, 925696, PROT_READ|PROT_WRITE) = 0
mprotect(0x4001a000, 925696, PROT_READ|PROT_EXEC) = 0
munmap(0x40014000, 22195)               = 0
personality(PER_LINUX)                  = 0
getpid()                                = 880
chdir("/service")                       = 0
wait4(-1, 0xbffffea8, WNOHANG, NULL)    = -1 ECHILD (No child processes)
open("/dev/null", O_RDONLY|O_NONBLOCK|0x10000) = -1 ENOTDIR (Not a directory)
open(".", O_RDONLY|O_NONBLOCK|0x10000)  = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
brk(0)                                  = 0x8053d20
brk(0x8054d68)                          = 0x8054d68
brk(0x8055000)                          = 0x8055000
getdents(3, /* 2 entries */, 3933)      = 28
getdents(3, /* 0 entries */, 3933)      = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({5, 0}, {5, 0})               = 0
wait4(-1, 0xbffffea8, WNOHANG, NULL)    = -1 ECHILD (No child processes)
open(".", O_RDONLY|O_NONBLOCK|0x10000)  = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
getdents(3, /* 2 entries */, 3933)      = 28
getdents(3, /* 0 entries */, 3933)      = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({5, 0}, {5, 0})               = 0
wait4(-1, 0xbffffea8, WNOHANG, NULL)    = -1 ECHILD (No child processes)
open(".", O_RDONLY|O_NONBLOCK|0x10000)  = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
getdents(3, /* 2 entries */, 3933)      = 28
getdents(3, /* 0 entries */, 3933)      = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({5, 0}, {5, 0})               = 0
