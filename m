Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265360AbSJaSrG>; Thu, 31 Oct 2002 13:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSJaSrG>; Thu, 31 Oct 2002 13:47:06 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:7339 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S265360AbSJaSq7>; Thu, 31 Oct 2002 13:46:59 -0500
Date: Thu, 31 Oct 2002 11:53:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Adrian Bunk <bunk@fs.tum.de>,
       Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_TINY
Message-ID: <20021031185308.GE30193@opus.bloom.county>
References: <20021030233605.A32411@jaquet.dk> <Pine.NEB.4.44.0210310145300.20835-100000@mimas.fachschaften.tu-muenchen.de> <20021031011002.GB28191@opus.bloom.county> <20021031053310.GB4780@mark.mielke.cc> <20021031143301.GC28191@opus.bloom.county> <20021031165113.GB8565@mark.mielke.cc> <20021031170420.GA30193@opus.bloom.county> <20021031132607.E21801@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021031132607.E21801@borg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 01:26:07PM -0500, Kent Borg wrote:
> On Thu, Oct 31, 2002 at 10:04:20AM -0700, Tom Rini wrote:
> > In other words, s/CONFIG_TINY/CONFIG_FINE_TUNE, and ask about
> > anything / everything which might want to be tuned up.
> 
> Please, no.  Keep this simple.  

We can keep it simple, as long as we keep it flexible.
 
> I don't want a bunch of configs that abstract out everything I might
> want to tamper with to make a small system.  The only way I am going
> to make sense out of them will be to look at the source controlled by
> each anyway.  I would rather search the source for CONFIG_TINY and see
> a single, coherent, and sensible set of concrete changes that make
> things smaller.  Let me mangle and customize from there, it will be
> much easier for me to understand what I am doing.

Templates would help out here.  Right now, if something isn't a config
option, you have to dig into the source to tune things.  This isn't
really nice since to tweak most things you only need to change a few
constants.  The problem is finding all of these constants, and the
places where maybe someone used a number derrived from the constant, and
so on..

> > Then this becomes a truely useful set of options, since as Alan
> > pointed out in one of the earlier CONFIG_TINY threads, his Athlon
> > could benefit from some of these 'tiny' options too.
> 
> Certainly, if there are potential config options that would be truly
> useful to general folks, then by all means, yes!, make them separate
> options.  (Isn't that what has been going on all along?)

I would hope it was, but it doesn't seem like that's been what's going
on..

> But let us
> not put in a config for every imaginable tuning and then pretend that
> hiding them behind a CONFIG_FINE_TUNE somehow doesn't make them any
> less a groady mess.  

Let's not pretend that changing > 1 tunable param with 1 CONFIG question
makes it any better than it is now.

> Isn't there an attempt with the current config process to set up
> dependencies so that any config from "make config" or "make xconfig"
> has a crack at being at least self-consistent, if not otherwise
> sensible?  Won't this CONFIG_FINE_TUNE become a bloating ground for
> every obscure special interest config, related to size or not, whether
> it builds or not, whether it runs of not?  (And be so confusing as to
> still not help me build a tiny kernel?)

Building a 'tiny' kernel should have nothing to do with any of this.
Don't think 'tiny' think 'flexible'.  And I'm not necessarily saying it
has to be N CONFIG options (Matt Porter's template idea is rather
tempting), just that things have to be:
a) Flexible enough such that someone who wants to tweak param X doesn't
have to know every intricate detail of subsystem Y just to tune things.
b) Done in a way that doesn't clutter up the code in question (ideally
s/some_constant/SOME_DEFINE).
c) Be simple enough such that people don't shoot their feet off, at
least not unintentionally.

> If something is worth a config, give it a config.  (And if it isn't,
> don't!)  But not every component of making a tiny system is worth a
> standalone config.  Let me grep for CONFIG_TINY and hack my
> nonstandard things from there.

By that token, if it's not worth it's own CONFIG, don't mask it under 1
CONFIG either.  That doesn't make it easier to tune one param if you
have to check N occurances of CONFIG_TINY to make sure you got all of
the correct places.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
