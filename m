Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284264AbRLBRmv>; Sun, 2 Dec 2001 12:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284262AbRLBRme>; Sun, 2 Dec 2001 12:42:34 -0500
Received: from mail128.mail.bellsouth.net ([205.152.58.88]:9114 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284259AbRLBRm1>; Sun, 2 Dec 2001 12:42:27 -0500
Message-ID: <3C0A67FD.D2D59E84@mandrakesoft.com>
Date: Sun, 02 Dec 2001 12:42:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dalecki@evision.ag
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>,
        Christer Weinigel <wingel@hog.ctrl-c.liu.se>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <3C0A5A61.62A0F885@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> 
> Jeff Garzik wrote:
> >
> > I do not plan to submit this patch to Linus/Marcelo.
> >
> > This patch applies an obvious technique to the kernel:  increase the
> > amount of code compiled in a single compilation unit, to increase the
> > overall knowledge the compiler has of the code, to allow for better
> > optimization and dead code removal.  KDE does this, with definite
> > success, though they definitely are not the first to do this.
> >
> > Simply, all ext2 files are #include'd into a single file, ext2_all.c,
> > and all functions and data structures are declared static.
> >
> > This technique can be used in the kernel, userspace applications, and
> > userspace libraries to decrease icache footprint and overall size of
> > your applications.
> >
> > Results from 2.4.17-pre2 plus the attached patch:  1135 bytes saved in
> > vmlinux, simply from making all the functions static.
> > (*.orig is prior to my patch.  kernel is P2 SMP-based)
> > > [jgarzik@rum linux-e2all]$ ls -l vmlinux* arch/i386/boot/bzImage*
> > > -rw-r--r--    1 jgarzik  jgarzik   1030259 Dec  2 06:18 arch/i386/boot/bzImage
> > > -rw-r--r--    1 jgarzik  jgarzik   1030263 Dec  2 06:04 arch/i386/boot/bzImage.orig
> > > -rwxr-xr-x    1 jgarzik  jgarzik   2814631 Dec  2 06:18 vmlinux*
> > > -rwxr-xr-x    1 jgarzik  jgarzik   2815766 Dec  2 06:04 vmlinux.orig*
> r
> 
> size vmlinux
> and
> size vmlinux.orig
> 
> would be a bit more telling whatever the reaons of the impact is.

easily done, on the latest CONFIG_FINAL patch posted to lkml:

[jgarzik@rum linux.test]$ size vmlinux.vanilla 
   text    data     bss     dec     hex filename
1908047  274672  353340 2536059  26b27b vmlinux.vanilla

[jgarzik@rum linux.test]$ size vmlinux
   text    data     bss     dec     hex filename
1905136  273808  352860 2531804  26a1dc vmlinux

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

