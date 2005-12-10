Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVLJCQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVLJCQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVLJCQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:16:56 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:33761
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751301AbVLJCQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:16:55 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Fri, 9 Dec 2005 20:16:42 -0600
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051203152339.GK31395@stusta.de> <20051204232205.GF8914@kroah.com> <4395A72E.6030006@tmr.com>
In-Reply-To: <4395A72E.6030006@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512092016.42825.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 December 2005 08:58, Bill Davidsen wrote:
> Greg KH wrote:
> > On Sun, Dec 04, 2005 at 04:46:31AM +0000, Luke-Jr wrote:
> >>Well, devfs does have some abilities udev doesn't: hotplug/udev
> >>doesn't detect everything, and can result in rarer or non-PnP devices
> >>not being automatically available;
> >
> > Are you sure about that today?  And udev wasn't created to do everything
> > that devfs does.  And devfs can't do everything that udev can (by
> > far...)
> >
> >>devfs has the effect of trying to load a module when a program looks
> >>for the devices it provides-- while it can cause problems, it does
> >>have a possibility to work better.
> >
> > Sorry, but that model of loading modules is very broken and it is good
> > that we don't do that anymore (as you allude to.)
> >
> >>Interesting effects of switching my desktop from devfs to udev:
> >>1. my DVD burners are left uninitialized until I manually modprobe ide-cd
> >> or (more recently) ide-scsi
> >
> > Sounds like a broken distro configuration :)
> >
> >>2. my sound card is autodetected and the drivers loaded, but the OSS
> >> emulation modules are omitted; with devfs, they would be autoloaded when
> >> an app tried to use OSS
> >
> > Again, broken distro configuration :)
>
> If a new udev config is needed with every new kernel, why isn't it in
> the kernel tarball?

Why isn't inittab in the kernel tarball?

I have a shell script that initializes /dev.  (I've posted it here a few 
times, somebody ported it to C, and a micro-udev replacement will go into 
busybox in 1.2.)

Why isn't there a command shell in the kernel tarball?  Kinda hard to use your 
system without a shell...

As far as I can tell, what broke with udev was their embedded version of 
"libsysfs", which is an abstraction layer I've _never_ understood the point 
of.  (Because opening single value files in /sys is just too hard.  Nobody 
needed a "libproc", the parsing of which is actual work, but they felt a need 
a libsysfs.  Uh-huh...)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
