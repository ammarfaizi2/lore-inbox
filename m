Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262670AbSKDTnl>; Mon, 4 Nov 2002 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSKDTnk>; Mon, 4 Nov 2002 14:43:40 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:23989 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S262670AbSKDTnf>; Mon, 4 Nov 2002 14:43:35 -0500
Date: Mon, 4 Nov 2002 12:50:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021104195005.GB27298@opus.bloom.county>
References: <20021030233605.A32411@jaquet.dk> <20021031132607.E21801@borg.org> <20021031185308.GE30193@opus.bloom.county> <200211012054.34338.landley@trommello.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211012054.34338.landley@trommello.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 02:13:33AM +0000, Rob Landley wrote:
> On Thursday 31 October 2002 18:53, Tom Rini wrote:
> > On Thu, Oct 31, 2002 at 01:26:07PM -0500, Kent Borg wrote:
> > > On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> > > > In other words, s/CONFIG_TINY/CONFIG_FINE_TUNE, and ask about
> > > > anything / everything which might want to be tuned up.
> > >
> > > Please, no.  Keep this simple.
> >
> > We can keep it simple, as long as we keep it flexible.
> 
> If having the source isn't enough flexibility for you, it's not possible TO 
> have enough flexibility for you.
> 
> The point of CONFIG_TINY is that anybody interested in looking at how to trim 
> the fat on their kernel has something to grep for, and it's als a quick and 
> dirty way to say "this kernel will go on boot floppy or eprom boot image" 
> without having to spend two days micro-managing.

With the way CONFIG_TINY is now you still have to have a good deal of
knowledge of the source and look at N different files and hope that you
did manage to catch all of the places that CONFIG_TINY really did effect
the area you want.  And that the author of new subsystem Y takes
advantage of CONFIG_TINY and works things out appropriately.  I want
(and I will try and get working this week if I have time) 1 place where
you have to change things.

> Having "config_8_million_tweaks" is actually counter-productive.  It's quite 
> possible to give people so many buttons and levers they can't find the two 
> they're interested in, and there will ALWAYS be instances where you have to 
> go diddle the source.
> 
> Are you seriously suggesting that every single #defined constant should be 
> editable from make menuconfig?  If not, you acknowledge that there IS a line 
> that needs to be drawn.  And the place it has CURRENTLY been drawn (what IS 
> in make menuconfig) is a darn good starting point for discussion of where it 
> should be.

No, I have been talked out of doing config options as a better solution,
the problem with doing templates (which I'm trying to figure out how to
do now) is how to do it in a manner which doesn't uglify the source.

> > > I don't want a bunch of configs that abstract out everything I might
> > > want to tamper with to make a small system.  The only way I am going
> > > to make sense out of them will be to look at the source controlled by
> > > each anyway.  I would rather search the source for CONFIG_TINY and see
> > > a single, coherent, and sensible set of concrete changes that make
> > > things smaller.  Let me mangle and customize from there, it will be
> > > much easier for me to understand what I am doing.
> >
> > Templates would help out here.  Right now, if something isn't a config
> > option, you have to dig into the source to tune things.
> 
> More or less by definition, yes.

Which leads to missing places where the original coder used SOME_CONST /
4 directly instead of (SOME_CONST / 4).  We had this problem on PPC for
a while when people would want to get 1gb of RAM w/o using
CONFIG_HIGHMEM.  We've since solved this quite nicely.

> > This isn't
> > really nice since to tweak most things you only need to change a few
> > constants.
> 
> You're against people having to modify the source at all, then.  That 
> argument's not going far around here, you realise this don't you?

I'm against making it harder to tweak things than needed.

> > The problem is finding all of these constants, and the
> > places where maybe someone used a number derrived from the constant, and
> > so on..
> 
> 1) This is a seperate argument.  Your'e trying to bolt your personal pet 
> project on to the CONFIG_TINY discussion, and they have nothing to do with 
> each other.

CONFIG_TINY is an attempt to make it 'easier' on the embedded world.  I
work in the embedded world.  I'm trying to point out that kernel size is
not the biggest problem facing embedded linux people.  It's making the
kernel flexible enough, without being a guru of every subsystem you need
to change.

> 2) Provide a patch.  The CONFIG_TINY people have a patch.  You do not.  You 
> lose.

bk://ppc.bkbits.net/linuxppc-2.5, CONFIG_ADVANCED_OPTIONS (or !) is
sort-of how I want the code to look (I just don't have templates yet
since doing that, without massive modifications to the code (except for
changing 0x1234 into a define) is non-trivial).  If you want to change
HIGHMEM/LOWMEM/KERNELLOAD, etc it's quite trivial and it didn't require
any real uglification of the code.

> > > > Then this becomes a truely useful set of options, since as Alan
> > > > pointed out in one of the earlier CONFIG_TINY threads, his Athlon
> > > > could benefit from some of these 'tiny' options too.
> > >
> > > Certainly, if there are potential config options that would be truly
> > > useful to general folks, then by all means, yes!, make them separate
> > > options.  (Isn't that what has been going on all along?)
> >
> > I would hope it was, but it doesn't seem like that's been what's going
> > on..
> 
> Because you haven't personally done it, and nobody else seems to be 
> interested.

Well, Alan did mention in the original thread that lots of desktop boxes
could make use of some of these things too, and I was hoping that it
would be picked up on myself.  But yes, this is on my todo list, along
with school and other things.

> > Building a 'tiny' kernel should have nothing to do with any of this.
> 
> Oh good, we agree on something.

:P

> > Don't think 'tiny' think 'flexible'.
> 
> Nobody's working on CONFIG_FLEXIBLE.  You're trying to hijack a project with a 
> different agenda because it doesn't do something totally unrelated that you 
> think should be done.

CONFIG_TINY aims at producing a kernel because that's seen as the
largest problem facing embedded linux people.  I'm trying to convince
people that it is not.  It's being flexible enough to easily adapt the
kernel for any systems use.

> >  And I'm not necessarily saying it
> > has to be N CONFIG options (Matt Porter's template idea is rather
> > tempting), just that things have to be:
> > a) Flexible enough such that someone who wants to tweak param X doesn't
> > have to know every intricate detail of subsystem Y just to tune things.
> 
> And the universe in general should be easily manipulated by people who don't 
> understand how it actually works.  This is called "magic".

If you don't understand how something generally works, you can't
reasonably expect to be able to change it, I agree.  But if you do
understand how something works in general, you shouldn't need to be a
subsystem guru of kernel version X.Y.Z to tweak things for your
application.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
