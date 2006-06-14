Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWFNNSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWFNNSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWFNNSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:18:05 -0400
Received: from ex001a.cxnet.dk ([195.135.216.13]:43724 "EHLO
	comxexch01.comx.local") by vger.kernel.org with ESMTP
	id S964910AbWFNNSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:18:04 -0400
Subject: Re: [PATCH 2/2] NET: Accurate packet scheduling for ATM/ADSL
	(userspace)
From: Jesper Dangaard Brouer <hawk@comx.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       lartc@mailman.ds9a.nl, russell-tcatm@stuart.id.au, hawk@diku.dk,
       linux-kernel@vger.kernel.org, hawk@comx.dk
In-Reply-To: <1150282625.3490.23.camel@localhost.localdomain>
References: <1150278040.26181.37.camel@localhost.localdomain>
	 <1150282625.3490.23.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-41hGIGQHvr3hTqy3Q0B/"
Organization: ComX Networks A/S
Date: Wed, 14 Jun 2006 15:18:02 +0200
Message-Id: <1150291082.26186.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
X-OriginalArrivalTime: 14 Jun 2006 13:18:02.0899 (UTC) FILETIME=[F716CE30:01C68FB4]
X-TM-AS-Product-Ver: SMEX-7.0.0.1345-3.52.1006-14506.002
X-TM-AS-Result: No--1.300000-8.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-41hGIGQHvr3hTqy3Q0B/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 11:57 +0100, Alan Cox wrote:
> Ar Mer, 2006-06-14 am 11:40 +0200, ysgrifennodd Jesper Dangaard Brouer:
> > option to calculate traffic transmission times (rate table)
> > over all ATM links, including ADSL, with perfect accuracy.
>
> The other problem I see with this code is it is very tightly tied to ATM
> cell sizes, not to solving the generic question of packetisation.=20

Well, we did consider to do so, but we though that it would be harder to
get it into the kernel.

Actually thats the reason for the defines:
 #define        ATM_CELL_SIZE           53
 #define        ATM_CELL_PAYLOAD        48

Changing these should should make it possible to adapt to any other SAR
(Segment And Reasembly) link layer.

> I'm
> not sure if that matters but for modern processors I'm also sceptical
> that the clever computation is actually any faster than just doing the
> maths, especially if something cache intensive is also running.

I guess you are refering to the rate table lookup system, that is based
upon array lookups.  I do think that the rate table array lookup system
has been outdated, as memory access is the bottleneck on modern CPUs.
But its design by Alexey for a long time ago where the hardware
restrictions were different.  It also avoids floting point operations in
the kernel.

Thanks for your comments.

--=20
Med venlig hilsen / Best regards
  Jesper Brouer
  ComX Networks A/S
  Linux Network developer
  Cand. Scient Datalog / MSc.
  Author of http://adsl-optimizer.dk


--=-41hGIGQHvr3hTqy3Q0B/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkAyKwuVH+NB3fZkRAspAAJ491JxslgE27tm4XgIBsm8ioSp8yACfXfI9
0E2FZkM/s1qb12g027c19VY=
=pnha
-----END PGP SIGNATURE-----

--=-41hGIGQHvr3hTqy3Q0B/--

