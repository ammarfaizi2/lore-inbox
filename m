Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264247AbUEXK4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264247AbUEXK4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUEXK4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:56:43 -0400
Received: from nasty.thecoop.net ([216.218.255.165]:47000 "EHLO
	nasty.thecoop.net") by vger.kernel.org with ESMTP id S264247AbUEXK4j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:56:39 -0400
Subject: Re: Problems w/ 2.6.6 on smp system...
From: Drew Bertola <drew@drewb.com>
Reply-To: drew@drewb.com
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1085373949.2758.12.camel@ws.thecoop.net>
References: <1085298938.2760.22.camel@ws.thecoop.net>
	 <1085373949.2758.12.camel@ws.thecoop.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-bQFA2CEYQE7juEVakBN7"
Message-Id: <1085396197.2870.27.camel@ws.thecoop.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 May 2004 03:56:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bQFA2CEYQE7juEVakBN7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[Again, sorry to reply to my own post.  Someone's bound to email me in 6
or 8 months wondering if I ever found a solution.  My second post in
this thread has dmesg output, etc.]

On Sun, 2004-05-23 at 21:45, Drew Bertola wrote:
> On Sun, 2004-05-23 at 00:55, Drew Bertola wrote:
> > I've installed FC2 and am experiencing problems with usb devices and
> > ethernet cards (it might be everything on the pci bus).  I don't
have
> > this problem with their UP kernel, but I do have it with their SMP
> > kernel.
> >=20
> > I decided to build a 2.6.6 using the FC2 i686-smp config to see if
that
> > would help, but I have the same problems.

Passing "noapic" as a kernel option fixes this.

[For anyone wondering how, read the bottom of this post].

This is a bit of voodoo to me.  I didn't seem to be able to configure
out the CONFIG*_APIC_* options when I built the kernel.  Even if I
manually edited the .config file, the options were re-inserted.  I
believe this is due to my choice of arch and SMP.

CONFIG_MPENTIUMIII=3Dy
...
CONFIG_SMP=3Dy
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_SMP=3Dy
...
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy

> > The system is a Tyan Tiger 230T (S2507T) with dual 800MHz PIIIs.=20
This
> > board has a Via Apollo Pro133T chipset, a VT82C694T north bridge,
and a
> > VT82CC686B south bridge.  lspci output is below.
>=20
> 1 GB ram.
>=20
> > I have 2 nics installed (e100 and 8139too).  Both have the right
modules
> > loaded and are configured properly (including routes), but I can't
ping
> > out of the system nor do anything else over the network other than
> > pinging the nics themselves.
> >=20
> > My usb hosts are detected, but nothing attached works.  My usb
optical
> > mouse doesn't even light up.
> >=20
> > All of these problems go away in UP mode.

To recap the solution, pass the "noapic" option to the kernel at boot
time.  Typically, edit grub.conf with "noapic" appended to the kernel
line like so:

title Custom 2.6.7-rc1-smp
        root (hd0,0)
        kernel /boot/vmlinuz-2.6.7-rc1 ro root=3DLABEL=3D/ noapic
        initrd /boot/initrd-2.6.7-rc1.img

You might have other options as well.

--
Drew

--=-bQFA2CEYQE7juEVakBN7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsdTlt26h+Ap1SlURAvrRAJ90VNZzeWvBgud3uWsyKP8VaWeSlQCg5F7j
jdKKOtojcR1p7bjYg1DI1nw=
=kX7U
-----END PGP SIGNATURE-----

--=-bQFA2CEYQE7juEVakBN7--

