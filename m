Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUKPWIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUKPWIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 17:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbUKPWHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 17:07:23 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:48902 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261857AbUKPWDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 17:03:40 -0500
Message-ID: <419A7927.6090608@techsource.com>
Date: Tue, 16 Nov 2004 17:03:19 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Darren Williams <dsw@gelato.unsw.edu.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
References: <419914F9.7050509@techsource.com> <20041115234623.GA19452@cse.unsw.EDU.AU>
In-Reply-To: <20041115234623.GA19452@cse.unsw.EDU.AU>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alright, thanks for the suggestions [snipped].  I managed to get a 
number of the sound-related things to work.  Unfortunately, it still 
doesn't work 100%.

Now, KDE sounds seem to work, for instance, the bell sound in konsole 
when you try to backspace too many times.  However, that sound comes out 
noisy, raspy, and the wrong pitch.

I tried using 'aplay' with some wav files.  When I just do 'aplay 
<filename>', I get silence.  When I do 'strace aplay <filename>', I get 
lots of noise and output like this:


puck tim # strace aplay elements.wav
execve("/usr/bin/aplay", ["aplay", "elements.wav"], [/* 82 vars */]) = 0
brk(0)                                  = 0x8054000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or 
directory)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40017000
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=88450, ...}) = 0
old_mmap(NULL, 88450, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\335"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=860000, ...}) = 0
old_mmap(NULL, 850784, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0x4002e000
old_mmap(0x400fa000, 16384, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xcc000) = 0x400fa000
close(3)                                = 0
mprotect(0xbfffe000, 4096, 
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN) = 0
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3205\0"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=152744, ...}) = 0
old_mmap(NULL, 134544, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0x400fe000
old_mmap(0x4011e000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1f000) = 0x4011e000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0f\33\0\000"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=10324, ...}) = 0
old_mmap(NULL, 12080, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x4011f000
old_mmap(0x40121000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x40121000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360B\0"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=148084, ...}) = 0
old_mmap(NULL, 331332, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0x40122000
old_mmap(0x40130000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xe000) = 0x40130000
old_mmap(0x40131000, 269892, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40131000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\1U\1\000"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1169088, ...}) = 0
old_mmap(NULL, 1099428, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0x40173000
old_mmap(0x4027a000, 12288, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x106000) = 0x4027a000
old_mmap(0x4027d000, 9892, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4027d000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40280000
munmap(0x40018000, 88450)               = 0
getrlimit(RLIMIT_STACK, {rlim_cur=RLIM_INFINITY, 
rlim_max=RLIM_INFINITY}) = 0
setrlimit(RLIMIT_STACK, {rlim_cur=2044*1024, rlim_max=RLIM_INFINITY}) = 0
getpid()                                = 26097
uname({sys="Linux", node="puck", ...})  = 0
rt_sigaction(SIGRTMIN, {0x40129d8d, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x40129dcf, [], 0}, NULL, 8) = 0
rt_sigaction(SIGRT_2, {0x40129e96, [], 0}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [RTMIN], NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RT_1], NULL, 8) = 0
_sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbfffebb4, 31, (nil), 0}) = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\33R\205\"", 4)                = 4
close(3)                                = 0
brk(0)                                  = 0x8054000
brk(0x8075000)                          = 0x8075000
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8365, 
...}) = 0
open("/usr/share/alsa/alsa.conf", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=8365, ...}) = 0
old_mmap(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0x40281000
read(3, "#\n#  ALSA library configuration "..., 131072) = 8365
read(3, "", 131072)                     = 0
read(3, "", 131072)                     = 0
close(3)                                = 0
munmap(0x40281000, 131072)              = 0
access("/etc/asound.conf", R_OK)        = -1 ENOENT (No such file or 
directory)
access("/root/.asoundrc", R_OK)         = -1 ENOENT (No such file or 
directory)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0xbfffe96c)  = 0
ioctl(3, 0x40045532, 0xbfffe994)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR)       = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfffe870) = 0
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
ioctl(4, AGPIOC_INFO, 0xbfffe86c)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0xbfffe868) = 0
old_mmap(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000000) = 0x40281000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000000) = 
0x40282000
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0xbfffedc4) = 0
rt_sigaction(SIGINT, {0x4012d34c, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x4012d34c, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x4012d34c, [ABRT], SA_RESTART}, {SIG_DFL}, 8) = 0
open("elements.wav", O_RDONLY|O_LARGEFILE) = 3
read(3, "\377\373\222\0\0\0\0\'\0\330\205\4\0\2\217\3\271\200\246"..., 
24) = 24
read(3, "R\30", 2)                      = 2
write(2, "Playing raw data \'elements.wav\' "..., 34Playing raw data 
'elements.wav' : ) = 34
write(2, "Unsigned 8 bit, ", 16Unsigned 8 bit, )        = 16
write(2, "Rate 8000 Hz, ", 14Rate 8000 Hz, )          = 14
write(2, "Mono", 4Mono)                     = 4
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0xbfffe6e0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe330)        = 0
ioctl(4, 0xc25c4110, 0xbfffe330)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6e0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe330)        = 0
ioctl(4, 0xc25c4110, 0xbfffe330)        = 0
ioctl(4, 0xc25c4110, 0xbfffe6e0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe0a0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe450)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdb80)        = 0
ioctl(4, 0xc25c4110, 0xbfffdb80)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdb80)        = 0
ioctl(4, 0xc25c4110, 0xbfffdb80)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffdf30)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe190)        = 0
ioctl(4, 0xc25c4110, 0xbfffe650)        = 0
ioctl(4, 0xc25c4110, 0xbfffe650)        = 0
ioctl(4, 0xc25c4110, 0xbfffe650)        = 0
ioctl(4, 0xc25c4110, 0xbfffe680)        = 0
ioctl(4, 0xc25c4110, 0xbfffe680)        = 0
ioctl(4, 0xc25c4110, 0xbfffe2f0)        = 0
ioctl(4, 0xc25c4110, 0xbfffe300)        = 0
ioctl(4, 0xc25c4111, 0xbfffe300)        = 0
ioctl(4, 0xc0684113, 0xbfffe260)        = 0
ioctl(4, 0x80104132, 0xbfffe1b0)        = 0
ioctl(4, 0x80104132, 0xbfffe1b0)        = 0
old_mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0) = 0x40283000
ioctl(4, 0x4140, 0)                     = 0
ioctl(4, 0xc0684113, 0xbfffe9e4)        = 0
read(3, "r\200\t\241\310(\203\32\240\1\0\7\377\377\376\0\0\0\0\0"..., 
974) = 974
read(3, "\362\235\223\337\257w\322\33\364\231\372-\307\0075o<3\261"..., 
1000) = 1000
read(3, "\353W\367R\3137-wb\326_\26w\207\344\245r\355\3653\223\317"..., 
1000) = 1000
read(3, "\325\223\245\371M/\377\v\210\217\354\244W\312HQ\251\31"..., 
1000) = 1000
ioctl(4, 0x4142, 0x334e)                = 0
read(3, "\343\222SMcSFZ\253+V\306\376\246\"V\275\337\243>e=\363"..., 
1000) = 1000
ioctl(4, 0x4122, 0x400fce4c)            = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\262\322\200\363\226\217\304\\!\0\32nN9\3\223\377\373\222"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\210\331\7\362\207%\21\373[G\225!R\351{j|\344%^\374:X\335"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "2\n \22\203\322\333\271\270\"\320P\205\302\205\202$\331"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\250\355\363o\317\375|\177\367\376\177y3\312\307)\304\310"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "c\0\0\0\0\17m\267\10\t\320\243/\247-\241\33;\321\314>\344"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\270\372\230\236\234\177\275\335F\304 \317\225\377_\226"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\246\335\334k\214~\33\262\n%\270Ul5\367\206.\262\10\6>"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "Lld\3664Q\204\233\231\32DR%\304\3025\224r\205.|\306\5\255"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\364[z@\313cn\240\356\225\266\206\307=\302\2209\345N\373"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\257\262\262\254LW\364\324\301W\215\0\0\0\0\4\322n\260"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\25,\327|\213:j\247U)\25\321WR\n2Ql\223\17\307J\262\373"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\351\222F\314\203^C\376H\0\0\312\0mm\3420\nT\234e\2\340"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "Z\211\236\244,\270E\271O7F\320\242)j\10\221X\336\n\312"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "K\351\222\244\353t\365\r}\7\333n\200\32\300M\261\24k=\20"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\306\260(\22\n\220k\304\300Pe\215`\321\217um$\240\33C\305"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\221\345K\376\353\351\376NU\317\371\233\336\233\236SZF"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "{\253\252[k\251\2405\225\214\376\216\336f\206\206\236T"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\233\37\376\331\232\177\306\226\31\'\254\4\264\317\214"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\22\352_B\272\335=#9L\0W[\247\244g)\233,\253t\364\r\275"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\345.\347\304\305p\263M\213\256f{\254\223\267D\251\313"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\365\2777\376\366w\277\305#55d\353\377\346]Cg&6\20IU\10"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\263\317\252\25\310\213A\324\247>\261\3246\251\30\n\241"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "{ \230\227W\265\221\234\247\254\207O\332Im\271n\377\362"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\200\0\21\200\377\373\222\0\2\200\3\3)\326\351\350\22j"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\v\367_]\277\267\371\336i/kXh\200\1\2C\210N~ &\246\244"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\0\374\21b\30\360\272,6*!\323\26\325$W\277\222ND \204I"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "}\7\216OYX\212\17\256\22\2424-\"\272\213\36 ,\224\343\221"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\364\212\322\324\367\16\324\346\304\212p\374\330\251`\202"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "`\205\300\264\236DEu#\3175\340P\365/\276R@\0\377\373\222"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\30\36\32\0259\213\325\237\232\246S\245\323\247\373\357"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\315O\366R4\365\'\372\300\n\22X\314\266\356ME\265\2218"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "5*{\303\247\344aSo\"\267\312\256\271\22\23\267M\364\353"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\265\233\254)\343$\310X\263\250\356\330\311}\377s\30\363"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\241:\341\354rd\367\"\374c\2042.\244\256\237\241\4G2l\242"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\312X]\24\7\242\16\21\336\341\250\333\326\375X\356JU5!"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "X$xQ\212\201\257A\307\f\234\'\240\'\1E\365d\222\5\224\273"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL, revents=POLLOUT}], 1, -1) = 1
ioctl(4, 0x4122, 0x1)                   = 0
read(3, "\34\246ot\245\316\363\365\255\261oB?(5DG\256\351m\213!"..., 
1000) = 1000
ioctl(4, 0x4122, 0x3e8)                 = 0
poll( <unfinished ...>
Aborted by signal Terminated...
puck tim #
