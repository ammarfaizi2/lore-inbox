Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315919AbSGLKS7>; Fri, 12 Jul 2002 06:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315925AbSGLKS6>; Fri, 12 Jul 2002 06:18:58 -0400
Received: from tao.natur.cuni.cz ([195.113.56.1]:56335 "EHLO natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S315919AbSGLKS5>;
	Fri, 12 Jul 2002 06:18:57 -0400
X-Obalka-From: mmokrejs@natur.cuni.cz
Date: Fri, 12 Jul 2002 12:21:42 +0200 (CEST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Missing files in 2.4.19-rc1
In-Reply-To: <200207120513.48616.kelledin+LKML@skarpsey.dyndns.org>
Message-ID: <Pine.OSF.4.44.0207121216580.264794-100000@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Kelledin wrote:

Hi,

> > via-pmu.c:40: asm/prom.h: No such file or directory
> > via-pmu.c:41: asm/machdep.h: No such file or directory
> > via-pmu.c:45: asm/sections.h: No such file or directory
> > via-pmu.c:48: asm/pmac_feature.h: No such file or directory
> > via-pmu.c:51: asm/sections.h: No such file or directory
> > via-pmu.c:52: asm/cputable.h: No such file or directory
> > via-pmu.c:53: asm/time.h: No such file or directory
[...]
> Dumb question: Did you do a make menuconfig/config/xconfig, or just copy over
> your .config file from an old kernel?  Was a make mrproper done at any time?

I extracted 2.4.18 src tree, patched (no errors while untarring the
archive or patching). I did `make menuconfig`, loaded external config file
created from 2.4.18-pre2, exited and saved setting from menuconfig, run
`make dep`.

>
> When you first untar a stock kernel source tree, the "include/asm" directory
> does not exist in the tree.  When you make config/menuconfig/xconfig, an
> "include/asm" symlink gets created (among other things), linking to an
> architecture specific asm header directory like include/asm-i386 or the like.
> "make mrproper" destroys this symlink as part of the source tree cleanup.

No `make mrproper` at all.

>
> So if you fail to do the make *config, or you do a make mrproper after your
> most recent make *config, you lose that symlink.  Thus a possible cause for
> the errors you're getting.

Hmm, I have:

$ ls -la include/asm
lrwxrwxrwx    1 root     root            8 Jul 12 11:32 include/asm -> asm-i386
$ ls -la include/asm-i386
total 648
drwxr-xr-x    2 573      573          4096 Jul 12 11:31 .
drwxr-xr-x   26 573      573          4096 Jul 12 11:35 ..
-rw-r--r--    1 573      573           764 Jun 16  1995 a.out.h
-rw-r--r--    1 root     root         2535 Jul 12 11:35 apic.h
-rw-r--r--    1 573      573          9125 Aug 12  2001 apicdef.h
-rw-r--r--    1 573      573          5066 Nov 22  2001 atomic.h
-rw-r--r--    1 573      573          9625 Nov 22  2001 bitops.h
-rw-r--r--    1 573      573           409 Apr 16  1997 boot.h
[...]

So, what to do now? ;)
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585

