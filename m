Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSDVOgh>; Mon, 22 Apr 2002 10:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313019AbSDVOgg>; Mon, 22 Apr 2002 10:36:36 -0400
Received: from boden.synopsys.com ([204.176.20.19]:11170 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S312610AbSDVOgf>; Mon, 22 Apr 2002 10:36:35 -0400
Date: Mon, 22 Apr 2002 16:36:06 +0200
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.1 is available
Message-ID: <20020422163606.A1142@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <27268.1019374988@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 05:43:08PM +1000, Keith Owens wrote:
> 
> Release 2.1 of kernel build for kernel 2.5 (kbuild 2.5) is available.
> http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
> release 2.1.
> 

Hi, i've got some problems with 2.1:

First, i needed to interrupt the build (Ctrl-C), did that,
and once i let it really run freely, got this:

$ time nice -4 make -f Makefile-2.5 CC=/usr/bin/gcc
Using ARCH='i386' AS='as' LD='ld' CC='/usr/bin/gcc' CPP='/usr/bin/gcc -E'
 AR='ar' HOSTAS='as' HOSTLD='gcc' HOSTCC='gcc' HOSTAR='ar'
Generating global Makefile
  phase 1 (find all inputs)
pp_makefile1: .tmp_db_main was not shut down correctly, forcing complete rebuild
pp_makefile1: .../v2.5-1/scripts/pp_db.c:158: alloc_db_chunk: Assertion `__tv.dptr' failed.
make: *** [phase1] Error 134

trying to make clean didn't help, btw. I removed .tmp* and did make
oldconfig (suggested by kbuild), which helped.


Next, i needed to comment out line about dc2xx.o in
drivers/usb/image/Makefile.in (it doesn't has source anymore) to make it
compile.


And the last:
.../v2.5-1/arch/i386/kernel/entry.S:223: unterminated character constant
.../v2.5-1/arch/i386/kernel/entry.S:264: unterminated character constant
.../v2.5-1/arch/i386/kernel/entry.S:280: unterminated character constant


That was Linus's bk tree (cset 1.562)
+ kbuild-2.5-core-4
+ kbuild-2.5-common-2.5.8-pre3-1
+ kbuild-2.5-i386-2.5.8-pre3-1

P.S. "phase 1" for xconfig is evil, is it absolutely unavoidable?
