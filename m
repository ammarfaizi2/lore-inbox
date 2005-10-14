Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVJNTFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVJNTFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbVJNTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:05:44 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:27362 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1750883AbVJNTFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:05:43 -0400
Subject: Re: 2.6.14-rc4-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051014045615.GC13595@elte.hu>
References: <20051011111454.GA15504@elte.hu>
	 <1129064151.5324.6.camel@cmn3.stanford.edu>
	 <20051012061455.GA16586@elte.hu> <20051012071037.GA19018@elte.hu>
	 <1129242595.4623.14.camel@cmn3.stanford.edu>
	 <1129256936.11036.4.camel@cmn3.stanford.edu>
	 <20051014045615.GC13595@elte.hu>
Content-Type: text/plain
Date: Fri, 14 Oct 2005 12:05:19 -0700
Message-Id: <1129316719.5308.5.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-14 at 06:56 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > #!/bin/bash
> > while true ; do
> >     START=`date +"%s"`
> >     sleep 10
> >     END=`date +"%s"`
> >     let DIFF=END-START
> >     echo "$DIFF" >>time
> >     echo "---"
> > done
> > 
> > I'm attaching what I found when I got back.
> 
> > 1
> > 10
> > 6
> > 0
> > 0
> 
> could you try:
> 
> 	strace -o log sleep 10
> 
> and wait for a failure, and send us the log? Is it perhaps nanosleep 
> unexpectedly returning with -EAGAIN or -512? There's a transient 
> nanosleep failure that happens on really fast boxes, which we havent 
> gotten to the bottom yet. That problem is very sporadic, but maybe your 
> box is just too fast and triggers it more likely :-)

Arghh, now my computers are too fast!! :-) ;-) :-)

BTW, the behavior with rt5 is slightly different. The problem does not
take a while to appear but rather it is there from the time I first
login after a reboot (it does not take 10 minutes or so like before to
appear). In my first try (this is the second reboot into rt5) the
problem, at some point, seemed to dissapear completely. 

Here's one strace for you:

execve("/bin/sleep", ["sleep", "10"], [/* 47 vars */]) = 0
brk(0)                                  = 0x804d000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7f83000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=116896, ...}) = 0
old_mmap(NULL, 116896, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f66000
close(3)                                = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20#\241"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=201040, ...}) = 0
old_mmap(0x4ba0f000, 147616, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x4ba0f000
old_mmap(0x4ba32000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x22000) = 0x4ba32000
close(3)                                = 0
open("/lib/librt.so.1", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\340"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=49428, ...}) = 0
old_mmap(0x4c6ac000, 81656, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x4c6ac000
old_mmap(0x4c6b4000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x7000) = 0x4c6b4000
old_mmap(0x4c6b6000, 40696, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x4c6b6000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\212\216"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1485672, ...}) = 0
old_mmap(0x4b8e4000, 1215452, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x4b8e4000
old_mmap(0x4ba07000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x123000) = 0x4ba07000
old_mmap(0x4ba0b000, 7132, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x4ba0b000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\204W\245"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=101600, ...}) = 0
old_mmap(0x4ba51000, 70084, PROT_READ|PROT_EXEC, MAP_PRIVATE|
MAP_DENYWRITE, 3, 0) = 0x4ba51000
old_mmap(0x4ba5f000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0xd000) = 0x4ba5f000
old_mmap(0x4ba61000, 4548, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) = 0x4ba61000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7f65000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7f64000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f646c0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0x4ba32000, 4096, PROT_READ)   = 0
mprotect(0x4c6b4000, 4096, PROT_READ)   = 0
mprotect(0x4ba07000, 8192, PROT_READ)   = 0
mprotect(0x4b8e0000, 4096, PROT_READ)   = 0
mprotect(0x4ba5f000, 4096, PROT_READ)   = 0
munmap(0xb7f66000, 116896)              = 0
set_tid_address(0xb7f64708)             = 5001
rt_sigaction(SIGRTMIN, {0x4ba55340, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x4ba553a8, [], SA_RESTART|SA_SIGINFO}, NULL, 8)
= 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) =
0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfe833a0, 43, (nil), 0}) = 0
brk(0)                                  = 0x804d000
brk(0x806e000)                          = 0x806e000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=49618736, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7d64000
close(3)                                = 0
clock_gettime(CLOCK_REALTIME, {1129316227, 88832424}) = 0
nanosleep({10, 0}, 0)                   = ? ERESTART_RESTARTBLOCK (To be
restarted)
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2528, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f82000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2528
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f82000, 4096)                = 0
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY)
= -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY)
= -1 ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/coreutils.mo", O_RDONLY) =
-1 ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/coreutils.mo", O_RDONLY) =
-1 ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/coreutils.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
write(2, "sleep: ", 7)                  = 7
write(2, "cannot read realtime clock", 26) = 26
open("/usr/share/locale/en_US.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en_US.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en_US/LC_MESSAGES/libc.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en.UTF-8/LC_MESSAGES/libc.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en.utf8/LC_MESSAGES/libc.mo", O_RDONLY) = -1
ENOENT (No such file or directory)
open("/usr/share/locale/en/LC_MESSAGES/libc.mo", O_RDONLY) = -1 ENOENT
(No such file or directory)
write(2, ": Unknown error 516", 19)     = 19
write(2, "\n", 1)                       = 1
exit_group(1)                           = ?

-- Fernando


