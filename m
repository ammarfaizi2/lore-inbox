Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVIOAYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVIOAYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVIOAYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:24:30 -0400
Received: from sls-ce5p321.hostitnow.com ([72.9.236.50]:17119 "EHLO
	sls-ce5p321.hostitnow.com") by vger.kernel.org with ESMTP
	id S932495AbVIOAY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:24:29 -0400
From: Chris White <chriswhite@gentoo.org>
Reply-To: chriswhite@gentoo.org
Organization: Gentoo
To: marekw1977@yahoo.com.au
Subject: Re: Automatic Configuration of a Kernel
Date: Thu, 15 Sep 2005 17:53:17 +0900
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com> <4328B710.5080503@in.tum.de> <200509151009.59981.marekw1977@yahoo.com.au>
In-Reply-To: <200509151009.59981.marekw1977@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4855049.OxLx6jn7Nu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509151753.21971.chriswhite@gentoo.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - sls-ce5p321.hostitnow.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - gentoo.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4855049.OxLx6jn7Nu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 15 September 2005 09:09, Marek W wrote:
> On Thu, 15 Sep 2005 09:49, Daniel Thaler wrote:
> > Michal Piotrowski wrote:
> > > Hi,
> > >
> > > On 15/09/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
> > >>Hi
> > >>
> > >>I wrote this Framework for making a .config based on
> > >>the System Hardwares. It would be a great help if some
> > >>people would give me their opinion about it.

[tons of snipping]

> Something that can do the hardware detection, then maps that to drivers
> would be very useful.

well, in theory this works as well.  If you do this in the kernel source=20
directory:

make allmodconfig

that makes a kernel with all possible configure options that can be built a=
s=20
modules enabled.

make install

and you have a couple of nice files in /lib/modules/(version)/modules.*map

=2Drw-r--r--  1 root root    73 Sep 14 23:15 modules.ieee1394map
=2Drw-r--r--  1 root root   132 Sep 14 23:15 modules.inputmap
=2Drw-r--r--  1 root root    81 Sep 14 23:15 modules.isapnpmap
=2Drw-r--r--  1 root root  7834 Sep 14 23:15 modules.pcimap
=2Drw-r--r--  1 root root    43 Sep 14 23:15 modules.seriomap
=2Drw-r--r--  1 root root 80010 Sep 14 23:15 modules.usbmap

the usual favorite of mine is modules.pcimap, which, when compined with lsp=
ci=20
can give you the proper module for your pci device.  Granted it has the fau=
lt=20
of a) how to figure out the configure option.  Sometimes it's CONFIG_[name]=
,=20
sometimes it's not (grepping maybe?) b) sometimes two drivers do the same=20
thing, but if enabled together will cause kittens to cry and babies to pull=
=20
flowers.  Therein lies one of the main issues.  I'm going to assume by seei=
ng=20
the rules_file bit that you address it in that way.  However, seeing the=20
development model of the kernel, trying to keep that updated may get a litt=
le=20
weird. =20

My 1.5 $denomination
Chris White

--nextPart4855049.OxLx6jn7Nu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDKTaBFdQwWVoAgN4RAogMAKDnOWRuNP04bZ2/GLZuLrKn8puzaACgyF7/
qluAB1hNvFnvmzWflZdmcaI=
=//fX
-----END PGP SIGNATURE-----

--nextPart4855049.OxLx6jn7Nu--
