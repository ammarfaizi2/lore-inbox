Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUIABZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUIABZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUIABZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 21:25:29 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:26794 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S265847AbUIABZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 21:25:24 -0400
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@lst.de>
Date: Wed, 1 Sep 2004 11:24:22 +1000
Subject: Re: kbuild: Support LOCALVERSION
Message-ID: <20040901012422.GM2897@cse.unsw.EDU.AU>
References: <20040831192642.GA15855@mars.ravnborg.org> <20040901010840.GL2897@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKy6e3LXpfmanBFM"
Content-Disposition: inline
In-Reply-To: <20040901010840.GL2897@cse.unsw.EDU.AU>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKy6e3LXpfmanBFM
Content-Type: multipart/mixed; boundary="yzvKDKJiLNESc64M"
Content-Disposition: inline


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 01, 2004 at 11:08:40AM +1000, Ian Wienand wrote:
> With this patch *without* a localversion file I get
>=20
> ianw@baci:/tmp/kbuild-test$ make
> cat: /tmp/kbuild-test/localversion*: No such file or directory
> make: *** No rule to make target `/tmp/kbuild-test/localversion*', needed=
 by `include/linux/version.h'.  Stop.
>=20
> However, with the right files there it works as you describe.

Sorry to reply to myself, but I forgot to include a suggested patch
(attached).

-i

--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Makefile.localversion.diff"
Content-Transfer-Encoding: quoted-printable

=3D=3D=3D=3D=3D Makefile 1.523 vs edited =3D=3D=3D=3D=3D
--- 1.523/Makefile	2004-08-25 06:34:30 +10:00
+++ edited/Makefile	2004-09-01 11:17:27 +10:00
@@ -141,7 +141,14 @@
=20
 export srctree objtree VPATH TOPDIR
=20
-KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
+nullstring :=3D=20
+space      :=3D $(nullstring) # end of line
+localversion-files :=3D $(wildcard $(objtree)/localversion* $(srctree)/loc=
alversion*)
+
+LOCALVERSION :=3D $(subst $(space),, \
+                $(shell cat /dev/null $(localversion-files)))
+
+KERNELRELEASE=3D$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)$(LOCAL=
VERSION)
=20
 # SUBARCH tells the usermode build what the underlying arch is.  That is s=
et
 # first, and if a usermode build is happening, the "ARCH=3Dum" on the comm=
and
@@ -329,8 +336,8 @@
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:=3D -D__ASSEMBLY__
=20
-export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
-	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
+export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION LOCALVERSION KERNELRELEASE=
 \
+	ARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
 	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK CHECKFLAGS
=20
@@ -763,7 +770,7 @@
 	)
 endef
=20
-include/linux/version.h: Makefile
+include/linux/version.h: $(srctree)/Makefile $(localversion-files)
 	$(call filechk,version.h)
=20
 # ------------------------------------------------------------------------=
---

--yzvKDKJiLNESc64M--

--tKy6e3LXpfmanBFM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNSTGWDlSU/gp6ecRAli3AJ99ioycwDojhNaa3JSO7yShFTOvjwCeOa+W
oyAB1nvufrDy/qrK2RR1X68=
=IYaI
-----END PGP SIGNATURE-----

--tKy6e3LXpfmanBFM--
