Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUIDKg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUIDKg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 06:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267238AbUIDKg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 06:36:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264256AbUIDKgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 06:36:55 -0400
Date: Sat, 4 Sep 2004 12:36:48 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/patch] macro_removal_agp_mtrr.diff
Message-ID: <20040904103648.GC5313@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0409041053450.25475@skynet> <1094292878.2801.7.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409041126500.25475@skynet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409041126500.25475@skynet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 04, 2004 at 11:30:40AM +0100, Dave Airlie wrote:
> so something like
> static inline int drm_core_has_AGP(struct drm_device *dev)
> {
> #if __OS_HAS_AGP
> 	return drm_core_check_feature(dev, DRIVER_USE_AGP);
> #else
> 	return 0;
> }
> 
> or the macro one
> 
> #if __OS_HAS_AGP
> #define drm_core_has_AGP(dev) drm_core_check_feature(dev, DRIVER_USE_AGP)
> #else
> #define drm_core_has_AGP(dev) (0)
> #endif
> 
> if the inline will work I'll be happier using it.. I just need to know it
> works for the range of compilers we use...

please do not put ifdefs inside functions; 
how about

#if __OS_HAS_AGP
static inline int drm_core_has_AGP(struct drm_device *dev)
{
	return drm_core_check_feature(dev, DRIVER_USE_AGP);
}
#else
#define drm_core_has_AGP(dev) 0
#endif


where you can make the later an inline if you really want to but I don't see
the point.


--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBOZrAxULwo51rQBIRAimaAJ93EpG4P91FfuzWsp0q175K+208EwCfbFGF
zobVYgGpEjh6Bd4Tn17im0s=
=MJxv
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
