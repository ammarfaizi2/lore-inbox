Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbSIZSyR>; Thu, 26 Sep 2002 14:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbSIZSyR>; Thu, 26 Sep 2002 14:54:17 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:4924 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261453AbSIZSyQ>;
	Thu, 26 Sep 2002 14:54:16 -0400
Date: Thu, 26 Sep 2002 20:59:24 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, davem@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] gfp_t
Message-ID: <20020926185924.GA1892@jaquet.dk>
References: <20020926044401.9C60D2C3CC@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20020926044401.9C60D2C3CC@lists.samba.org>
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 02:35:30PM +1000, Rusty Russell wrote:
> This creates a mythical gfp_t for passing gfp states, and conversion
> macros __GFP() and __UNGFP(), to give warnings, It's 55k, so
> compressed and attached.

This breaks ntfs/malloc.h which is doing the following:
49:       return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);

This turns into=20
=09
          return __vmalloc(size, ((struct gfp_arg *)(0x10 | 0x40 |
		0x80)) | 0x02, ((pgprot_t) { (__PAGE_KERNEL) } ));
	=09
which '|' is not happy with.

Regards,
  Rasmus

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k1kMlZJASZ6eJs4RAtFJAJ4szg9Fv5EUe/wN0pm2vohOjMpf3gCfUjfM
n0GtQXK7MAZL3/+vjfBxyR0=
=VBcf
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
