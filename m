Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313126AbSDIKyl>; Tue, 9 Apr 2002 06:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSDIKyk>; Tue, 9 Apr 2002 06:54:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50698 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313126AbSDIKyj>; Tue, 9 Apr 2002 06:54:39 -0400
Date: Tue, 9 Apr 2002 12:54:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: m.knoblauch@TeraPort.de
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp fixes] Re: Linux 2.4.19pre5-ac3
Message-ID: <20020409105440.GB14695@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3CB1B89D.13DDF456@TeraPort.de> <20020408215908.GI31172@atrey.karlin.mff.cuni.cz> <3CB29AE3.E3447952@TeraPort.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > +
> > > > +You have two ways to use this code. The first one is if you've compiled in
> > > > +sysrq support then you may press Sysrq-D to request suspend. The other way
> > > > +is with a patched SysVinit (my patch is against 2.76 and available at my
> > > > +home page). You might call 'swsusp' or 'shutdown -z <time>'.
> > > > +
> > > > +Either way it saves the state of the machine into active swaps and then
> > > > +reboots. By the next booting the kernel's resuming function is either triggered
> > > > +by swapon -a (which is ought to be in the very early stage of booting) or you
> > > > +may explicitly specify the swap partition/file to resume from with ``resume=''
> > > > +kernel option. If signature is found it loads and restores saved state. If the
> > >
> > >  Does it have to be an "active swap partition"? What about systems
> > > without active swap, but space enough for a partition?
> > 
> > There you just make it partition and then mkswap/swapon it. Or did I
> > misunderstand the question?
> >                                                                 Pavel
> Pavel,
> 
>  maybe I was unclear. For reasons of interactivity, I do not have any
> swap enabled on my Notebook. The 320 MB are enough for my workload and I
> am willing to accept the OOM Killer when I do really stupid things. If I
> enable swap the (all of them to some degree :-) VM decides to swap out
> "unused" processes. Most of them are desktop related and if I need them
> the system responds sluggish. Therefore - no swap activated.
> 
>  My question was: can I have a system without active swap and still use
> swsusp? Creating a swap/suspend partition of appropriate size is not a
> problem. I just do not want to "swapon" it.

You need to swapon it. If you do not want to keep it swapped on,
there's no problem in

swapon /dev/swap
echo 4 > /proc/acpi/sleep
sleep 10
swapoff /dev/swap

									Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
