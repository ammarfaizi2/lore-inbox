Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUEUXr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUEUXr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUEUXqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:46:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:30391 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264596AbUEUXYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:24:24 -0400
From: Rob Landley <rob@landley.net>
To: John Bradford <john@grabjohn.com>,
       Rene Rebe <rene@rocklinux-consulting.de>
Subject: Re: Distributions vs kernel development
Date: Wed, 19 May 2004 20:59:46 -0500
User-Agent: KMail/1.5.4
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, rock-user@rocklinux.org
References: <409BB334.7080305@pobox.com> <200405121412.00068.rob@landley.net> <200405190849.i4J8nqfb000280@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405190849.i4J8nqfb000280@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405192059.47056.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 May 2004 03:49, John Bradford wrote:
> Quote from Rob Landley <rob@landley.net>:
> > On Sunday 09 May 2004 05:53, John Bradford wrote:
> > > > And no, it is not like Gentoo where you need to rebuild on each box
> > > > or so.
> > >
> > > I keep hearing about projects which I hope will be what you describe
> > > above for ROCK Linux.  Unfortunately, I haven't found one that goes far
> > > enough in that direction yet.  Maybe there just isn't the demand for it
> > > these days.
> >
> > As a side effect of debugging busybox, I created a shellscript that
> > compiles a stripped down Linux From Scratch system entirely from source.
>
> That's interesting - what I find dissapointing about the Linux From Scratch
> project is that it basically involves first setting up a minimal system,
> then booting in to that new system at an early stage to complete the
> construction of the system.

It's not really a distro.  It's an enormous HOWTO.  (Then again, so's Gentoo, 
but gentoo does claim to be a distro, which is where I get disappointed...)

> Although it lets the user 'escape' their original system quite quickly, my
> interest lies more in creating a custom Linux installation using an
> existing development environment.

Earlier versions of Linux From Scratch did that; they didn't have the 
intermediate system, you just did a build from the main system to get a 
result.  Unfortunately, it would do things like break strangely on certain 
versions of debian due to environment variables or the way they'd patched 
make, and they had to have various warnings and "if it does this, do this..."

The two stage thing of minimal build, chroot, build final system made it a lot 
easier to reproduce regardless of the starting distro.

> [snip]
>
> > As for the rest of your article: don't assume that trading a familiar set
> > of problems for an unfamiliar set of problems automatically solves more
> > than it causes.
>
> Well, I don't just assume that, but in this case, I think I've demonstrated
> to myself that pre-compiled binaries are more difficult to support than
> programs compiled from source.

And how many users are you trying to support?  (This varies depending on scale 
of deployment.  Been there, done that...)

Being _able_ to rebuild the system with printf's in it is a Very Good Thing.  
But presumably, that's what Red Hat's SRPMs are for...

> Of course, it's possible to learn a lot about one specific version of one
> specific distribution, and doing that might make it easier to support any
> pre-compiled binaries in that particular version of that particular
> distribution than an installation from source.

Your support idiosyncrasies are going to differ from GCC 3.3.1 vs GCC 3.3.3, 
let alone 3.3 vs 3.4 or 3.5.  And of course if they compiled it from source, 
but did so with the funky broken gcc 2.9.6 in Red Hat 8 or whatever it was, 
then you could still have strange bugs that have nothing to do with the 
actual package.

As I said, you're really just exchanging one set of problems for another.  
It's not a magic bullet.

> However, surely that is just learning about more and more special cases.

All tech support is learning about more and more special cases.  You learn how 
it _should_ work (which is often something you don't start out knowing, 
because when it's working you don't HAVE to know).  You learn specific ways 
it can break (by encountering them).  You learn to ask the right questions 
when the user did something totally unrelated that broke it and doesn't think 
to volunteer this information because it _IS_ seemingly totally unrelated 
(like upgrading the kernel or libc, switching on ECN, moving the sucker 
behind a masquerading router...)

> It might even be possible to learn about such a large number of special
> cases that a user can solve all the problems they encounter without any
> generic knowledge of a system, but I think that is a bad thing to
> encourage.

I.E. if the user becomes enough of an expert they don't need you to support 
them anymore.  While theoretically possible, this is not actually a useful 
observation in the field much.

> If I get a phone call asking for help with a program I've never heard of
> before, possibly on a distribution I've never heard of before, I belive
> that I can offer much better generic advice based on an overall knowledge
> of the system if everything is source-based, than if a distribution's
> pre-compiled binaries have been installed.  To me, those pre-compiled
> binaries are "non-standard".

Red Hat _is_ source based.  So is Debian.  The fact they build it on their 
servers rather than the target machine doesn't mean they don't give you the 
source to build it yourself if you want to.  However, figuring out how to 
reproduce their build process can be a flaming pain.

The same is true with build-on-the-target-system distributions.  I put 
together one based on a bash script, which is as simple as I could make it 
and designed to have the bits cut and pasted out if you need to rebuild 
stuff, but you've still got to remember to set the right environment 
variables for source and target directories.

The uclibc project has "buildroot", where everything is done by a giant 
makefile.  I hate makefiles: languages should be either declarative or 
imparative, you should not mix both in the same environment.  Also, it has a 
bunch of rough edges like the fact I once typed "make clean" and it deleted 
stuff out of my parent system.  I could presumably figure out what a given 
segment of that is doing and boil it down to the appropraite ./configure make 
make install commands (and the patches and such they apply, and the symlinks 
and config files they create, and...)  But it wouldn't exactly be a 60 second 
job.

And then there's gentoo, which has a python script talk to a server out on the 
net to figure out what to build.  If you're going to even TRIGGER that, you 
need to be familiar with their packaging tool.  To take it apart and modify 
the build would take a lot of eyeballing.

That said, I once spent four hours diagnosing the fact that a friend's Windows 
98 machine was booting into safe mode because they'd deleted a font that was 
used by one of the more obscure help files.  (Because the help file used that 
font, that meant help system referenced this font while indexing files on 
bootup.  And when it didn't find it, it aborted the boot.  Thus it was 
booting into "safe mode", a diagnostic mode where none of the diagnostic 
tools actually run.  Brilliant.  I copied another font to that name and told 
them not to do it again.)

> This is one reason why I do not advertise support services for proprietrary
> systems.  I do not want to fix problems by learning about many, many,
> special cases - I want to use my generic knowledge of computers to fix
> problems, and I believe that it is a better way to use computers in
> general.

I.E. you don't want to do tech support.

Even with all the source, tech support is STILL knowing about many many 
special cases.  Yes, you can work it out from first principles, and having 
the source code in a readily buildable state where you can compile and drop 
in functional replacements (this is NOT the same thing as just having the 
source code) can help.

But if you're working out the answer from first principles every time you 
provide somebody with tech support, you're going to be an amazingly 
inefficient support person.

> > Build from source has more potential, sure.  And when the standard
> > laptop has a 10 ghz 64 bit processor and 4 gigabytes of ram, it'll make a
> > lot of sense
>
> I don't think compiling from source is particularly inpractical on a
> typical modern desktop machine today.

You've never built kde then.

> [snip]
>
> > But compiling stuff from source is HEAVILY dependent on sequencing;
> > ./configure won't add ncurses support unless you installed ncurses first.
>
> That's true for a lot of libraries and basic components of a system, but I
> don't think it's so much of a problem in general.

You've tried it, then?

> > How much stuff do you rebuild because you just added openssl, or switched
> > to alsa from oss?
>
> Not too much to make it impractical, in my opinion.

And if the end-user decides to upgrade their system with stuff it didn't have 
before?

This isn't restricted to source distributions, by the way.  I tried to update 
a friend's SuSE system to the 2.6 kernel.  I expected to have to upgrade a 
number of packages, but what I didn't expect was that SuSE doesn't seem to 
have have ncurses installed (or at least not something make menuconfig can 
find).  Python in Red Hat didn't have ncurses support last I checked, either.  
(RH 9, I think...)

Suppose they don't select OpenSSL because they go "this is a desktop system, 
not a server", and then they realise later "oh, I need https:// support in 
Konqueror/Mozilla"...

> > How do you keep track of the dependencies so it CAN rebuild?
>
> In practice, I haven't found it to be particularly complicated.

How much practice have you found it in?

> > If your build system is a static command set like my shellscript, "build
> > this list of packages in this order",
>
> It's not.  My 'build system' is basically me sitting at the console.

I've supported end-users before.  I've built systems for people who can't roll 
their own.  Lots of the problems they have are non-obvious from the 
perspective of geekdom.

> > how much of an improvement is this really
> > over a binary distro?
>
> For the initial installation, maybe not much of an improvement, but for
> on-going use of a system, I think compiling from source is better overall.

Name me a Linux distribution that is not "compiled from source".

You keep saying that installing from source is better, but it seems to be from 
"gee, wouldn't it be nice if" land rather than due to actual experience.  You 
_can_ build and install an SRPM into a Red Hat system.  It's too much of a 
pain to be worth it to me, but it's been an option for years and years.

Most desktop users I've seen who modify their own systems dirty them badly 
enough that they copy their data off and reinstall every year or so anyway, 
so your long term support argument is a bit strange.  (We make fun of this as 
a windows thing, but in the LInux world people DO reinstall when the next Red 
Hat comes out...)  And having the server setup reproducible from a fresh 
install is just plain good hygiene, anyway.  (Doesn't mean everybody does it, 
but carrying around verbatim binary images through three or four hardware 
upgrades is _not_ a recipe for maintainability.  And what do you do if the 
sucker gets rootkitted, anyway?  Hope you got it all cleaned out?)

I'm not saying compiling from source is BAD.  I'm just saying it's not as big 
an improvement as you seem to think it will be.  It does allow a number of 
new things to be done, but by itself it doesn't make a major difference.

> John.

Rob

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

