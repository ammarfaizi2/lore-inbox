Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262373AbTAUGBO>; Tue, 21 Jan 2003 01:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbTAUGBO>; Tue, 21 Jan 2003 01:01:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:17145 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262373AbTAUGBL>;
	Tue, 21 Jan 2003 01:01:11 -0500
Message-Id: <200301210608.h0L68n9a031102@northrelay01.pok.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Vamsi Krishna S." <vamsi_krishna@in.ibm.com>
To: "Mikael Pettersson" <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess
Date: Tue, 21 Jan 2003 11:56:01 +0530
References: <200301201341.OAA23795@harpo.it.uu.se>
Reply-To: vamsi_krishna@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003 19:12:52 +0530, Mikael Pettersson wrote:

> And why does KBUILD_MODNAME change the name like this? A grep for KBUILD_MODNAME
> shows that it's only used in #ifdef and __stringify(). __stringify()
> macro-expands its argument before turning it to a string literal. If this is
> intensional, then its a bug, since it breaks module parameters to any module
> whose (munged) name also is a #define. (I was bitten by that myself recently
> when adding a module param to ide-scsi.c.)
> 
> Would anything break if we made scripts/Makefile.lib set KBUILD_MODNAME to the
> original module name in "", drop the __stringify() around uses of
> KBUILD_MODNAME, and remove the s/-/_/ from kernel/param.c ?
> 
This is what Rusty had to say regd s/-/_/ for KBUILD_MODNAME.

--Vamsi.

--quote--
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: vamsi@in.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-'
Date: Tue, 17 Dec 2002 11:17:05 +1100

In message <Pine.LNX.4.50.0212161831340.1804-100000@montezuma.mastecende.com> y
ou write:
> On Tue, 17 Dec 2002, Rusty Russell wrote:
>
> > How did you get a module which has - in its name?  The build system
> > *should* turn them into _'s.
>
> ALSA modules?
>
> -rw-r--r--    1 root     root       170125 Dec 15 00:10 snd-mixer-oss.ko
> -rw-r--r--    1 root     root       143685 Dec 15 00:10 snd-mpu401-uart.ko
> -rw-r--r--    1 root     root       312564 Dec 15 00:10 snd-opl3-lib.ko
> -rw-r--r--    1 root     root       194307 Dec 15 00:10 snd-opl3sa2.ko
> -rw-r--r--    1 root     root       612512 Dec 15 00:10 snd-opl3-synth.ko
> -rw-r--r--    1 root     root      1160272 Dec 15 00:10 snd-pcm.ko
>
> But they do get converted when we load ie snd-pcm turns into snd_pcm

Yes, the filenames are unchanged.  But if you modprobe snd-mixer-oss,
you'll see snd_mixer_oss in /proc/modules.  But rmmod "snd-mixer-oss"
works as expected.  Basically, the kernel and tools see them as
equivalent: anything else is a bug, please report.

BTW, this was done for (1) simplicity, (2) so KBUILD_MODNAME can be
used to construct identifiers, and (3) so parameters when the module
is built-in have a consistent name.

Hope that clarifies!
