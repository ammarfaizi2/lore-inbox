Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283836AbRLRETU>; Mon, 17 Dec 2001 23:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284017AbRLRETK>; Mon, 17 Dec 2001 23:19:10 -0500
Received: from zok.SGI.COM ([204.94.215.101]:30363 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S283836AbRLRETA>;
	Mon, 17 Dec 2001 23:19:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: BURJAN Gabor <burjang@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 kernel panic at boot 
In-Reply-To: Your message of "Mon, 17 Dec 2001 09:29:05 -0800."
             <3C1E2B61.3F9A685E@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Dec 2001 15:18:47 +1100
Message-ID: <2375.1008649127@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2001 09:29:05 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>BURJAN Gabor wrote:
>> >>NIP; c0264050 <vortex_probe1+394/cbc>   <=====
>> Trace; c0263f28 <vortex_probe1+26c/cbc>
>
>That's a big function, unfortunately.   Could you please
>do the following?
>
>In the top-level makefile, add the line:
>
>CFLAGS += -g
>
>right at the end.    Then rebuild the kernel, recreate the
>crash, then run:
>
>gdb vmlinux
>(gdb) l *0xc0264050

Not need to go quite that far.  It is not necessary to recompile the
entire kernel nor do you need to boot a kernel to get the source code
for an instruction.

cd linux
rm drivers/net/3c59x.o
make CFLAGS_3c59x.o=-g vmlinux
s=$(sed -ne '/vortex_probe1/s/ .*//p' System.map | tr '[a-z]' '[A-Z]')
e=$(echo -e "obase=16\nibase=16\n$s+500" | bc)
objdump -S --start-address=0x$s --stop-address=0x$e vmlinux

That recompiles just 3c59x.o with -g and dumps the first 0x500 bytes of
vortex_probe1, including the source code.

