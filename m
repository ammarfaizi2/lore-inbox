Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSFZOWb>; Wed, 26 Jun 2002 10:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSFZOWa>; Wed, 26 Jun 2002 10:22:30 -0400
Received: from n218.ols.wavesec.net ([209.151.19.218]:24846 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S316595AbSFZOW3>; Wed, 26 Jun 2002 10:22:29 -0400
Date: Tue, 25 Jun 2002 23:38:48 -0400
Message-Id: <200206260338.g5Q3cmc19214@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
       "'akpm@zip.com.au'" <akpm@zip.com.au>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'devfs@oss.sgi.com'" <devfs@oss.sgi.com>
Subject: Re: Inexplicable disk activity trying to load modules on devfs
In-Reply-To: <20020617150108.GA4989@nevyn.them.org>
References: <6134254DE87BD411908B00A0C99B044F039645EB@mowd019a.mow.siemens.ru>
	<20020617150108.GA4989@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz writes:
> On Mon, Jun 17, 2002 at 10:59:26AM +0400, Borsenkow Andrej wrote:
> > >> 
> > >> I just booted into 2.4.19-pre10-ac2 for the first time, and noticed 
> > >> something very odd: my disk activity light was flashing at about 
> > >> half-second intervals, very regularly, and I could hear the disk 
> > >> moving. I was only able to track it down to which disk controller, via 
> > >> /proc/interrupts (are there any tools for monitoring VFS activity? 
> > >> They'd be really useful). Eventually I hunted down the program causing 
> > >> it: xmms. 
> > >> 
> > >> The reason turned out to be that I hadn't remembered to build my sound 
> > >> driver for this kernel version. Every half-second xmms tried to open 
> > >> /dev/mixer (and failed, ENOENT). Every time it did that there was 
> > >> actual disk activity. Easily reproducible without xmms. Reproducible 
> > >> on any non-existant device in devfs, but not for nonexisting files on 
> > >> other filesystems. Is something bypassing the normal disk cache 
> > >> mechanisms here? That doesn't seem right at all. 
> > >> 
> > >
> > >
> > >syslog activity from a printk, perhaps? 
> > 
> > No. It is most probably devfsd trying to load sound modules.
> > 
> > This is exactly the reason Mandrake does not enable devfs in kernel-secure.
> > You can badly hit your system by doing in a loop ls /dev/foo for some device
> > foo that is configured for module autoloading.
> > 
> > It is very fascist decision; the slightly more forgiving way is to disable
> > devfsd module autoloading (or disable devfsd entirely, just run it once
> > after all drivers are loaded to execute actions) but then you lose support
> > for hot plugging and some people do use kernel-secure on desktops. 
> 
> For the curious, the reason is that modprobe writes even failed
> attempts to a log in /var/log/ksymoops, and calls fdatasync() on
> that file afterwards.  There is no way to disable this without
> removing that directory, as a design decision.  I don't personally
> see the point in logging attempts which fail because there is no
> driver...

Sounds like the behaviour of modprobe needs to be fixed.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
