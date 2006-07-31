Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWGaEkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWGaEkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 00:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWGaEkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 00:40:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54433 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751466AbWGaEkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 00:40:14 -0400
Date: Sun, 30 Jul 2006 21:35:42 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com,
       laurent.riffard@free.fr, andrew.j.wade@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Kubuntu's udev broken with 2.6.18-rc2-mm1
Message-ID: <20060731043542.GA9919@kroah.com>
References: <20060727015639.9c89db57.akpm@osdl.org> <44CCBBC7.3070801@free.fr> <20060731000359.GB23220@kroah.com> <200607302227.07528.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com> <20060731033757.GA13737@kroah.com> <20060730212227.175c844c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730212227.175c844c.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 09:22:27PM -0700, Andrew Morton wrote:
> On Sun, 30 Jul 2006 20:37:57 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> > On Sun, Jul 30, 2006 at 10:27:06PM -0400, Andrew James Wade wrote:
> > > On Sunday 30 July 2006 20:03, Greg KH wrote:
> > > > Something's really broken with that version of udev then, because the
> > > > 094 version I have running here works just fine with these symlinks.
> > > 
> > > Maybe, but some really odd things were happening in /sys with the
> > > patch. I could still follow the bogus symlinks. More than that
> > > 
> > > /sys/class/mem/mem$ cd ../../class
> > > and
> > > /sys/class/mem/mem$ cd ../..
> > > 
> > > _both_ ended up with a $PWD of /sys/class.
> > 
> > Ick, ok, the problem is that my "virtual device" patch isn't in my
> > "public" patch set that Andrew pulls from.  It will fix this issue up.
> > I'll work on cleaning it up to be used by everyone tomorrow and move it
> > to the tree that Andrew pulls from.  Then the next -mm release should
> > have this issue fixed.
> 
> Mutter.  This stuff breaks my FC3 test box and there is, afaict, no clear
> way for users to upgrade udev to unbreak it.
> 
> As a developer I could of course bang on things until it works, but that's
> not the point.  The point is that these patches break Linux on a major
> release from a major vendor only two years after its release.  That's not a
> minor problem, is it?

Well, yes, it is.  That distro is unsupported now, right?

How long do you expect the kernel to support unsupported, community
based distros that thrive on the fact that they are quickly updated?

Look at Documentation/Changes for the version of udev that the kernel
now requires.  It's 071 due to the input layer code (which was released
in October of 2005).  Odds are you have just gotten lucky that FC3 is
not working for you right now.

And yes, I will revert the patch in mainline that causes people to have
to upgrade to a udev that is in FC5, and wait till the next release for
that to happen (the minimum will be 081, which was released in January,
2006, by the time 2.6.19 is out, that will be about 10 months old.)

Debian and Gentoo already support new enough versions of udev, and so
does OpenSuSE and Fedora with their latest, supported versions.  How
long should the kernel be forced to lag behind?

I'm also going to fix up older versions of SuSE (10.0, which is no
longer supported by the vendor) so that it will support this kernel
change too, it's only a few lines of patch to udev, but don't have the
ability to do the same for Fedora, sorry.

Remember, most distros tie their kernel to their userspace very tightly,
so the ability to upgrade the kernel without some userspace packages
does not always work (HAL stopped working long ago in FC3 with newer
kernels I imagine.)  If you are a kernel developer, who updates kernels
often, choose a distro that allows that flexibility (Gentoo and Debian
are two that I know of, FC Rawhide and OpenSuSE Factory are two others
that should also do it.)

Remember, FC3 is now in Legacy support mode, not something the mainline
kernel should have to worry about.

thanks,

greg k-h
