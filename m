Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265162AbSJRPIV>; Fri, 18 Oct 2002 11:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265164AbSJRPIV>; Fri, 18 Oct 2002 11:08:21 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:26496 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S265162AbSJRPIT>; Fri, 18 Oct 2002 11:08:19 -0400
Message-Id: <200210181514.g9IFEErG006526@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security 
In-Reply-To: Your message of "Fri, 18 Oct 2002 14:05:43 BST."
             <20021018140543.C1670@infradead.org> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
References: <Pine.GSO.4.21.0210180309540.18575-100000@weyl.math.psu.edu> <3DAFCE1B.805@wirex.com>
            <20021018140543.C1670@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-53981906P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Oct 2002 11:14:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-53981906P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Oct 2002 14:05:43 BST, Christoph Hellwig said:
> All three are actually very good examples on how your "Security"
> modules work around problems instead of fixing thev actual cause.

OK.. I'll grant that a lot of things done here are fixing the fact that
there are some really fundamental botches in the Linux kernel, such as
the fact that there isn't a long history of Posix-capability flavor
separation (so processes need to start as root just so they can bind
a low-number port - blech).

Would fixing *ALL* of that history (and all the userspace crap that has
grown on top of it) be *LESS* invasive/disruptive than what LSM does?

Do you have a projected timeline of when this mythical "all the warts in the
kernel are fixed and all the userspace cruft is cleaned up" world will happen?
I'd like some sort of reasonable estimate, so I know whether this will be
before or after I retire. (While we're at it, can we reverse the definition
of the 'r' and 'x' permissions on directories, so 'umask 037' doesn't result
in directories with borked permissions?  I'm actually somewhat serious here -
this is the sort of thing that will need to be cleaned up and fixed all over
the place...)

> Instead of adding hacks for tempfile races you rather want to
> give each user a private namesapace and it's own /tmp (IMHO
> we should also get rid of symlinks entirely, but they're in too wide
> use nowdays unfortunately).

Symlinks are in too wide use, and too much code knows about them - yes,
it might be nice if we threw symlinks out the window and replaced them with
a union-mount scheme.  But would that be any less disruptive than what LSM does?

> And ptrace _really_ _really_ needs to be replaced by a sane debug
> interface,  like the plan9 procfs-based debugging.

Yes.  But would that be less disruptive than what LSM does?

> But instead of attaking these causes security folks like wirex just
> implement fuzzy busword mechanisms that are selable to managers.

The part you're missing here is that the "fuzzy buzzword mechanism" is
deployable *NOW*, and will provide *real benefits* *NOW*, rather than having
to wait for the 2.7 or 3.1 or whatever kernel.

And before you go off on the "but a lot of these can be circumvented" tangent,
I'll point out that almost *NOTHING* is totally secure.  Yes, there are a
number of ways to defraud my bank.  This doesn't mean that my bank is remiss
in making sure that *one class* of attacks (for instance, physical attacks
on ATM machines) isn't sufficiently protected against.  Yes, my signature
can be forged - but my bank still has a signature card on file.

Which is more easily sellable to managers:

1) "We could deploy extended attributes and ACLs, except that they're not
supported yet on the filesystem that would otherwise be most suited.  Once
they're integrated into that filesystem it will be great, but we're not sure
which release of the kernel it will happen in, or when that will be. And once
it DOES get supported, we don't have any guarantee that some clever person
won't find a way around the permissions that the kernel maintainer(*) isn't
allowed to explain to us, like we've seen at least once already that we know
of.  Oh, and if the facilities provided don't match our business model,
we're stuck maintaining local patches or changing our business model".

2) "We could deploy an LSM module, that will work no matter WHAT filesystem
we're using. It's there for the current kernel, and although there's always
the chance that some clever person will find a way to end-run our module and
bypass it, it's equally likely that the same clever person will find some
OTHER silly bug elsewhere in the kernel that lets them bypass everything.
Oh, and we can tailor the restrictions to fit *OUR* business model and the
threats *we* feel are important."

(*) Apologies to Alan Cox here - I actually think he did The Right Thing, and
the actual bugs weren't his fault. The point here is that we've seen a *LOT*
more security problems caused by simple *BUGS* than we have by any hypothetical
"the LSM model doesn't secure 100% of the cases, so it's breakable and totally
useless" problems.

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-53981906P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9sCVGcC3lWbTT17ARArvgAJ4q3hIorAc/TbN8gWDTJTt/5WXnGQCfWuD+
9dNQ0Jv2Xj0Eh3lKIsR2V1k=
=Faa4
-----END PGP SIGNATURE-----

--==_Exmh_-53981906P--
