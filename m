Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284944AbRL2RMS>; Sat, 29 Dec 2001 12:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284956AbRL2RMH>; Sat, 29 Dec 2001 12:12:07 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:51216 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S284944AbRL2RLz>;
	Sat, 29 Dec 2001 12:11:55 -0500
From: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
To: kaos@ocs.com.au
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <7974.1009590240@ocs3.intra.ocs.com.au> (message from Keith Owens
	on Sat, 29 Dec 2001 12:44:00 +1100)
Subject: Re: State of the new config & build system
Reply-To: wingel@t1.ctrl-c.liu.se
In-Reply-To: <7974.1009590240@ocs3.intra.ocs.com.au>
Message-Id: <20011229171153.49D4C36DE6@hog.ctrl-c.liu.se>
Date: Sat, 29 Dec 2001 18:11:53 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
>   Run make dep after -
> 
>     A change to .config.

Ok

>     Any source change, it might have changed the #include list.
>     Any source or command line change that affects generated files.

Not really, I only need to run "make dep" if I change a #include or
mess with generated files somehow.  When I'm hacking on a driver, I
think I'm supposed to be clever enough to realise when it's time to
run "make dep".

When I apply a patch from somebody else, I usually don't know exactly
what has changed, so to be on the safe side I should always run "make
oldconfig && make dep" after applying a patch.

If I move the kernel tree so that the absolute paths won't match any
more, I also run "make dep".

> How do you automate that?  You end up saying that you always run make
> dep.

I don't want to automate that.  In my opinion trying to automatically
figure out when to run make dep is overkill (except to run make dep a
first time when it hasn't been run before).

Anyway, from what you have said it seems as if the slowdowns are due
to two things, checking dependencies every time and doing the
translation of absolute to relative paths.  I'm not arguing against
kbuild-2.5, what I want to say is that I think that not all of the
nine bugs you mention are showstoppers.  If you can get kbuild-2.5
into the kernel without the absolute->relative translation, why not do
it?

I just noted the option:

    make NO_MAKEFILE_GEN=anything

which allows me to test things rather quickly (does this avoid the
absolute->relative conversion?) so it seems as if you've fixed this
already.  :-)

One thing I'd like to change though:

Error: the previous kbuild used NO_MAKEFILE_GEN, install is not safe
       You must do a clean kbuild without NO_MAKEFILE_GEN before doing
       install

I don't care that it is unsafe, if I know what I'm doing I don't want
the computer to say "Sorry Dave, I can't let you do that".  My current
way of working with embedded systems is to install etherboot on the
machine and the suck the kernel over tftp and mount the root file
system using NFS.  The way I work is usually:

    change a source file (e.g. drivers/char/scx200_watchdog.c)
    make SUBDIRS=drivers/char modules
    make INSTALL_MOD_PATH=/export/nfs/00601D1D1D52 modules_install
    reboot the target system and test the change

Of course I could just copy the module by hand, but when there is a
whole build system that does things, it would be nice to be able to
use it.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
