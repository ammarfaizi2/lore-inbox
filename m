Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVFWITU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVFWITU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbVFWIOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:14:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:51096 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262329AbVFWGtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:49:00 -0400
Date: Wed, 22 Jun 2005 23:48:47 -0700
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623064847.GC11638@kroah.com>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <20050623062842.GE17453@mikebell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623062842.GE17453@mikebell.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:28:42PM -0700, Mike Bell wrote:
> On Wed, Jun 22, 2005 at 09:59:59PM -0700, Greg KH wrote:
> > I don't mean to pick on you, but this has been known for over a year
> > now, right?  Hasn't anyone been preparing for any alternative situation
> > should this happen?  I know some distros have, but it seems the embedded
> > people (you aren't the first to mention the "joys" of using devfs in
> > embedded systems) just have been hoping this wasn't going to happen.
> >
> > Very odd...
> 
> What other choices are there? Fork the kernel?

No, plan for it.  Speak up.  Complain sometime a while ago instead of
right when it happens.

> > Not true, look at how long it was maintained out of mainline to start
> > with.  Using the tools we have today (like quilt and git) it should be
> > quite easy to keep the patch going if you really need it.
> 
> In an increasingly broken and harder to maintain state. Official
> blessing means a great deal.

I understand this.

> If you didn't know this, why did you go to such great lengths to state
> that udev was the official future path of the linux kernel?

When did I ever say this?  I have only ever said it was an option that
people who want dynamic /dev and persistant naming can use.  There are
other projects out there becides udev that do much the same thing in
userspace, udev isn't the only one.

> Even before the official removal date was announced, vocal udev
> proponents actively discouraged out-of-tree projects from accepting
> devfs fixes.

I was not aware of this.

> > I do care about this, please don't think that.  But here's my reasoning
> > for why it needs to go:
> 
> > 	- unmaintained for a number of years
> 
> Semi-debatable. Even without a single maintainer, it has been getting
> fixes (just look at all the work that happened in the 2.5 series). And
> Adam J. Richter attempted to take over maintainership not long ago as I
> recall.

He did, as did others.  However no one actually did the work, and were
persistant, which is what really matters in this community.

> > 	- policy in the kernel.
> 
> Already exists.

namespace policy does?  Yes, the LANNANA one.  A non-LSB standard should
not.

> Don't see why /dev is policy in userspace but /proc and /sys aren't,
> or why a single canonical name set by the driver author with symlinks
> to whateverthehellyouwant isn't far superior. Fine, people hate
> devfs's drive naming.

See the above point about LSB.

> I'm hardly a big fan of it either. But that doesn't mean the idea of a
> single canonical naming scheme by which userspace can consistently
> identify devices isn't a good one.

But for persistant device naming, you need to do this in userspace, the
kernel can not do it (and before the old ptx developers pipe up, yes,
you all did do this within your kernel years ago, but your performance
sucked and I'm not putting a whole database into our kernel...)

> As I recall you even tried to propose such a scheme, albiet as
> overridable policy in udev rather than in devfs, so you must recognize
> that there is advantage to not having a different /dev naming scheme
> on every dist.

udev allows different /dev naming schemes, even a devfs-compatible one
so you don't have to change any other programs if you want so.  devfs
was unable to provide different ones.

> As long as I can have my USB serial wireless modem named
> "/dev/usb-serial-wireless-modem" via a symlink, why should I care that
> the canonical name is something about USBttyS?

dot-files will die that way :(

Becides them, no, you shouldn't, in fact, some distros use udev that way
today.

> > 	- no distro uses it
> 
> Bull. Complete. Can I claim by similar logic that no distro uses udev?

What distro shipps support for devfs and a 2.6 kernel?  I am not aware
of one (Gentoo doesn't count, they don't "ship" anything :)  Honestly, I
don't know of any.  I do know of a lot of them that ship udev.

> > 	- clutter and mess
> 
> Which is true of many other parts of the kernel, some of which were
> cleaned up rather than being declared obsolete and preventing further
> work to clean them up.

But it was unmaintained clutter and mess.

> > 	- code is broken and unfixable
> 
> People attempting to fix the code might disagree. In fact, I'd consider
> the claim that any code is "unfixable" pretty hard to back up logically.

See Al Viro's comments about this, and then try to refute them.  It's
not just me saying this at all.  In the end, no one has fixed them to
prove him wrong so he might just be on to something...

> > 	- udev is a full, and way more complete solution (it offers up
> > 	  so much more than just a dynamic /dev.  Way more than I ever
> > 	  dreamed of.)
> 
> That works if you exclude all the things that devfs does that udev
> doesn't, which you do because you consider them misfeatures, but that
> kind of logic doesn't work for everyone.

There is only 1 thing that I know of that devfs does that udev does not,
auto-module-loading if you try to access a device node that isn't
present.  See my previous posts as to why this is a unworkable scheme
anyway for 99% of the kernel devices.  Yes, the other 1% can use this,
like ppp and raw.  But the distros have already solved this issue, so
it's kind of moot.

Is there anything else that devfs can do that udev can't?  I have a
whole list of things that udev can do that devfs can not :)

> > 	- companies are shipping, and supporting distros that use udev.
> 
> After being forced to do so by the sudden surprise deprication of devfs
> and the ensuing publicity to udev.

I have not forced _any_ company to do so.  I have not even _asked_ any
company to do so.  I have simply been amazed that so many companies
siezed on udev and brought it up to maturity and shipped it.  That tells
me that people really wanted it and see the advantages of it over devfs.

> > 	- It has been public knowledge that it would be removed for a
> > 	  number of years, and the date has been specifically known for
> > 	  the past year.
> 
> Based somewhat on repeated statements that this was fait accompli.

Nothing is ever that way in our community, you should know that :)

> If people are still using it and still consider udev not to be a
> complete replacement, then the possibility of leaving it in the kernel
> should at least be entertained.

I have not heard any such issues in the past 6 months.  Hence my
supprise now (well, not really supprise, I knew someone would complain,
pretty amazed that it's only been one person in public (and one person
privatly) so far.)

> Not only is OSS still around for these reasons, but
> even cryptoloop is still there! And unlike OSS and devfs, I haven't
> recently heard anyone claim cryptoloop did something dm-crypt doesn't.

Maybe no one has just taken the time and effort to want to remove
cryptoloop.  That's what it takes to get anything done around here...
Don't thing that lack of action always implies acceptance...

> > Are you really going to want to update a running system that uses devfs
> > to a newer kernel?
> 
> Why not? I've been doing it for over five years now. Or do you mean
> change a running system using devfs to udev? No, I don't want to do that
> at all, which is why I'm trying to get devfs left alone.

Ok, fair enough.

> > If so, your distro will have a static /dev or a udev package to
> > replace it.  If you aren't using your own distro, a drop-in static
> > /dev tree is a piece of cake for the short run, and udev is simple to
> > get up and running after that if you really want dynamic stuff.
> 
> Well, in my case dynamic stuff is a prerequisite, while my servers would
> all be fine with a static dev it would for all intents and purposes
> destroy the functionality of my notebooks (practically everything is
> dynamic. I can't even type on one without devfs.)

Then use the devfs mode of udev.  The devfs author even sent me updates
in order to get them to work properly for his machines...

> > And again, for embedded systems, there are packages to build it and
> > put it in initramfs.  People have already done the work for you.
> 
> I'll look yet again, but I've been told that udev was "ready" when it
> wasn't enough times now that I'm highly skeptical.

I would be glad to help out in any way, if you have any issues.  You
should post them to the linux-hotplug-devel mailing list so the other
udev developers can also help out.

> I've always considered myself an early adopter of "better" solutions. I
> switched to devfs on my desktop the day it was put into mainline. I
> invested a little time to switch from cryptoloop to dm-crypt for my
> crypted-home-on-flash setup before dm-crypt was even in the kernel,
> because I was won over by arguments that it was better. I always run the
> current development series (when there is one) on at least one of my
> machines, usually my main one. It's not like I'm resistant to change,
> quite the opposite. I'm just plain unconvinced that udev is better in
> every way to devfs. And the bizarre "force it down your throats" policy
> that has characterized the udev over devfs saga has done little to
> endear me to it.

I have never, until now, forced anyone to use udev.  And even now, I'm
not forcing anyone (there are other solutions to a dynamic /dev becides
udev).  I do feel, and it seems others agree, that udev is a far
superior solution to the persistant device naming issue than devfs is
(well, that's not really fair, as devfs can't even do that.)  As a
wonderful side affect, it also handles a dynamic /dev which other people
seem to like.

thanks,

greg k-h
