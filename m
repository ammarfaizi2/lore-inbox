Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVFCLDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVFCLDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 07:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFCLDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 07:03:51 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:62981 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261213AbVFCLDl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 07:03:41 -0400
Message-ID: <42A0390A.2050303@stud.feec.vutbr.cz>
Date: Fri, 03 Jun 2005 13:03:38 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050506)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Parag Warudkar <kernel-stuff@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: RT patch breaks X86_64 build
References: <200505302201.48123.kernel-stuff@comcast.net> <429BFF51.4000401@stud.feec.vutbr.cz> <200505310753.49447.kernel-stuff@comcast.net> <429C530E.70704@stud.feec.vutbr.cz> <20050601091344.GB11703@elte.hu> <429EFB66.8030909@stud.feec.vutbr.cz> <20050602123927.GB10878@elte.hu> <429F4A19.7030508@stud.feec.vutbr.cz> <20050602183343.GB30309@elte.hu> <429F8C00.3070803@stud.feec.vutbr.cz> <20050603051821.GC14059@elte.hu>
In-Reply-To: <20050603051821.GC14059@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------030307090009030907040301"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.0 UPPERCASE_25_50        message body is 25-50% uppercase
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030307090009030907040301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> perhaps my mcount stubs dont save enough registers, leading to register 
> corruption on 64-bit userspace? In that case i'd expect more breakage 
> though, so maybe it's something more subtle.

I got an strace of 64-bit bash segfaulting under x86_64 kernel with 
LATENCY_TRACE. For comparison I also attach an strace output of the same 
bash running under a kernel without LATENCY_TRACE.

Michal

--------------030307090009030907040301
Content-Type: text/plain;
 name="bashtrace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bashtrace"

execve("/bin/bash.real", ["bash.real"], [/* 15 vars */]) = 0
uname({sys="Linux", node="k4-912b", ...}) = 0
brk(0)                                  = 0x5c1000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/lib/tls/x86_64/libncurses.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/lib/tls/x86_64", 0x7fffffb38440) = -1 ENOENT (No such file or directory)
open("/lib/tls/libncurses.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/lib/tls", 0x7fffffb38440)        = -1 ENOENT (No such file or directory)
open("/lib/x86_64/libncurses.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/lib/x86_64", 0x7fffffb38440)     = -1 ENOENT (No such file or directory)
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\371\1\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0644, st_size=365776, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaaaac0000
mmap(NULL, 1415952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2aaaaabc3000
mprotect(0x2aaaaac0b000, 1121040, PROT_NONE) = 0
mmap(0x2aaaaad0a000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x47000) = 0x2aaaaad0a000
mmap(0x2aaaaad1c000, 2832, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2aaaaad1c000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\22\0\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0644, st_size=11464, ...}) = 0
mmap(NULL, 1058136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2aaaaad1d000
mprotect(0x2aaaaad1f000, 1049944, PROT_NONE) = 0
mmap(0x2aaaaae1f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x2aaaaae1f000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\313\1\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0644, st_size=1287456, ...}) = 0
mmap(NULL, 2345768, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2aaaaae20000
mprotect(0x2aaaaaf41000, 1162024, PROT_NONE) = 0
mmap(0x2aaaab041000, 98304, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x121000) = 0x2aaaab041000
mmap(0x2aaaab059000, 15144, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2aaaab059000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaab05d000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaab05e000
arch_prctl(ARCH_SET_FS, 0x2aaaab05dd50) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK)     = -1 ENOENT (No such file or directory)
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
brk(0)                                  = 0x5c1000
brk(0x5c2000)                           = 0x5c2000
brk(0x5c4000)                           = 0x5c4000
readlink("/proc/self/fd/0", 0x5c2008, 4095) = -1 ENOENT (No such file or directory)
fstat(0, {st_mode=S_IFCHR|0600, st_rdev=makedev(4, 1), ...}) = 0
stat("/dev/pts", 0x7fffffb38a70)        = -1 ENOENT (No such file or directory)
stat("/dev/vc", 0x7fffffb38a70)         = -1 ENOENT (No such file or directory)
stat("/dev/tts", 0x7fffffb38a70)        = -1 ENOENT (No such file or directory)
open("/dev", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/locale-archive", O_RDONLY) = -1 ENOENT (No such file or directory)
brk(0x5c5000)                           = 0x5c5000
open("/usr/share/locale/locale.alias", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs_CZ.UTF-8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs_CZ.utf8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs_CZ/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs.UTF-8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs.utf8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
getuid()                                = 0
getgid()                                = 0
geteuid()                               = 0
getegid()                               = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

--------------030307090009030907040301
Content-Type: text/plain;
 name="bashtrace.ok"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bashtrace.ok"

execve("/bin/bash.real", ["bash.real"], [/* 15 vars */]) = 0
uname({sys="Linux", node="k4-912b", ...}) = 0
brk(0)                                  = 0x5c1000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/lib/tls/x86_64/libncurses.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/lib/tls/x86_64", 0x7fffffab5bc0) = -1 ENOENT (No such file or directory)
open("/lib/tls/libncurses.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/lib/tls", 0x7fffffab5bc0)        = -1 ENOENT (No such file or directory)
open("/lib/x86_64/libncurses.so.5", O_RDONLY) = -1 ENOENT (No such file or directory)
stat("/lib/x86_64", 0x7fffffab5bc0)     = -1 ENOENT (No such file or directory)
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\371\1\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0644, st_size=365776, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaaaac0000
mmap(NULL, 1415952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2aaaaabc3000
mprotect(0x2aaaaac0b000, 1121040, PROT_NONE) = 0
mmap(0x2aaaaad0a000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x47000) = 0x2aaaaad0a000
mmap(0x2aaaaad1c000, 2832, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2aaaaad1c000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\22\0\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0644, st_size=11464, ...}) = 0
mmap(NULL, 1058136, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2aaaaad1d000
mprotect(0x2aaaaad1f000, 1049944, PROT_NONE) = 0
mmap(0x2aaaaae1f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0x2aaaaae1f000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\313\1\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0644, st_size=1287456, ...}) = 0
mmap(NULL, 2345768, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2aaaaae20000
mprotect(0x2aaaaaf41000, 1162024, PROT_NONE) = 0
mmap(0x2aaaab041000, 98304, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x121000) = 0x2aaaab041000
mmap(0x2aaaab059000, 15144, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2aaaab059000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaab05d000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2aaaab05e000
arch_prctl(ARCH_SET_FS, 0x2aaaab05dd50) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK)     = -1 ENOENT (No such file or directory)
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
brk(0)                                  = 0x5c1000
brk(0x5c2000)                           = 0x5c2000
brk(0x5c4000)                           = 0x5c4000
readlink("/proc/self/fd/0", 0x5c2008, 4095) = -1 ENOENT (No such file or directory)
fstat(0, {st_mode=S_IFCHR|0600, st_rdev=makedev(4, 1), ...}) = 0
stat("/dev/pts", 0x7fffffab61f0)        = -1 ENOENT (No such file or directory)
stat("/dev/vc", 0x7fffffab61f0)         = -1 ENOENT (No such file or directory)
stat("/dev/tts", 0x7fffffab61f0)        = -1 ENOENT (No such file or directory)
open("/dev", O_RDONLY|O_NONBLOCK|O_DIRECTORY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/locale-archive", O_RDONLY) = -1 ENOENT (No such file or directory)
brk(0x5c5000)                           = 0x5c5000
open("/usr/share/locale/locale.alias", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs_CZ.UTF-8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs_CZ.utf8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs_CZ/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs.UTF-8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs.utf8/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/locale/cs/LC_IDENTIFICATION", O_RDONLY) = -1 ENOENT (No such file or directory)
getuid()                                = 0
getgid()                                = 0
geteuid()                               = 0
getegid()                               = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(2, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
brk(0x5c6000)                           = 0x5c6000
open("/etc/mtab", O_RDONLY)             = -1 ENOENT (No such file or directory)
open("/etc/fstab", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/proc/meminfo", O_RDONLY)         = -1 ENOENT (No such file or directory)
brk(0x5c7000)                           = 0x5c7000
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 8) = 0
...and so on, continues without problems

--------------030307090009030907040301--
