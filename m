Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVBMVFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVBMVFo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 16:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVBMVFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 16:05:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:40584 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261307AbVBMVFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 16:05:35 -0500
Date: Sun, 13 Feb 2005 16:05:15 -0500
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: [PATCH] 0/5: LSM hooks rework
Message-ID: <20050213210515.GH27893@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Andreas Gruenbacher <agruen@suse.de>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="reI/iBAAp9kzkmX4"
Content-Disposition: inline
X-Operating-System: Linux 2.6.11-rc3-bk6-20-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--reI/iBAAp9kzkmX4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this goes back to a discussion in August last year:
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.1/0623.html

The following patchset addresses three issues of the security.h stub
collection:
* All the functions are implemented twice, once for
  CONFIG_SECURITY enabled and once for disabled.
  Makes it harder than necessary to keep in sync
  and the file much longer than needed.=20
* We do lots of indirect (and thus non-inlined) calls to
  mostly noop functions, which has a performance impact.
  By using a branch (as suggested by David Mosberger and
  implemented by Brian Baker) we can save a number of cycles.
  Especially visible on IA64, where we can get > 3% improvement
  on netperf -t TCP_RR
* The default of dummy if CONFIG_SECURITY is enabled is not
  desirable as it does differ from the CONFIG_SECURITY disabled
  default. Thus make capabilities the default.

Patches are against 2.6.11-rc4 and follow in subsequent mails.
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--reI/iBAAp9kzkmX4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCD8ELxmLh6hyYd04RArQ8AJ90TTa9ws3tVkGJ732z7yjdPFwl0QCeISor
X4xYPMFb7Wduv3oFVf/6O9g=
=Fp2y
-----END PGP SIGNATURE-----

--reI/iBAAp9kzkmX4--
