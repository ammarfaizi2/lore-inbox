Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbUAKWer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUAKWer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:34:47 -0500
Received: from coffee.creativecontingencies.com ([210.8.121.66]:3006 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S266007AbUAKWen
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:34:43 -0500
Subject: Re: PCMCIA lockups on HP Pavilion laptop
From: Peter Lieverdink <peter@cc.com.au>
To: Aubin LaBrosse <arl8778@rit.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1073191980.1505.32.camel@localhost.localdomain>
References: <1073191980.1505.32.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6ov3z8Zv7d9iSxx6J+Q4"
Message-Id: <1073860473.1103.3.camel@kahlua>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 09:34:33 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6ov3z8Zv7d9iSxx6J+Q4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-04 at 15:53, Aubin LaBrosse wrote:
> Hi all,
>=20
> I have an HP pavilion ze4145 laptop running fedora core 1 with arjanv's
> 2.6.0-1.109 kernel. I have recently purchased an SMC 2532W-B 802.11b
> wireless card.  I am not sure that this is supported under linux, but
> the problem I am having is rooted deeper than that:
>=20
> when the redhat pcmcia script is run, the laptop locks up solid.  sysrq
> is enabled but i have not tried it yet, i'd have to look up the keys and
> what they do.  regardless, i have traced the problem to cardmgr itself,
> cardctl works alright though it can't provide much info on the card.  I
> have pcmcia modularized as is most of the redhat kernel, and the modules
> pcmcia_core, yenta_socket and ds are loaded.  when cardmgr runs, it
> locks the box up when it is inside the adjust_resources function in
> cardmgr.c - at least on this 2.6.0 kernel, though the pcmcia script also
> locks the box up on the 2.4 fedora kernels (2.4.22-1.2135.nptl and
> 2.4.22-1.2115.nptl, both fedora core 1 stock kernels).
> =20
> the version of the pcmcia kernel stuff installed with fedora is 3.1.31 -
> i have also installed the 3.2.7 userspace utilities (not kernel side,
> the configuration process from pcmcia-cs-3.2.7 detected that pcmcia was
> already enabled in the kernel and only installed the userspace stuff.)
>=20
> the way in which i determined that cardmgr was at fault was by running
> it by hand, simply cardmgr -v.  I then traced it down further by adding
> fprintfs to stderr to cardmgr.c - the specific line from which my box
> never returns is=20
>=20
>  ret =3D ioctl(fd, DS_ADJUST_RESOURCE_INFO, &al->adj);
>=20
> in adjust_resources() in cardmgr.c
> the resource being adjusted is an io-range resource, and it's the second
> one in the linked list that crashes my box, the first one succeeds just
> fine
>=20
> i also tried booting with noapic and acpi=3Doff just to see if that had
> anything to do with it, but no luck.  I have not yet tried a stock
> kernel.org kernel.=20
>=20
> debugging this inside the ioctl is a bit out of my league, which is why
> i have written this mail - any insight anyone else has (even if it's
> just 'what the hell is wrong with you, you've screwed everything up by
> doing xxx') would be much appreciated.  Not being a kernel-hacker but
> being a compsci major in school probably makes me too dangerous for my
> own good. ;-) so if i've totally made a mess of things just tell me so.=20
> I've attached the diff between my modified copy of cardmgr.c and the one
> from pcmcia-cs-3.2.7. First diff I've ever made, so it could be wrong -
> it's just fprintfs to see where it got while it was running.  I'll study
> up on the format of adjust_list_t and see if i can figure out exactly
> which io range the code is trying to adjust and failing at.=20
>=20
> thanks for any insights, all. =20
>=20
> -aubin

I have an HP nx9005 laptop which also hung quite badly during pcmcia
startup. I found a website with a config.opts which seems to work around
this problem. It may or may not work for you, but it might be worth a
try. This is what I used:

http://www.consultmatt.co.uk/nx9005/config.php

- Peter.

--=-6ov3z8Zv7d9iSxx6J+Q4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAAc94f34AjKyA6C4RAqF3AKCGmN1GDVJhK7Dn+OmPyW6AXK9yegCfR2Ox
zIYqqZPpWWDtqXZUGiOAJu0=
=YzaS
-----END PGP SIGNATURE-----

--=-6ov3z8Zv7d9iSxx6J+Q4--

