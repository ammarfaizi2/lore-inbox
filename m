Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbUCXLhb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUCXLhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:37:31 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:38039 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S263302AbUCXLgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:36:44 -0500
Message-ID: <406172C9.8000706@free.fr>
Date: Wed, 24 Mar 2004 12:36:41 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.5-rc2-mm2 still does not boot but it progress : seems to be console
 font related
Content-Type: multipart/mixed;
 boundary="------------020709010304060507040603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709010304060507040603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

I have compiled a completely clean, unpatched (I mean except of course 
rc2-mm2) and I can still not manage to finish booting. However, this 
time, I get a little bit further AND system seems to hang exactly at the 
same place each time (which was not the case with rc2-mm1). In fact I 
managed to have the same behavior after removing the initramfs patches 
from rc2-mm1 and fixing some other things using bk snapshots diffs (SCSI 
st driver).

It hangs when executing :
/etc/init.d/console-screen.sh after displaying:

Setting up general console font..

Attached is a shell trace of a working session on
2.6.5-rc1-mm2. It basically does (twice wonder why!) a loop of :


/usr/bin/consolechars --tty=/dev/vc/[X] -f lat0-16

I also traced the set of system calls /usr/bin/consolechars does via ptrace.

Of course, the same shell script, same binaries and same settings works 
for 2.6.5-rc1-mm2


Does this rings a bell or suggest a culprit patche?

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




--------------020709010304060507040603
Content-Type: text/plain;
 name="consolecharTrace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="consolecharTrace"

execve("/usr/bin/consolechars", ["/usr/bin/consolechars", "--tty=/dev/vc/1", "-f", "lat0-16"], [/* 64 vars */]) = 0
uname({sys="Linux", node="tri-yann", ...}) = 0
brk(0)                                  = 0x804e000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=83303, ...}) = 0
old_mmap(NULL, 83303, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40018000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libconsole.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360Z\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=60156, ...}) = 0
old_mmap(NULL, 59128, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4002d000
old_mmap(0x40039000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xc000) = 0x40039000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libcfont.so.0", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\r\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=11784, ...}) = 0
old_mmap(NULL, 14844, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4003c000
old_mmap(0x4003f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x2000) = 0x4003f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libctutils.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\26\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=18288, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40040000
old_mmap(NULL, 17456, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40041000
old_mmap(0x40045000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x4000) = 0x40045000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240X\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1271388, ...}) = 0
old_mmap(NULL, 1281772, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40046000
old_mmap(0x40174000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x12d000) = 0x40174000
old_mmap(0x4017d000, 7916, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4017d000
close(3)                                = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x40040b40, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40018000, 83303)               = 0
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2264496, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0x4017f000
close(3)                                = 0
brk(0)                                  = 0x804e000
brk(0x806f000)                          = 0x806f000
brk(0)                                  = 0x806f000
open("/dev/vc/1", O_RDWR)               = 3
ioctl(3, 0x4b33, 0xbfffe9af)            = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGCHLD, {0x400427f0, [], 0}, {SIG_DFL}, 8) = 0
stat64("lat0-16", 0xbfffe11c)           = -1 ENOENT (No such file or directory)
stat64("lat0-16.gz", 0xbfffe11c)        = -1 ENOENT (No such file or directory)
stat64("lat0-16.lzo", 0xbfffe11c)       = -1 ENOENT (No such file or directory)
stat64("lat0-16.Z", 0xbfffe11c)         = -1 ENOENT (No such file or directory)
stat64("lat0-16.bz2", 0xbfffe11c)       = -1 ENOENT (No such file or directory)
stat64("lat0-16.psf", 0xbfffe11c)       = -1 ENOENT (No such file or directory)
stat64("lat0-16.psf.gz", 0xbfffe11c)    = -1 ENOENT (No such file or directory)
stat64("lat0-16.psf.lzo", 0xbfffe11c)   = -1 ENOENT (No such file or directory)
stat64("lat0-16.psf.Z", 0xbfffe11c)     = -1 ENOENT (No such file or directory)
stat64("lat0-16.psf.bz2", 0xbfffe11c)   = -1 ENOENT (No such file or directory)
stat64("lat0-16.cp", 0xbfffe11c)        = -1 ENOENT (No such file or directory)
stat64("lat0-16.cp.gz", 0xbfffe11c)     = -1 ENOENT (No such file or directory)
stat64("lat0-16.cp.lzo", 0xbfffe11c)    = -1 ENOENT (No such file or directory)
stat64("lat0-16.cp.Z", 0xbfffe11c)      = -1 ENOENT (No such file or directory)
stat64("lat0-16.cp.bz2", 0xbfffe11c)    = -1 ENOENT (No such file or directory)
stat64("lat0-16.fnt", 0xbfffe11c)       = -1 ENOENT (No such file or directory)
stat64("lat0-16.fnt.gz", 0xbfffe11c)    = -1 ENOENT (No such file or directory)
stat64("lat0-16.fnt.lzo", 0xbfffe11c)   = -1 ENOENT (No such file or directory)
stat64("lat0-16.fnt.Z", 0xbfffe11c)     = -1 ENOENT (No such file or directory)
stat64("lat0-16.fnt.bz2", 0xbfffe11c)   = -1 ENOENT (No such file or directory)
stat64("lat0-16.psfu", 0xbfffe11c)      = -1 ENOENT (No such file or directory)
stat64("lat0-16.psfu.gz", 0xbfffe11c)   = -1 ENOENT (No such file or directory)
stat64("lat0-16.psfu.lzo", 0xbfffe11c)  = -1 ENOENT (No such file or directory)
stat64("lat0-16.psfu.Z", 0xbfffe11c)    = -1 ENOENT (No such file or directory)
stat64("lat0-16.psfu.bz2", 0xbfffe11c)  = -1 ENOENT (No such file or directory)
stat64("/usr", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/share", {st_mode=S_IFDIR|0755, st_size=8192, ...}) = 0
stat64("/usr/share/consolefonts", {st_mode=S_IFDIR|0755, st_size=16384, ...}) = 0
stat64("/usr/share/consolefonts/lat0-16", 0xbfffdeac) = -1 ENOENT (No such file or directory)
stat64("/usr/share/consolefonts/lat0-16.gz", 0xbfffdeac) = -1 ENOENT (No such file or directory)
stat64("/usr/share/consolefonts/lat0-16.lzo", 0xbfffdeac) = -1 ENOENT (No such file or directory)
stat64("/usr/share/consolefonts/lat0-16.Z", 0xbfffdeac) = -1 ENOENT (No such file or directory)
stat64("/usr/share/consolefonts/lat0-16.bz2", 0xbfffdeac) = -1 ENOENT (No such file or directory)
stat64("/usr/share/consolefonts/lat0-16.psf", 0xbfffdeac) = -1 ENOENT (No such file or directory)
stat64("/usr/share/consolefonts/lat0-16.psf.gz", {st_mode=S_IFREG|0644, st_size=1982, ...}) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
open("/usr/share/consolefonts/lat0-16.psf.gz", O_RDONLY) = 4
fstat64(4, {st_mode=S_IFREG|0644, st_size=1982, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4037f000
read(4, "\37\213\10\10\225\320^@\2\3lat0-16.psf\0u\230k\220\34U"..., 4096) = 1982
pipe([5, 6])                            = 0
pipe([7, 8])                            = 0
clone(Process 2805 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x40040b88) = 2805
[pid  2805] close(8)                    = 0
[pid  2805] close(5)                    = 0
[pid  2805] close(0)                    = 0
[pid  2805] dup2(7, 0)                  = 0
[pid  2805] close(1)                    = 0
[pid  2805] dup2(6, 1)                  = 1
[pid  2805] execve("/sbin/gunzip", ["gunzip"], [/* 64 vars */]) = -1 ENOENT (No such file or directory)
[pid  2805] execve("/bin/gunzip", ["gunzip"], [/* 64 vars */]) = 0
[pid  2805] uname({sys="Linux", node="tri-yann", ...}) = 0
[pid  2805] brk(0)                      = 0x80a5000
[pid  2805] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
[pid  2805] access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
[pid  2805] open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
[pid  2805] open("/etc/ld.so.cache", O_RDONLY) = 5
[pid  2805] fstat64(5, {st_mode=S_IFREG|0644, st_size=83303, ...}) = 0
[pid  2805] old_mmap(NULL, 83303, PROT_READ, MAP_PRIVATE, 5, 0) = 0x40018000
[pid  2805] close(5)                    = 0
[pid  2805] access("/etc/ld.so.nohwcap", F_OK) = -1 ENOENT (No such file or directory)
[pid  2805] open("/lib/tls/libc.so.6", O_RDONLY) = 5
[pid  2805] read(5, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240X\1"..., 512) = 512
[pid  2805] fstat64(5, {st_mode=S_IFREG|0644, st_size=1271388, ...}) = 0
[pid  2805] old_mmap(NULL, 1281772, PROT_READ|PROT_EXEC, MAP_PRIVATE, 5, 0) = 0x4002d000
[pid  2805] old_mmap(0x4015b000, 36864, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 5, 0x12d000) = 0x4015b000
[pid  2805] old_mmap(0x40164000, 7916, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40164000
[pid  2805] close(5)                    = 0
[pid  2805] old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40166000
[pid  2805] set_thread_area({entry_number:-1 -> 6, base_addr:0x401662a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
[pid  2805] munmap(0x40018000, 83303)   = 0
[pid  2805] rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
[pid  2805] rt_sigaction(SIGINT, {0x804c848, [INT], SA_RESTART}, {SIG_IGN}, 8) = 0
[pid  2805] rt_sigaction(SIGTERM, {SIG_IGN}, {SIG_DFL}, 8) = 0
[pid  2805] rt_sigaction(SIGTERM, {0x804c848, [TERM], SA_RESTART}, {SIG_IGN}, 8) = 0
[pid  2805] rt_sigaction(SIGHUP, {SIG_IGN}, {SIG_DFL}, 8) = 0
[pid  2805] rt_sigaction(SIGHUP, {0x804c848, [HUP], SA_RESTART}, {SIG_IGN}, 8) = 0
[pid  2805] ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbffff600) = -1 EINVAL (Invalid argument)
[pid  2805] read(0,  <unfinished ...>
[pid  2804] close(7)                    = 0
[pid  2804] close(6)                    = 0
[pid  2804] clone(Process 2806 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x40040b88) = 2806
[pid  2806] write(8, "\37\213\10\10\225\320^@\2", 9) = 9
[pid  2806] write(8, "\3lat0-16.psf\0u\230k\220\34U\25\200;@M\241\266\313ZZ8"..., 512) = 512
[pid  2806] write(8, "-\266\374l7{a\30\t\207R}@\4\370\340\16R\335v\347\30ak\316"..., 512) = 512
[pid  2806] write(8, "\363ET\267\263\210MN\370\23\234\357r?;b?\273\353i\374\216"..., 512) = 512
[pid  2806] read(4, "", 4096)           = 0
[pid  2806] write(8, "K\341e\360r\250\303+`\27\\\f\273\341\2250\16\257\2\v^\r"..., 437) = 437
[pid  2806] read(4, "", 4096)           = 0
[pid  2806] exit_group(0)               = ?
Process 2806 detached
[pid  2804] close(8)                    = 0
[pid  2804] close(4)                    = 0
[pid  2804] munmap(0x4037f000, 4096)    = 0
[pid  2804] fcntl64(5, F_GETFL)         = 0 (flags O_RDONLY)
[pid  2804] fstat64(5, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid  2804] mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4037f000
[pid  2804] _llseek(5, 0, 0xbfffe09c, SEEK_CUR) = -1 ESPIPE (Illegal seek)
[pid  2804] read(5,  <unfinished ...>
[pid  2805] <... read resumed> "\37\213\10\10\225\320^@\2\3lat0-16.psf\0u\230k\220\34U"..., 32768) = 1982
[pid  2805] read(0, "", 30786)          = 0
[pid  2805] brk(0)                      = 0x80a5000
[pid  2805] brk(0x80c6000)              = 0x80c6000
[pid  2805] brk(0)                      = 0x80c6000
[pid  2805] write(1, "6\4\2\20\0\0~\303\231\231\363\347\347\377\347\347~\0\0"..., 5156 <unfinished ...>
[pid  2804] <... read resumed> "6\4\2\20\0\0~\303\231\231\363\347\347\377\347\347~\0\0"..., 4096) = 4096
[pid  2804] pipe([4, 6])                = 0
[pid  2804] clone(Process 2807 attached
child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x40040b88) = 2807
[pid  2807] close(4)                    = 0
[pid  2807] write(6, "6\4\2\20\0\0~\303\231\231\363\347\347\377\347\347~\0\0"..., 32) = 32
[pid  2807] write(6, "\0\0\0\0\0\0n\370\330\330\334\330\330\330\370n\0\0\0\0"..., 512) = 512
[pid  2807] write(6, "\0\0\0\0\0fff$\0\0\0\0\0\0\0\0\0\0\0\0\0\0ll\376lll\376"..., 512) = 512
[pid  2807] write(6, "\0\0\0\0\0\0\374fff|ffff\374\0\0\0\0\0\0<f\302\300\300"..., 512) = 512
[pid  2807] write(6, "\0\0\0\0\0\0\340``xlffff|\0\0\0\0\0\0\0\0\0|\306\300\300"..., 512) = 512
[pid  2807] write(6, "\0\0\0\0\0208l\0008l\306\306\376\306\306\306\0\0\0\0v\334"..., 512) = 512
[pid  2807] write(6, "<\30\0\0\0\0\0\0\20|\326\320\320\320\326|\20\0\0\0\0\000"..., 512) = 512
[pid  2807] write(6, "\0\0\0\0\0\0\0\0\0\0\0\37\0\0\0\0\0\0\0\0\30\30\30\30\30"..., 512) = 512
[pid  2807] read(5,  <unfinished ...>
[pid  2804] close(6)                    = 0
[pid  2804] fcntl64(4, F_GETFL)         = 0 (flags O_RDONLY)
[pid  2804] fstat64(4, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid  2804] mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40380000
[pid  2804] _llseek(4, 0, 0xbfffe09c, SEEK_CUR) = -1 ESPIPE (Illegal seek)
[pid  2804] rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
[pid  2804] fstat64(4, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
[pid  2804] read(4, "6\4\2\20\0\0~\303\231\231\363\347\347\377\347\347~\0\0"..., 4096) = 3616
[pid  2804] read(4,  <unfinished ...>
[pid  2805] <... write resumed> )       = 5156
[pid  2805] exit_group(0)               = ?
Process 2805 detached
[pid  2807] <... read resumed> "\6\f\370\0\375\377\377\377H\"\377\377R\1\377\377S\1\377"..., 4096) = 1060
[pid  2807] write(6, "\0\0\0\0\0\0208l\0x\f|\314\314\314v\0\0\0\0\0\0v\334\0"..., 512 <unfinished ...>
[pid  2804] <... read resumed> "\0\0\0\0\0\0208l\0x\f|\314\314\314v\0\0\0\0\0\0v\334\0"..., 4096) = 512
[pid  2804] read(4,  <unfinished ...>
[pid  2807] <... write resumed> )       = 512
[pid  2807] write(6, "\r$\377\377\n$\377\377\221%\377\377\222%\377\377\223%\377"..., 512 <unfinished ...>
[pid  2804] <... read resumed> "\r$\377\377\n$\377\377\221%\377\377\222%\377\377\223%\377"..., 4096) = 512
[pid  2804] read(4,  <unfinished ...>
[pid  2807] <... write resumed> )       = 512
[pid  2807] write(6, "+!\377\377\306\0\377\377\307\0\377\377\310\0\377\377\311"..., 512 <unfinished ...>
[pid  2804] <... read resumed> "+!\377\377\306\0\377\377\307\0\377\377\310\0\377\377\311"..., 4096) = 512
[pid  2804] read(4,  <unfinished ...>
[pid  2807] <... write resumed> )       = 512
[pid  2807] read(5, "", 4096)           = 0
[pid  2807] write(6, "\377\0\377\377", 4 <unfinished ...>
[pid  2804] <... read resumed> "\377\0\377\377", 4096) = 4
[pid  2804] close(4)                    = 0
[pid  2804] munmap(0x40380000, 4096)    = 0
[pid  2804] ioctl(3, 0x4b72, 0xbfffe850) = 0
[pid  2804] rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
[pid  2804] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid  2804] wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 2806
[pid  2804] sigreturn()                 = ? (mask now [])
[pid  2804] ioctl(3, 0x4b68, 0xbfffe9d0) = 0
[pid  2804] ioctl(3, 0x4b67, 0xbfffea68) = 0
[pid  2804] exit_group(0)               = ?
<... write resumed> )                   = 4
read(5, "", 4096)                       = 0
exit_group(0)                           = ?
Process 2807 detached

--------------020709010304060507040603
Content-Type: application/octet-stream;
 name="console-screen.out"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="console-screen.out"

KyAnWycgLXIgL2V0Yy9jb25zb2xlLXRvb2xzL2NvbmZpZyAnXScKKyAuIC9ldGMvY29uc29s
ZS10b29scy9jb25maWcKKysgU0NSRUVOX0ZPTlQ9bGF0MC0xNgorKyBTQ1JFRU5fRk9OVF92
YzE9bGF0MC0xNgorKyBTQ1JFRU5fRk9OVF92YzI9bGF0MC0xNgorKyBTQ1JFRU5fRk9OVF92
YzM9bGF0MC0xNgorKyBTQ1JFRU5fRk9OVF92YzQ9bGF0MC0xNgorKyBTQ1JFRU5fRk9OVF92
YzU9bGF0MC0xNgorKyBBUFBfQ0hBUlNFVF9NQVA9aXNvMTUKKysgQkxBTktfVElNRT0zMAor
KyBCTEFOS19EUE1TPW9mZgorKyBQT1dFUkRPV05fVElNRT0zMAorIFBBVEg9L3NiaW46L2Jp
bjovdXNyL3NiaW46L3Vzci9iaW4KKyBTRVRGT05UPS91c3IvYmluL2NvbnNvbGVjaGFycwor
IFNFVEZPTlRfT1BUPQorIENIQVJTRVQ9L3Vzci9iaW4vY2hhcnNldAorIFZDU1RJTUU9L3Vz
ci9zYmluL3Zjc3RpbWUKKyAnWycgLXggL3Vzci9iaW4vY29uc29sZWNoYXJzICddJworICdb
JyAtZSAvZGV2Ly5kZXZmc2QgJ10nCisgREVWSUNFX1BSRUZJWD0vZGV2L3ZjLworIHNldHVw
CisgVlQ9bm8KKysgZmdjb25zb2xlCisgQ09OU09MRV9UWVBFPTIKKyAnWycgJyEnIDIgPSBz
ZXJpYWwgJ10nCisgcmVhZGxpbmsgL3Byb2Mvc2VsZi9mZC8wCisgZ3JlcCAtcSAtZSAvZGV2
L3ZjIC1lICcvZGV2L3R0eVtecF0nIC1lIC9kZXYvY29uc29sZQorICdbJyAwIC1lcSAwICdd
JworIFZUPXllcworIHJlc2V0X3ZnYV9wYWxldHRlCisgJ1snIC1mIC9wcm9jL2ZiICddJwor
IGVjaG8gLW4gJxtdUicKG11SKyAnWycgeWVzID0gbm8gJ10nCisgJ1snICcnID0geWVzIC1h
IC14IC91c3Ivc2Jpbi92Y3N0aW1lICddJworICdbJyBsYXQwLTE2ICddJworIGVjaG8gLW4g
J1NldHRpbmcgdXAgZ2VuZXJhbCBjb25zb2xlIGZvbnQuLi4gJwpTZXR0aW5nIHVwIGdlbmVy
YWwgY29uc29sZSBmb250Li4uICsgU0NSRUVOX0ZPTlQ9LWYgbGF0MC0xNgorICdbJyAnJyAn
XScKKysgc2VxIDAgNgorIC91c3IvYmluL2NvbnNvbGVjaGFycyAtLXR0eT0vZGV2L3ZjLzAg
LWYgbGF0MC0xNgorICdbJyAwIC1lcSA2ICddJworIC91c3IvYmluL2NvbnNvbGVjaGFycyAt
LXR0eT0vZGV2L3ZjLzEgLWYgbGF0MC0xNgorICdbJyAxIC1lcSA2ICddJworIC91c3IvYmlu
L2NvbnNvbGVjaGFycyAtLXR0eT0vZGV2L3ZjLzIgLWYgbGF0MC0xNgorICdbJyAyIC1lcSA2
ICddJworIC91c3IvYmluL2NvbnNvbGVjaGFycyAtLXR0eT0vZGV2L3ZjLzMgLWYgbGF0MC0x
NgorICdbJyAzIC1lcSA2ICddJworIC91c3IvYmluL2NvbnNvbGVjaGFycyAtLXR0eT0vZGV2
L3ZjLzQgLWYgbGF0MC0xNgorICdbJyA0IC1lcSA2ICddJworIC91c3IvYmluL2NvbnNvbGVj
aGFycyAtLXR0eT0vZGV2L3ZjLzUgLWYgbGF0MC0xNgorICdbJyA1IC1lcSA2ICddJworIC91
c3IvYmluL2NvbnNvbGVjaGFycyAtLXR0eT0vZGV2L3ZjLzYgLWYgbGF0MC0xNgorICdbJyA2
IC1lcSA2ICddJworIGVjaG8gJyBkb25lLicKIGRvbmUuCisrIHNldAorKyBncmVwICdeU0NS
RUVOX0ZPTlRfdmNbMC05XSo9JworKyB0ciAtZCAnJ1wnJycKKyBQRVJWQ19GT05UUz1TQ1JF
RU5fRk9OVF92YzE9bGF0MC0xNgpTQ1JFRU5fRk9OVF92YzI9bGF0MC0xNgpTQ1JFRU5fRk9O
VF92YzM9bGF0MC0xNgpTQ1JFRU5fRk9OVF92YzQ9bGF0MC0xNgpTQ1JFRU5fRk9OVF92YzU9
bGF0MC0xNgorICdbJyAnU0NSRUVOX0ZPTlRfdmMxPWxhdDAtMTYKU0NSRUVOX0ZPTlRfdmMy
PWxhdDAtMTYKU0NSRUVOX0ZPTlRfdmMzPWxhdDAtMTYKU0NSRUVOX0ZPTlRfdmM0PWxhdDAt
MTYKU0NSRUVOX0ZPTlRfdmM1PWxhdDAtMTYnICddJworIGVjaG8gLW4gJ1NldHRpbmcgdXAg
cGVyLVZDIGZvbnRzOiAnClNldHRpbmcgdXAgcGVyLVZDIGZvbnRzOiArKyBlY2hvIFNDUkVF
Tl9GT05UX3ZjMT1sYXQwLTE2CisrIGN1dCAtYjE1LQorKyBjdXQgLWQ9IC1mMQorIHZjPTEK
KyBldmFsICdmb250PSRTQ1JFRU5fRk9OVF92YzEnCisrIGZvbnQ9bGF0MC0xNgorICdbJyBY
ICchPScgWDEgJ10nCisgZWNobyAtbiAnL2Rldi92Yy8xLCAnCi9kZXYvdmMvMSwgKyBldmFs
ICdzZm09JHtTQ1JFRU5fRk9OVF9NQVBfdmMxfScKKysgc2ZtPQorICdbJyAnJyAnXScKKyAv
dXNyL2Jpbi9jb25zb2xlY2hhcnMgLS10dHk9L2Rldi92Yy8xIC1mIGxhdDAtMTYKKysgZWNo
byBTQ1JFRU5fRk9OVF92YzI9bGF0MC0xNgorKyBjdXQgLWIxNS0KKysgY3V0IC1kPSAtZjEK
KyB2Yz0yCisgZXZhbCAnZm9udD0kU0NSRUVOX0ZPTlRfdmMyJworKyBmb250PWxhdDAtMTYK
KyAnWycgWCAnIT0nIFgxICddJworIGVjaG8gLW4gJy9kZXYvdmMvMiwgJwovZGV2L3ZjLzIs
ICsgZXZhbCAnc2ZtPSR7U0NSRUVOX0ZPTlRfTUFQX3ZjMn0nCisrIHNmbT0KKyAnWycgJycg
J10nCisgL3Vzci9iaW4vY29uc29sZWNoYXJzIC0tdHR5PS9kZXYvdmMvMiAtZiBsYXQwLTE2
CisrIGVjaG8gU0NSRUVOX0ZPTlRfdmMzPWxhdDAtMTYKKysgY3V0IC1iMTUtCisrIGN1dCAt
ZD0gLWYxCisgdmM9MworIGV2YWwgJ2ZvbnQ9JFNDUkVFTl9GT05UX3ZjMycKKysgZm9udD1s
YXQwLTE2CisgJ1snIFggJyE9JyBYMSAnXScKKyBlY2hvIC1uICcvZGV2L3ZjLzMsICcKL2Rl
di92Yy8zLCArIGV2YWwgJ3NmbT0ke1NDUkVFTl9GT05UX01BUF92YzN9JworKyBzZm09Cisg
J1snICcnICddJworIC91c3IvYmluL2NvbnNvbGVjaGFycyAtLXR0eT0vZGV2L3ZjLzMgLWYg
bGF0MC0xNgorKyBlY2hvIFNDUkVFTl9GT05UX3ZjND1sYXQwLTE2CisrIGN1dCAtYjE1LQor
KyBjdXQgLWQ9IC1mMQorIHZjPTQKKyBldmFsICdmb250PSRTQ1JFRU5fRk9OVF92YzQnCisr
IGZvbnQ9bGF0MC0xNgorICdbJyBYICchPScgWDEgJ10nCisgZWNobyAtbiAnL2Rldi92Yy80
LCAnCi9kZXYvdmMvNCwgKyBldmFsICdzZm09JHtTQ1JFRU5fRk9OVF9NQVBfdmM0fScKKysg
c2ZtPQorICdbJyAnJyAnXScKKyAvdXNyL2Jpbi9jb25zb2xlY2hhcnMgLS10dHk9L2Rldi92
Yy80IC1mIGxhdDAtMTYKKysgZWNobyBTQ1JFRU5fRk9OVF92YzU9bGF0MC0xNgorKyBjdXQg
LWIxNS0KKysgY3V0IC1kPSAtZjEKKyB2Yz01CisgZXZhbCAnZm9udD0kU0NSRUVOX0ZPTlRf
dmM1JworKyBmb250PWxhdDAtMTYKKyAnWycgWCAnIT0nIFgxICddJworIGVjaG8gLW4gJy9k
ZXYvdmMvNSwgJwovZGV2L3ZjLzUsICsgZXZhbCAnc2ZtPSR7U0NSRUVOX0ZPTlRfTUFQX3Zj
NX0nCisrIHNmbT0KKyAnWycgJycgJ10nCisgL3Vzci9iaW4vY29uc29sZWNoYXJzIC0tdHR5
PS9kZXYvdmMvNSAtZiBsYXQwLTE2CisgZWNobyBkb25lLgpkb25lLgorICdbJyBpc28xNSAn
XScKKyAvdXNyL2Jpbi9jaGFyc2V0IEcwIGlzbzE1CisrIHNldAorKyBncmVwICdeQVBQX0NI
QVJTRVRfTUFQX3ZjWzAtOV0qPScKKysgdHIgLWQgJydcJycnCisgUEVSVkNfQUNNUz0KKyAn
WycgJycgJ10nCisgJ1snIC1mIC9ldGMvZW52aXJvbm1lbnQgJ10nCisrIGVncmVwICdeW14j
XSpMQU5HPScgL2V0Yy9lbnZpcm9ubWVudAorKyBjdXQgLWQ9IC1mMgorIHZhbHVlPWZyX0ZS
QGV1cm8KKyBldmFsIExBTkc9ZnJfRlJAZXVybworKyBMQU5HPWZyX0ZSQGV1cm8KKysgZWdy
ZXAgJ15bXiNdKkxDX0FMTD0nIC9ldGMvZW52aXJvbm1lbnQKKysgY3V0IC1kPSAtZjIKKyB2
YWx1ZT0KKyBldmFsIExDX0FMTD0KKysgTENfQUxMPQorKyBlZ3JlcCAnXlteI10qTENfQ1RZ
UEU9JyAvZXRjL2Vudmlyb25tZW50CisrIGN1dCAtZD0gLWYyCisgdmFsdWU9ZW5fSUUKKyBl
dmFsIExDX0NUWVBFPWVuX0lFCisrIExDX0NUWVBFPWVuX0lFCisrIExBTkc9ZnJfRlJAZXVy
bworKyBMQ19BTEw9CisrIExDX0NUWVBFPWVuX0lFCisrIGxvY2FsZSBjaGFybWFwCisgQ0hB
Uk1BUD1JU08tODg1OS0xCisgdGVzdCBJU08tODg1OS0xID0gVVRGLTgKKyAvdXNyL2Jpbi91
bmljb2RlX3N0b3AKKyB0cnVlCisgc2V0dGVybV9hcmdzPQorICdbJyAzMCAnXScKKyBzZXR0
ZXJtX2FyZ3M9IC1ibGFuayAzMAorICdbJyBvZmYgJ10nCisgc2V0dGVybV9hcmdzPSAtYmxh
bmsgMzAgLXBvd2Vyc2F2ZSBvZmYKKyAnWycgMzAgJ10nCisgc2V0dGVybV9hcmdzPSAtYmxh
bmsgMzAgLXBvd2Vyc2F2ZSBvZmYgLXBvd2VyZG93biAzMAorICdbJyAnIC1ibGFuayAzMCAt
cG93ZXJzYXZlIG9mZiAtcG93ZXJkb3duIDMwJyAnXScKKyBzZXR0ZXJtIC1ibGFuayAzMCAt
cG93ZXJzYXZlIG9mZiAtcG93ZXJkb3duIDMwChtbOTszMF0bWzE0OzMwXSsgS0JEUkFURV9B
UkdTPQorICdbJyAtbiAnJyAnXScKKyAnWycgLW4gJycgJ10nCisgJ1snIC1uICcnICddJwor
ICdbJyAtZiAvdmFyL3J1bi9ncG0ucGlkICddJworKyBjYXQgL3Zhci9ydW4vZ3BtLnBpZAor
IGtpbGwgLVdJTkNIIDExMzgKKyAnWycgLXIgL2V0Yy9jb25zb2xlLXRvb2xzL3JlbWFwICdd
JworIGR1bXBrZXlzCisgc2VkIC1mIC9ldGMvY29uc29sZS10b29scy9yZW1hcAorIGxvYWRr
ZXlzIC0tcXVpZXQKKyAnWycgJycgJyE9JyAnJyAnXScK
--------------020709010304060507040603--
