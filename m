Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVANFsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVANFsZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 00:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVANFsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 00:48:25 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:38283 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261187AbVANFsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 00:48:19 -0500
Date: Thu, 13 Jan 2005 22:48:03 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Dave <dave.jiang@gmail.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com, mporter@kernel.crashing.org
Subject: Re: [PATCH 2/5] Convert resource to u64 from unsigned long
Message-ID: <20050114054803.GA22715@schnapps.adilger.int>
Mail-Followup-To: Dave <dave.jiang@gmail.com>, akpm@osdl.org,
	torvalds@osdl.org, linux-kernel@vger.kernel.org, smaurer@teja.com,
	linux@arm.linux.org.uk, dsaxena@plexity.net, drew.moseley@intel.com,
	mporter@kernel.crashing.org
References: <8746466a050113152843f32a2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <8746466a050113152843f32a2f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 13, 2005  16:28 -0700, Dave wrote:
> Fixed some of the drivers as example just to get working on i386.
> +     /*
> +      * FIXME: apparently ia32 does not have u64 divide implementation
> +      * we cast the pci_resource_len to u32 for the time being
> +      * this probably should be fixed to support u64 for ia32
> +      * and other archs that do not have u64 divide
> +      */
> +#if BIS_PER_LONG =3D=3D 64
>       maxnr =3D (pci_resource_len(dev, bar) - board->first_offset) /
>               (8 << board->reg_shift);
> +#else
> +     maxnr =3D ((u32)pci_resource_len(dev, bar) - board->first_offset) /
> +             (8 << board->reg_shift);
> +#endif
                                                                           =
    =20
One of the reasons that ia32 doesn't support 64-bit divide directly is
because it is a big red flag that you are probably doing something wrong.
This is a prime example - why do a divide when you could do a shift:
                                                                           =
    =20
        maxnr =3D (pci_resource_len(dev, bar) - board->first_offset) >>
                (board->reg_shift + 3);

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFB510TpIg59Q01vtYRAoScAKCJhUt6/7oX1nRp2IpEpTbjj/c5FACgi7k+
vD/2AsUEf3embuTy7jh7qFE=
=6i7u
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
