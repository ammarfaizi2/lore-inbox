Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUBJWUc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUBJWUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:20:32 -0500
Received: from mhub-c6.tc.umn.edu ([160.94.128.36]:62945 "EHLO
	mhub-c6.tc.umn.edu") by vger.kernel.org with ESMTP id S261188AbUBJWU1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:20:27 -0500
Subject: Re: devfs vs udev, thoughts from a devfs user
From: Matthew Reppert <repp0017@tc.umn.edu>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040210182943.GO4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca>
	 <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca>
	 <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca>
	 <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SfuL0kdzgsh7BZ930ob8"
Message-Id: <1076451567.21725.21.camel@minerva>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 16:19:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SfuL0kdzgsh7BZ930ob8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

As always, not flaming ...

On Tue, 2004-02-10 at 12:29, Mike Bell wrote:
> On Tue, Feb 10, 2004 at 10:12:42AM -0800, Greg KH wrote:
> >
> > devfs also does not export the position within the entire device tree,
> > which sysfs does. =20
>=20
> devfs tried to do just that. sysfs does it better though. I don't see
> what that has to do with my point.

The point is illustrating differences between devfs and sysfs, since you
seem to be saying "they do the same thing" over and over, when really, they
don't.

> > But the main point is that udev is in userspace, and devfs is in the
> > kernel.  You forgot that :)
>=20
> No I didn't. udev is userspace, devfsd is userspace. devfs is kernel
> space, sysfs is kernel space. They're the same.

At the very least, sysfs' and devfs' approaches to devices differ in
philosophy. devfs says "here's a device node, you can tell where it is
in the bus hierarchy by looking at its filename". sysfs, on the other
hand, says "here's the device hierarchy", and gives you enough information
to create device nodes for each point in the hierarchy if you wish to do
so.

> > sysfs has no such "naming policy".  It merely exports the name that the
> > kernel happened to give the device, using the LSB naming scheme.  It
> > does not rely on driver substems to create subdirectories for their
> > devices, nor export their own nested naming schemes.
>=20
> But sysfs is still setting naming policy in the kernel. Because you
> didn't write the kernelspace static names in question, they don't exist?

This is kind of like saying "bzImage sets root partition location policy
because it uses whatever was the root partition when you made the image".
Which is bogus, that's what root=3D is for.

sysfs is in no way setting naming policy by exporting the LSB naming scheme=
.
First of all, sysfs isn't even creating the device nodes - that, of course,
is udev's (or whatever else you might want to use) job. You're right,
actually - if you're using udev, files the sysfs static names *don't* exist=
 -
*unless* your udev is configured to use them. If not, then obviously the
sysfs names don't matter at all.

> > sysfs merely exports the info that the kernel knows about a device, by
> > which udev creates a device node.
>=20
> devfs merely exports information the kernel knows, by which devfsd can
> create device nodes.

As I understand it, devfs actually creates device nodes, but devfsd can
request that the names be changed. (Granted, my understanding of the Linux
devfs implementation is far from complete.) "Exporting the information into
device nodes" is kind of silly to claim as a minimal exercise, when creatin=
g
the device nodes is the end goal of the software.

> > devfs exports the device node, and then lets devfsd override that node
> > and create other stuff.
>=20
> And sysfs exports files that are (from a kernel point of view) very
> nearly a device node.

This is like arguing that a file named foo with an accompanying file named
foo.acl is "very nearly" a file with an ACL. Or, more dramatically, like
equating a nuclear warhead with instructions on making U-238. The informati=
on
is there in sysfs, granted, but it's not in a directly usable form by itsel=
f.

> > But the point is that udev does not require such a interface as devfs t=
o
> > get the job done.  devfsd does.
>=20
> Yes it does, it requires sysfs.

ps requires /proc :3

The difference between sysfs and devfs, in this regard, is fairly simple. B=
y
just turning on devfs support, you've suddenly changed the behaviour of the
system (device node creation and naming) once /dev is mounted. By turning o=
n
sysfs, the behaviour of the system doesn't change at all, even when /sys is
mounted.

> > Providing specific examples of what you find lacking in udev would be
> > constructive.  Saying, "I don't like it as it doesn't feel right to me"
> > is merely wanting to pick a fight.
>=20
> udev tries to do the job without a devfs. I said that already. I think
> there should be a kernel exported filesystem with kernel-created device
> nodes,

Why should the kernel create the device nodes? Sure, it's "just an extra
step", but the general Linux philosophy is that "just extra steps" don't
belong inside the kernel. Why should the kernel do more work?

Matt

--=-SfuL0kdzgsh7BZ930ob8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAKVjvA9ZcCXfrOTMRAq4RAJkB3+6iVqPfMMwxC1/8BnaoumFwYwCfXxPe
TfR18YYpIZTKP+Sqjyc5Zto=
=gw7O
-----END PGP SIGNATURE-----

--=-SfuL0kdzgsh7BZ930ob8--

