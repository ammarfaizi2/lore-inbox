Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278669AbRJSVnc>; Fri, 19 Oct 2001 17:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278668AbRJSVnY>; Fri, 19 Oct 2001 17:43:24 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:41674 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S278669AbRJSVnJ>; Fri, 19 Oct 2001 17:43:09 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C42D68F@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Mike Fedyk'" <mfedyk@matchmail.com>, Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: RE: [RFC] New Driver Model for 2.5
Date: Fri, 19 Oct 2001 14:43:37 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My impression was that while long-term having a device tree (with or without
a fs to expose it to userland) may help with the infamous Linux naming
issues, that the first go-round should try to completely avoid this issue
entirely, and focus on just enabling the global device tree itself. (I just
want to suspend/wake my laptop's devices in the right order!)

Everyone pretty much agrees that the device tree and device power management
are good. My hope is we don't let other contentious issues hinder its
implementation.

Regards -- Andy


> From: Mike Fedyk [mailto:mfedyk@matchmail.com]
> Sent: Friday, October 19, 2001 1:24 PM
> To: Tim Jansen
> Cc: linux-kernel@vger.kernel.org; Patrick Mochel
> Subject: Re: [RFC] New Driver Model for 2.5
> 
> 
> On Fri, Oct 19, 2001 at 10:07:39PM +0200, Tim Jansen wrote:
> > On Friday 19 October 2001 21:21, you wrote:
> > > > For example for harddisks. You usually want them to be 
> mounted in the
> > > > same directory.
> > > When is /etc/fstab going to support this?
> > 
> > You can use the device ids to provide stable symlinks, then 
> /etc/fstab 
> > shouldn't be a problem. 
> 
> Sounds good.
> 
> >Or you rewrite mount to support it. Or you do it in
> > the kernel with a user-space helper: when a new device is 
> connected its ID is 
> > sent to some user-space app, and the user-space app then 
> assigns a minor 
> > number and devfs name to the node.
> >
> 
> Or, just use autofs, it does pretty much what you're describing.
> 
> > IMHO using the path of a file in /dev to identify a device 
> node does not work 
> > in a hotplugging environment. You need this to support 
> existing apps, but the
> > only way to be sure that you always get the same device is 
> to use device IDs. 
> 
> Actually, I don't have a hotplug envoronment, but that's not 
> the only place
> it would be useful.  Does ide/scsi have reliably unique 
> device IDs?  If so,
> once devfs gets rid of those races it would be very useful in 
> a large raid
> setup.  Hmm, I guess that could be hot-pluggable with high 
> end hardware.
> 
> > You could encode that device id in the node's path or use 
> the path as a 
> > moniker for the device id (the symlink solution does this), 
> but you need to 
> > have more information about the device than it's minor 
> number (the X in 
> > /dev/lpX).
> >
> 
> What does devfs do now?
> 
> > 
> > > >Or for ethernet adapters:
> > > > because each is connected to a different network, so 
> you need to assign
> > > > different IP addresses to them.
> > > I haven't seen anything assign ethX assign a certain 
> order, except for
> > > ordered module loading, and then if there are multiple 
> devices with the
> > > same driver, the order is chosen by bus scanning order, 
> or module option.
> > 
> > Ok, but I think no one doubts that it is a bad idea to assign ethX 
> > semi-randomly. Basically this is the same problem as with 
> device files, only 
> > in a different namespace.
> >
> 
> So is that in favor of changing the current ethX naming 
> convention or not?
> 
> > 
> > > Does anyone know if devfs will, or has any plans to 
> support any of the
> > > above features?
> > 
> > The device registry (www.tjansen.de/devreg) patches devfs 
> to allow the things 
> > described above though.
> > 
> 
> Everything, with all of the ids?  What about scsi/ide?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
