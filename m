Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVHMNj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVHMNj1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 09:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVHMNj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 09:39:27 -0400
Received: from nef2.ens.fr ([129.199.96.40]:2825 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932169AbVHMNj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 09:39:26 -0400
Date: Sat, 13 Aug 2005 15:39:25 +0200
From: Nicolas George <nicolas.george@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix mmap kmem (was: [question] What's the difference between /dev/kmem and /dev/mem)
Message-ID: <20050813133925.GA29182@clipper.ens.fr>
References: <1123796188.17269.127.camel@localhost.localdomain> <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Sat, 13 Aug 2005 15:39:25 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le quintidi 25 thermidor, an CCXIII, Linus Torvalds a =E9crit=A0:
> We do need to support /dev/mem for X, but even that might go away some=20
> day.=20

If I may interfere, I would like to point another use of /dev/mem:
long-running memory tests that do not alter the service much. I have written
a small package which does such tests. The principle is to write
pseudo-random data in a page, and later read it back and compare it to what
it should be. For such a test, /dev/mem can be used two ways:

- to access memory pages that have been disabled by mem=3D/memmap=3D command
  lines arguments;

- to look for the physical address of an userland-allocated and mlock()ed
  page (by writing a known pattern in it).

(Well, I am not even sure that the physical address of a mlock()ed page can
not change.)

With the increasing cheapness but lack of reliability of noname RAM, such
tests become very useful for home and even professional usage. I could
easyly imagine a fully automated distribution that would enable such a test
tool for a month after the first installation, for example.

It can be noted that those tests do not require the full features of
/dev/mem, and especially not the security threatening ones. It would be
sufficient to have some sort of API to:

- map a particular physical page of memory in a process' address space,
  optionnally reallocating a previous usage of that page, and failing if it
  can not be done;

- ask the physical address of a maped page.

The second can be done with /proc/kcore, but it depends on internal
structures of the kernel. I believe it could easily be done with a
/proc/$PID/maps-like file.

The first could be implemented as a flag to mmap (maybe MAP_PHYSICAL) which
would cause the addr argument to be the physical address of the requested
page.

It may seem a lot of trouble for some very specific need, but I have
remarked that bad memory bits are an increasing problem, and ECC memory and
motherboards supporting it are not easy to find for non high-grade
professional hardware. A well-integrated software workaround would be really
useful I believe.

Regads,

--=20
  Nicolas George

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFC/fgNsGPZlzblTJMRAsxSAJ0YRitHci1BMLThxs2LxZOFT3USuQCfQbLd
TF1l3qg0TI6xrorGtCwnlso=
=9Gaw
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
