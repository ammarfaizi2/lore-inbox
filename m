Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbUBNQyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 11:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUBNQyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 11:54:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:52187 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262360AbUBNQyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 11:54:46 -0500
Date: Sat, 14 Feb 2004 08:54:44 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040214165444.GA26602@kroah.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com> <20040214085110.GG5649@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214085110.GG5649@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 12:51:11AM -0800, Mike Bell wrote:
> On Fri, Feb 13, 2004 at 01:19:20PM -0800, Greg KH wrote:
> > > That's a pretty minor difference, from the kernel's point of view. It's
> > > basically putting the same numbers in different fields.
> > 
> > Heh, that's a HUGE difference!
> 
> Only from userspace's point of view. To the kernel, it's basically the
> same thing.

Woah, no this is NOT true.  If you continue to this this, then this
discussion is going to go no where.

Remember, the "dev" file in sysfs is just another attribute for the
device.  Just like a serial number or product id.  A device node would
be a totally different thing.  See all of the other messages from others
about why this is true.

> Now keeping in mind again that I'm not advocating putting device nodes
> into sysfs, what about a little thought experiment. Supposing you did
> replace sysfs's major:minor text file with a real device node

Stop right there and go read the archives for why we are not going to do
this.  This has been discussed a lot.

> Now, here's a question. What's wrong with taking those and splitting
> them into a new filesystem?

Because then you have devfs, which is not what we are trying to do here.

It seems that you are insisting that we have to make a devfs.  Great,
have fun, use the devfs we already have.

> As I see it, part of the reason procfs
> became such a nightmare was because people thought there could be only
> one kernel-generated filesystem and put everything in there.

Not true.  procfs got to be a mess for lots of other reasons (lack of
control, no other options, etc...)

> Linux
> is moving a lot of the silly magic values out of proc and into sysfs
> where they make more sense. Great! But what about stuff that doesn't
> really fit into sysfs as it is right now? Should we take sysfs's clean
> interface and extend it with special cases until it's the ugly mess proc
> is?

No, and I'm not advocating that at all, and never have.  That's not the
point here.

> Or leave everything that doesn't fit cleanly into sysfs in proc,
> making proc a sort of special-cases wasteland?

No, go make your own fs if that's what is needed.  See the IBM service
processor driver filesystem for an example of something like this.

> Alternativly, why not say that there doesn't need to be just one or two
> kernel-exported filesystems, and instead make a sort of library for
> exporting kernel information via fake filesystems (I can't remember, has
> this already been done?)

already been done, see the libfs code.  I don't understand what this has
to do with udev though....

> I'm not a kernel hacker

Stop.  Go read http://ometer.com/hacking.com  Especially pay attention to
the section "Back-seat coders are bad."  I specifically like the lines:

	If you don't know how to code, then you don't know how to design
	the software either. Period.  You can only cause trouble.


So my main point is, I don't know what you are arguing anymore.  If you
don't like udev, and for some reason think that devfs and devfsd can
provide you a stable, secure, and PERSISTENT device naming system, then
fine, go use devfs.

The rest of us will be over here using udev.

(Remember you still haven't told me how you are going to name your scsi
disk and USB printer in a persistent manner no matter how they are
discovered using devfsd.)

> How do you figure that's free? hotplug's a great feature, nothing
> against it, but as far as I know the vast majority of installations
> aren't making use of it right now.

Hint, I don't know of ANY distro that does not enable CONFIG_HOTPLUG
that is not a embedded distro.  That's why I call it "free".  It has so
many other benefits that people can no longer turn it off and expect
their systems to work "nicely".

In conclusion, if you have any problems with udev, how it works, how it
is configured, etc., I'm very glad to hear them and help you through it.
But if you just want to complain about how we all should be using devfs
and devfsd instead of sysfs and udev, you are going to get no where with
me.

thanks,

greg k-h
