Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314063AbSDQFER>; Wed, 17 Apr 2002 01:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314065AbSDQFEQ>; Wed, 17 Apr 2002 01:04:16 -0400
Received: from adsl-64-109-202-37.dsl.milwwi.ameritech.net ([64.109.202.37]:8434
	"EHLO alphaflight.d6.dnsalias.org") by vger.kernel.org with ESMTP
	id <S314063AbSDQFEP>; Wed, 17 Apr 2002 01:04:15 -0400
Date: Wed, 17 Apr 2002 00:04:12 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Larry McVoy <lm@work.bitmover.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Fbdev Bitkeeper repository
Message-ID: <20020417050412.GD5897@0xd6.org>
In-Reply-To: <Pine.LNX.4.10.10204161542470.29030-100000@www.transvirtual.com> <20020416225752.GA5897@0xd6.org> <20020416160121.B24069@work.bitmover.com> <20020417000818.GB5897@0xd6.org> <20020416181034.C24069@work.bitmover.com> <20020417024149.GC5897@0xd6.org> <20020416203721.B27525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Larry McVoy <lm@bitmover.com> on Tue, Apr 16, 2002:

>=20
> > This requires consistency on the part of the drop-in tree maintainer, to
> > sync to and from the mainline kernel.  Usually, only the maintainer sen=
ds
> > patches upstream, but experienced project developers can easily merge
> > changes coming from the mainline kernel.  I'm not aware of how BK may
> > automate this or make it easier, but this is one of those "use rigid
> > guidelines where CVS falls short" situations.  *Shrug*, a bit of extra
> > work, but still easier than tracking an entire tree's worth of changes.
>=20
> That's not a widely shared opinion.  Check with the people maintaining=20
> their own trees, tracking the mainline and/or some branch.  Saying
> "CVS falls short" is quite the understatement.  Try doing the same=20
> thing with CVS (or whatever else) and you'll see what I mean.  CVS
> is great for simple things; the kernel isn't simple.
>=20

Not sure I follow here, you're a bit vague about "doing the same thing".
Do you mean syncing from the mainline kernel?  It's easier to sync from
Linus because BK is being used to do it (e.g. because the Linus kernel is
tracked by BK?)?

For the LinuxSH project, we moved from tracking the full kernel tree (via
CVS) to a drop-in tree structure mainly because of the difficulty in
tracking all upstream kernel changes at once.  It wasn't really related to
what CVS did or did not offer.

> There is a basic flaw in your reasoning.  You're assuming that you
> can do all your work in isolation.  That's not true, the rest of the
> tree is changing around you and you need to build/test against that.
> Not doing so is just cutting corners and while I'm sure you are smart
> enough not to get burned too often by this, I'm equally sure you have
> and will get burned by it again.  Noone is immune.  And all of this is
> to save some disk space?  Disk drives are about $1/GB on pricewatch.
> A kernel tree, compressed, takes less than .1GB.  So you saved yourself
> 10 whole cents.  Wheeeeeee!
>

I never said anything about working in isolation in any of my posts.  A
drop-in tree is only usable when "dropped in" or symlinked on top of a full
kernel tree.  Because it's not a complete tree, it won't build otherwise.
In order to build and test a drop-in tree, you must have the current
mainline kernel version to drop against (whatever kernel version that has
been specified in the drop-in tree).  If something breaks upstream
(which happens more often than not, esp. in architecture ports), then
you'll see it as soon your build fails or when your kernel panics.  It's
impossible to develop a drop-in tree in complete isolation, so I'm not sure
why you thought this was possible?

Say cache handling is modified kernel-wide and it breaks a number of
architecture backends (this is a real world example, somewhere around
2.4.10 or so this actually happened).  Until you work out a fix for say,
the SuperH architecture, you pull in and modify the global cache-handling
files and modify it locally.  Once a proper fix has been developed, you
send your arch-specific cache routines upstream and remove the global
cache-handling files from your drop-in tree.

Also, the size of a drop-in tree is a side effect of its composition, it
was used to illustrate the benefit of the simplicity of drop-in trees - if
you recall the introductory paragraph of my original reply to yours, I said
that drop-in trees are most useful for kernel subsystems and backend
(architecture) ports.  The number of files that are specific to these
projects are a fraction of the size of the full kernel, and because of
this, it gives you a simpler, more readable view of your "corner" of the
kernel.  I don't know why you assumed I was on some fanatical quest to save
disk space.  However, I do mind how much of my broadband bandwidth is used
(since I'm stuck with a flaky ADSL link) and I'm sure developers still on 5=
6K
links also mind.

[snip]
>=20
> > Right, but CVS-like operations in BK currently won't allow me to do dro=
p-in
> > trees.  It's not so much a complexity of use issue as it's an issue of =
how
> > things are implemented or done in CVS vs. BK.  Because of its simplistic
> > view of repositories and how to work with them, CVS wins with small, fi=
nely
> > cultivated (excuse the lack of a better term) trees, whereas BK's compl=
ex
> > view of repositories does not.
>=20
> Nonsense.  You can do drops right now.  Just split the tree apart and
> clone the parts you need.  All the nested repos are going to do is=20
> give you some syntatic sugar which allows you to do just that.
>=20

Cool, finally you give a straight answer to an honest query.  You orignally
asked why I thought BK was inefficient as opposed to CVS, so I assume you
misunderstood my response to James.  I'm operating on the available info I
have on BK, where cloning is an all or nothing operation.  Is this not the
case?  Can you selectively pull in parts of the tree (similiar to drop-in
functionality) and is anyone doing it?  This is why I was opposed to the
linuxconsole drop-in tree moving to BK, not because of "some other agenda"
but because it screws up how I develop and test the tree.  I guess in
retrospect, you really didn't have a valid entrance into the thread, but I
guess any post including "Bitkeeper" catches your eye?

So, splitting trees in BK.  Do you mean by using native BK commands, or by
planning ahead and using multiple repositories?  Perhaps when you've
finished flaming me and defaming CVS you can give me a valid response as to
how one would maintain a drop-in tree using BK.  The isolation argument
doesn't fly since drop-in trees are far from isolated, and the disk space
thing was taken a bit out of context, but that's understandable.

You seem to be stuck on "why CVS sucks" while I'm trying to convey "why CVS
does what I need it to do" as far as drop-in trees are concerned.  From
every other pro-BK anti-everyother-RCS post I've read from you, you seem
conditioned to attack (or belittle) anyone that doesn't accept BK as
gospel.  I understand taking pride in your work, but damn!  Take it easy.
If you really wanted to help me (or convert me) to using BK, you'd just
tell me how the heck to do a drop-in tree, and I'd walk away enlightened.

[snide personal insults snipped]
>=20
> At the same time, it would also be great if you left off describing tools
> you don't use.  I don't know what part of the kernel you work on, but
> I can assure you that I won't go complaining about it unless I actually
> use it and think about it first.
>=20

I was able to ascertain that BK didn't support drop-in trees by just
reading www.bitmover.com.  Was there somewhere else I should've been
instead?

M. R.

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE8vQJMaK6pP/GNw0URAqZtAJ0bnJlHZUySQknLb9oYcyzZz0VMHgCgiudl
qMVShZNo6Zz4HaMTgKd7PBg=
=Srf+
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
