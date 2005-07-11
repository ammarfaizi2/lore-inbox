Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVGKSTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVGKSTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVGKSSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 14:18:02 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49049 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261977AbVGKSQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 14:16:06 -0400
Message-Id: <200507111815.j6BIFgc6002696@laptop11.inf.utfsm.cl>
To: erik@hensema.net
cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again 
In-Reply-To: Message from Erik Hensema <erik@hensema.net> 
   of "Mon, 11 Jul 2005 09:01:18 GMT." <slrndd4dau.bct.erik@bender.home.hensema.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 11 Jul 2005 14:15:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 11 Jul 2005 14:15:50 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema <erik@hensema.net> wrote:
> Horst von Brand (vonbrand@inf.utfsm.cl):
> [on reiserfs4]
> >> >>                                                   and _can_ do things
> >> >> no other FS can

> > Mostly useless things...

> Depends on your point of view. If you define things to be useful
> only when POSIX requires them, then yes, reiser4 contains a lot
> of useless stuff.

That isn't my definition.

> However, it's the 'beyond POSIX'-stuff what makes reiser4
> interesting.

I haven't seen a shred of evidence of that up to here. Just redoing
in-kernel (for completely inscrutable reasons) stuff that has been
confortably done in userland for many years isn't "Interesting", quite the
contrary.

> Multistream files have been useful on other OSses for years.

I only have seen other OSes moving away from such stuff...

>                                                              They
> might be useful on Linux too (Samba will surely like them).

OK, if you think Windows is a good idea all around...

> The plugin architecture is very interesting.

Again: It isn't "plugins", it's "kernel configuration options redefining
the filesystem layout". And that is extremely toxic: If the claims are to
be believed, somebody using ReiserFS 4 could end up using filesystems as
widely different as ext3 and ufs today. Both called the same. Or everybody
will end up using the exact same set of "plugins", so they make no sense as
configuration options. Sure, it is nice to have different versions of the
same filesystem (in a way, ext3 is a version of ext2; in ext3 there are
some options that where introduced later, and some of which aren't
backwards-compatible), but this is not something I would want each
individual user screw around with willy-nilly. So the whole "plugin" idea
is very questionable to me.

>                                              Sometimes you don't
> need files to be in the POSIX namespace.

The POSIX namespace /is/ the namespace for files.

>                                          Why would you want to
> store a mysql database in files?

Because it is the abstraction of permanent storage that the OS gives me. Or
I could write them directly on a raw block device for performance (by
cutting out a middleman).

>                                  Why not skip the overhead of the
> VFS and POSIX rules and just store them in a more efficient way?

Exactly. Cut out the filesystem.

> Maybe you can create a swapfile plugin.

The kernel manages swapping on files and devices just fine, thank you.

>                                         No need for a swapfile to
> be in the POSIX namespace either.

And how do you handle it if it has no filename?!

> It's just a fun thing to experiment with.

Noone here is stopping you from experimenting.

>                                           It's not always
> nescesary to let the demand create the means. Give programmers
> some powerful tools and wait and see what wonderful things start
> to evolve.

The sad truth is that if you give a random collection of people powerful
tools they misuse them more often than not, creating a huge mess in the
process. That is why it is so hard to design good tools.

> And yes, maybe in ten years time POSIX is just a subsystem in
> Linux. Maybe commerciale Unix vendors will start following Linux
> as 'the' standard instead of the other way around. Seems fun to
> me :-)

To me too. But forcing Linux today to be as non-POSIX as possible, just so
it will be prepared for 10 years in the future makes no sense, because you
break it /now/.

> I think this debate will mostly boil down to 'do we want to
> experiment with beyond-POSIX filesystems in linux?'.

You (and some others) clearly want to. More power to the bunch that comes
up with clean semantics that can be implemented efficiently and are useful
in real life (as opposed to "it would be oh-so-nice to also have $FEATURE
for my pet $NICHE_CASE, feature for which I just can't be bothered
considering ramifications at all"). Before going off look up "featuritis"
(and consider how it all but killed off a lot of OSes, even many Unix
variants, and uncountable other things too).
 
> Clearly we don't _need_ it now. There simply are no users. But
> will users come when reiser4 is merged? Nobody knows.

Probably a tiny minority. Something like the following ReiserFS 3 has
today.

> IMHO reiser4 should be merged and be marked as experimental.

IMHO ReiserFS 4 should not be merged into Linus' kernel. So what? It is not
my call (nor yours).

>                                                              It
> should probably _always_ be marked as experimental, because we
> _know_ we're going to need some other -- more generic -- API when
> we decide we like the features of reiser4. The reiser4 APIs
> should probably be implemented as generic VFS APIs. But since we
> don't know yet what features we're going to use, let reiser4 be
> self contained. Maybe reiser5 or reiser6 will follow standard
> VFS-beyond-POSIX rules, with ext4 and JFS2 also implementing them.

If is is /that/ experimental, it has no place in Linus' kernel at all. It
is not (and has not been for a half dozen years at least) a playground for
random experiments. Sure, you can fork off a branch for fooling around, you
are even wellcome to keep your laboratory synched up with the version
everybody is using, if that serves your needs.

> It's just too damn hard to predict the future.

Right. Instead of gambling it will turn out just as you think (why should I
give /your/ view more weight than mine? or prefer views which have shown to
be erroneous over the view of people who /have/ shaped the present we are
in today?), why not wait and see?

>                                                IMHO better just
> merge reiser4 and let it be clear to everybody that reiser4 is an
> experiment.

IMHO much simpler just leaving experiments to experimental branches.

> As long as it doesn't affect the rest of the kernel

Impossible.

>                                                      and it's
> clear to the users that reiser4 is *not* going to be the
> standard, it's fine with me.

Now I'm at a complete loss... Why should it be placed in the standard
kernel then?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
