Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbUB0AGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUB0AD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:03:26 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:41603 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S261359AbUB0ACY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:02:24 -0500
Date: Thu, 26 Feb 2004 16:02:59 -0800
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040227000258.GB540@tinyvaio.nome.ca>
References: <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com> <20040214085110.GG5649@tinyvaio.nome.ca> <20040214165444.GA26602@kroah.com> <20040219094720.GD432@tinyvaio.nome.ca> <20040219194357.GA13934@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219194357.GA13934@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 11:43:57AM -0800, Greg KH wrote:
> > It may be enabled in a lot of kernels, but I don't know any distros that
> > actually break if you turn it off (though I may be wrong here). So I
> > don't think you're right when you say "It has so many other benefits
> > that people can no longer turn it off and expect their systems to work
> > "nicely"".
> 
> As you have proved that you do not understand what CONFIG_HOTPLUG is and
> does for a system, I do not see how you can back up your argument about
> this topic.  Please become more well-informed of the situation before
> trying to discuss this.

Sorry, what? How did I prove that? All I'm saying is that I've got
plenty of systems that don't have any executable at /sbin/hotplug, even
though /proc/sys/kernel/hotplug is set to that, and they work just fine.
To me, this means that the system in question obviously ISN'T relying on
the hotplug mechanism dispite your claims that it's required for any
system to behave nicely.  Please stop resorting to personal insults
every time I disagree with you.

> If you look at your first post on this topic, it falls far short of this
> goal.  It seemed like another "why is everyone picking on devfs as it's
> so great!" complaint to me by someone who does not fully understand how
> the devfs or udev code works.

I just reread it, and I don't see how you can make any of those claims.

I asked "is a devfs-like implementation really unfixable? And if not, is
it worth whatever disadvantages can't be avoided?" To me, the answers
are still no and yes, but I'm going to /try/ to shut up about it now.
Either udev will eventually be sufficient for everyone's needs, or
someone will come along and write something better. I just wanted to
show people why I thought it was the latter, and hopefully encourage
that something better to come around sooner rather than later. I don't
see how that makes me a devfs-loving whiner who doesn't know what he's
talking about.

I said I disagreed with your argument about how devfs sets naming
policy in the kernel, while udev does not. devfs sets /dev's naming
policy in the kernel, while udev does not. But udev still relies on
naming policy set in the kernel, in the form of sysfs. To me, that's an
important difference. What you claim seems to me like you're saying that
names in the kernel are a deadly sin and udev does away with them
completely. What actually happens is that udev relies on names set in
the kernel in a new filesystem, so that people can see the /dev layout
they're used to or whatever other one they want. If you made that claim
and said it was an advantage for udev and I wouldn't argue, but to me
it's actually an advantage to devfs. One canonical name format for any
given device node and then symlinks for alternate names (like
/dev/mouse or a persistant name for a given USB device or anything else
that can only be decided in userspace) makes more sense to me than the
complete flexibility of udev.

Either people make use of udev's capability to do that, and their
system's SCSI hard drives have totally different device names to anyone
else's, or they don't, everyone has LSB /dev names, and the same effect
could have been accomplished by a devfs that exported LSB names instead
of the (sometimes objectionably long) ones it wound up exporting. Either
way, if you ask me, one consistant naming scheme is better than all the
"flexibility" udev has to offer, just like consistant syscall numbers
are better than consulting a userspace table to figure out what read()
is on this system, and just like /proc/sys/ and sysfs have consistant,
kernel generated names that people don't object to.

> Also, please remember the main goal of udev, the ability to create
> persistent names for devices.  This is something that devfs can not do
> for you at all. 
> 
> The fact that udev can fully replace devfs with a tiny userspace
> program is further proof that udev is the proper way to manage a /dev
> tree.

Creating persistent names for devices is good. It must be done from
userspace, since there's no way you could sanely put all the logic
required into the kernel. udev does this, and that's a good thing about
udev. The only part I disagree with is where you jump to "therefore,
udev is the right way to manage a /dev tree." The two do not go
together, udev creating all the device nodes in /dev is not required for
udev (or whatever the program is called) making persistent names (device
nodes or symlinks or whatever) in /dev.
