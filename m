Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTKFObi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 09:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKFObi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 09:31:38 -0500
Received: from trantor.org.uk ([213.146.130.142]:2537 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263620AbTKFObf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 09:31:35 -0500
Subject: Re: CONFIG_PACKET_MMAP revisited
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Oliver Dain <omd1@cornell.edu>
Cc: odain2@mindspring.com, linux-kernel@vger.kernel.org
In-Reply-To: <200311060913.41719.omd1@cornell.edu>
References: <176730-2200310329491330@M2W026.mail2web.com>
	 <1068116914.6144.1410.camel@lemsip>  <200311060913.41719.omd1@cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TBmtgSkVPle6r339FmHf"
Message-Id: <1068129060.530.1438.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 15:31:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TBmtgSkVPle6r339FmHf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 15:13, Oliver Dain wrote:
> It seems to me that it can't loop in user mode forever.  There is no way =
to=20
> get data into user mode (the ring buffer) witout going through the kernel=
. =20
> My understanding is that the NIC doesn't transfer directly to the user mo=
de=20
> ring buffer, but rather to a different DMA buffer.  The kernel must copy =
it=20
> from the DMA buffer to the ring buffer. Thus once the user mode app has=20
> processed all the data in the ring buffer the kenel _must_ get involved t=
o=20
> get more data to user space.  Currently the data gets there because the N=
IC=20
> produces an interrupt for each packet (or for every few packets) and when=
 the=20
> kernel handles these the data is copied to user space.  Then, as you poin=
t=20
> out, the cost of the RETI can't be avoided. =20

yes, in interrupt context. My point is that that *task* will never go in
to kernel mode, it will always be running in user mode.

> However, if the NIC could transfer the data directly to user space it wou=
ldn't=20
> need to cause an interrupt and the cost of the RETI and the context switc=
h is=20
> avoided.  The user mode app really could process forever without sleeping=
 at=20
> that point.

it would need to cause an interrupt to notify of the packet, unless the
program communicated directly with the NIC in polling mode. This the
point of mmap packet socket, provides a *portable* ring buffer structure
so that userspace doesn't have to reimplement drtivers.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-TBmtgSkVPle6r339FmHf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qlskkbV2aYZGvn0RAl3cAJ9KaFw+s2+PQLyxXu2IiRGBqT7K2ACfY/LT
50AqwW4YO3WN3PRELgV4k/o=
=RKk0
-----END PGP SIGNATURE-----

--=-TBmtgSkVPle6r339FmHf--

