Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbSJKMnI>; Fri, 11 Oct 2002 08:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262255AbSJKMnI>; Fri, 11 Oct 2002 08:43:08 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:31626 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262241AbSJKMnH> convert rfc822-to-8bit; Fri, 11 Oct 2002 08:43:07 -0400
Message-ID: <3DA6C8A3.2892656@folkwang-hochschule.de>
Date: Fri, 11 Oct 2002 14:48:35 +0200
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Reply-To: lad <linux-audio-dev@music.columbia.edu>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lad <linux-audio-dev@music.columbia.edu>, Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: latency performance of 2.4 and 2.5...
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi andrew, hi everyone !

as per your request, i fearlessly built and booted 2.5.41 with
preemption enabled.
although it was my first take at the dev kernel, it went very smoothly
:-D

anyway, it seems to perform worse than 2.4.20-pre1-lowlatency. it feels
very snappy on startup, but under load it is a lot less responsive to
user interaction.

i have run benno senoner's latencytest on both kernels. you can see the
results at 

	http://spunk.dnsalias.org/latencytest .

for me, the biggest problem seems to be soft-raid. i have my /var
partition striped over 2 scsi disks, and accessing them causes huge
latency peaks.
is there any chance to get this under control ?
i don't have a spare disk around, so i can't easily compare to non-raid,
but i'm quite sure it's the source of the problem, because people with
similar hardware are doing fine.

other than that, there were a few peaks under /proc stress, but they are
not easily reproducible.

i have not yet tested your mm-patches due to a compile failure (log is
attached below). i used
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.41/2.5.41-mm3/2.5.41-mm3.gz.


if there's any patches to try or more benchmarks to run, let me know.

best,

jörn


***
Hardware: Dual-P3 @ 600Mhz, 512MB PC100 SDRAM, ASUS P2B-DS
one 4G IBM DCAS SCSI disk (/), 2 9G COMPAQ SCSI disks (/var, soft-RAID
0),
SCSI CDROM and CDR, no IDE devices.

Soundcards: SB Live (used during the tests) and Ensoniq 1371 (idle)
The audio file that was played back during the tests came over NFS.

***
make -f init/Makefile
  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686 -Iarch/i386/mach-generic
-fomit-frame-pointer -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o
init/do_mounts.o
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o
--start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o 
fs/built-in.o  ipc/built-in.o  security/built-in.o  lib/lib.a 
arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o .tmp_vmlinux1
fs/built-in.o: In function `isofs_put_super':
fs/built-in.o(.text+0x390e5): undefined reference to `unload_nls'
fs/built-in.o: In function `isofs_fill_super':
fs/built-in.o(.text+0x39f0b): undefined reference to `load_nls'
fs/built-in.o(.text+0x39f25): undefined reference to `load_nls_default'
fs/built-in.o(.text+0x3a0c6): undefined reference to `unload_nls'
fs/built-in.o: In function `wcsntombs_be':
fs/built-in.o(.text+0x3c60b): undefined reference to `utf8_wctomb'
make: *** [.tmp_vmlinux1] Error 1




-- 
Jörn Nettingsmeier     
Kurfürstenstr 49, 45138 Essen, Germany      
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)
