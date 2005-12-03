Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVLCI5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVLCI5z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 03:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVLCI5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 03:57:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14863 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751219AbVLCI5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 03:57:54 -0500
Date: Sat, 3 Dec 2005 09:57:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] clean-boot.pl version 0.1 - Simple utility to clean up /boot and /lib/modules
Message-ID: <20051203085734.GB22139@alpha.home.local>
References: <1133573415.32583.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133573415.32583.108.camel@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 08:30:15PM -0500, Steven Rostedt wrote:
> I'm not sure if this has been done already or not (let me know if it
> has), but I've just noticed that after playing with several
> developmental kernels I had about 30 to 40 different versions of
> vmlinuz, initrd.img, config, and System.maps in my /boot directory, not
> to mention all the modules loaded in /lib/modules.

One more reason to put kernels and modules into /boot. On my systems,
/lib/modules is a symlink to /boot, so that I have my modules
physically located in /boot/<kversion> and my kernel, config, System.map, ...
into the same directory. So I just have to rm -rf /boot/<kversion> to remove
one kernel, and managing them is very easy. One more advantage is that
when you build many kernels, you just 'sudo make modules_install' first,
which creates the /boot/<kversion> entry, then you just have to
'sudo cp arch/i386/boot/bzImage System.map .config /boot/<kversion>/'
which is very convenient.

The default flat /boot directory + /lib/modules is a real mess, proved
by the fact that you had to write a tool just to manage that. Not that
I find your script useless at all, it's the opposite, I think it will
make life easier for people who want to keep this obsolete directory
structure.

> So I wrote this perl script that let me pick and choose what I wanted to
> clean up.  Be careful, this must be run as root, and although the
> default is to do nothing, if you hit a "y" in the wrong place, you can
> lose that kernel.
> 
> The script is here:
> 
> http://www.kihontech.com/code/clean-boot.pl
> 
> Here's the usage:
> 
> # ./clean-boot.pl -h
> 
> usage: clean-boot.pl [-b boot_dir] [-m module_dir]
>   (version 0.1)
>    default boot_dir = /boot
>    default module_dir = /lib/modules
> 
> It's run like the following:
> 
> ---
> #./clean-boot.pl
> List of versions found:
>   2.6.12-1-386              2.6.14                    2.6.14-2-386
>   2.6.14-2-k7-smp           2.6.14-kthrt2             2.6.14-rt13
>   2.6.14-rt13-logdev1       2.6.14-rt15               2.6.14-rt20
>   2.6.15-rc3
> Remove files for version 2.6.12-1-386 [y/N/l/q/?]:  ?
>   y - remove files from boot and modules
>   n [default] - skip this version
>   l - list the found versions again
>   q - quit
>   ? - display this message
> Remove files for version 2.6.12-1-386 [y/N/l/q/?]:  q
> ---
> 
> If you hit "y" (or yes or ye, case is ignored), it will then remove any
> of the vmlinuz, initrd.img, config and System.map files for version
> 2.6.12-1-386 in /boot and the directory /lib/modules/2.6.12-1-386.
> 
> This is under just a public license, no warranty, so just be careful not
> to delete too much.
> 
> Also remember to update lilo or grub, since this doesn't handle that.
> 
> Comments?
> 
> -- Steve

Regards,
Willy

