Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283782AbRLROYG>; Tue, 18 Dec 2001 09:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283783AbRLROX4>; Tue, 18 Dec 2001 09:23:56 -0500
Received: from mail.elte.hu ([157.181.151.13]:41991 "HELO mail.elte.hu")
	by vger.kernel.org with SMTP id <S283782AbRLROXo>;
	Tue, 18 Dec 2001 09:23:44 -0500
Date: Tue, 18 Dec 2001 15:23:39 +0100
From: BURJAN Gabor <burjang@elte.hu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17-rc1 kernel panic at boot
Message-ID: <20011218142339.GA12011@csoma.elte.hu>
In-Reply-To: <3C1E2B61.3F9A685E@zip.com.au> <2375.1008649127@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2375.1008649127@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.3.24i
X-Accept-Language: en, hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Dec 18, Keith Owens wrote:

> Not need to go quite that far.  It is not necessary to recompile the
> entire kernel nor do you need to boot a kernel to get the source code
> for an instruction.
> 
> cd linux
> rm drivers/net/3c59x.o
> make CFLAGS_3c59x.o=-g vmlinux
> s=$(sed -ne '/vortex_probe1/s/ .*//p' System.map | tr '[a-z]' '[A-Z]')
> e=$(echo -e "obase=16\nibase=16\n$s+500" | bc)
> objdump -S --start-address=0x$s --stop-address=0x$e vmlinux

I did this.

c0264048:       39 32 00 0e     addi    r9,r18,14
c026404c:       7d 29 52 14     add     r9,r9,r10
c0264050:       91 7d 01 90     stw     r11,400(r29)    <==
        vp->options = option;
c0264054:       93 fd 01 8c     stw     r31,396(r29)

Full output: http://www.csoma.elte.hu/~burjang/objdump-2001-12-18.out

	buga
