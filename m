Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261742AbSLQATo>; Mon, 16 Dec 2002 19:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLQATo>; Mon, 16 Dec 2002 19:19:44 -0500
Received: from dp.samba.org ([66.70.73.150]:57783 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261742AbSLQATn>;
	Mon, 16 Dec 2002 19:19:43 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: vamsi@in.ibm.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
In-reply-to: Your message of "Mon, 16 Dec 2002 18:39:58 CDT."
             <Pine.LNX.4.50.0212161831340.1804-100000@montezuma.mastecende.com> 
Date: Tue, 17 Dec 2002 11:17:05 +1100
Message-Id: <20021217002740.598D32C05B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
