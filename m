Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278649AbRJSUYM>; Fri, 19 Oct 2001 16:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278650AbRJSUYC>; Fri, 19 Oct 2001 16:24:02 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22517
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278649AbRJSUXu>; Fri, 19 Oct 2001 16:23:50 -0400
Date: Fri, 19 Oct 2001 13:24:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Tim Jansen <tim@tjansen.de>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011019132418.I2467@mikef-linux.matchmail.com>
Mail-Followup-To: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org,
	Patrick Mochel <mochel@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0110191108590.17647-100000@osdlab.pdx.osdl.net> <15uerh-0NbBEeC@fmrl04.sul.t-online.com> <20011019122101.G2467@mikef-linux.matchmail.com> <15uft5-12MXk8C@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15uft5-12MXk8C@fmrl04.sul.t-online.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 10:07:39PM +0200, Tim Jansen wrote:
> On Friday 19 October 2001 21:21, you wrote:
> > > For example for harddisks. You usually want them to be mounted in the
> > > same directory.
> > When is /etc/fstab going to support this?
> 
> You can use the device ids to provide stable symlinks, then /etc/fstab 
> shouldn't be a problem. 

Sounds good.

>Or you rewrite mount to support it. Or you do it in
> the kernel with a user-space helper: when a new device is connected its ID is 
> sent to some user-space app, and the user-space app then assigns a minor 
> number and devfs name to the node.
>

Or, just use autofs, it does pretty much what you're describing.

> IMHO using the path of a file in /dev to identify a device node does not work 
> in a hotplugging environment. You need this to support existing apps, but the
> only way to be sure that you always get the same device is to use device IDs. 

Actually, I don't have a hotplug envoronment, but that's not the only place
it would be useful.  Does ide/scsi have reliably unique device IDs?  If so,
once devfs gets rid of those races it would be very useful in a large raid
setup.  Hmm, I guess that could be hot-pluggable with high end hardware.

> You could encode that device id in the node's path or use the path as a 
> moniker for the device id (the symlink solution does this), but you need to 
> have more information about the device than it's minor number (the X in 
> /dev/lpX).
>

What does devfs do now?

> 
> > >Or for ethernet adapters:
> > > because each is connected to a different network, so you need to assign
> > > different IP addresses to them.
> > I haven't seen anything assign ethX assign a certain order, except for
> > ordered module loading, and then if there are multiple devices with the
> > same driver, the order is chosen by bus scanning order, or module option.
> 
> Ok, but I think no one doubts that it is a bad idea to assign ethX 
> semi-randomly. Basically this is the same problem as with device files, only 
> in a different namespace.
>

So is that in favor of changing the current ethX naming convention or not?

> 
> > Does anyone know if devfs will, or has any plans to support any of the
> > above features?
> 
> The device registry (www.tjansen.de/devreg) patches devfs to allow the things 
> described above though.
> 

Everything, with all of the ids?  What about scsi/ide?

