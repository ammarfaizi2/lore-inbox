Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUFXUfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUFXUfe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUFXUfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:35:33 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:41095 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S265521AbUFXUfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:35:18 -0400
Date: Thu, 24 Jun 2004 14:35:16 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Testing for kernel features in external modules
Message-ID: <20040624203516.GV31203@schnapps.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040624203043.GA4557@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0k4Rxg87Lb8yV0u3"
Content-Disposition: inline
In-Reply-To: <20040624203043.GA4557@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0k4Rxg87Lb8yV0u3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Jun 24, 2004  22:30 +0200, Sam Ravnborg wrote:
> +if [ -f remap4.o ]; then
> +	echo "#define REMAP4 1" > $2
> +elif [ -f remap5.o ]; then
> +	echo "#define REMAP5 1" > $2
> +fi

I would prefer that these be called something like HAVE_REMAP5, or
better yet something descriptive like HAVE_REMAP_PAGE_RANGE_VMA.

This obviously needs to be smarter also, to handle adding multiple
#defines to a single .h file.

Ideally, when people make an incompatible kernel API change like this
they would just #define HAVE_REMAP_PAGE_RANGE_VMA in the header that
declares remap_page_range() directly (e.g. KERNEL_AS_O_DIRECT was added
for this reason) instead of external builds having to figure this out
themselves.  Adding the check script is no less work than just adding
the #define to the appropriate header directly.

Having something like "features.h" is only useful as far as it checks
for features that applications care about.  If it doesn't have checks
for features, then the apps need to implement those checks anyways
and different apps will name the script/#define differently so until
they make it into the stock kernel it isn't terribly useful.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/                 http://members.shaw.ca/golinux/


--0k4Rxg87Lb8yV0u3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFA2zsEpIg59Q01vtYRAvhSAKCJ98LonhOQY+AGMNC2GtF8qcDEFwCfagUd
9pflEXlsQr+eskM0TA0jTLs=
=ofz7
-----END PGP SIGNATURE-----

--0k4Rxg87Lb8yV0u3--
