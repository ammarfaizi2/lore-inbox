Return-Path: <linux-kernel-owner+w=401wt.eu-S932104AbXACVjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbXACVjh (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbXACVjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:39:37 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43139 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932104AbXACVjh (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:39:37 -0500
Message-Id: <200701032139.l03LdX6Y000889@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Pelle Svensson <pelle2004@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Symbol links to only needed and targeted source files
In-Reply-To: Your message of "Wed, 03 Jan 2007 22:14:43 +0100."
             <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <6bb9c1030701030724k4ca544cfg364e28059cf5dfe@mail.gmail.com> <20070103162409.GA30071@uranus.ravnborg.org>
            <6bb9c1030701031314l1b57bd2brffb61cce68a7174@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1167860373_9256P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Jan 2007 16:39:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1167860373_9256P
Content-Type: text/plain; charset=us-ascii

On Wed, 03 Jan 2007 22:14:43 +0100, Pelle Svensson said:
> Hi Sam,
> 
> You misunderstand me I think, I already using a separate output directory.
> What I like to do is a separate 'source tree' with only valid files
> for my configuration. In that way, when I use grep for instance,
> I would only hit valid files and not 50 other files which are
> not in the current build configuration.

This is covered in the Kernel FAQ:

http://www.tux.org/lkml/#s7-7

"The kernel source is HUUUUGE and takes too long to download. Couldn't it be
split in various tarballs?

The kernel (as of 2.1.110) has about 1.5 million lines of code in *.c, *.h and
*.S files. Of those, about 253 k lines (17%) are in the architecture-specific
subdirectories, and about 815 k lines (54%) are in platform-independent
drivers. If, like most people, you are only interested in i386, you could save
about 230 k lines by removing the other architecture-specific trees. That is a
15% saving, which is not that much, really. The "core" kernel and filesystems
take up about 433 k lines, or around 29%.

If you want to start pruning drivers away, the problem becomes much harder,
since most of that code is architecture independent. Or at least, is supposed
to be/will be. There is some driver code which probably should be moved to an
i386-specific subdirectory, and perhaps over time it will be (it will take a
lot of work!), but you need to be careful. PCI cards for example should be
architecture independent. Throwing out the non i386-specific drivers will save
around 97 k lines, a saving of about 6%.

But the most important argument for/against splitting the kernel sources is not
about how much space/download time you could save. It's about the work involved
for Linus or whoever will be putting together the kernel releases. Building
tarballs (compressed tarfiles) of the whole kernel already represents a
considerable amount of work; splitting it into various architecture-dependent
tarballs would dramatically increase this effort and would probably pose
serious maintainability problems too.

If you are really desperate for a reduced kernel, set up some automated
procedure yourself, which takes the patches which are made available, applies
them to a base tree and then tars up the tree into multiple components. Once
you've done all this, make it available to the world as a public service. There
will be others who will appreciate your efforts."

In other words, it won't help as much as you think.  And note that you'd
*really* need to make it config-specific - the instant you change *any*
option in that .config, you're likely now including some newoption.c file
that will fail your kernel build...  Whoops.



--==_Exmh_1167860373_9256P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFnCKVcC3lWbTT17ARAlvkAJ9VmScW8i7N1tSB4EcR/xJ8ZgWN+gCgqXRO
4nz28fXKyaSq9yQX6UO0XFs=
=Mvfg
-----END PGP SIGNATURE-----

--==_Exmh_1167860373_9256P--
