Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269379AbUJQUOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbUJQUOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269388AbUJQUOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:14:09 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:3495 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S269337AbUJQUMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:12:45 -0400
Subject: Re: 2.6.9-rc4-mm1: initramfs build fix [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Martin Waitz <tali@admingilde.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041017213334.GA8214@mars.ravnborg.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <20041017161554.GD10532@admingilde.org>
	 <1098034147.879.21.camel@nosferatu.lan>
	 <20041017213334.GA8214@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8IaeaYG4lBVgU6ZnOns5"
Date: Sun, 17 Oct 2004 22:12:09 +0200
Message-Id: <1098043929.15115.24.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8IaeaYG4lBVgU6ZnOns5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 23:33 +0200, Sam Ravnborg wrote:

Hiya,

>=20
> Can you submit a new version based on Linus' tree with the following modi=
fications:

It depends on gen_init_cpio-uses-external-file-list.patch from -mm, so
cannot until that is merged.

> 1) Propoer changelog

Should be with the other thread I guess.

> 2) Document use of .shipped somewhere
>=20

If I remember correctly, Andrew asked Thayne Harbaugh to add docs for
the list format, etc.  I will thus have to wait for those to do changes
brought by my patch.

> And the following small comments.
>=20
>=20
> >  # or set INITRAMFS_LIST to another filename.
> > -INITRAMFS_LIST ?=3D $(obj)/initramfs_list
> > +INITRAMFS_LIST :=3D $(obj)/initramfs_list
>=20
> Kbuild style is to reser all-uppercase to external visible variables.
>=20

Ok, so we need that in smaller caps.

> >  # initramfs_data.o contains the initramfs_data.cpio.gz image.
> >  # The image is included using .incbin, a dependency which is not
> > @@ -23,6 +23,23 @@ $(obj)/initramfs_data.o: $(obj)/initramf
> >  # Commented out for now
> >  # initramfs-y :=3D $(obj)/root/hello
> > =20
> > +quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
> Please aling output properly with rest of kbuild output.
> > +quiet_cmd_gen_list =3D GEN     $@
> Should be enough - the filename give some context as well
>=20

Right, thanks.  I did change it at some time (second only being GEN),
but I guess I missed the first.

> > +      cmd_gen_list =3D $(shell \
> > +        if test -f "$(CONFIG_INITRAMFS_SOURCE)"; then \
> > +	  if [ "$(CONFIG_INITRAMFS_SOURCE)" !=3D $@ ]; then \
> > +	    echo 'cp -f "$(CONFIG_INITRAMFS_SOURCE)" $@'; \
> > +	  else \
> > +	    echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
> Test for .shipped to be present first?
>=20

This needed even though its supposed to be there?  How should one handle
the event that its not .. just 'exit 1' ?

>=20
> > +	  fi; \
> > +	elif test -d "$(CONFIG_INITRAMFS_SOURCE)"; then \
> > +	  echo 'scripts/gen_initramfs_list.sh "$(CONFIG_INITRAMFS_SOURCE)" > =
$@'; \
> > +	else \
> > +	  echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
> Same here.
>=20
> > +	fi)
> > +
> > +$(INITRAMFS_LIST): FORCE
> > +	$(call cmd,gen_list)
>=20
> How do you secure that the list gets updated when some of the above logic=
 changes?

Currently it will error if one of the commands called fails - is there a
more preferred error handling method?

> Likewise avoid the list to be generated unles required.
>=20

Simply checking mtime should do?


Thanks,

--=20
Martin Schlemmer


--=-8IaeaYG4lBVgU6ZnOns5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBctIZqburzKaJYLYRAg9aAJ0c6XGkd5UVyJ/DNmwWtPC7tR2vNwCeNCfY
AcVYCamhFvyH2VYWPINe/Vg=
=nk11
-----END PGP SIGNATURE-----

--=-8IaeaYG4lBVgU6ZnOns5--

