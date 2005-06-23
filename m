Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVFWIIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVFWIIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVFWIGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:06:18 -0400
Received: from nome.ca ([65.61.200.81]:37055 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S262416AbVFWG2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:28:40 -0400
Date: Wed, 22 Jun 2005 23:28:42 -0700
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623062842.GE17453@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623045959.GB10386@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:59:59PM -0700, Greg KH wrote:
> I don't mean to pick on you, but this has been known for over a year
> now, right?  Hasn't anyone been preparing for any alternative situation
> should this happen?  I know some distros have, but it seems the embedded
> people (you aren't the first to mention the "joys" of using devfs in
> embedded systems) just have been hoping this wasn't going to happen.
>
> Very odd...

What other choices are there? Fork the kernel?

> Not true, look at how long it was maintained out of mainline to start
> with.  Using the tools we have today (like quilt and git) it should be
> quite easy to keep the patch going if you really need it.

In an increasingly broken and harder to maintain state. Official
blessing means a great deal. If you didn't know this, why did you go to
such great lengths to state that udev was the official future path of
the linux kernel? Even before the official removal date was announced,
vocal udev proponents actively discouraged out-of-tree projects from
accepting devfs fixes. Once it's removed, this becomes even worse.
Something like devfs (or the device model, or anything else core
infrastructurey) isn't possible without the cooperation of the community
in general, because it touches so much.

> I do care about this, please don't think that.  But here's my reasoning
> for why it needs to go:

> 	- unmaintained for a number of years

Semi-debatable. Even without a single maintainer, it has been getting
fixes (just look at all the work that happened in the 2.5 series). And
Adam J. Richter attempted to take over maintainership not long ago as I
recall.

> 	- policy in the kernel.

Already exists. Don't see why /dev is policy in userspace but /proc and
/sys aren't, or why a single canonical name set by the driver author
with symlinks to whateverthehellyouwant isn't far superior. Fine, people
hate devfs's drive naming. I'm hardly a big fan of it either. But that
doesn't mean the idea of a single canonical naming scheme by which
userspace can consistently identify devices isn't a good one. As I
recall you even tried to propose such a scheme, albiet as overridable
policy in udev rather than in devfs, so you must recognize that there is
advantage to not having a different /dev naming scheme on every dist. As
long as I can have my USB serial wireless modem named
"/dev/usb-serial-wireless-modem" via a symlink, why should I care that
the canonical name is something about USBttyS?

> 	- no distro uses it

Bull. Complete. Can I claim by similar logic that no distro uses udev?

> 	- clutter and mess

Which is true of many other parts of the kernel, some of which were
cleaned up rather than being declared obsolete and preventing further
work to clean them up.

> 	- code is broken and unfixable

People attempting to fix the code might disagree. In fact, I'd consider
the claim that any code is "unfixable" pretty hard to back up logically.

> 	- udev is a full, and way more complete solution (it offers up
> 	  so much more than just a dynamic /dev.  Way more than I ever
> 	  dreamed of.)

That works if you exclude all the things that devfs does that udev
doesn't, which you do because you consider them misfeatures, but that
kind of logic doesn't work for everyone.

> 	- companies are shipping, and supporting distros that use udev.

After being forced to do so by the sudden surprise deprication of devfs
and the ensuing publicity to udev.

> 	- It has been public knowledge that it would be removed for a
> 	  number of years, and the date has been specifically known for
> 	  the past year.

Based somewhat on repeated statements that this was fait accompli. If
people are still using it and still consider udev not to be a complete
replacement, then the possibility of leaving it in the kernel should at
least be entertained. Not only is OSS still around for these reasons, but
even cryptoloop is still there! And unlike OSS and devfs, I haven't
recently heard anyone claim cryptoloop did something dm-crypt doesn't.

> Are you really going to want to update a running system that uses devfs
> to a newer kernel?

Why not? I've been doing it for over five years now. Or do you mean
change a running system using devfs to udev? No, I don't want to do that
at all, which is why I'm trying to get devfs left alone.

> If so, your distro will have a static /dev or a udev package to
> replace it.  If you aren't using your own distro, a drop-in static
> /dev tree is a piece of cake for the short run, and udev is simple to
> get up and running after that if you really want dynamic stuff.

Well, in my case dynamic stuff is a prerequisite, while my servers would
all be fine with a static dev it would for all intents and purposes
destroy the functionality of my notebooks (practically everything is
dynamic. I can't even type on one without devfs.)

> And again, for embedded systems, there are packages to build it and
> put it in initramfs.  People have already done the work for you.

I'll look yet again, but I've been told that udev was "ready" when it
wasn't enough times now that I'm highly skeptical.

I've always considered myself an early adopter of "better" solutions. I
switched to devfs on my desktop the day it was put into mainline. I
invested a little time to switch from cryptoloop to dm-crypt for my
crypted-home-on-flash setup before dm-crypt was even in the kernel,
because I was won over by arguments that it was better. I always run the
current development series (when there is one) on at least one of my
machines, usually my main one. It's not like I'm resistant to change,
quite the opposite. I'm just plain unconvinced that udev is better in
every way to devfs. And the bizarre "force it down your throats" policy
that has characterized the udev over devfs saga has done little to
endear me to it.
