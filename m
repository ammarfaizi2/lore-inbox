Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVIDM7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVIDM7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIDM7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:59:10 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:34516 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750807AbVIDM7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:59:09 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] New: Omnikey CardMan 4040 PCMCIA Driver
Date: Sun, 4 Sep 2005 14:58:27 +0200
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20050904101218.GM4415@rama.de.gnumonks.org>
In-Reply-To: <20050904101218.GM4415@rama.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1635815.ehtM9xSVJF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509041458.33341.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1635815.ehtM9xSVJF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 04 September 2005 12:12, Harald Welte wrote:
> cmx_llseek

just use

	return nonseekable_open(inode, filp);

as your last statement in cmx_open() instead of

	return 0;

to really disable any file pointer positioning (e.g. pwrite/pread too).

Addtionally cmx_llseek() is implement already as "no_llseek()"
by the VFS, so you delete it from the driver an use no_llseek() from
the VFS instead.


Regards

Ingo Oeser


--nextPart1635815.ehtM9xSVJF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDGu95U56oYWuOrkARAmfGAKDauKDj0CvpohqDm5p7UpjEUwzqEACeM0Jo
/Q5Q9o0GW4DO9CeqLChsiRA=
=OSQJ
-----END PGP SIGNATURE-----

--nextPart1635815.ehtM9xSVJF--
