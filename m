Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267200AbUBSJrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 04:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267213AbUBSJrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 04:47:15 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:35974 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S267200AbUBSJqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 04:46:54 -0500
Date: Thu, 19 Feb 2004 01:47:21 -0800
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040219094720.GD432@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com> <20040214085110.GG5649@tinyvaio.nome.ca> <20040214165444.GA26602@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040214165444.GA26602@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 14, 2004 at 08:54:44AM -0800, Greg KH wrote:
> Woah, no this is NOT true.  If you continue to this this, then this
> discussion is going to go no where.
> 
> Remember, the "dev" file in sysfs is just another attribute for the
> device.  Just like a serial number or product id.  A device node would
> be a totally different thing.  See all of the other messages from others
> about why this is true.

Again, you're not understanding what I'm saying. It's different from
userspace's point of view (it's totally changing the kind of thing sysfs
is presenting, which is why I said I don't believe it should be done)
what I'm saying is that it wouldn't require extra code. It's not making
the kernel do extra work, it's just making it do the same work in a
different way. It was an example to prove a later point, not a
suggestion for how to do things.

> Stop right there and go read the archives for why we are not going to do
> this.  This has been discussed a lot.

I just said I wasn't advocating it! It was just to illustrate a later
point.

> Because then you have devfs, which is not what we are trying to do here.
>
> It seems that you are insisting that we have to make a devfs.  Great,
> have fun, use the devfs we already have.

Do you see the irony here? You accuse me of just wanting devfs instead
of udev the line after you answer a question with, essentially, "because
then you have devfs, and devfs is bad".

And I already do use the devfs we already have, and have done so for a
long time. But it could use a lot of improvement (the same way udev
could).

> > As I see it, part of the reason procfs became such a nightmare was
> > because people thought there could be only one kernel-generated
> > filesystem and put everything in there.
> 
> Not true.  procfs got to be a mess for lots of other reasons (lack of
> control, no other options, etc...)

Did you miss the word "part"? And you say "no other options", isn't that
what I just said ("only one kernel generated filesystem")? 

> > Linux is moving a lot of the silly magic values out of proc and into
> > sysfs where they make more sense. Great! But what about stuff that
> > doesn't really fit into sysfs as it is right now? Should we take
> > sysfs's clean interface and extend it with special cases until it's
> > the ugly mess proc is?
> 
> No, and I'm not advocating that at all, and never have.  That's not
> the point here.

No, but it was my example of why not everything has to be done in sysfs,
and why having a greater number of more specialised filesystems can be a
good thing.

What I was trying to say is:

1) Isn't it good to have more than one kernel-generated filesystem, if
each one can thereby be more specialised and therefore cleaner? (I
believe you agree on this point).

2) If that's the case, why do you keep arguing that devfs (exporting
device nodes from the kernel in a small and simple filesystem and
letting a userspace daemon control their permissions and make symlinks
so that the "right" cdrom drive is /dev/cdrom and such) is so horrible?

> already been done, see the libfs code.  I don't understand what this
> has to do with udev though....

Thought so, but I couldn't remember the name. And it has to do with
devfs (and implementing it using libfs), not with udev per se.

> > I'm not a kernel hacker
> 
> Stop.  Go read http://ometer.com/hacking.com  Especially pay attention
> to the section "Back-seat coders are bad."  I specifically like the
> lines:
> 
> 	If you don't know how to code, then you don't know how to design
> 	the software either. Period.  You can only cause trouble.

I didn't say I don't know how to code, I said I wasn't a kernel hacker.
And I wasn't TRYING to tell you how to write udev, though I may
accidentally have come off that way.

I started this thread out saying that I liked devfs better than udev for
a few reasons, that udev didn't give me everything I wanted, and that
therefore I would like to know if anyone else felt likewise and if so
whether there was enough interest to "save" devfs, either by fixing the
existing one or by doing it again from scratch.

I wasn't trying to tell you how to do udev (though again, I may have
come off that way accidentally, and if so I'm sorry). The only issue I
ever had with you was that I didn't agree with a lot of your "devfs
versus udev" document. Which is why I started the thread with a sort of
counter to that.

> So my main point is, I don't know what you are arguing anymore.  If
> you don't like udev, and for some reason think that devfs and devfsd
> can provide you a stable, secure, and PERSISTENT device naming system,
> then fine, go use devfs.

Again, I do. But if everyone stopped working on udev except for
bug-fixes, I bet it would start to be pretty nasty in one or two major
kernel releases. Which is why I was trying to see if anyone else was
interested in saving devfs.

> > How do you figure that's free? hotplug's a great feature, nothing
> > against it, but as far as I know the vast majority of installations
> > aren't making use of it right now.
> 
> Hint, I don't know of ANY distro that does not enable CONFIG_HOTPLUG
> that is not a embedded distro.  That's why I call it "free".  It has
> so many other benefits that people can no longer turn it off and
> expect their systems to work "nicely".

It may be enabled in a lot of kernels, but I don't know any distros that
actually break if you turn it off (though I may be wrong here). So I
don't think you're right when you say "It has so many other benefits
that people can no longer turn it off and expect their systems to work
"nicely"".

> In conclusion, if you have any problems with udev, how it works, how
> it is configured, etc., I'm very glad to hear them and help you
> through it.  But if you just want to complain about how we all should
> be using devfs and devfsd instead of sysfs and udev, you are going to
> get no where with me.

I wasn't trying to get somewhere with you. The main purpose of this
thread was to guage the level of interest in keeping devfs alive (which
I suppose I've done, though I'm disappointed more people don't seem to
agree with me on the advantages of a devfs solution over udev).

The most I ever wanted from you personally was for you to make your udev
versus devfs document a little fairer to devfs. I wish you the best of
luck in developing udev, and since it looks like it's the preferred
solution, I genuinely hope it matures quickly so that static /dev on
linux can go away.
