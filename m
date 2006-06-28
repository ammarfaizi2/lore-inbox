Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWF1UOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWF1UOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWF1UOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:14:36 -0400
Received: from aa002msr.fastwebnet.it ([85.18.95.65]:59832 "EHLO
	aa002msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751186AbWF1UOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:14:34 -0400
Date: Wed, 28 Jun 2006 22:14:10 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       stable@kernel.org
Subject: Re: Unkillable process in last git -- Bisected
Message-ID: <20060628221410.68776a24@localhost>
In-Reply-To: <1151521577.10385.3.camel@tribesman.namesys.com>
References: <20060628142918.1b2c25c3@localhost>
	<20060628145349.53873ccc@localhost>
	<20060628150943.78e91871@localhost>
	<20060628151955.0acdb39a@localhost>
	<20060628203825.47790a10@localhost>
	<1151521577.10385.3.camel@tribesman.namesys.com>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 23:06:17 +0400
"Vladimir V. Saveliev" <vs@namesys.com> wrote:

> On Wed, 2006-06-28 at 20:38 +0200, Paolo Ornati wrote:
> > > Running "localedef" triggers an infinite loop in kernel mode (or
> > > something) --> localdef becomes unkillable.
> > > 
> 
> Can you, please, run localedef under strace -e set=open,write on a
> kernel having the below patch applied, so that we will see arguments of
> write which caused write to fall into endless loop.

The full strace is short enough, I think:

$ strace localedef --no-archive -c -i en_US -f ISO-8859-1 -A /usr/share/locale/locale.alias en_US

execve("/usr/bin/localedef", ["localedef", "--no-archive", "-c", "-i", "en_US", "-f", "ISO-8859-1", "-A", "/usr/share/locale/locale.alias", "en_US"], [/* 44 vars */]) = 0
uname({sys="Linux", node="tux", ...})   = 0
brk(0)                                  = 0x549000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f18098000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=163137, ...}) = 0
mmap(NULL, 163137, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b0f18099000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\360\306"..., 640) = 640
lseek(3, 64, SEEK_SET)                  = 64
read(3, "\6\0\0\0\5\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0"..., 616) = 616
lseek(3, 680, SEEK_SET)                 = 680
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0"..., 32) = 32
fstat(3, {st_mode=S_IFREG|0755, st_size=1268224, ...}) = 0
lseek(3, 64, SEEK_SET)                  = 64
read(3, "\6\0\0\0\5\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0\0\0\0@\0\0\0\0"..., 616) = 616
mmap(NULL, 2261000, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b0f1819a000
madvise(0x2b0f1819a000, 2261000, MADV_SEQUENTIAL|0x1) = 0
mprotect(0x2b0f182b9000, 1085448, PROT_NONE) = 0
mmap(0x2b0f183b8000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11e000) = 0x2b0f183b8000
mmap(0x2b0f183be000, 16392, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2b0f183be000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f183c3000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f183c4000
mprotect(0x2b0f183b8000, 12288, PROT_READ) = 0
mprotect(0x2b0f18198000, 4096, PROT_READ) = 0
arch_prctl(ARCH_SET_FS, 0x2b0f183c3ae0) = 0
munmap(0x2b0f18099000, 163137)          = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\363\300\254\335\34A\365\327", 8) = 8
close(3)                                = 0
brk(0)                                  = 0x549000
brk(0x56a000)                           = 0x56a000
open("/usr/lib64/locale/locale-archive", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2586, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f18099000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2586
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x2b0f18099000, 4096)            = 0
open("/usr/lib64/locale/en_US.utf8/LC_MESSAGES", O_RDONLY) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
close(3)                                = 0
open("/usr/lib64/locale/en_US.utf8/LC_MESSAGES/SYS_LC_MESSAGES", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=52, ...}) = 0
mmap(NULL, 52, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b0f18099000
close(3)                                = 0
open("/usr/lib64/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=21546, ...}) = 0
mmap(NULL, 21546, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f1809a000
close(3)                                = 0
open("/usr/lib64/locale/en_US.utf8/LC_CTYPE", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=208464, ...}) = 0
mmap(NULL, 208464, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b0f180a0000
close(3)                                = 0
access("/usr/lib64/locale/en_US", W_OK) = 0
open("ISO-8859-1", O_RDONLY)            = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/charmaps/ISO-8859-1", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/charmaps/ISO-8859-1.gz", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=3150, ...}) = 0
pipe([4, 5])                            = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x2b0f183c3b70) = 4258
close(5)                                = 0
close(3)                                = 0
fcntl(4, F_GETFL)                       = 0 (flags O_RDONLY)
fstat(4, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f180d3000
lseek(4, 0, SEEK_CUR)                   = -1 ESPIPE (Illegal seek)
read(4, "<code_set_name> ISO-8859-1\n<comm"..., 4096) = 4096
read(4, "     LATIN CAPITAL LETTER Z\n<U00"..., 4096) = 4096
read(4, "        SUPERSCRIPT THREE\n<U00B4"..., 4096) = 4096
read(4, "L LETTER U WITH CIRCUMFLEX\n<U00F"..., 4096) = 337
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x2b0f180d3000, 4096)            = 0
open("en_US", O_RDONLY)                 = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/en_US", O_RDONLY) = 3
--- SIGCHLD (Child exited) @ 0 (0) ---
fstat(3, {st_mode=S_IFREG|0644, st_size=5480, ...}) = 0
mmap(NULL, 5480, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 5480, SEEK_SET)                = 5480
open("i18n", O_RDONLY)                  = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/i18n", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=95199, ...}) = 0
mmap(NULL, 95199, PROT_READ, MAP_SHARED, 4, 0) = 0x2b0f180d5000
lseek(4, 95199, SEEK_SET)               = 95199
brk(0x58b000)                           = 0x58b000
mmap(NULL, 262144, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f180ed000
mremap(0x2b0f180ed000, 262144, 524288, MREMAP_MAYMOVE) = 0x2b0f180ed000
brk(0x5ac000)                           = 0x5ac000
brk(0x5d4000)                           = 0x5d4000
mmap(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f1816d000
mmap(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f183c5000
mmap(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f183e6000
brk(0x5c7000)                           = 0x5c7000
mremap(0x2b0f1816d000, 135168, 266240, MREMAP_MAYMOVE) = 0x2b0f18407000
mremap(0x2b0f183c5000, 135168, 266240, MREMAP_MAYMOVE) = 0x2b0f18448000
mremap(0x2b0f183e6000, 135168, 266240, MREMAP_MAYMOVE) = 0x2b0f18489000
mremap(0x2b0f180ed000, 524288, 1048576, MREMAP_MAYMOVE) = 0x2b0f184ca000
mremap(0x2b0f18407000, 266240, 528384, MREMAP_MAYMOVE) = 0x2b0f180ed000
mremap(0x2b0f18448000, 266240, 528384, MREMAP_MAYMOVE) = 0x2b0f183c5000
mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b0f185ca000
brk(0x5a7000)                           = 0x5a7000
mremap(0x2b0f18489000, 266240, 528384, MREMAP_MAYMOVE) = 0x2b0f1864b000
mremap(0x2b0f184ca000, 1048576, 3674112, MREMAP_MAYMOVE) = 0x2b0f186cc000
mremap(0x2b0f186cc000, 3674112, 7344128, MREMAP_MAYMOVE) = 0x2b0f186cc000
mremap(0x2b0f180ed000, 528384, 1052672, MREMAP_MAYMOVE) = 0x2b0f18446000
mremap(0x2b0f183c5000, 528384, 1052672, MREMAP_MAYMOVE) = 0x2b0f18dcd000
mremap(0x2b0f185ca000, 528384, 1052672, MREMAP_MAYMOVE) = 0x2b0f18ece000
mremap(0x2b0f1864b000, 528384, 1052672, MREMAP_MAYMOVE) = 0x2b0f18547000
brk(0x5c8000)                           = 0x5c8000
brk(0x5e9000)                           = 0x5e9000
brk(0x60a000)                           = 0x60a000
brk(0x62b000)                           = 0x62b000
brk(0x64c000)                           = 0x64c000
brk(0x66d000)                           = 0x66d000
fstat(4, {st_mode=S_IFREG|0644, st_size=95199, ...}) = 0
munmap(0x2b0f180d5000, 95199)           = 0
close(4)                                = 0
open("iso14651_t1", O_RDONLY)           = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/iso14651_t1", O_RDONLY) = 4
fstat(4, {st_mode=S_IFREG|0644, st_size=47626, ...}) = 0
mmap(NULL, 47626, PROT_READ, MAP_SHARED, 4, 0) = 0x2b0f180d5000
lseek(4, 47626, SEEK_SET)               = 47626
brk(0x68e000)                           = 0x68e000
brk(0x68d000)                           = 0x68d000
brk(0x6ae000)                           = 0x6ae000
brk(0x6cf000)                           = 0x6cf000
brk(0x6f0000)                           = 0x6f0000
brk(0x711000)                           = 0x711000
brk(0x73d000)                           = 0x73d000
fstat(4, {st_mode=S_IFREG|0644, st_size=47626, ...}) = 0
munmap(0x2b0f180d5000, 47626)           = 0
close(4)                                = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=5480, ...}) = 0
munmap(0x2b0f180d3000, 5480)            = 0
close(3)                                = 0
open("translit_neutral", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_neutral", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=7383, ...}) = 0
mmap(NULL, 7383, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 7383, SEEK_SET)                = 7383
brk(0x75e000)                           = 0x75e000
fstat(3, {st_mode=S_IFREG|0644, st_size=7383, ...}) = 0
munmap(0x2b0f180d3000, 7383)            = 0
close(3)                                = 0
open("translit_circle", O_RDONLY)       = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_circle", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=14116, ...}) = 0
mmap(NULL, 14116, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 14116, SEEK_SET)               = 14116
brk(0x77f000)                           = 0x77f000
fstat(3, {st_mode=S_IFREG|0644, st_size=14116, ...}) = 0
munmap(0x2b0f180d3000, 14116)           = 0
close(3)                                = 0
open("translit_cjk_compat", O_RDONLY)   = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_cjk_compat", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=59104, ...}) = 0
mmap(NULL, 59104, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 59104, SEEK_SET)               = 59104
brk(0x7a0000)                           = 0x7a0000
brk(0x7c1000)                           = 0x7c1000
brk(0x7e2000)                           = 0x7e2000
brk(0x803000)                           = 0x803000
fstat(3, {st_mode=S_IFREG|0644, st_size=59104, ...}) = 0
munmap(0x2b0f180d3000, 59104)           = 0
close(3)                                = 0
open("translit_compat", O_RDONLY)       = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_compat", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=34361, ...}) = 0
mmap(NULL, 34361, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 34361, SEEK_SET)               = 34361
brk(0x824000)                           = 0x824000
fstat(3, {st_mode=S_IFREG|0644, st_size=34361, ...}) = 0
munmap(0x2b0f180d3000, 34361)           = 0
close(3)                                = 0
open("translit_font", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_font", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=58986, ...}) = 0
mmap(NULL, 58986, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 58986, SEEK_SET)               = 58986
brk(0x845000)                           = 0x845000
brk(0x866000)                           = 0x866000
brk(0x887000)                           = 0x887000
brk(0x8a8000)                           = 0x8a8000
fstat(3, {st_mode=S_IFREG|0644, st_size=58986, ...}) = 0
munmap(0x2b0f180d3000, 58986)           = 0
close(3)                                = 0
open("translit_fraction", O_RDONLY)     = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_fraction", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=2380, ...}) = 0
mmap(NULL, 2380, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 2380, SEEK_SET)                = 2380
fstat(3, {st_mode=S_IFREG|0644, st_size=2380, ...}) = 0
munmap(0x2b0f180d3000, 2380)            = 0
close(3)                                = 0
open("translit_narrow", O_RDONLY)       = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_narrow", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=6210, ...}) = 0
mmap(NULL, 6210, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 6210, SEEK_SET)                = 6210
brk(0x8c9000)                           = 0x8c9000
fstat(3, {st_mode=S_IFREG|0644, st_size=6210, ...}) = 0
munmap(0x2b0f180d3000, 6210)            = 0
close(3)                                = 0
open("translit_small", O_RDONLY)        = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_small", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=3088, ...}) = 0
mmap(NULL, 3088, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 3088, SEEK_SET)                = 3088
fstat(3, {st_mode=S_IFREG|0644, st_size=3088, ...}) = 0
munmap(0x2b0f180d3000, 3088)            = 0
close(3)                                = 0
open("translit_wide", O_RDONLY)         = -1 ENOENT (No such file or directory)
open("/usr/share/i18n/locales/translit_wide", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=5030, ...}) = 0
mmap(NULL, 5030, PROT_READ, MAP_SHARED, 3, 0) = 0x2b0f180d3000
lseek(3, 5030, SEEK_SET)                = 5030
fstat(3, {st_mode=S_IFREG|0644, st_size=5030, ...}) = 0
munmap(0x2b0f180d3000, 5030)            = 0
close(3)                                = 0
brk(0x8ea000)                           = 0x8ea000
brk(0x910000)                           = 0x910000
unlink("/usr/lib64/locale/en_US/LC_CTYPE") = 0
creat("/usr/lib64/locale/en_US/LC_CTYPE", 0666) = 3
writev(3, [{"\25\21\3 X\0\0\0", 8}, {"h\1\0\0h\4\0\0h\n\0\0h\n\0\0h\20\0\0h\20\0\0h\24\0\0h\24"..., 352}, {"\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2\0\2"..., 768}, {"\200\0\0\0\201\0\0\0\202\0\0\0\203\0\0\0\204\0\0\0\205"..., 1536}, {NULL, 0}, {"\200\0\0\0\201\0\0\0\202\0\0\0\203\0\0\0\204\0\0\0\205"..., 1536}, {NULL, 0}, {"\0\0\2\0\0\0\2\0\0\0\2\0\0\0\2\0\0\0\2\0\0\0\2\0\0\0\2"..., 1024}, {NULL, 0}, {NULL, 0}, {NULL, 0}, {NULL, 0}, {"upper\0", 6}, {"lower\0", 6}, {"alpha\0", 6}, {"digit\0", 6}, {"xdigit\0", 7}, {"space\0", 6}, {"print\0", 6}, {"graph\0", 6}, {"blank\0", 6}, {"cntrl\0", 6}, {"punct\0", 6}, {"alnum\0", 6}, {"combining\0", 10}, {"combining_level3\0", 17}, {"\0\0\0\0", 4}, {"toupper\0", 8}, {"tolower\0", 8}, {"totitle\0", 8}, {"\0\0\0\0", 4}, {"\20\0\0\0\1\0\0\0\7\0\0\0\377\1\0\0\177\0\0\0\30\0\0\0"..., 2328}, ...], 125

-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
