Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVERLE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVERLE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVERLE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:04:57 -0400
Received: from home.leonerd.org.uk ([217.147.80.44]:17352 "EHLO
	home.leonerd.org.uk") by vger.kernel.org with ESMTP id S262168AbVERLEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:04:52 -0400
Date: Wed, 18 May 2005 12:04:46 +0100
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix to virtual terminal UTF-8 mode handling
Message-ID: <20050518120446.2eeb559f@nim.leo>
In-Reply-To: <20050517195848.4a09318d.akpm@osdl.org>
References: <20050518030513.7fe55ef1@nim.leo>
	<20050517195848.4a09318d.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.6cvs45 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Wed__18_May_2005_12_04_46_+0100_+nXq5IIiQRLMIzZQ;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__18_May_2005_12_04_46_+0100_+nXq5IIiQRLMIzZQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 May 2005 19:58:48 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Paul LeoNerd Evans <leonerd@leonerd.org.uk> wrote:
> >
> >  This patch fixes a bug in the virtual terminal driver, whereby the
> > UTF-8 mode is reset to "off" following a console reset, such as might
> > be delivered by mingetty, screen, vim, etc...
>=20
> Is it a bug?  What did earlier kernels do?  2.4.x?

I haven't checked earlier 2.4 kernels, but I know the 2.6 ones have done
this for quite some time; a good year or so at least.

> Presumably userspace knows what mode the user wants the terminal to be
> using.  Shouldn't userspace be resetting that mode after a reset?

Well, that does require changes to a lot of the programs that talk to the
console, moreover, they now need to be sensitive to whether it is in
UTF-8 mode, where previously they did not. E.g. consider mingetty...

Also, as I understand it, there is one keyboard map, and one console font
for the entire virtual console system - either they are UTF-8, or not. It
doesn't really make sense to be switching these about.

Moreover, this code also affects dynamic creation of new virtual
consoles. E.g. when debian's "oh no, I can't start the X server" ncurses
dialog appears, without my patch it prints UTF-8 characters on a new
console, tty8, on a console that isn't set to display them, and mass
breakage results. Now, it all happens cleanly, because the new console is
already in UTF-8 mode.

Were this to be pushed to userland, every program that outputs data would
need to detect the UTF-8 mode of the console, and set it appropriately.
Moreover, they would need to perform this logic only on a Linux virtual
console; such things as XTerm or Gnome-terminal do it automatically.

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Signature_Wed__18_May_2005_12_04_46_+0100_+nXq5IIiQRLMIzZQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCiyFRvcPg11V/1hgRAvCsAJ9NlCT3n0Rqlh0WP8W/6AVJUpUrgwCbBDSA
Cl1p1GcNgG8YDpgEF+pLjag=
=rSmx
-----END PGP SIGNATURE-----

--Signature_Wed__18_May_2005_12_04_46_+0100_+nXq5IIiQRLMIzZQ--
