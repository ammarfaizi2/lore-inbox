Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUHPKv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUHPKv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267522AbUHPKv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:51:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267519AbUHPKtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:49:13 -0400
Date: Mon, 16 Aug 2004 12:48:10 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: Keith Whitwell <keith@tungstengraphics.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: DRM and 2.4 ...
Message-ID: <20040816104810.GA13029@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0408160652350.9944@skynet> <1092640312.2791.6.camel@laptop.fenrus.com> <412081C6.20601@tungstengraphics.com> <20040816094622.GA31696@devserv.devel.redhat.com> <412088A5.6010106@tungstengraphics.com> <20040816101426.GB31696@devserv.devel.redhat.com> <Pine.LNX.4.58.0408161137330.21177@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408161137330.21177@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 16, 2004 at 11:42:00AM +0100, Dave Airlie wrote:
> 
> >
> > DRM_IOCTL_ARGS, DRM_ERR, DRM_CURRENTPID, DRM_UDELAY, DRM_READMEMORYBARRIER,
> > DRM_COPY_FROM_USER_IOCTL etc etc existed prior to freebsd support? Oh my
> > god...
> 
> I'm currently open for constructive critics with ideas on how to fix these
> things, the DRM is open for business if we can fix things up now it will
> be a lot easier while I'm knee deep with time than after I'm finished and
> back travelling .. should we have try to implement Linux fns in BSD, what
> do we do if more parameters/info are needed from a BSD side, or do we try
> and sideline all these into a separate library of functions and wrap them
> on both bsd and linux?

it's a bit of all of this.
If BSD doesn't have a conflicting udelay(), why not just implement one
there instead of a superfluous rename.
DRM_ERR() otoh should have been dealt with by making a core function for the
ioctl with only the really needed/used arguments (probably even such that
the arguments are already copied from userspace) and then a linux and a bsd
specific API wrapper. The BSD one can then easily flip the sign (that's
basically free), it also takes case of DRM_IOCTL_ARGS mess as well and
DRM_COPY_FROM_USER_IOCTL if you do it right.
DRM_CURRENTPID probably shouldn't exist at all, drivers shouldn't use pid's
in general.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBIJDqxULwo51rQBIRAijyAJ45UJgwqcPm1UjLXKGnS+rMgNFcdACcC7v1
y9m6aMhuO20MrAWqGBh2+k0=
=Zf/j
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
