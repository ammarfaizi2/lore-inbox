Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbULVPur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbULVPur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 10:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261995AbULVPuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 10:50:46 -0500
Received: from svana.org ([203.20.62.76]:49167 "EHLO svana.org")
	by vger.kernel.org with ESMTP id S261992AbULVPub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 10:50:31 -0500
Date: Wed, 22 Dec 2004 16:50:05 +0100
From: Martijn van Oosterhout <kleptog@svana.org>
To: Mandeep Sandhu <Mandeep_Sandhu@infosys.com>
Cc: dima@s2io.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-newbie@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: zero copy issue while receiving the data (counter part of sendfil e)
Message-ID: <20041222155003.GA29278@svana.org>
Reply-To: Martijn van Oosterhout <kleptog@svana.org>
References: <267988DEACEC5A4D86D5FCD780313FBB02C66FCA@exch-03.noida.hcltech.com> <1103649767.7217.100.camel@beastie> <41C879CB.3040600@pobox.com> <1103658190.7217.121.camel@beastie> <1103703718.3775.93.camel@samish.india.ascend.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1103703718.3775.93.camel@samish.india.ascend.com>
User-Agent: Mutt/1.3.28i
X-PGP-Key-ID: Length=1024; ID=0x0DC67BE6
X-PGP-Key-Fingerprint: 295F A899 A81A 156D B522  48A7 6394 F08A 0DC6 7BE6
X-PGP-Key-URL: <http://svana.org/kleptog/0DC67BE6.pgp.asc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 22, 2004 at 01:51:58PM +0530, Mandeep Sandhu wrote:
> On Wed, 2004-12-22 at 01:13, Dmitry Yusupov wrote:
> > indeed :)
> > another words if you have modern NIC than you get "zero-copy"(except
> > copy_to_user()) for free :)
> what does "checksum on rx" mean??? Don't most of the NIC's support
> DMA-ing to mem on rx-ing a packet? so what does "zero-copy for free"
> mean here?

It's if the network card will check the checksums of the packets on
receiving. If it doesn't, the main CPU needs to read every byte in the
packet to calculate the checksum itself. If the CPU is doing that
anyway you can copy it elsewhere for free.=20

Generally, reading from memory takes time because the CPU has to wait,
writing is free since it can be deferred in the cache (in theory
indefinitly) until there's free cycle.

In other words, if the card isn't checksumming but does DMA you're not
really saving any time over a manual copy.

Hope this helps,
--=20
Martijn van Oosterhout   <kleptog@svana.org>   http://svana.org/kleptog/
> Patent. n. Genius is 5% inspiration and 95% perspiration. A patent is a
> tool for doing 5% of the work and then sitting around waiting for someone
> else to do the other 95% so you can sue them.

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFByZeqY5Twig3Ge+YRAhqrAJ9xLO66LZpRLgD2D3wIzuUx0Jo1jgCgic+r
NSxeItQ4wZKPxGjqv0VqGDo=
=XEu8
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
