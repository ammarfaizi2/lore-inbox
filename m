Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423011AbWJFXyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423011AbWJFXyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423010AbWJFXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:54:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56212 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423011AbWJFXyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:54:44 -0400
Date: Fri, 6 Oct 2006 16:54:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
Message-Id: <20061006165425.23b326e0.akpm@osdl.org>
In-Reply-To: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006 01:36:24 +0200
"Jesper Juhl" <jesper.juhl@gmail.com> wrote:

> Hi,
> 
> I've been using the this very simple script for a while to do test
> builds of the kernel :
> 
> 
> #!/bin/bash
> 
> for i in $(seq 1 100); do
>         nice make distclean
>         while true; do
>                 nice make randconfig
>                 grep -q "CONFIG_EXPERIMENTAL=y" .config
>                 if [ $? -eq 1 ]; then
>                         break
>                 fi
>         done
>         cp .config config.${i}
>         nice make -j3 > build.log.${i} 2>&1
> done
> 
> 
> Which has worked great in the past, but with recent kernels it has
> been a sure way to cause a complete lockup within 1 hour :-(
> 

This is probably one of those nobody-but-you-can-reproduce-it things.

> 
> The last kernel where I know for sure that it ran without problems is
> 2.6.17.13 .
> The first kernel where I know for sure it caused lockups is
> 2.6.18-git15 .   I've also tested 2.6.18-git16, 2.6.18-git21 and
> 2.6.19-rc1-git2 and those 3 also lock up solid.
> 
> The lockup usually happens within 30 minutes, but sometimes the box
> survives longer, but I've not seen it survive for more than 60 minutes
> at most.
> It doesn't seem to matter if I leave it alone just building kernels or
> if I use it for other purposes while building in the background - if
> anything, it seems to survive longer when I do other work while it
> builds.
> 
> When the lockup happens the box just freezes and doesn't respond to
> anything at all. Sometimes I can reboot with alt+sysrq+b but sometimes
> not even that works.

If you can do sysrq-b then you can do sysrq-t, too?

Please ensure that you have all the CONFIG_DEBUG_* things set, apart from
PAGEALLOC.

> Here's exactely what I do, so you can try to reproduce :
> 
> 1) boot my distro (Slackware 11.0) into runlevel 4 (multi-user with
> X), using kernel 2.6.19-rc1-git2 (or one of the other "known-bad"
> kernels).
> 
> 2) Log in via kdm, and once I'm at my KDE desktop I start 'konsole'.
> 
> 3) cd into a dir holding a fresh copy of the 2.6.19-rc1-git2 source
> and run the above script from a file named build-random.sh that I have
> placed in the root of the source dir and made executable.
> 
> 4) wait for 0-60 minutes.
> 
> 
> After a reboot I find nothing in the logs, so I can't give you many
> hints on what goes wrong, unfortunately.
>

Once you've got the test set up and running, you can do the alt-ctl-F1
thing to take you out of X and into the vga console.  I suggest you leave
it running that way, see if anything pops up when it hangs.

