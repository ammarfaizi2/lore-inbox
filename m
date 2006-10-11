Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030647AbWJKGRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030647AbWJKGRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbWJKGRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:17:21 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:26276 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030656AbWJKGRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:17:19 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] SCSI: minor bug fixes and cleanups
Date: Wed, 11 Oct 2006 08:18:24 +0200
User-Agent: KMail/1.9.4
Cc: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20061010232231.GA19015@havoc.gtf.org>
In-Reply-To: <20061010232231.GA19015@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1271319.9g9qtjkpBh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610110818.25158.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1271319.9g9qtjkpBh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jeff Garzik wrote:
> BusLogic: use kzalloc(), remove cast to/from void*
>
> aic7xxx_old: fix typo in cast
>
> NCR53c406a: ifdef out static built code
>
> fd_mcs: ifdef out static built code
>
> ncr53c8xx: ifdef out static built code
>
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
>
> ---
>
>  drivers/scsi/BusLogic.c       |   12 ++++++------
>  drivers/scsi/NCR53c406a.c     |    5 +++++
>  drivers/scsi/aic7xxx_old.c    |    2 +-
>  drivers/scsi/fd_mcs.c         |    2 ++
>  drivers/scsi/ncr53c8xx.c      |   19 +++++++++++--------
>
> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
> index 7c59bba..689dc4c 100644
> --- a/drivers/scsi/BusLogic.c
> +++ b/drivers/scsi/BusLogic.c
> @@ -2186,21 +2186,21 @@ #endif
>
>  	if (BusLogic_ProbeOptions.NoProbe)
>  		return -ENODEV;
> -	BusLogic_ProbeInfoList = (struct BusLogic_ProbeInfo *)
> -	    kmalloc(BusLogic_MaxHostAdapters * sizeof(struct BusLogic_ProbeInfo),
> GFP_ATOMIC); +	BusLogic_ProbeInfoList =
> +	    kzalloc(BusLogic_MaxHostAdapters * sizeof(struct BusLogic_ProbeInfo),
> GFP_KERNEL); if (BusLogic_ProbeInfoList == NULL) {
>  		BusLogic_Error("BusLogic: Unable to allocate Probe Info List\n", NULL);
>  		return -ENOMEM;
>  	}
> -	memset(BusLogic_ProbeInfoList, 0, BusLogic_MaxHostAdapters *
> sizeof(struct BusLogic_ProbeInfo));

kcalloc

Eike

--nextPart1271319.9g9qtjkpBh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFLIyxXKSJPmm5/E4RAvFqAKCF16dI/+zlI19DfZWp2nknxQkXMwCcCdfa
4iXSvvijOc6R44XbwnZn/Ik=
=nA4y
-----END PGP SIGNATURE-----

--nextPart1271319.9g9qtjkpBh--
