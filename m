Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUEGLRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUEGLRs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 07:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263557AbUEGLRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 07:17:47 -0400
Received: from p3EE062E9.dip0.t-ipconnect.de ([62.224.98.233]:10372 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S263540AbUEGLR0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 07:17:26 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: Problem with nptl and uname
Date: Fri, 07 May 2004 13:10:37 +0200
Organization: privat
Message-ID: <409B6EAD.4060809@p3EE062E9.dip0.t-ipconnect.de>
References: <fa.ligadq5.1r0qj91@ifi.uio.no> <fa.goqhgl2.1bg8h0i@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
Cc: ken@kenmoffat.uklinux.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040502
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.goqhgl2.1bg8h0i@ifi.uio.no>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ken,
first of all - thank you for your hint!

Ken Moffat wrote:
> On Wed, 5 May 2004, Andreas Hartmann wrote:
> 
>> Hello all,
>>
>> I have a problem to get ntpl working on my machine:
>>
> 
> Sorry about replying to the list, but my (cable) IP address fails your
> blacklist.
> 
>> I have a AMD Athlon XP and kernel 2.6.6-rc3 (2.6.6-rc3-mm1). I compil=
> ed
>> glibc 2.3.3 with gcc 3.3.2, kernelheaders 2.6.5.1 and binutils
>> 2.15.90.0.3 with
>>
>> configure --with-tls --prefix=/usr --enable-add-ons=nptl --enable=
> -kernel=2.4.1
>>
> 
>>
>> initial thread stack 0x80037000-0xc0000000 (0x3ffc9000)
>> /opt/cd/libc/compile/nptl/tst-attr3: pthread_create #1 failed: Cannot
>> allocate memory
>>
> 
>  At a guess, no tmpfs support, or it's not mounted at /dev/shm.

andreas@athlon:~ > mount
[...]
tmpfs on /dev/shm type tmpfs (rw)
sysfs on /sys type sysfs (rw)

Should be there.
And as you can see in the following tst-mutex2 sample, mmap2 generally 
does work. But there is always one call, that doesn't work and which leads 
to an error. I think, the programm wants to have too much memory - but why?


31457 execve("/opt/cd/libc/compile/elf/ld-linux.so.2", 
["/opt/cd/libc/compile/elf/ld-linux.so.2", "--library-path", 
"/opt/cd/libc/compile:/opt/cd/libc/compile/math:/opt/cd/libc/compile/elf:/opt/cd/libc/compile/dlfcn:/opt/cd/libc/compile/nss:/opt/cd/libc/compile/nis:/opt/cd/libc/compile/rt:/opt/cd/libc/compile/resolv:/opt/cd/libc/compile/crypt:/opt/cd/libc/compile/nptl", 
"/opt/cd/libc/compile/nptl/tst-mutex2"], [/* 55 vars */]) = 0
31457 uname({sys="Linux", node="athlon", ...}) = 0
31457 brk(0)                            = 0x80015d8c
31457 brk(0x80016000)                   = 0x80016000
31457 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40000000
31457 open("/opt/cd/libc/compile/nptl/tst-mutex2", O_RDONLY) = 3
31457 read(3, 
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\2\0\3\0\1\0\0\0\200\216"..., 512) = 512
31457 fstat64(3, {st_mode=S_IFREG|0755, st_size=15591, ...}) = 0
31457 mmap2(0x8048000, 12288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 
3, 0) = 0x8048000
31457 mmap2(0x804b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0x2) = 0x804b000
31457 close(3)                          = 0
31457 stat64("/opt/cd/libc/compile", {st_mode=S_IFDIR|0755, st_size=3672, 
...}) = 0
31457 stat64("/opt/cd/libc/compile/math", {st_mode=S_IFDIR|0755, 
st_size=85888, ...}) = 0
31457 stat64("/opt/cd/libc/compile/elf", {st_mode=S_IFDIR|0755, 
st_size=13520, ...}) = 0
31457 stat64("/opt/cd/libc/compile/dlfcn", {st_mode=S_IFDIR|0755, 
st_size=4392, ...}) = 0
31457 stat64("/opt/cd/libc/compile/nss", {st_mode=S_IFDIR|0755, 
st_size=4408, ...}) = 0
31457 stat64("/opt/cd/libc/compile/nis", {st_mode=S_IFDIR|0755, 
st_size=10864, ...}) = 0
31457 stat64("/opt/cd/libc/compile/rt", {st_mode=S_IFDIR|0755, 
st_size=8440, ...}) = 0
31457 stat64("/opt/cd/libc/compile/resolv", {st_mode=S_IFDIR|0755, 
st_size=7160, ...}) = 0
31457 stat64("/opt/cd/libc/compile/crypt", {st_mode=S_IFDIR|0755, 
st_size=1544, ...}) = 0
31457 open("/opt/cd/libc/compile/nptl/libpthread.so.0", O_RDONLY) = 3
31457 read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360I\0"..., 
512) = 512
31457 fstat64(3, {st_mode=S_IFREG|0755, st_size=151719, ...}) = 0
31457 mmap2(NULL, 69068, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40001000
31457 mmap2(0x4000f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 
3, 0xe) = 0x4000f000
31457 mmap2(0x40010000, 7628, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40010000
31457 close(3)                          = 0
31457 open("/opt/cd/libc/compile/libc.so.6", O_RDONLY) = 3
31457 read(3, 
"\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`P\1\000"..., 512) = 512
31457 fstat64(3, {st_mode=S_IFREG|0755, st_size=1380243, ...}) = 0
31457 mmap2(NULL, 1121772, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
0x40012000
31457 mmap2(0x40119000, 36864, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED, 3, 0x106) = 0x40119000
31457 mmap2(0x40122000, 7660, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40122000
31457 close(3)                          = 0
31457 mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40124000
31457 set_thread_area({entry_number:-1 -> 6, base_addr:0x40124670, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
31457 set_tid_address(0x401246b8)       = 31457
31457 rt_sigaction(SIGRTMIN, {0x40005640, [], SA_SIGINFO}, NULL, 8) = 0
31457 rt_sigprocmask(SIG_UNBLOCK, [RTMIN], NULL, 8) = 0
31457 getrlimit(RLIMIT_STACK, {rlim_cur=2147483647, rlim_max=2147483647}) = 0
31457 _sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff304, 31, (nil), 0}) = 0
31457 clone(child_stack=0, 
flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x401246b8) = 31458
31457 rt_sigaction(SIGALRM, {0x8049430, [ALRM], SA_RESTART},  <unfinished ...>
31458 setrlimit(RLIMIT_CORE, {rlim_cur=0, rlim_max=0} <unfinished ...>
31457 <... rt_sigaction resumed> {SIG_DFL}, 8) = 0
31458 <... setrlimit resumed> )         = 0
31457 alarm(2 <unfinished ...>
31458 getrlimit(RLIMIT_DATA,  <unfinished ...>
31457 <... alarm resumed> )             = 0
31458 <... getrlimit resumed> {rlim_cur=2147483647, rlim_max=2147483647}) = 0
31457 waitpid(31458,  <unfinished ...>
31458 setrlimit(RLIMIT_DATA, {rlim_cur=65536*1024, rlim_max=2147483647}) = 0
31458 setpgid(0, 0)                     = 0
31458 mmap2(NULL, 2147487744, PROT_READ|PROT_WRITE,
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 ENOMEM (Cannot allocate memory)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


31458 write(1, "create failed", 13)     = 13
31458 write(1, "\n", 1)                 = 1
31458 exit_group(1)                     = ?
31457 <... waitpid resumed> [WIFEXITED(s) && WEXITSTATUS(s) == 1], 0) = 31458
31457 --- SIGCHLD (Child exited) @ 0 (0) ---
31457 exit_group(1)                     = ?


I would be very glad to get some hints to find the problem!


Kind regards,
Andreas Hartmann
