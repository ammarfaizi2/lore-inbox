Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVFWIsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVFWIsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVFWIrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:47:09 -0400
Received: from nome.ca ([65.61.200.81]:5828 "HELO gobo.nome.ca")
	by vger.kernel.org with SMTP id S263043AbVFWI33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:29:29 -0400
Date: Thu, 23 Jun 2005 01:29:00 -0700
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050623082859.GD955@mikebell.org>
Mail-Followup-To: Mike Bell <kernel@mikebell.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org> <20050621151019.GA19666@kroah.com> <20050623010031.GB17453@mikebell.org> <20050623045959.GB10386@kroah.com> <20050623062842.GE17453@mikebell.org> <20050623064847.GC11638@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623064847.GC11638@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 11:48:47PM -0700, Greg KH wrote:
> No, plan for it.  Speak up.  Complain sometime a while ago instead of
> right when it happens.

Did so. Raised the same points I'm doing now. Said at the time I was
going to wait and see if udev evolved to meet my needs before devfs got
removed. That time has arrived, and it hasn't, hence this. Seems
sensible to me.

> When did I ever say this?  I have only ever said it was an option that
> people who want dynamic /dev and persistant naming can use.  There are
> other projects out there becides udev that do much the same thing in
> userspace, udev isn't the only one.

But they all use fundamentally the same interface as udev and thus none
of them is any different with regard to my problems with udev, no?

> > Even before the official removal date was announced, vocal udev
> > proponents actively discouraged out-of-tree projects from accepting
> > devfs fixes.
> I was not aware of this.

Nonetheless true, and an example of the kind of problems maintaining
it out of tree would only make worse. And are you yourself not an
advocate of not caring if one breaks anything out of tree?

> He did, as did others.  However no one actually did the work, and were
> persistant, which is what really matters in this community.

The process for getting code into mainline involves getting someone "in
the loop" to adopt your patch. If no one looks like they are going to do
that, your effort is wasted. What is one supposed to do?

> namespace policy does?  Yes, the LANNANA one.  A non-LSB standard should
> not.

> See the above point about LSB.

See my point about how I don't care about devfs's specific namescheme,
how driver authors should pick the names for their devices, and how if
you mean "these particular names don't belong in the kernel" you should
say as much, not "policy in kernel".

> But for persistant device naming, you need to do this in userspace, the
> kernel can not do it (and before the old ptx developers pipe up, yes,
> you all did do this within your kernel years ago, but your performance
> sucked and I'm not putting a whole database into our kernel...)

You can't reasonably have "this USB fob will always have this name but
another of the same make will have a different name" without userspace
help, nor should you, but you can have "all v4l devices show up in this
form" and the like. Which, for the vast majority of cases, is enough.

> udev allows different /dev naming schemes, even a devfs-compatible one
> so you don't have to change any other programs if you want so.  devfs
> was unable to provide different ones.
> 
> > As long as I can have my USB serial wireless modem named
> > "/dev/usb-serial-wireless-modem" via a symlink, why should I care that
> > the canonical name is something about USBttyS?
> 
> dot-files will die that way :(

Not if they follow the symlink as they should.

> Becides them, no, you shouldn't, in fact, some distros use udev that way
> today.

So basically you've stated that this way of doing things is fine? And
since there's nothing to stop this way of doing things from happening
with devfs and a small, optional userspace helper to come up with
meaningful symlinked names based on logic that cannot reasonably be put
in the kernel....

> What distro shipps support for devfs and a 2.6 kernel?  I am not aware
> of one (Gentoo doesn't count, they don't "ship" anything :)  Honestly, I
> don't know of any.  I do know of a lot of them that ship udev.

Debian? Their installer even relies on devfs instead of udev. And
following up absolute statements like "no distro uses it" with things
like "gentoo doesn't count" is why I never trust the things you say.
"udev is smaller than devfs", if you discount sysfs. Or earlier "udev
does everything devfs does" comments which were actually "can
theoretically do these things, but currently isn't implemented, and it
only works with a handful of devices"

> But it was unmaintained clutter and mess.

Which people have attempted to maintain. Presumably, had it not been
marked OBSOLETE and thus useless to bother maintaining in the eyes of
most, said patches would have gone in just like any other cleanup, and
just like devfs cleanups had been doing until that point.

> See Al Viro's comments about this, and then try to refute them.  It's
> not just me saying this at all.  In the end, no one has fixed them to
> prove him wrong so he might just be on to something...

If this is about the stupid race, I don't see why all of devfs should be
damned for a feature no one (to my knowledge) uses anyway and thus could
be easily ripped out without the objections of devfs-liking people. See
above comments about a single canonical name for devices.

> There is only 1 thing that I know of that devfs does that udev does not,
> auto-module-loading if you try to access a device node that isn't
> present.  See my previous posts as to why this is a unworkable scheme
> anyway for 99% of the kernel devices.  Yes, the other 1% can use this,
> like ppp and raw.  But the distros have already solved this issue, so
> it's kind of moot.

I mentioned earlier that my main problems with udev were the continued
reliance on a partially static /dev, the way /dev is no longer
representative of the kernel's state, the reliance on sysfs to get any
usable system (assuming you treat static /dev as an unacceptable option,
which it is increasingly becoming) and most especially the early
userspace stuff. But before I assume you're making it up again I do need
to check your claims that these things have been addressed.

> Is there anything else that devfs can do that udev can't?  I have a
> whole list of things that udev can do that devfs can not :)

But I'll wager none (well, not if you exclude
features-that-aren't-features in my mind like "not being devfs" and "not
having device names in the kernel) that I can't accomplish just fine on
a devfs using system, right? You said yourself that udev isn't intended
to be a dynamic dev, that's just a fringe benefit. So there's absolutely
nothing stopping me using hotplug and sysfs with devfs - as I do right
now - to gain the features of udev without losing devfs.

> > After being forced to do so by the sudden surprise deprication of devfs
> > and the ensuing publicity to udev.
> 
> I have not forced _any_ company to do so.  I have not even _asked_ any
> company to do so.  I have simply been amazed that so many companies
> siezed on udev and brought it up to maturity and shipped it.  That tells
> me that people really wanted it and see the advantages of it over devfs.

Mysteriously and coincidentally in a great burst around the time devfs
was marked obsolete and you repeatedly commented that people needed to
switch away from devfs or risk getting caught where I am now? :)

> I have not heard any such issues in the past 6 months.  Hence my
> supprise now (well, not really supprise, I knew someone would complain,
> pretty amazed that it's only been one person in public (and one person
> privatly) so far.)

Because when patches to fix it get ignored, what else can one do? Who
wants to pipe up with "I like devfs" only to be told "you're stupid, if
you think you like devfs you don't understand udev" and knowing that
even saying so you don't really stand a chance of saving it?

> Then use the devfs mode of udev.  The devfs author even sent me updates
> in order to get them to work properly for his machines...

The names aren't my concern, the early-boot behaviour, partially static
nature, and other such incompatibilities are.

> I have never, until now, forced anyone to use udev. 

Technically true given the definition of the word "forced". But will you
not concede that the whole "OBSOLETE" thing, especially at such an early
stage in udev's maturity, was a good deal more of a strong-arm tactic
than the kernel usually sees?

> And even now, I'm not forcing anyone (there are other solutions to a
> dynamic /dev becides udev).

Yeah, the name of the userspace app doesn't mean a lot to me, they're
all forced to rely on the same kernel<=>userspace communication
mechanism and basically all work the same. I never complained about the
way udev handles its job in userspace, only about the removal of what
IMHO is a superior interface to kernelspace which offers things udev
alone cannot.

> I do feel, and it seems others agree, that udev is a far superior
> solution to the persistant device naming issue than devfs is

Wouldn't disagree with this. In fact, I'll come right out and say that
given the complete stagnation of devfs (which, I would argue, is not
entirely its own fault as you claim) and udev's rapid advances (based to
some degree I would argue on the attention it gained from things like
the marking of devfs obsolete) udev is the better solution today
(ignoring the migration headache and pretending both were completely new
systems introduced today, the features it offers that devfs doesn't are
worth much more than those devfs offers and udev doesn't, and it has a
much stronger community behind it).

But I also think that an even better solution could have been built
around the idea of a simple devfs that presented a single canonical
device file to userspace for each device and left the creation of
meaningful symlinks to an optional sysfs-using userspace helper. This
would have eliminated dependence on sysfs for the majority of systems I
know of, which rarely have custom rules giving more meaning to a device
than devfs currently presents, leaving me with all the features of devfs
I enjoy today and no migration headache, but a simple sysfs-using
userspace I could optionally apply to gain the features of udev. And
before you say something about "why didn't I then", I'd like to point
out that feature-wise I have that today, the only thing lacking is the
cleanups of devfs code, which really wasn't my primary concern and based
on the examples of others wouldn't have gotten in even if I had written
them.


So in closing, while I disagree with the whole way this has gone about,
in terms of things that can be done /now/ all I'm asking is that kernel
developers reevaluate the assumption that devfs is truly obsolete rather
than merely depricated, based on the fact that even after all this time
and energy udev is still not seen as a complete replacement by everyone.
